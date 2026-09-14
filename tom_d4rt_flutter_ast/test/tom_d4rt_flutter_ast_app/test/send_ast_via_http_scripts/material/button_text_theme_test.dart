// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== ButtonTextTheme Deep Demo ===');
  for (final v in ButtonTextTheme.values) {
    print('  ${v.index}: ${v.name}');
  }

  // ==========================================================================
  // SECTION 1 - HERO CARD
  // A first encounter: the three enum values applied to FlatButtons under a
  // default light theme. This is intentionally minimal so the eye can
  // discover the actual contrast difference between normal / accent / primary
  // before any other variable is introduced.
  // ==========================================================================
  final heroBackground = const Color(0xFFFAF6FF);
  final heroAccent = const Color(0xFF6750A4);
  final heroBorder = const Color(0xFFD0BCFF);
  final heroTextStrong = const Color(0xFF1D1B20);
  final heroTextSoft = const Color(0xFF49454F);

  final heroSection = Card(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    color: heroBackground,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
      side: BorderSide(color: heroBorder, width: 1.4),
    ),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: heroAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'BT',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ButtonTextTheme',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: heroTextStrong,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'three values, three foreground tints',
                      style: TextStyle(fontSize: 13, color: heroTextSoft),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            'A flat row of FlatButtons, one per enum value, sharing the same '
            'label and the same Material default theme. Only the textTheme '
            'parameter changes between them. Notice how normal renders the '
            'theme body text colour, accent picks up the colorScheme.secondary, '
            'and primary picks up the colorScheme.primary.',
            style: TextStyle(fontSize: 13.5, color: heroTextSoft, height: 1.4),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: _heroTile(
                  label: 'normal',
                  description: 'theme body text',
                  background: Colors.white,
                  borderColor: heroBorder,
                  button: MaterialButton(
                    onPressed: () {},
                    textTheme: ButtonTextTheme.normal,
                    child: const Text('Submit'),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _heroTile(
                  label: 'accent',
                  description: 'colorScheme.secondary',
                  background: Colors.white,
                  borderColor: heroBorder,
                  button: MaterialButton(
                    onPressed: () {},
                    textTheme: ButtonTextTheme.accent,
                    child: const Text('Submit'),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _heroTile(
                  label: 'primary',
                  description: 'colorScheme.primary',
                  background: Colors.white,
                  borderColor: heroBorder,
                  button: MaterialButton(
                    onPressed: () {},
                    textTheme: ButtonTextTheme.primary,
                    child: const Text('Submit'),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFEADDFF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: heroAccent, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'ButtonTextTheme is read by ButtonBarThemeData and by the '
                    'legacy MaterialButton family (FlatButton / RaisedButton / '
                    'OutlineButton). Modern TextButton / ElevatedButton derive '
                    'colour through ButtonStyle instead.',
                    style: TextStyle(fontSize: 12.5, color: heroTextStrong),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF4E5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFFFD180), width: 1),
            ),
            child: Row(
              children: [
                Icon(Icons.warning_amber_rounded,
                    color: const Color(0xFFB26A00), size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Deprecation note: ButtonBarThemeData.buttonTextTheme historically propagated this enum down a widget subtree. Modern Flutter has dropped that propagation; the equivalent today is per-button styling via style: overrides on ElevatedButton, TextButton, OutlinedButton etc. This demo focuses on the ButtonTextTheme enum itself - every visible button below sets MaterialButton.textTheme directly so the resolved colour is driven by the enum value alone.',
                    style: TextStyle(
                      fontSize: 12.5,
                      color: const Color(0xFF7A4A00),
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  // ==========================================================================
  // SECTION 2 - BRIGHTNESS SWEEP
  // The same three values rendered twice: once on a light surface inside a
  // Brightness.light theme, once on a dark surface inside a Brightness.dark
  // theme. The point is to show that the resolved foreground colour is
  // brightness-aware: under dark themes, the picked colour is the lighter
  // sibling from the swatch.
  // ==========================================================================
  final brightnessLightBg = const Color(0xFFEFF5FB);
  final brightnessDarkBg = const Color(0xFF1B232E);
  final brightnessAccent = const Color(0xFF1976D2);
  final brightnessAccentDark = const Color(0xFF90CAF9);

  final brightnessSweep = Card(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    color: const Color(0xFFFFFFFF),
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
      side: const BorderSide(color: Color(0xFFCBD5E1), width: 1.4),
    ),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '2 - Brightness Sweep',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: brightnessAccent,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Same enum values, different brightness baselines.',
            style: TextStyle(fontSize: 13, color: Color(0xFF475569)),
          ),
          const SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Theme(
                  data: ThemeData(
                    brightness: Brightness.light,
                    primaryColor: brightnessAccent,
                    colorScheme: const ColorScheme.light(
                      primary: Color(0xFF1976D2),
                      secondary: Color(0xFFE91E63),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: brightnessLightBg,
                      borderRadius: BorderRadius.circular(14),
                      border: const Border(
                        left: BorderSide(color: Color(0xFF1976D2), width: 4),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.wb_sunny_outlined,
                                size: 18, color: Color(0xFF1976D2)),
                            SizedBox(width: 6),
                            Text(
                              'Brightness.light',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _labelledMaterialButton(
                          'normal', ButtonTextTheme.normal, 'Save'),
                        const SizedBox(height: 6),
                        _labelledMaterialButton(
                            'accent', ButtonTextTheme.accent, 'Save'),
                        const SizedBox(height: 6),
                        _labelledMaterialButton(
                            'primary', ButtonTextTheme.primary, 'Save'),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Theme(
                  data: ThemeData(
                    brightness: Brightness.dark,
                    primaryColor: brightnessAccentDark,
                    colorScheme: const ColorScheme.dark(
                      primary: Color(0xFF90CAF9),
                      secondary: Color(0xFFF48FB1),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: brightnessDarkBg,
                      borderRadius: BorderRadius.circular(14),
                      border: const Border(
                        left: BorderSide(color: Color(0xFF90CAF9), width: 4),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.nightlight_round,
                                size: 18, color: Color(0xFF90CAF9)),
                            SizedBox(width: 6),
                            Text(
                              'Brightness.dark',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Color(0xFFF1F5F9),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _labelledMaterialButton(
                          'normal', ButtonTextTheme.normal, 'Save',
                          labelColor: const Color(0xFFCBD5E1),
                        ),
                        const SizedBox(height: 6),
                        _labelledMaterialButton(
                          'accent', ButtonTextTheme.accent, 'Save',
                          labelColor: const Color(0xFFCBD5E1),
                        ),
                        const SizedBox(height: 6),
                        _labelledMaterialButton(
                          'primary', ButtonTextTheme.primary, 'Save',
                          labelColor: const Color(0xFFCBD5E1),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Text(
            'Observation: under Brightness.dark the resolved colour is the '
            'lighter swatch sibling, because Material assumes the surface is '
            'dark and lightens the foreground for contrast. The enum value '
            'itself is unchanged - the resolution path is.',
            style: TextStyle(
              fontSize: 12.5,
              color: Color(0xFF475569),
              height: 1.4,
            ),
          ),
        ],
      ),
    ),
  );

  // ==========================================================================
  // SECTION 3 - COLOR SCHEME TINTING
  // Three nested Themes: each one mutates only the colorScheme. The same
  // FlatButton with ButtonTextTheme.primary should follow the colorScheme.
  // primary, while the same button with ButtonTextTheme.accent should follow
  // the colorScheme.secondary - so swapping these two scheme entries is the
  // visible test of the resolution path.
  // ==========================================================================
  final schemeAcards = const [
    _SchemeRecipe(
      label: 'Indigo / Amber',
      primary: Color(0xFF3F51B5),
      secondary: Color(0xFFFFC107),
      surface: Color(0xFFE8EAF6),
      accent: Color(0xFF1A237E),
    ),
    _SchemeRecipe(
      label: 'Teal / Pink',
      primary: Color(0xFF00897B),
      secondary: Color(0xFFEC407A),
      surface: Color(0xFFE0F2F1),
      accent: Color(0xFF004D40),
    ),
    _SchemeRecipe(
      label: 'DeepOrange / Cyan',
      primary: Color(0xFFE64A19),
      secondary: Color(0xFF00ACC1),
      surface: Color(0xFFFFF3E0),
      accent: Color(0xFFBF360C),
    ),
  ];

  final schemeSection = Card(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    color: const Color(0xFFFFFDE7),
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
      side: const BorderSide(color: Color(0xFFFFE082), width: 1.4),
    ),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '3 - ColorScheme Tinting',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF6D4C41),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Mutate only the colorScheme; watch primary and accent values '
            'follow each entry independently.',
            style: TextStyle(fontSize: 13, color: Color(0xFF6D4C41)),
          ),
          const SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < schemeAcards.length; i++) ...[
                if (i != 0) const SizedBox(width: 10),
                Expanded(child: _schemeRecipeCard(schemeAcards[i])),
              ],
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFFFE082),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'Internally, ButtonTextTheme.primary -> colorScheme.primary, '
              'ButtonTextTheme.accent -> colorScheme.secondary, and '
              'ButtonTextTheme.normal -> theme textTheme body colour.',
              style: TextStyle(fontSize: 12.5, color: Color(0xFF4E342E)),
            ),
          ),
        ],
      ),
    ),
  );

  // ==========================================================================
  // SECTION 4 - FOOTER ROW APPLICATION
  // The classic place to mix ButtonTextTheme values is a card footer with two
  // or three actions. Each footer below renders the same trio of
  // MaterialButton actions, with one ButtonTextTheme value applied per row.
  // The wrapping layout primitive is a plain Wrap so nothing competes with
  // the enum as the visual subject.
  // ==========================================================================
  final buttonBarSection = Card(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    color: const Color(0xFFE0F7FA),
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
      side: const BorderSide(color: Color(0xFF80DEEA), width: 1.4),
    ),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '4 - Footer row application',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF006064),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Three footer rows, identical children, different '
            'ButtonTextTheme value applied per MaterialButton.',
            style: TextStyle(fontSize: 13, color: Color(0xFF00695C)),
          ),
          const SizedBox(height: 18),
          _textThemeRow(
            label: 'ButtonTextTheme.normal',
            description: 'inherits text colour from theme body',
            theme: ButtonTextTheme.normal,
            tintBackground: const Color(0xFFB2EBF2),
            stripeColor: const Color(0xFF00838F),
          ),
          const SizedBox(height: 12),
          _textThemeRow(
            label: 'ButtonTextTheme.accent',
            description: 'inherits colorScheme.secondary',
            theme: ButtonTextTheme.accent,
            tintBackground: const Color(0xFFB2DFDB),
            stripeColor: const Color(0xFF00796B),
          ),
          const SizedBox(height: 12),
          _textThemeRow(
            label: 'ButtonTextTheme.primary',
            description: 'inherits colorScheme.primary',
            theme: ButtonTextTheme.primary,
            tintBackground: const Color(0xFFC8E6C9),
            stripeColor: const Color(0xFF388E3C),
          ),
        ],
      ),
    ),
  );

  // ==========================================================================
  // SECTION 5 - DISABLED COLOUR PATH
  // Material's disabled-button colour is independent of ButtonTextTheme,
  // but the resolution still passes through the ambient ThemeData. This
  // section pairs each enabled button with a disabled twin so the
  // disabledColor can be observed for each value.
  // ==========================================================================
  final disabledSection = Card(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    color: const Color(0xFFFFF1F2),
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
      side: const BorderSide(color: Color(0xFFFECDD3), width: 1.4),
    ),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '5 - Disabled colour path',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF9F1239),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Each enum paired with its disabled twin to show the disabledColor.',
            style: TextStyle(fontSize: 13, color: Color(0xFFBE123C)),
          ),
          const SizedBox(height: 18),
          _disabledPair(ButtonTextTheme.normal, 'normal',
              const Color(0xFFFFE4E6), const Color(0xFFE11D48)),
          const SizedBox(height: 10),
          _disabledPair(ButtonTextTheme.accent, 'accent',
              const Color(0xFFFFE4E6), const Color(0xFFBE123C)),
          const SizedBox(height: 10),
          _disabledPair(ButtonTextTheme.primary, 'primary',
              const Color(0xFFFFE4E6), const Color(0xFF9F1239)),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFFECACA),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'Disabled foreground is resolved through ThemeData.disabledColor '
              'and is intentionally desaturated relative to the active value.',
              style: TextStyle(fontSize: 12.5, color: Color(0xFF7F1D1D)),
            ),
          ),
        ],
      ),
    ),
  );

  // ==========================================================================
  // SECTION 6 - PRIMARYCOLOR FOLLOW-THROUGH
  // Three nested Themes that change ThemeData.primaryColor while leaving the
  // colorScheme alone. The 'primary' button picks up the new primaryColor
  // through the cascade. This is the demo of how a single colour swap up
  // the tree retints every primary-typed button below it.
  // ==========================================================================
  final primaryColorSection = Card(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    color: const Color(0xFFF1F8E9),
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
      side: const BorderSide(color: Color(0xFFC5E1A5), width: 1.4),
    ),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '6 - primaryColor follow-through',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF33691E),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Mutating ThemeData.primaryColor retints buttons that read it.',
            style: TextStyle(fontSize: 13, color: Color(0xFF558B2F)),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(child: _primaryColorChip(const Color(0xFF388E3C),
                  'forest', const Color(0xFFE8F5E9))),
              const SizedBox(width: 10),
              Expanded(child: _primaryColorChip(const Color(0xFFF57C00),
                  'amber', const Color(0xFFFFF3E0))),
              const SizedBox(width: 10),
              Expanded(child: _primaryColorChip(const Color(0xFF512DA8),
                  'royal', const Color(0xFFEDE7F6))),
            ],
          ),
        ],
      ),
    ),
  );

  // ==========================================================================
  // SECTION 7 - REFERENCE TABLE
  // The classic "name / index / description / resolved colour" table -
  // one row per enum value. This is the textual digest of everything the
  // visual sections demonstrated above.
  // ==========================================================================
  final referenceTable = Card(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    color: const Color(0xFFFFFFFF),
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
      side: const BorderSide(color: Color(0xFFCBD5E1), width: 1.4),
    ),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '7 - Reference table',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'name | index | description | resolved colour @ default light theme',
            style: TextStyle(fontSize: 12, color: Color(0xFF475569)),
          ),
          const SizedBox(height: 14),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFCBD5E1)),
            ),
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(11),
                      topRight: Radius.circular(11),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 10),
                  child: const Row(
                    children: [
                      SizedBox(
                        width: 70,
                        child: Text('name',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 12.5,
                              color: Color(0xFF0F172A),
                            )),
                      ),
                      SizedBox(
                        width: 40,
                        child: Text('idx',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 12.5,
                              color: Color(0xFF0F172A),
                            )),
                      ),
                      Expanded(
                        child: Text('description',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 12.5,
                              color: Color(0xFF0F172A),
                            )),
                      ),
                      SizedBox(
                        width: 130,
                        child: Text('resolved (light)',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 12.5,
                              color: Color(0xFF0F172A),
                            )),
                      ),
                    ],
                  ),
                ),
                _refRow('normal', 0, 'theme body text colour',
                    const Color(0xFF1D1B20), 'textTheme.bodyMedium'),
                _refRow('accent', 1, 'colorScheme.secondary',
                    const Color(0xFF03DAC6), 'scheme.secondary'),
                _refRow('primary', 2, 'colorScheme.primary',
                    const Color(0xFF6750A4), 'scheme.primary'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Resolved colours assume an unconfigured ThemeData.light() with the '
            'Material 3 default colour scheme. Custom colorSchemes will, of '
            'course, redirect both accent and primary - that is the entire '
            'point of the enum.',
            style: TextStyle(
              fontSize: 12.5,
              color: Color(0xFF475569),
              height: 1.4,
            ),
          ),
        ],
      ),
    ),
  );

  // ==========================================================================
  // SECTION 8 - REAL WORLD RECIPES
  // Three card mockups: a form footer with normal text-theme buttons, a
  // settings save bar with accent text-theme buttons, and a confirm-dialog
  // with primary text-theme buttons. This is the section that pretends to
  // live in a real product, showing why one would deliberately pick one
  // value over another.
  // ==========================================================================
  final recipeSection = Card(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    color: const Color(0xFFF8FAFC),
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
      side: const BorderSide(color: Color(0xFFCBD5E1), width: 1.4),
    ),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '8 - Real world recipes',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Three card mockups - each picks a different enum value for a '
            'reason rooted in product context.',
            style: TextStyle(fontSize: 13, color: Color(0xFF475569)),
          ),
          const SizedBox(height: 18),
          _recipeFormFooter(),
          const SizedBox(height: 14),
          _recipeSettingsBar(),
          const SizedBox(height: 14),
          _recipeConfirmDialog(),
        ],
      ),
    ),
  );

  // ==========================================================================
  // SECTION 9 - CLOSING NOTE
  // A small textual sign-off that wraps the page; useful to confirm visually
  // that the scroll view has bottomed out.
  // ==========================================================================
  final closingNote = Padding(
    padding: const EdgeInsets.fromLTRB(16, 18, 16, 30),
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'End of demo',
            style: TextStyle(
              color: Color(0xFFE2E8F0),
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'ButtonTextTheme is small but central to legacy Material button '
            'styling. The same three values drive the foreground of '
            'FlatButton / RaisedButton / OutlineButton via the cascade of '
            'colorScheme tinting; modern style: overrides on TextButton / '
            'ElevatedButton replicate it on a per-button basis.',
            style: TextStyle(
              color: Color(0xFF94A3B8),
              fontSize: 12.5,
              height: 1.4,
            ),
          ),
        ],
      ),
    ),
  );

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6750A4)),
    ),
    home: Scaffold(
      backgroundColor: const Color(0xFFF5F3FF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 6),
              heroSection,
              brightnessSweep,
              schemeSection,
              buttonBarSection,
              disabledSection,
              primaryColorSection,
              referenceTable,
              recipeSection,
              closingNote,
            ],
          ),
        ),
      ),
    ),
  );
}

// ============================================================================
// HELPERS
// All helpers are top-level functions returning Widgets. No private widget
// classes - the harness expects a plain build() in/out.
// ============================================================================

Widget _heroTile({
  required String label,
  required String description,
  required Color background,
  required Color borderColor,
  required Widget button,
}) {
  return Container(
    padding: const EdgeInsets.fromLTRB(10, 12, 10, 12),
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: borderColor, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Color(0xFF49454F),
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          description,
          style: const TextStyle(
            fontSize: 11,
            color: Color(0xFF6750A4),
          ),
        ),
        const SizedBox(height: 8),
        Align(alignment: Alignment.centerLeft, child: button),
      ],
    ),
  );
}

Widget _labelledMaterialButton(
  String label,
  ButtonTextTheme theme,
  String text, {
  Color labelColor = const Color(0xFF334155),
}) {
  return Row(
    children: [
      SizedBox(
        width: 64,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: labelColor,
          ),
        ),
      ),
      MaterialButton(
        onPressed: () {},
        textTheme: theme,
        child: Text(text),
      ),
    ],
  );
}

Widget _schemeRecipeCard(_SchemeRecipe recipe) {
  return Container(
    decoration: BoxDecoration(
      color: recipe.surface,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: recipe.primary.withOpacity(0.3)),
    ),
    padding: const EdgeInsets.all(12),
    child: Theme(
      data: ThemeData(
        colorScheme: ColorScheme.light(
          primary: recipe.primary,
          secondary: recipe.secondary,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            recipe.label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: recipe.accent,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              _swatch(recipe.primary, 'P'),
              const SizedBox(width: 4),
              _swatch(recipe.secondary, 'S'),
            ],
          ),
          const SizedBox(height: 10),
          MaterialButton(
            onPressed: () {},
            textTheme: ButtonTextTheme.normal,
            child: const Text('normal'),
          ),
          MaterialButton(
            onPressed: () {},
            textTheme: ButtonTextTheme.accent,
            child: const Text('accent'),
          ),
          MaterialButton(
            onPressed: () {},
            textTheme: ButtonTextTheme.primary,
            child: const Text('primary'),
          ),
        ],
      ),
    ),
  );
}

Widget _swatch(Color color, String letter) {
  return Container(
    width: 22,
    height: 22,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(6),
    ),
    alignment: Alignment.center,
    child: Text(
      letter,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 11,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _textThemeRow({
  required String label,
  required String description,
  required ButtonTextTheme theme,
  required Color tintBackground,
  required Color stripeColor,
}) {
  return Container(
    decoration: BoxDecoration(
      color: tintBackground,
      borderRadius: BorderRadius.circular(12),
      border: Border(left: BorderSide(color: stripeColor, width: 4)),
    ),
    padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 13,
            color: stripeColor,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          description,
          style: const TextStyle(fontSize: 11.5, color: Color(0xFF334155)),
        ),
        const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(
            'ButtonTextTheme.${theme.name}  (index ${theme.index})',
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              color: stripeColor,
              letterSpacing: 0.4,
            ),
          ),
        ),
        Wrap(
          spacing: 6,
          runSpacing: 4,
          children: [
            MaterialButton(
              onPressed: () {},
              textTheme: theme,
              child: Text(_styleHintFor(theme, 'Cancel')),
            ),
            MaterialButton(
              onPressed: () {},
              textTheme: theme,
              child: Text(_styleHintFor(theme, 'Discard')),
            ),
            MaterialButton(
              onPressed: () {},
              textTheme: theme,
              child: Text(_styleHintFor(theme, 'Save')),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          'Each MaterialButton above sets textTheme: ${theme.name} directly. '
          'The enum value is the only differentiator between rows; layout '
          'primitives (Wrap, Container, Padding) are deliberately neutral so '
          'nothing distracts from the colour resolution path.',
          style: const TextStyle(
              fontSize: 11, color: Color(0xFF334155), height: 1.35),
        ),
      ],
    ),
  );
}

String _styleHintFor(ButtonTextTheme theme, String base) {
  switch (theme) {
    case ButtonTextTheme.normal:
      return '$base (Normal sizing)';
    case ButtonTextTheme.accent:
      return '$base (Accent text)';
    case ButtonTextTheme.primary:
      return '$base (Padded sizing)';
  }
}

Widget _disabledPair(
  ButtonTextTheme theme,
  String label,
  Color background,
  Color labelColor,
) {
  return Container(
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(12),
    ),
    padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
    child: Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12.5,
              color: labelColor,
            ),
          ),
        ),
        const SizedBox(width: 6),
        MaterialButton(
          onPressed: () {},
          textTheme: theme,
          child: const Text('Active'),
        ),
        const SizedBox(width: 4),
        MaterialButton(
          onPressed: null,
          textTheme: theme,
          child: const Text('Disabled'),
        ),
        const SizedBox(width: 4),
        MaterialButton(
          onPressed: () {},
          textTheme: theme,
          child: const Text('Active'),
        ),
        const SizedBox(width: 4),
        MaterialButton(
          onPressed: null,
          textTheme: theme,
          child: const Text('Disabled'),
        ),
      ],
    ),
  );
}

Widget _primaryColorChip(Color primary, String label, Color surface) {
  return Theme(
    data: ThemeData(
      primaryColor: primary,
      colorScheme: ColorScheme.light(primary: primary),
    ),
    child: Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primary.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: primary,
            ),
          ),
          const SizedBox(height: 8),
          MaterialButton(
            onPressed: () {},
            textTheme: ButtonTextTheme.primary,
            child: const Text('Primary'),
          ),
          MaterialButton(
            onPressed: () {},
            textTheme: ButtonTextTheme.accent,
            child: const Text('Accent'),
          ),
          MaterialButton(
            onPressed: () {},
            textTheme: ButtonTextTheme.normal,
            child: const Text('Normal'),
          ),
        ],
      ),
    ),
  );
}

Widget _refRow(
  String name,
  int index,
  String description,
  Color resolved,
  String resolvedLabel,
) {
  return Container(
    decoration: const BoxDecoration(
      color: Colors.white,
      border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    child: Row(
      children: [
        SizedBox(
          width: 70,
          child: Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12.5,
              color: Color(0xFF0F172A),
            ),
          ),
        ),
        SizedBox(
          width: 40,
          child: Text(
            '$index',
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: Color(0xFF334155),
            ),
          ),
        ),
        Expanded(
          child: Text(
            description,
            style: const TextStyle(fontSize: 12, color: Color(0xFF475569)),
          ),
        ),
        SizedBox(
          width: 130,
          child: Row(
            children: [
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: resolved,
                  borderRadius: BorderRadius.circular(3),
                  border: Border.all(color: const Color(0xFFCBD5E1)),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  resolvedLabel,
                  style: const TextStyle(
                    fontSize: 11.5,
                    color: Color(0xFF334155),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _recipeFormFooter() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: const Color(0xFFE2E8F0)),
    ),
    padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Form footer (normal)',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 13.5,
            color: Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Cancel and Submit are visually equal in weight - normal text-theme '
          'keeps both buttons unobtrusive against a long form.',
          style: TextStyle(fontSize: 12, color: Color(0xFF475569)),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  'name@example.com',
                  style: TextStyle(fontSize: 12, color: Color(0xFF334155)),
                ),
              ),
              MaterialButton(
                onPressed: () {},
                textTheme: ButtonTextTheme.normal,
                child: const Text('Cancel'),
              ),
              const SizedBox(width: 4),
              MaterialButton(
                onPressed: () {},
                textTheme: ButtonTextTheme.normal,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _recipeSettingsBar() {
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFFFFF7ED),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: const Color(0xFFFED7AA)),
    ),
    padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Settings save bar (accent)',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 13.5,
            color: Color(0xFF7C2D12),
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Accent (colorScheme.secondary) gives Save mild prominence without '
          'shouting - the right level for non-destructive settings.',
          style: TextStyle(fontSize: 12, color: Color(0xFF7C2D12)),
        ),
        const SizedBox(height: 10),
        Theme(
          data: ThemeData(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFEA580C),
              secondary: Color(0xFFD97706),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFFED7AA)),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    '3 unsaved changes',
                    style: TextStyle(fontSize: 12, color: Color(0xFF92400E)),
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  textTheme: ButtonTextTheme.accent,
                  child: const Text('Discard'),
                ),
                const SizedBox(width: 4),
                MaterialButton(
                  onPressed: () {},
                  textTheme: ButtonTextTheme.accent,
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _recipeConfirmDialog() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: const Color(0xFFE2E8F0)),
      boxShadow: const [
        BoxShadow(color: Color(0x14000000), blurRadius: 8, offset: Offset(0, 2)),
      ],
    ),
    padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Confirm dialog (primary)',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 13.5,
            color: Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Primary text-theme makes the destructive action visually loud - '
          'it reads as the action the user is committing to.',
          style: TextStyle(fontSize: 12, color: Color(0xFF475569)),
        ),
        const SizedBox(height: 12),
        const Text(
          'Delete this workspace?',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'This action cannot be undone. All members will lose access.',
          style: TextStyle(fontSize: 12.5, color: Color(0xFF475569)),
        ),
        const SizedBox(height: 12),
        Theme(
          data: ThemeData(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFB91C1C),
              secondary: Color(0xFF1F2937),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MaterialButton(
                onPressed: () {},
                textTheme: ButtonTextTheme.normal,
                child: const Text('Cancel'),
              ),
              const SizedBox(width: 4),
              MaterialButton(
                onPressed: () {},
                textTheme: ButtonTextTheme.primary,
                child: const Text('Delete'),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _SchemeRecipe {
  final String label;
  final Color primary;
  final Color secondary;
  final Color surface;
  final Color accent;
  const _SchemeRecipe({
    required this.label,
    required this.primary,
    required this.secondary,
    required this.surface,
    required this.accent,
  });
}
