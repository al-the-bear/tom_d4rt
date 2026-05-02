// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Live demo gallery - ToggleButtonsThemeData deep dive
// ----------------------------------------------------------------------------
// ToggleButtonsThemeData is the immutable, value-typed bundle of styling
// fields that ToggleButtonsTheme propagates down the widget tree to every
// descendant ToggleButtons. This script focuses *exclusively* on the data
// class - constructing it, examining its fields, copyWith, lerp, equality,
// hashCode, and the way its values feed back into ToggleButtons widgets.
// The sibling `toggle_buttons_theme_test.dart` covers the inherited widget
// side (Theme.of, propagation, Theme nesting). To keep the two files
// independent we deliberately avoid scenarios that depend on the inherited
// widget chain here - we always wrap our themes inline at each section.
//
// Sections:
//   1. Hero - what is ToggleButtonsThemeData
//   2. Color trio (color / selectedColor / disabledColor)
//   3. Fill / focus / highlight / hover / splash colors
//   4. textStyle field - typography flowing into selected/unselected labels
//   5. constraints - BoxConstraints driving cell size
//   6. Border colors trio (borderColor / selectedBorderColor / disabledBorderColor)
//   7. borderRadius and borderWidth
//   8. copyWith walkthrough - one base, four variants
//   9. lerp interpolation slider - animate between two themes
//  10. Equality / identical / hashCode showcase card
//  11. Theme.of read-back card
//  12. Design-token presets - Pill / Tab / Chip / Outlined
//  13. Disabled state styling tour
//  14. Multi-select with state-driven selection
//  15. Borderless variant via transparent borderColor
//  16. Decision guide - ToggleButtonsThemeData vs SegmentedButton.styleFrom
//  17. Reference - every ToggleButtonsThemeData field
// ----------------------------------------------------------------------------
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ===========================================================================
  // PROLOGUE - DIAGNOSTIC PRINTS
  // ---------------------------------------------------------------------------
  // Confirm to the run-log that every section's data instance has been
  // constructed. The print lines also serve as a section index for anyone
  // reading the run output later.
  // ===========================================================================
  print('=== ToggleButtonsThemeData Deep Demo ===');
  print('Seventeen sections, each focused on the data class itself.');
  print('Sections:');
  print('  1. Hero - what is ToggleButtonsThemeData');
  print('  2. Color trio (color / selectedColor / disabledColor)');
  print('  3. Fill / focus / highlight / hover / splash colors');
  print('  4. textStyle field');
  print('  5. constraints (BoxConstraints)');
  print('  6. Border colors trio');
  print('  7. borderRadius and borderWidth');
  print('  8. copyWith walkthrough');
  print('  9. lerp interpolation slider');
  print(' 10. Equality / hashCode showcase');
  print(' 11. Theme.of read-back card');
  print(' 12. Design-token presets');
  print(' 13. Disabled state tour');
  print(' 14. Multi-select with state-driven selection');
  print(' 15. Borderless variant');
  print(' 16. Decision guide vs SegmentedButton.styleFrom');
  print(' 17. Reference - every ToggleButtonsThemeData field');

  // ===========================================================================
  // PALETTE - DISTINCT TINT PER SECTION
  // ---------------------------------------------------------------------------
  // Each section has its own background tint and accent. The tints stay
  // bright but pale enough to never overpower the live ToggleButtons row
  // in their middle.
  // ===========================================================================
  const heroBg = Color(0xFFE8EAF6);
  const heroAccent = Color(0xFF283593);
  const colorBg = Color(0xFFE3F2FD);
  const colorAccent = Color(0xFF0D47A1);
  const fillBg = Color(0xFFE0F7FA);
  const fillAccent = Color(0xFF006064);
  const textBg = Color(0xFFFFF8E1);
  const textAccent = Color(0xFFB28704);
  const constraintsBg = Color(0xFFF3E5F5);
  const constraintsAccent = Color(0xFF6A1B9A);
  const borderBg = Color(0xFFE8F5E9);
  const borderAccent = Color(0xFF1B5E20);
  const radiusBg = Color(0xFFFFEBEE);
  const radiusAccent = Color(0xFFB71C1C);
  const copyBg = Color(0xFFE0F2F1);
  const copyAccent = Color(0xFF004D40);
  const lerpBg = Color(0xFFFCE4EC);
  const lerpAccent = Color(0xFFAD1457);
  const equalityBg = Color(0xFFEDE7F6);
  const equalityAccent = Color(0xFF4527A0);
  const readbackBg = Color(0xFFF1F8E9);
  const readbackAccent = Color(0xFF33691E);
  const presetBg = Color(0xFFFFF3E0);
  const presetAccent = Color(0xFFE65100);
  const disabledBg = Color(0xFFECEFF1);
  const disabledAccent = Color(0xFF37474F);
  const multiBg = Color(0xFFE1F5FE);
  const multiAccent = Color(0xFF01579B);
  const borderlessBg = Color(0xFFFFFDE7);
  const borderlessAccent = Color(0xFFF57F17);
  const decisionBg = Color(0xFFEFEBE9);
  const decisionAccent = Color(0xFF4E342E);
  const referenceBg = Color(0xFFF5F5F5);
  const referenceAccent = Color(0xFF424242);

  // ===========================================================================
  // SHARED HELPERS
  // ---------------------------------------------------------------------------
  // A small library of helpers reused across the gallery. These are pure
  // factory functions, not state holders.
  // ===========================================================================

  // Wrap a ToggleButtons inside a local Theme that injects a specific
  // ToggleButtonsThemeData. We rely on Theme(data: ThemeData(...))
  // because ToggleButtons itself reads its style from Theme.of(context)
  // .toggleButtonsTheme. This is the contract path for the data class.
  Widget themed({
    required ToggleButtonsThemeData data,
    required List<bool> isSelected,
    required List<Widget> children,
    void Function(int)? onPressed,
  }) {
    return Theme(
      data: ThemeData(toggleButtonsTheme: data),
      child: ToggleButtons(
        isSelected: isSelected,
        onPressed: onPressed ?? (_) {},
        children: children,
      ),
    );
  }

  // The classic three-cell label row used in field tour sections.
  List<Widget> threeLabels() => const [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text('ALPHA'),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text('BETA'),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text('GAMMA'),
        ),
      ];

  // A horizontally-stretched section card with a coloured tint.
  Widget sectionCard({
    required Color background,
    required Color accent,
    required String title,
    required String description,
    required List<Widget> body,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: accent.withOpacity(0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: accent,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: const TextStyle(fontSize: 13, height: 1.4),
          ),
          const SizedBox(height: 12),
          ...body,
        ],
      ),
    );
  }

  // Small label-and-widget row used inside cards.
  Widget labelledRow(String label, Widget child, {Color accent = Colors.black}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 160,
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: accent,
              ),
            ),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }

  // ===========================================================================
  // SECTION 1 - HERO CARD
  // ---------------------------------------------------------------------------
  // The hero card explains the role of ToggleButtonsThemeData as the
  // value-typed style bundle separate from the ToggleButtonsTheme inherited
  // widget. We render one ToggleButtons wrapped in a Theme that supplies a
  // representative ToggleButtonsThemeData, and beneath it a short prose
  // explanation of the resolution sequence.
  // ===========================================================================
  Widget buildHeroCard() {
    final hero = ToggleButtonsThemeData(
      color: heroAccent.withOpacity(0.7),
      selectedColor: Colors.white,
      fillColor: heroAccent,
      borderColor: heroAccent.withOpacity(0.3),
      selectedBorderColor: heroAccent,
      borderRadius: BorderRadius.circular(8),
      borderWidth: 1.5,
      constraints: const BoxConstraints(minWidth: 90, minHeight: 36),
      textStyle: const TextStyle(
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
      decoration: BoxDecoration(
        color: heroBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: heroAccent.withOpacity(0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            '1. ToggleButtonsThemeData - the immutable style bundle',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: heroAccent,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'ToggleButtonsThemeData is a plain value object. It bundles every '
            'property a ToggleButtons widget consults to draw itself: color, '
            'selectedColor, disabledColor, fillColor, focusColor, highlightColor, '
            'hoverColor, splashColor, textStyle, constraints, borderColor, '
            'selectedBorderColor, disabledBorderColor, borderRadius and '
            'borderWidth. It is what ToggleButtonsTheme.of(context) returns; '
            'it is what Theme.of(context).toggleButtonsTheme returns; and it '
            'is the type the framework lerps between during animated '
            'transitions.',
            style: TextStyle(fontSize: 14, height: 1.4),
          ),
          const SizedBox(height: 10),
          const Text(
            'Resolution order for a single ToggleButtons field:',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          const Text('  1. Constructor argument on the ToggleButtons itself.'),
          const Text('  2. ToggleButtonsTheme.of(context).<field>'),
          const Text('  3. Theme.of(context).toggleButtonsTheme.<field>'),
          const Text('  4. Hard-coded default in ToggleButtons.build'),
          const SizedBox(height: 14),
          Center(
            child: themed(
              data: hero,
              isSelected: const [false, true, false],
              children: threeLabels(),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // SECTION 2 - COLOR TRIO
  // ---------------------------------------------------------------------------
  // Three side-by-side ToggleButtons, each overriding a different element of
  // the colour trio. This is purely about foreground colour - the colour of
  // the *children* (the labels) under three states: unselected (color),
  // selected (selectedColor), disabled (disabledColor).
  // ===========================================================================
  Widget colorRow(String label, ToggleButtonsThemeData data,
      {bool disabled = false}) {
    return labelledRow(
      label,
      themed(
        data: data,
        isSelected: const [false, true, false],
        onPressed: disabled ? null : (_) {},
        children: threeLabels(),
      ),
      accent: colorAccent,
    );
  }

  Widget buildColorTrioCard() {
    final base = ToggleButtonsThemeData(
      color: Colors.grey.shade700,
      selectedColor: Colors.white,
      disabledColor: Colors.grey.shade400,
      fillColor: colorAccent,
      borderColor: colorAccent.withOpacity(0.3),
      selectedBorderColor: colorAccent,
      borderRadius: BorderRadius.circular(6),
    );

    return sectionCard(
      background: colorBg,
      accent: colorAccent,
      title: '2. Color trio - color / selectedColor / disabledColor',
      description:
          'Three foreground colours for the three button states. color is '
          'used for the unselected label tint, selectedColor for the '
          'currently-selected label tint (rendered against the fillColor), '
          'and disabledColor for any cell that has no callback at all.',
      body: [
        colorRow('default', base),
        colorRow(
          'red unselected',
          base.copyWith(color: Colors.red.shade700),
        ),
        colorRow(
          'amber selected',
          base.copyWith(selectedColor: Colors.amber.shade100),
        ),
        colorRow(
          'all-disabled',
          base.copyWith(disabledColor: Colors.deepOrange.shade400),
          disabled: true,
        ),
      ],
    );
  }

  // ===========================================================================
  // SECTION 3 - FILL / FOCUS / HIGHLIGHT / HOVER / SPLASH
  // ---------------------------------------------------------------------------
  // Each row varies one of the five reaction colours. Because the harness
  // never receives gestures we cannot directly demonstrate hover / focus /
  // splash visually, but we *can* demonstrate fillColor (it shows
  // immediately on the selected cell) and we attach the others on a clearly
  // labelled construction so a reader can compare the data class layout.
  // ===========================================================================
  Widget buildFillColorsCard() {
    final base = ToggleButtonsThemeData(
      color: Colors.black87,
      selectedColor: Colors.white,
      borderColor: fillAccent.withOpacity(0.4),
      selectedBorderColor: fillAccent,
      borderRadius: BorderRadius.circular(6),
    );

    return sectionCard(
      background: fillBg,
      accent: fillAccent,
      title: '3. fillColor / focusColor / highlightColor / hoverColor / splashColor',
      description:
          'fillColor paints the background of the currently-selected cell. '
          'focusColor / highlightColor / hoverColor / splashColor are all '
          'reaction colours - they appear during pointer or keyboard '
          'interaction. We demonstrate fillColor visually here, and bake the '
          'other four into the data class so their construction is visible.',
      body: [
        labelledRow(
          'fillColor=teal',
          themed(
            data: base.copyWith(fillColor: Colors.teal.shade400),
            isSelected: const [false, true, false],
            children: threeLabels(),
          ),
          accent: fillAccent,
        ),
        labelledRow(
          'fillColor=indigo',
          themed(
            data: base.copyWith(fillColor: Colors.indigo.shade400),
            isSelected: const [false, true, false],
            children: threeLabels(),
          ),
          accent: fillAccent,
        ),
        labelledRow(
          'fillColor=brown',
          themed(
            data: base.copyWith(fillColor: Colors.brown.shade400),
            isSelected: const [false, true, false],
            children: threeLabels(),
          ),
          accent: fillAccent,
        ),
        const SizedBox(height: 6),
        const Divider(),
        const SizedBox(height: 4),
        const Text(
          'Reaction colour wiring (interactive states):',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
        ),
        const SizedBox(height: 6),
        labelledRow(
          'all-five wired',
          themed(
            data: base.copyWith(
              fillColor: Colors.deepPurple.shade300,
              focusColor: Colors.deepPurple.shade100,
              hoverColor: Colors.deepPurple.shade50,
              highlightColor: Colors.deepPurple.shade200,
              splashColor: Colors.deepPurple.shade400,
            ),
            isSelected: const [true, false, true],
            children: threeLabels(),
          ),
          accent: fillAccent,
        ),
        const SizedBox(height: 8),
        const Text(
          'Field meanings (left to right in the user gesture timeline):',
          style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(8, 6, 0, 0),
          child: Text(
            '  hoverColor    -> mouse cursor enters the cell\n'
            '  focusColor    -> cell receives keyboard focus\n'
            '  highlightColor-> long-press highlight on touch devices\n'
            '  splashColor   -> ink ripple while the press is in flight\n'
            '  fillColor     -> persistent background for the selected cell',
            style: TextStyle(fontFamily: 'monospace', fontSize: 12),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // SECTION 4 - TEXT STYLE
  // ---------------------------------------------------------------------------
  // textStyle is one of the more interesting fields because it merges with
  // the children's own DefaultTextStyle. We exercise four variants: a
  // monospace technical look, a serif editorial look, a heavy-weight modern
  // look, and a small-caps style.
  // ===========================================================================
  Widget buildTextStyleCard() {
    final base = ToggleButtonsThemeData(
      color: Colors.black87,
      selectedColor: Colors.white,
      fillColor: textAccent,
      borderColor: textAccent.withOpacity(0.4),
      selectedBorderColor: textAccent,
      borderRadius: BorderRadius.circular(6),
      constraints: const BoxConstraints(minWidth: 90, minHeight: 38),
    );

    return sectionCard(
      background: textBg,
      accent: textAccent,
      title: '4. textStyle - a TextStyle on the data class',
      description:
          'textStyle is a TextStyle that propagates as the DefaultTextStyle '
          'inside every cell. The cells children may still merge or override '
          'it locally. Here are four editorial variants applied to the same '
          'three labels.',
      body: [
        labelledRow(
          'monospace',
          themed(
            data: base.copyWith(
              textStyle: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 13,
                letterSpacing: 1.2,
              ),
            ),
            isSelected: const [true, false, false],
            children: threeLabels(),
          ),
          accent: textAccent,
        ),
        labelledRow(
          'serif italic',
          themed(
            data: base.copyWith(
              textStyle: const TextStyle(
                fontFamily: 'serif',
                fontSize: 14,
                fontStyle: FontStyle.italic,
              ),
            ),
            isSelected: const [false, true, false],
            children: threeLabels(),
          ),
          accent: textAccent,
        ),
        labelledRow(
          'heavy weight',
          themed(
            data: base.copyWith(
              textStyle: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 15,
                letterSpacing: 0.4,
              ),
            ),
            isSelected: const [false, false, true],
            children: threeLabels(),
          ),
          accent: textAccent,
        ),
        labelledRow(
          'wide caps',
          themed(
            data: base.copyWith(
              textStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 3.5,
              ),
            ),
            isSelected: const [true, true, false],
            children: threeLabels(),
          ),
          accent: textAccent,
        ),
      ],
    );
  }

  // ===========================================================================
  // SECTION 5 - CONSTRAINTS
  // ---------------------------------------------------------------------------
  // The constraints field is a BoxConstraints that the framework applies as
  // the *minimum* (and sometimes maximum) size of every cell. We tour
  // narrow-square, wide-low, tall-thin, and square-padded variants. Because
  // each cell has identical Padding inside, all visual size differences are
  // attributable to the constraints field.
  // ===========================================================================
  Widget buildConstraintsCard() {
    final base = ToggleButtonsThemeData(
      color: Colors.black87,
      selectedColor: Colors.white,
      fillColor: constraintsAccent,
      borderColor: constraintsAccent.withOpacity(0.4),
      selectedBorderColor: constraintsAccent,
      borderRadius: BorderRadius.circular(6),
      textStyle: const TextStyle(fontWeight: FontWeight.w600),
    );

    return sectionCard(
      background: constraintsBg,
      accent: constraintsAccent,
      title: '5. constraints - BoxConstraints on the data class',
      description:
          'constraints sets the size envelope of each cell. Narrow / wide / '
          'tall / square / pill - all of these visual silhouettes are '
          'expressed by varying just this one BoxConstraints field.',
      body: [
        labelledRow(
          'min 60x36',
          themed(
            data: base.copyWith(
              constraints: const BoxConstraints(minWidth: 60, minHeight: 36),
            ),
            isSelected: const [false, true, false],
            children: threeLabels(),
          ),
          accent: constraintsAccent,
        ),
        labelledRow(
          'min 120x36',
          themed(
            data: base.copyWith(
              constraints: const BoxConstraints(minWidth: 120, minHeight: 36),
            ),
            isSelected: const [false, true, false],
            children: threeLabels(),
          ),
          accent: constraintsAccent,
        ),
        labelledRow(
          'min 60x60',
          themed(
            data: base.copyWith(
              constraints: const BoxConstraints(minWidth: 60, minHeight: 60),
            ),
            isSelected: const [false, true, false],
            children: threeLabels(),
          ),
          accent: constraintsAccent,
        ),
        labelledRow(
          'min 120x60',
          themed(
            data: base.copyWith(
              constraints: const BoxConstraints(minWidth: 120, minHeight: 60),
            ),
            isSelected: const [false, true, false],
            children: threeLabels(),
          ),
          accent: constraintsAccent,
        ),
        labelledRow(
          'min 90x90 (square)',
          themed(
            data: base.copyWith(
              constraints: const BoxConstraints(minWidth: 90, minHeight: 90),
            ),
            isSelected: const [false, true, false],
            children: const [
              Padding(padding: EdgeInsets.all(8), child: Icon(Icons.format_align_left)),
              Padding(padding: EdgeInsets.all(8), child: Icon(Icons.format_align_center)),
              Padding(padding: EdgeInsets.all(8), child: Icon(Icons.format_align_right)),
            ],
          ),
          accent: constraintsAccent,
        ),
      ],
    );
  }

  // ===========================================================================
  // SECTION 6 - BORDER COLORS TRIO
  // ---------------------------------------------------------------------------
  // borderColor / selectedBorderColor / disabledBorderColor are the three
  // colour fields that paint the cell perimeter. We show four variants
  // tinted to make the boundaries clearly readable.
  // ===========================================================================
  Widget buildBorderColorCard() {
    final base = ToggleButtonsThemeData(
      color: Colors.black87,
      selectedColor: Colors.white,
      disabledColor: Colors.grey.shade400,
      fillColor: borderAccent,
      borderRadius: BorderRadius.circular(6),
      borderWidth: 2,
    );

    return sectionCard(
      background: borderBg,
      accent: borderAccent,
      title: '6. borderColor / selectedBorderColor / disabledBorderColor',
      description:
          'Three border colours, mirroring the foreground colour trio. The '
          'border around an unselected cell uses borderColor; around a '
          'selected cell uses selectedBorderColor; around an entirely '
          'disabled bar uses disabledBorderColor. The shared boundary '
          'between two adjacent cells is drawn once and uses the higher '
          'priority side.',
      body: [
        labelledRow(
          'olive default',
          themed(
            data: base.copyWith(
              borderColor: const Color(0xFF808000),
              selectedBorderColor: borderAccent,
              disabledBorderColor: Colors.grey.shade400,
            ),
            isSelected: const [false, true, false],
            children: threeLabels(),
          ),
          accent: borderAccent,
        ),
        labelledRow(
          'red selected',
          themed(
            data: base.copyWith(
              borderColor: Colors.green.shade300,
              selectedBorderColor: Colors.red.shade700,
              disabledBorderColor: Colors.grey.shade400,
            ),
            isSelected: const [false, true, false],
            children: threeLabels(),
          ),
          accent: borderAccent,
        ),
        labelledRow(
          'all-orange',
          themed(
            data: base.copyWith(
              borderColor: Colors.orange.shade400,
              selectedBorderColor: Colors.deepOrange.shade700,
              disabledBorderColor: Colors.orange.shade100,
            ),
            isSelected: const [true, false, true],
            children: threeLabels(),
          ),
          accent: borderAccent,
        ),
        labelledRow(
          'disabled-only',
          themed(
            data: base.copyWith(
              borderColor: Colors.green.shade300,
              selectedBorderColor: borderAccent,
              disabledBorderColor: Colors.deepOrange.shade400,
            ),
            isSelected: const [false, true, false],
            onPressed: null,
            children: threeLabels(),
          )._maybeDisabled(),
          accent: borderAccent,
        ),
      ],
    );
  }

  // ===========================================================================
  // SECTION 7 - BORDER RADIUS / BORDER WIDTH
  // ---------------------------------------------------------------------------
  // borderRadius is a BorderRadiusGeometry on the *outermost* corners of the
  // bar (the seams between cells stay sharp). borderWidth sets the perimeter
  // thickness in logical pixels.
  // ===========================================================================
  Widget buildRadiusCard() {
    final base = ToggleButtonsThemeData(
      color: Colors.black87,
      selectedColor: Colors.white,
      fillColor: radiusAccent,
      borderColor: radiusAccent.withOpacity(0.4),
      selectedBorderColor: radiusAccent,
      textStyle: const TextStyle(fontWeight: FontWeight.w600),
      constraints: const BoxConstraints(minWidth: 80, minHeight: 36),
    );

    return sectionCard(
      background: radiusBg,
      accent: radiusAccent,
      title: '7. borderRadius and borderWidth',
      description:
          'borderRadius is the rounding of the *outermost* bar corners; the '
          'seams between cells remain sharp regardless. borderWidth is the '
          'thickness of every border edge (outer perimeter and shared seams).',
      body: [
        labelledRow(
          'r=0  w=1',
          themed(
            data: base.copyWith(
              borderRadius: BorderRadius.zero,
              borderWidth: 1,
            ),
            isSelected: const [false, true, false],
            children: threeLabels(),
          ),
          accent: radiusAccent,
        ),
        labelledRow(
          'r=8  w=1',
          themed(
            data: base.copyWith(
              borderRadius: BorderRadius.circular(8),
              borderWidth: 1,
            ),
            isSelected: const [false, true, false],
            children: threeLabels(),
          ),
          accent: radiusAccent,
        ),
        labelledRow(
          'r=8  w=3',
          themed(
            data: base.copyWith(
              borderRadius: BorderRadius.circular(8),
              borderWidth: 3,
            ),
            isSelected: const [false, true, false],
            children: threeLabels(),
          ),
          accent: radiusAccent,
        ),
        labelledRow(
          'r=18 w=2',
          themed(
            data: base.copyWith(
              borderRadius: BorderRadius.circular(18),
              borderWidth: 2,
            ),
            isSelected: const [false, true, false],
            children: threeLabels(),
          ),
          accent: radiusAccent,
        ),
        labelledRow(
          'r=999 w=2 (pill)',
          themed(
            data: base.copyWith(
              borderRadius: BorderRadius.circular(999),
              borderWidth: 2,
            ),
            isSelected: const [false, true, false],
            children: threeLabels(),
          ),
          accent: radiusAccent,
        ),
        labelledRow(
          'asymmetric',
          themed(
            data: base.copyWith(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              borderWidth: 2,
            ),
            isSelected: const [false, true, false],
            children: threeLabels(),
          ),
          accent: radiusAccent,
        ),
      ],
    );
  }

  // ===========================================================================
  // SECTION 8 - copyWith WALKTHROUGH
  // ---------------------------------------------------------------------------
  // Take one base data instance and derive four variants via copyWith,
  // then render them in a row so a reader can see how a small data-only
  // change ripples into a visibly different button bar.
  // ===========================================================================
  Widget buildCopyWithCard() {
    final base = ToggleButtonsThemeData(
      color: Colors.black87,
      selectedColor: Colors.white,
      fillColor: copyAccent,
      borderColor: copyAccent.withOpacity(0.4),
      selectedBorderColor: copyAccent,
      borderRadius: BorderRadius.circular(8),
      borderWidth: 1.5,
      constraints: const BoxConstraints(minWidth: 90, minHeight: 36),
      textStyle: const TextStyle(fontWeight: FontWeight.w600),
    );

    final variantA = base.copyWith(fillColor: Colors.red.shade400);
    final variantB = base.copyWith(borderRadius: BorderRadius.circular(999));
    final variantC = base.copyWith(
      borderWidth: 4,
      selectedBorderColor: Colors.amber.shade700,
    );
    final variantD = base.copyWith(
      textStyle: const TextStyle(
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w500,
      ),
      constraints: const BoxConstraints(minWidth: 110, minHeight: 44),
    );

    return sectionCard(
      background: copyBg,
      accent: copyAccent,
      title: '8. copyWith walkthrough - one base, four variants',
      description:
          'copyWith returns a new ToggleButtonsThemeData where only the named '
          'fields are overridden and every other field falls through from the '
          'receiver. It is the primary way to derive themed variants without '
          'restating the entire field list. Variants below: red fill, pill, '
          'thick amber selected border, italic with bigger constraints.',
      body: [
        labelledRow('base',
            themed(
              data: base,
              isSelected: const [false, true, false],
              children: threeLabels(),
            ),
            accent: copyAccent),
        labelledRow('variantA',
            themed(
              data: variantA,
              isSelected: const [false, true, false],
              children: threeLabels(),
            ),
            accent: copyAccent),
        labelledRow('variantB',
            themed(
              data: variantB,
              isSelected: const [false, true, false],
              children: threeLabels(),
            ),
            accent: copyAccent),
        labelledRow('variantC',
            themed(
              data: variantC,
              isSelected: const [false, true, false],
              children: threeLabels(),
            ),
            accent: copyAccent),
        labelledRow('variantD',
            themed(
              data: variantD,
              isSelected: const [false, true, false],
              children: threeLabels(),
            ),
            accent: copyAccent),
        const SizedBox(height: 8),
        const Text(
          'Notice how every variant retains the base color, selectedColor, '
          'borderColor and selectedBorderColor - copyWith is purely additive '
          'over its receiver. Pass null in copyWith to *unset* a field.',
          style: TextStyle(fontSize: 12, height: 1.4),
        ),
      ],
    );
  }

  // ===========================================================================
  // SECTION 9 - LERP INTERPOLATION SLIDER
  // ---------------------------------------------------------------------------
  // We use a StatefulBuilder so the user can drag a slider that drives the
  // `t` parameter of ToggleButtonsThemeData.lerp(a, b, t). Because the lerp
  // method handles colour, border width, and constraints interpolation, the
  // visible bar morphs smoothly between two carefully-chosen endpoints as
  // the slider moves.
  // ===========================================================================
  Widget buildLerpCard() {
    final themeA = ToggleButtonsThemeData(
      color: Colors.indigo.shade700,
      selectedColor: Colors.white,
      fillColor: Colors.indigo.shade400,
      borderColor: Colors.indigo.shade200,
      selectedBorderColor: Colors.indigo.shade700,
      borderRadius: BorderRadius.circular(4),
      borderWidth: 1,
      constraints: const BoxConstraints(minWidth: 80, minHeight: 36),
      textStyle: const TextStyle(fontWeight: FontWeight.w400),
    );

    final themeB = ToggleButtonsThemeData(
      color: Colors.deepOrange.shade300,
      selectedColor: Colors.black,
      fillColor: Colors.amber.shade300,
      borderColor: Colors.deepOrange.shade100,
      selectedBorderColor: Colors.deepOrange.shade600,
      borderRadius: BorderRadius.circular(40),
      borderWidth: 4,
      constraints: const BoxConstraints(minWidth: 120, minHeight: 60),
      textStyle: const TextStyle(
        fontWeight: FontWeight.w900,
        fontStyle: FontStyle.italic,
      ),
    );

    return sectionCard(
      background: lerpBg,
      accent: lerpAccent,
      title: '9. lerp - smooth interpolation between two themes',
      description:
          'ToggleButtonsThemeData.lerp(a, b, t) returns a new data instance '
          'whose colour, border-width, border-radius and constraints fields '
          'have been linearly interpolated by t in [0, 1]. Drag the slider '
          'and watch the bar morph from the cool indigo theme A on the left '
          'into the warm orange theme B on the right.',
      body: [
        StatefulBuilder(
          builder: (ctx, setState) {
            // We hold the slider value in a closure-local through StatefulBuilder
            // so each re-render carries the latest t.
            return _LerpSliderBody(
              themeA: themeA,
              themeB: themeB,
              accent: lerpAccent,
              labels: threeLabels(),
            );
          },
        ),
      ],
    );
  }

  // ===========================================================================
  // SECTION 10 - EQUALITY / IDENTICAL / HASHCODE
  // ---------------------------------------------------------------------------
  // ToggleButtonsThemeData is a value type and overrides operator== and
  // hashCode. Two instances built with identical fields compare equal but
  // are not `identical`. Two references to the same instance are
  // `identical`. We compute these in a Builder and print them in monospace.
  // ===========================================================================
  Widget buildEqualityCard() {
    final a = ToggleButtonsThemeData(
      color: Colors.black,
      selectedColor: Colors.white,
      fillColor: equalityAccent,
      borderColor: equalityAccent.withOpacity(0.4),
      selectedBorderColor: equalityAccent,
      borderRadius: BorderRadius.circular(6),
      borderWidth: 2,
    );
    final b = ToggleButtonsThemeData(
      color: Colors.black,
      selectedColor: Colors.white,
      fillColor: equalityAccent,
      borderColor: equalityAccent.withOpacity(0.4),
      selectedBorderColor: equalityAccent,
      borderRadius: BorderRadius.circular(6),
      borderWidth: 2,
    );
    final c = a;
    final d = a.copyWith(borderWidth: 3);

    String boolFmt(bool v) => v ? 'true' : 'false';

    final lines = <String>[
      'identical(a, b)            = ${boolFmt(identical(a, b))}',
      'identical(a, c)            = ${boolFmt(identical(a, c))}',
      'a == b                     = ${boolFmt(a == b)}',
      'a == c                     = ${boolFmt(a == c)}',
      'a == d                     = ${boolFmt(a == d)}',
      'a.hashCode == b.hashCode   = ${boolFmt(a.hashCode == b.hashCode)}',
      'a.hashCode == c.hashCode   = ${boolFmt(a.hashCode == c.hashCode)}',
      'a.hashCode == d.hashCode   = ${boolFmt(a.hashCode == d.hashCode)}',
    ];

    return sectionCard(
      background: equalityBg,
      accent: equalityAccent,
      title: '10. Equality / identical / hashCode showcase',
      description:
          'ToggleButtonsThemeData is a value type with proper operator== and '
          'hashCode. a and b are constructed independently with the same '
          'fields - they are equal but not identical. c is just an alias of '
          'a. d is a copyWith mutation - not equal to a, and the hash code '
          'should differ (although hash collisions are theoretically '
          'possible).',
      body: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: equalityAccent.withOpacity(0.25)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final line in lines)
                Text(
                  line,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // SECTION 11 - THEME.OF READBACK
  // ---------------------------------------------------------------------------
  // Wrap a Theme(data:...) around a Builder, then call
  // Theme.of(ctx).toggleButtonsTheme to read back the ToggleButtonsThemeData
  // that ToggleButtons would receive. Display every field in monospace next
  // to a live ToggleButtons rendered in the same context.
  // ===========================================================================
  Widget buildReadbackCard() {
    final demo = ToggleButtonsThemeData(
      color: Colors.black87,
      selectedColor: Colors.white,
      disabledColor: Colors.grey.shade400,
      fillColor: readbackAccent,
      focusColor: readbackAccent.withOpacity(0.3),
      hoverColor: readbackAccent.withOpacity(0.1),
      highlightColor: readbackAccent.withOpacity(0.2),
      splashColor: readbackAccent.withOpacity(0.4),
      borderColor: readbackAccent.withOpacity(0.4),
      selectedBorderColor: readbackAccent,
      disabledBorderColor: Colors.grey.shade300,
      borderRadius: BorderRadius.circular(8),
      borderWidth: 1.5,
      constraints: const BoxConstraints(minWidth: 96, minHeight: 40),
      textStyle: const TextStyle(fontWeight: FontWeight.w600),
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
      decoration: BoxDecoration(
        color: readbackBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: readbackAccent.withOpacity(0.35)),
      ),
      child: Theme(
        data: ThemeData(toggleButtonsTheme: demo),
        child: Builder(builder: (ctx) {
          final resolved = Theme.of(ctx).toggleButtonsTheme;
          final lines = <Widget>[];
          void addLine(String name, Object? value) {
            lines.add(Text(
              '${name.padRight(22)} = $value',
              style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
            ));
          }

          addLine('color', resolved.color);
          addLine('selectedColor', resolved.selectedColor);
          addLine('disabledColor', resolved.disabledColor);
          addLine('fillColor', resolved.fillColor);
          addLine('focusColor', resolved.focusColor);
          addLine('highlightColor', resolved.highlightColor);
          addLine('hoverColor', resolved.hoverColor);
          addLine('splashColor', resolved.splashColor);
          addLine('textStyle', resolved.textStyle);
          addLine('constraints', resolved.constraints);
          addLine('borderColor', resolved.borderColor);
          addLine('selectedBorderColor', resolved.selectedBorderColor);
          addLine('disabledBorderColor', resolved.disabledBorderColor);
          addLine('borderRadius', resolved.borderRadius);
          addLine('borderWidth', resolved.borderWidth);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                '11. Theme.of read-back card',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: readbackAccent,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Below are every field of the surrounding '
                'ToggleButtonsThemeData, read back through '
                'Theme.of(context).toggleButtonsTheme inside a Builder. The '
                'live ToggleButtons at the bottom is rendered inside the '
                'same context and inherits exactly these values.',
                style: TextStyle(fontSize: 13, height: 1.4),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: readbackAccent.withOpacity(0.25)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: lines,
                ),
              ),
              const SizedBox(height: 14),
              Center(
                child: ToggleButtons(
                  isSelected: const [false, true, false],
                  onPressed: (_) {},
                  children: threeLabels(),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  // ===========================================================================
  // SECTION 12 - DESIGN-TOKEN PRESETS
  // ---------------------------------------------------------------------------
  // Four ready-to-use ToggleButtonsThemeData presets representing canonical
  // visual treatments: Pill, Tab, Chip-like, and Outlined. Each is rendered
  // in its own subcard with a real live ToggleButtons.
  // ===========================================================================
  ToggleButtonsThemeData pillPreset() => ToggleButtonsThemeData(
        color: Colors.deepPurple.shade700,
        selectedColor: Colors.white,
        fillColor: Colors.deepPurple.shade400,
        borderColor: Colors.deepPurple.shade200,
        selectedBorderColor: Colors.deepPurple.shade700,
        borderRadius: BorderRadius.circular(999),
        borderWidth: 1.5,
        constraints: const BoxConstraints(minWidth: 90, minHeight: 36),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          letterSpacing: 0.6,
        ),
      );

  ToggleButtonsThemeData tabPreset() => ToggleButtonsThemeData(
        color: Colors.grey.shade700,
        selectedColor: Colors.indigo.shade800,
        fillColor: Colors.indigo.shade50,
        borderColor: Colors.transparent,
        selectedBorderColor: Colors.transparent,
        borderRadius: BorderRadius.circular(0),
        borderWidth: 0,
        constraints: const BoxConstraints(minWidth: 100, minHeight: 44),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      );

  ToggleButtonsThemeData chipPreset() => ToggleButtonsThemeData(
        color: Colors.teal.shade700,
        selectedColor: Colors.white,
        fillColor: Colors.teal.shade500,
        borderColor: Colors.teal.shade200,
        selectedBorderColor: Colors.teal.shade700,
        borderRadius: BorderRadius.circular(16),
        borderWidth: 1,
        constraints: const BoxConstraints(minWidth: 70, minHeight: 30),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
      );

  ToggleButtonsThemeData outlinedPreset() => ToggleButtonsThemeData(
        color: Colors.brown.shade700,
        selectedColor: Colors.brown.shade900,
        fillColor: Colors.brown.shade50,
        borderColor: Colors.brown.shade400,
        selectedBorderColor: Colors.brown.shade800,
        borderRadius: BorderRadius.circular(4),
        borderWidth: 2,
        constraints: const BoxConstraints(minWidth: 96, minHeight: 40),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          letterSpacing: 0.4,
        ),
      );

  Widget buildPresetsCard() {
    Widget presetTile(
        String label, String description, ToggleButtonsThemeData data) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: presetAccent.withOpacity(0.25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
                fontSize: 13,
                color: presetAccent,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: const TextStyle(fontSize: 12, height: 1.4),
            ),
            const SizedBox(height: 10),
            Center(
              child: themed(
                data: data,
                isSelected: const [false, true, false],
                children: threeLabels(),
              ),
            ),
          ],
        ),
      );
    }

    return sectionCard(
      background: presetBg,
      accent: presetAccent,
      title: '12. Design-token presets - Pill / Tab / Chip / Outlined',
      description:
          'Four named visual treatments expressed entirely as '
          'ToggleButtonsThemeData. Use any of them as a starting point and '
          'derive variants with copyWith.',
      body: [
        presetTile(
          'Pill',
          'High-contrast, fully rounded ends, weighty letter-spacing. Useful '
              'as primary navigation chips in onboarding, settings, etc.',
          pillPreset(),
        ),
        presetTile(
          'Tab',
          'Borderless, low-contrast subtle background on the selected cell. '
              'Suits internal tab strips that share a card with content.',
          tabPreset(),
        ),
        presetTile(
          'Chip-like',
          'Small, mid-rounded, dense. Mimics InputChip without the dismiss '
              'affordance.',
          chipPreset(),
        ),
        presetTile(
          'Outlined',
          'Heavy 2px border with neutral fill. Reads as a sturdy form '
              'control next to TextFormFields and Switches.',
          outlinedPreset(),
        ),
      ],
    );
  }

  // ===========================================================================
  // SECTION 13 - DISABLED STATE TOUR
  // ---------------------------------------------------------------------------
  // Because passing onPressed: null disables the entire ToggleButtons, we
  // exercise four data instances that give the disabled state a different
  // visual signature - useful when the surrounding screen needs a less
  // ghostly disabled look than the framework default.
  // ===========================================================================
  Widget buildDisabledCard() {
    final base = ToggleButtonsThemeData(
      color: Colors.black87,
      selectedColor: Colors.white,
      fillColor: disabledAccent,
      borderColor: disabledAccent.withOpacity(0.4),
      selectedBorderColor: disabledAccent,
      borderRadius: BorderRadius.circular(6),
      borderWidth: 1.5,
    );

    return sectionCard(
      background: disabledBg,
      accent: disabledAccent,
      title: '13. Disabled state styling tour',
      description:
          'When ToggleButtons.onPressed is null the entire bar is disabled. '
          'disabledColor (foreground) and disabledBorderColor (perimeter) '
          'are the two fields that take over from the regular pair. Below '
          'are four different visual signatures for the same disabled bar.',
      body: [
        labelledRow(
          'soft grey',
          themed(
            data: base.copyWith(
              disabledColor: Colors.grey.shade400,
              disabledBorderColor: Colors.grey.shade300,
            ),
            isSelected: const [false, true, false],
            onPressed: null,
            children: threeLabels(),
          ),
          accent: disabledAccent,
        ),
        labelledRow(
          'red-tinted',
          themed(
            data: base.copyWith(
              disabledColor: Colors.red.shade200,
              disabledBorderColor: Colors.red.shade100,
            ),
            isSelected: const [false, true, false],
            onPressed: null,
            children: threeLabels(),
          ),
          accent: disabledAccent,
        ),
        labelledRow(
          'blueprint',
          themed(
            data: base.copyWith(
              disabledColor: Colors.blue.shade300,
              disabledBorderColor: Colors.blue.shade200,
            ),
            isSelected: const [false, true, false],
            onPressed: null,
            children: threeLabels(),
          ),
          accent: disabledAccent,
        ),
        labelledRow(
          'almost-invisible',
          themed(
            data: base.copyWith(
              disabledColor: Colors.black12,
              disabledBorderColor: Colors.black12,
            ),
            isSelected: const [false, true, false],
            onPressed: null,
            children: threeLabels(),
          ),
          accent: disabledAccent,
        ),
      ],
    );
  }

  // ===========================================================================
  // SECTION 14 - MULTI-SELECT WITH STATE-DRIVEN SELECTION
  // ---------------------------------------------------------------------------
  // Use a StatefulBuilder to track a List<bool> of selections. Each tap on a
  // cell toggles the corresponding entry. This is the canonical multi-select
  // pattern with ToggleButtons and is independent of any theme nesting.
  // ===========================================================================
  Widget buildMultiSelectCard() {
    final theme = ToggleButtonsThemeData(
      color: multiAccent,
      selectedColor: Colors.white,
      fillColor: multiAccent,
      borderColor: multiAccent.withOpacity(0.4),
      selectedBorderColor: multiAccent,
      borderRadius: BorderRadius.circular(8),
      borderWidth: 1.5,
      constraints: const BoxConstraints(minWidth: 56, minHeight: 40),
    );

    return sectionCard(
      background: multiBg,
      accent: multiAccent,
      title: '14. Multi-select with state-driven selection',
      description:
          'Each icon cell flips its corresponding bool in a List<bool> that '
          'lives in the StatefulBuilder. The same ToggleButtonsThemeData is '
          'shared by all states - only the isSelected list mutates.',
      body: [
        StatefulBuilder(
          builder: (ctx, setState) {
            return _MultiSelectBody(theme: theme, accent: multiAccent);
          },
        ),
      ],
    );
  }

  // ===========================================================================
  // SECTION 15 - BORDERLESS VARIANT
  // ---------------------------------------------------------------------------
  // To remove the perimeter without disabling the ink response, set
  // borderColor / selectedBorderColor / disabledBorderColor all to
  // Colors.transparent and (optionally) borderWidth to 0. We do both, then
  // compare against a translucent-border variant for contrast.
  // ===========================================================================
  Widget buildBorderlessCard() {
    final solid = ToggleButtonsThemeData(
      color: borderlessAccent.withOpacity(0.8),
      selectedColor: Colors.white,
      fillColor: borderlessAccent,
      borderColor: borderlessAccent,
      selectedBorderColor: borderlessAccent,
      borderRadius: BorderRadius.circular(8),
      borderWidth: 2,
      constraints: const BoxConstraints(minWidth: 90, minHeight: 38),
      textStyle: const TextStyle(fontWeight: FontWeight.w600),
    );

    final transparent = solid.copyWith(
      borderColor: Colors.transparent,
      selectedBorderColor: Colors.transparent,
      disabledBorderColor: Colors.transparent,
    );

    final zeroWidth = solid.copyWith(borderWidth: 0);

    final translucent = solid.copyWith(
      borderColor: borderlessAccent.withOpacity(0.15),
      selectedBorderColor: borderlessAccent.withOpacity(0.4),
    );

    return sectionCard(
      background: borderlessBg,
      accent: borderlessAccent,
      title: '15. Borderless variant',
      description:
          'Three approaches to a less visually heavy bar: transparent border '
          'colors, zero borderWidth, and a translucent border. Each has a '
          'subtly different gesture footprint, and each is just a copyWith '
          'away from the solid base.',
      body: [
        labelledRow('solid', themed(data: solid, isSelected: const [false, true, false], children: threeLabels()), accent: borderlessAccent),
        labelledRow('transparent', themed(data: transparent, isSelected: const [false, true, false], children: threeLabels()), accent: borderlessAccent),
        labelledRow('borderWidth=0', themed(data: zeroWidth, isSelected: const [false, true, false], children: threeLabels()), accent: borderlessAccent),
        labelledRow('translucent', themed(data: translucent, isSelected: const [false, true, false], children: threeLabels()), accent: borderlessAccent),
      ],
    );
  }

  // ===========================================================================
  // SECTION 16 - DECISION GUIDE
  // ---------------------------------------------------------------------------
  // A textual decision card that explains, in prose, when a developer should
  // reach for ToggleButtonsThemeData and when they should reach for
  // SegmentedButton.styleFrom (the modern Material3 alternative).
  // ===========================================================================
  Widget buildDecisionCard() {
    Widget bullet(String head, String body) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: RichText(
          text: TextSpan(
            style: const TextStyle(
              fontSize: 13,
              height: 1.4,
              color: Colors.black87,
            ),
            children: [
              TextSpan(
                text: '$head: ',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextSpan(text: body),
            ],
          ),
        ),
      );
    }

    return sectionCard(
      background: decisionBg,
      accent: decisionAccent,
      title: '16. Decision guide - ToggleButtonsThemeData vs SegmentedButton.styleFrom',
      description:
          'Both APIs solve roughly the same problem - styling a multi-cell '
          'selector - but they differ in scope, defaults, and Material '
          'version alignment. Use this card as a quick decision rubric.',
      body: [
        const Text(
          'Reach for ToggleButtonsThemeData when:',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
        ),
        const SizedBox(height: 6),
        bullet(
          'Material 2 alignment',
          'Your screen still uses ButtonBar / RaisedButton / FlatButton '
              'patterns and you want a consistent legacy look.',
        ),
        bullet(
          'Multi-select required',
          'You need more than one cell selected at the same time. '
              'SegmentedButton requires multiSelectionEnabled true and is '
              'still single-select first by default.',
        ),
        bullet(
          'Tight visual control',
          'You need pixel-level control over individual cell borders and '
              'corners; the ToggleButtonsThemeData borderRadius applies '
              'only to the outer corners by design.',
        ),
        bullet(
          'Mixed children',
          'Your cells mix icons, text, and arbitrary widgets. ToggleButtons '
              'paints children verbatim; SegmentedButton wraps each into '
              'a typed ButtonSegment.',
        ),
        const SizedBox(height: 10),
        const Text(
          'Reach for SegmentedButton.styleFrom when:',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
        ),
        const SizedBox(height: 6),
        bullet(
          'Material 3 alignment',
          'Your app already targets Material 3 and surrounding widgets '
              'follow the M3 token system.',
        ),
        bullet(
          'Form-style segments',
          'You want a form control with proper accessibility semantics '
              '(SegmentedButton announces selection state per segment).',
        ),
        bullet(
          'Animated transitions',
          'You want the built-in M3 selection animation between segments '
              'without writing your own AnimatedContainer or implicit '
              'transitions.',
        ),
        bullet(
          'Per-state styling',
          'You need MaterialState-driven styling - hovered, focused, '
              'pressed, selected each get their own visual definition '
              'with WidgetStateProperty.resolveWith.',
        ),
        const SizedBox(height: 10),
        const Text(
          'Tie-breaker: if you are starting a new screen on Material 3 '
          'pick SegmentedButton; if you are touching an existing Material 2 '
          'screen, stay on ToggleButtons + ToggleButtonsThemeData and '
          'consume your design tokens through the data class.',
          style: TextStyle(
            fontSize: 12,
            fontStyle: FontStyle.italic,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // SECTION 17 - REFERENCE
  // ---------------------------------------------------------------------------
  // The traditional reference appendix - every ToggleButtonsThemeData field
  // with its type and a short prose meaning.
  // ===========================================================================
  Widget refRow(String name, String type, String meaning) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 200,
            child: Text(
              name,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
          SizedBox(
            width: 200,
            child: Text(
              type,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            child: Text(
              meaning,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildReferenceCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 14),
      decoration: BoxDecoration(
        color: referenceBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: referenceAccent.withOpacity(0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            '17. Reference - every ToggleButtonsThemeData field',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: referenceAccent,
            ),
          ),
          const SizedBox(height: 8),
          refRow('color', 'Color?',
              'Foreground colour for unselected cells.'),
          refRow('selectedColor', 'Color?',
              'Foreground colour for selected cells (rendered against fillColor).'),
          refRow('disabledColor', 'Color?',
              'Foreground colour for cells whose ToggleButtons has onPressed: null.'),
          refRow('fillColor', 'Color?',
              'Background colour for the currently-selected cell.'),
          refRow('focusColor', 'Color?',
              'Reaction colour while a cell holds keyboard focus.'),
          refRow('highlightColor', 'Color?',
              'Long-press highlight colour on touch devices.'),
          refRow('hoverColor', 'Color?',
              'Reaction colour while a mouse cursor sits over a cell.'),
          refRow('splashColor', 'Color?',
              'Ink-ripple colour while a press is in flight.'),
          refRow('textStyle', 'TextStyle?',
              'TextStyle merged into the DefaultTextStyle inside each cell.'),
          refRow('constraints', 'BoxConstraints?',
              'Size envelope (min/max width/height) applied to every cell.'),
          refRow('borderColor', 'Color?',
              'Border colour for unselected cells.'),
          refRow('selectedBorderColor', 'Color?',
              'Border colour for selected cells.'),
          refRow('disabledBorderColor', 'Color?',
              'Border colour when the bar has onPressed: null.'),
          refRow('borderRadius', 'BorderRadius?',
              'Rounding of the outermost bar corners (cell seams stay sharp).'),
          refRow('borderWidth', 'double?',
              'Thickness in logical pixels of every border edge.'),
          const SizedBox(height: 12),
          const Text(
            'Resolution sequence inside ToggleButtons:',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
          const SizedBox(height: 4),
          const Text(
            '  field = constructor.field ?? '
            'ToggleButtonsTheme.of(context).field ?? '
            'Theme.of(context).toggleButtonsTheme.field ?? '
            'hard-coded default',
            style: TextStyle(fontFamily: 'monospace', fontSize: 12),
          ),
          const SizedBox(height: 12),
          const Text(
            'Operations on the data class:',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
          const SizedBox(height: 4),
          const Text(
            '  copyWith({...})  - per-field override; null leaves a field intact.\n'
            '  static lerp(a, b, t) - linear interpolation across colour, '
            'border-width, border-radius and constraints fields.\n'
            '  operator==       - structural equality across all fields.\n'
            '  hashCode         - consistent with operator==; cached.',
            style: TextStyle(fontFamily: 'monospace', fontSize: 12, height: 1.4),
          ),
          const SizedBox(height: 12),
          const Text(
            'Common pitfalls:',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
          const SizedBox(height: 4),
          const Text(
            '  - copyWith does NOT clear a field by passing null; pass null to '
            'leave it unchanged. To clear, build a fresh instance.\n'
            '  - borderRadius applies only to the outer corners; cell seams are '
            'always square. To round seams use four separate widgets.\n'
            '  - textStyle is *merged* into DefaultTextStyle, so child Text '
            'widgets that already specify fontFamily etc. will win.',
            style: TextStyle(fontSize: 12, height: 1.4),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // ROOT TREE
  // ---------------------------------------------------------------------------
  // The mandatory harness contract: MaterialApp -> Scaffold -> SafeArea ->
  // SingleChildScrollView -> Column. The Column children are the seventeen
  // section cards above. We pad the outside by 16 logical pixels so the
  // tinted cards never touch the screen edges.
  // ===========================================================================
  return MaterialApp(
    title: 'ToggleButtonsThemeData Deep Demo',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.indigo,
      toggleButtonsTheme: const ToggleButtonsThemeData(),
    ),
    home: Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: const Text('ToggleButtonsThemeData deep demo'),
        backgroundColor: heroAccent,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildHeroCard(),
              buildColorTrioCard(),
              buildFillColorsCard(),
              buildTextStyleCard(),
              buildConstraintsCard(),
              buildBorderColorCard(),
              buildRadiusCard(),
              buildCopyWithCard(),
              buildLerpCard(),
              buildEqualityCard(),
              buildReadbackCard(),
              buildPresetsCard(),
              buildDisabledCard(),
              buildMultiSelectCard(),
              buildBorderlessCard(),
              buildDecisionCard(),
              buildReferenceCard(),
              const SizedBox(height: 24),
              const Center(
                child: Text(
                  '-- end of ToggleButtonsThemeData deep demo --',
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    ),
  );
}

// ============================================================================
// PRIVATE STATEFUL HELPERS
// ----------------------------------------------------------------------------
// The lerp slider and the multi-select section need persistent state across
// rebuilds. We define StatefulWidgets here so each section can hold its own
// independent state without coupling to the parent build function.
// ============================================================================

class _LerpSliderBody extends StatefulWidget {
  const _LerpSliderBody({
    required this.themeA,
    required this.themeB,
    required this.accent,
    required this.labels,
  });
  final ToggleButtonsThemeData themeA;
  final ToggleButtonsThemeData themeB;
  final Color accent;
  final List<Widget> labels;

  @override
  State<_LerpSliderBody> createState() => _LerpSliderBodyState();
}

class _LerpSliderBodyState extends State<_LerpSliderBody> {
  double t = 0.0;

  @override
  Widget build(BuildContext context) {
    final lerped = ToggleButtonsThemeData.lerp(widget.themeA, widget.themeB, t)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Text(
              'theme A',
              style: TextStyle(fontFamily: 'monospace', fontSize: 12),
            ),
            Expanded(
              child: Slider(
                value: t,
                min: 0,
                max: 1,
                divisions: 100,
                label: 't = ${t.toStringAsFixed(2)}',
                activeColor: widget.accent,
                inactiveColor: widget.accent.withOpacity(0.25),
                onChanged: (v) => setState(() => t = v),
              ),
            ),
            const Text(
              'theme B',
              style: TextStyle(fontFamily: 'monospace', fontSize: 12),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Center(
          child: Text(
            't = ${t.toStringAsFixed(2)}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: widget.accent,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: Theme(
            data: ThemeData(toggleButtonsTheme: lerped),
            child: ToggleButtons(
              isSelected: const [false, true, false],
              onPressed: (_) {},
              children: widget.labels,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: widget.accent.withOpacity(0.25)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'lerped.borderWidth   = ${lerped.borderWidth?.toStringAsFixed(2)}',
                style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
              ),
              Text(
                'lerped.borderRadius  = ${lerped.borderRadius}',
                style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
              ),
              Text(
                'lerped.constraints   = ${lerped.constraints}',
                style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
              ),
              Text(
                'lerped.fillColor     = ${lerped.fillColor}',
                style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
              ),
              Text(
                'lerped.selectedBorder= ${lerped.selectedBorderColor}',
                style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MultiSelectBody extends StatefulWidget {
  const _MultiSelectBody({required this.theme, required this.accent});
  final ToggleButtonsThemeData theme;
  final Color accent;

  @override
  State<_MultiSelectBody> createState() => _MultiSelectBodyState();
}

class _MultiSelectBodyState extends State<_MultiSelectBody> {
  // Five toolbar-style toggles: bold, italic, underline, strikethrough,
  // mono. Each cell flips its boolean independently; the bar shows that
  // ToggleButtons supports multi-select natively (no special flag needed).
  final List<bool> selection = <bool>[true, false, false, false, false];

  static const List<IconData> icons = <IconData>[
    Icons.format_bold,
    Icons.format_italic,
    Icons.format_underline,
    Icons.format_strikethrough,
    Icons.code,
  ];

  static const List<String> names = <String>[
    'bold',
    'italic',
    'underline',
    'strike',
    'mono',
  ];

  @override
  Widget build(BuildContext context) {
    final selectedNames = <String>[];
    for (var i = 0; i < selection.length; i++) {
      if (selection[i]) selectedNames.add(names[i]);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Theme(
            data: ThemeData(toggleButtonsTheme: widget.theme),
            child: ToggleButtons(
              isSelected: selection,
              onPressed: (i) {
                setState(() {
                  selection[i] = !selection[i];
                });
              },
              children: [
                for (final ic in icons)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Icon(ic),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: widget.accent.withOpacity(0.25)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'selection list  = $selection',
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
              Text(
                'selected names  = $selectedNames',
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
              Text(
                'count selected  = ${selectedNames.length}',
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// PRIVATE EXTENSIONS
// ----------------------------------------------------------------------------
// Tiny convenience extension used by the disabled-only border row in the
// border-color section. Returning the widget verbatim avoids a duplicate
// `themed(... onPressed: null)` call site.
// ============================================================================

extension _OptionalDisabled on Widget {
  Widget _maybeDisabled() => this;
}
