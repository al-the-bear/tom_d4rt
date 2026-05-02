// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo of ToggleButtonsTheme (the inherited widget).
// ----------------------------------------------------------------------------
// ToggleButtonsTheme is an InheritedTheme that distributes a
// ToggleButtonsThemeData to descendant ToggleButtons widgets. This file
// concentrates on the *inherited-widget* aspect:
//
//   - wrapping subtrees with ToggleButtonsTheme,
//   - layering ToggleButtonsTheme scopes (outer + inner overrides),
//   - .of(context) lookup walking up the widget tree,
//   - real-world recipes (markdown toolbar, settings panel),
//   - reusable widgets that depend solely on the inherited theme,
//   - animating between two themes with TweenAnimationBuilder + .lerp,
//   - relationship between ToggleButtonsTheme and
//     Theme.of(context).toggleButtonsTheme.
//
// A sibling file covers ToggleButtonsThemeData property-by-property.
// This file does NOT duplicate that data-class tour.
//
// Lookup order:
//   1. ToggleButtonsTheme.of(context) walks up the BuildContext until it
//      finds a ToggleButtonsTheme InheritedWidget; that data wins.
//   2. If none is found, it falls back to
//      Theme.of(context).toggleButtonsTheme.
// Closer scope wins. Each ToggleButtons resolves its appearance against
// whichever ToggleButtonsTheme is nearest - never global state.
// ----------------------------------------------------------------------------

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== ToggleButtonsTheme Deep Demo (inherited-widget focus) ===');

  // ===========================================================================
  // PALETTES - one per section, never reused.
  // ===========================================================================

  // Section 2 - twin sections: same theme via inherited widget vs ThemeData
  const Color twinBg = Color(0xFFE3F2FD);
  const Color twinFill = Color(0xFF1976D2);
  const Color twinSelectedFg = Color(0xFFFFFFFF);
  const Color twinUnselectedFg = Color(0xFF0D47A1);
  const Color twinBorder = Color(0xFF1565C0);

  // Section 3 - nested scope override (outer teal, inner amber)
  const Color outerTealBg = Color(0xFFE0F2F1);
  const Color outerTealFill = Color(0xFF00897B);
  const Color outerTealSelectedFg = Color(0xFFFFFFFF);
  const Color outerTealUnselectedFg = Color(0xFF004D40);
  const Color outerTealBorder = Color(0xFF00695C);
  const Color innerAmberFill = Color(0xFFFFA000);
  const Color innerAmberSelectedFg = Color(0xFF3E2723);

  // Section 4 - sibling sections (one purple, one green)
  const Color sibPurpleBg = Color(0xFFEDE7F6);
  const Color sibPurpleFill = Color(0xFF5E35B1);
  const Color sibPurpleSelectedFg = Color(0xFFFFFFFF);
  const Color sibPurpleUnselectedFg = Color(0xFF311B92);
  const Color sibPurpleBorder = Color(0xFF4527A0);

  const Color sibGreenBg = Color(0xFFE8F5E9);
  const Color sibGreenFill = Color(0xFF43A047);
  const Color sibGreenSelectedFg = Color(0xFFFFFFFF);
  const Color sibGreenUnselectedFg = Color(0xFF1B5E20);
  const Color sibGreenBorder = Color(0xFF2E7D32);

  // Section 5 - readout section (slate)
  const Color readoutBg = Color(0xFFCFD8DC);
  const Color readoutFill = Color(0xFF37474F);
  const Color readoutSelectedFg = Color(0xFFECEFF1);
  const Color readoutUnselectedFg = Color(0xFF263238);
  const Color readoutBorder = Color(0xFF455A64);

  // Section 6 - per-page-section theming (Pill / Outlined / Chip)
  const Color pillBg = Color(0xFFFCE4EC);
  const Color pillFill = Color(0xFFC2185B);
  const Color pillSelectedFg = Color(0xFFFFFFFF);
  const Color pillUnselectedFg = Color(0xFF880E4F);
  const Color pillBorder = Color(0xFFAD1457);

  const Color outlinedBg = Color(0xFFECEFF1);
  const Color outlinedFill = Color(0xFFB0BEC5);
  const Color outlinedSelectedFg = Color(0xFF263238);
  const Color outlinedUnselectedFg = Color(0xFF37474F);
  const Color outlinedBorder = Color(0xFF455A64);

  const Color chipBg = Color(0xFFFFF3E0);
  const Color chipFill = Color(0xFFEF6C00);
  const Color chipSelectedFg = Color(0xFFFFFFFF);
  const Color chipUnselectedFg = Color(0xFFE65100);
  const Color chipBorder = Color(0xFFFB8C00);

  // Section 7 - animation between themes
  const Color animStartBg = Color(0xFFE1F5FE);
  const Color animStartFill = Color(0xFF0288D1);
  const Color animStartSelectedFg = Color(0xFFFFFFFF);
  const Color animStartUnselectedFg = Color(0xFF01579B);
  const Color animStartBorder = Color(0xFF0277BD);

  const Color animEndFill = Color(0xFFD81B60);
  const Color animEndSelectedFg = Color(0xFFFFFFFF);
  const Color animEndUnselectedFg = Color(0xFF880E4F);
  const Color animEndBorder = Color(0xFFAD1457);

  // Section 8 - settings panel
  const Color panelBg = Color(0xFFF3E5F5);
  const Color panelChrome = Color(0xFF6A1B9A);
  const Color panelToolbarFill = Color(0xFF8E24AA);
  const Color panelToolbarSelectedFg = Color(0xFFFFFFFF);
  const Color panelToolbarUnselectedFg = Color(0xFF4A148C);
  const Color panelToolbarBorder = Color(0xFF7B1FA2);

  // Section 9 - decoupled themed toolbar
  const Color decoupledBg = Color(0xFFE0F7FA);
  const Color decoupledFill = Color(0xFF00838F);
  const Color decoupledSelectedFg = Color(0xFFFFFFFF);
  const Color decoupledUnselectedFg = Color(0xFF006064);
  const Color decoupledBorder = Color(0xFF00ACC1);

  // Section 10 - markdown editor toolbar
  const Color mdBg = Color(0xFFFAFAFA);
  const Color mdFill = Color(0xFF212121);
  const Color mdSelectedFg = Color(0xFFFFFFFF);
  const Color mdUnselectedFg = Color(0xFF424242);
  const Color mdBorder = Color(0xFF616161);

  // ===========================================================================
  // CANONICAL CHILDREN - alignment toggles reused across sections so visual
  // theming differences pop without label noise.
  // ===========================================================================

  List<Widget> alignChildren() {
    return const <Widget>[
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Icon(Icons.format_align_left),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Icon(Icons.format_align_center),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Icon(Icons.format_align_right),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Icon(Icons.format_align_justify),
      ),
    ];
  }

  List<Widget> viewChildren() {
    return const <Widget>[
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text('Day'),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text('Week'),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text('Month'),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text('Year'),
      ),
    ];
  }

  // ===========================================================================
  // FACTORY: a stateful ToggleButtons wrapped in a ToggleButtonsTheme. The
  // theme is the *only* way the buttons get their look in this demo - no
  // properties on ToggleButtons itself, just the inherited theme above.
  // ===========================================================================

  Widget themedToggle({
    required ToggleButtonsThemeData theme,
    required List<Widget> children,
    required List<bool> initial,
    bool isMultiSelect = false,
  }) {
    return StatefulBuilder(
      builder: (BuildContext sbContext, StateSetter setState) {
        final List<bool> sel = List<bool>.from(initial);
        return ToggleButtonsTheme(
          data: theme,
          child: ToggleButtons(
            isSelected: sel,
            onPressed: (int idx) {
              setState(() {
                if (isMultiSelect) {
                  sel[idx] = !sel[idx];
                } else {
                  for (int i = 0; i < sel.length; i++) {
                    sel[i] = i == idx;
                  }
                }
              });
            },
            children: children,
          ),
        );
      },
    );
  }

  // ===========================================================================
  // FACTORY: a generic section card.
  // ===========================================================================

  Widget sectionCard({
    required String title,
    required String description,
    required Color background,
    required Widget body,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Card(
        color: background,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Colors.black12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                description,
                style: const TextStyle(fontSize: 13, height: 1.4),
              ),
              const SizedBox(height: 14),
              body,
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // SECTION 1 - INTRO
  // ===========================================================================

  final Widget section1Intro = sectionCard(
    title: '1. ToggleButtonsTheme - the inherited-widget angle',
    description:
        'ToggleButtonsTheme is an InheritedTheme. It does one job: it makes a '
        'ToggleButtonsThemeData visible to every ToggleButtons descendant in '
        'its subtree. Each ToggleButtons calls ToggleButtonsTheme.of(context), '
        'which walks UP the BuildContext until it hits the nearest '
        'ToggleButtonsTheme; if none is present, it falls back to '
        'Theme.of(context).toggleButtonsTheme. The closest scope always wins.\n\n'
        'This file demonstrates the *inherited-widget* aspect: wrapping '
        'subtrees, layering scopes, decoupled child widgets that pull their '
        'look out of thin air via .of(context), animation between themes, and '
        'real-world recipes. A sibling file walks the data class field by '
        'field; we do not duplicate that here.',
    background: const Color(0xFFFAFAFA),
    body: const SizedBox.shrink(),
  );

  // ===========================================================================
  // SECTION 2 - INHERITED WIDGET vs ThemeData.toggleButtonsTheme
  // Same visual outcome, two routes. Left: ToggleButtonsTheme wrapping a
  // single ToggleButtons. Right: a nested Theme override sets
  // ThemeData.toggleButtonsTheme; the bare ToggleButtons inherits from there.
  // ===========================================================================

  const ToggleButtonsThemeData twinTheme = ToggleButtonsThemeData(
    color: twinUnselectedFg,
    selectedColor: twinSelectedFg,
    fillColor: twinFill,
    borderColor: twinBorder,
    selectedBorderColor: twinBorder,
    borderWidth: 1.5,
    borderRadius: BorderRadius.all(Radius.circular(8)),
    constraints: BoxConstraints(minHeight: 40, minWidth: 60),
  );

  final Widget section2Twin = sectionCard(
    title: '2. Two routes to the same look',
    description:
        'Both columns below render an identical ToggleButtons. The LEFT column '
        'uses ToggleButtonsTheme(data: ..., child: ...) wrapping a single '
        'ToggleButtons. The RIGHT column uses a nested Theme widget setting '
        'ThemeData.toggleButtonsTheme. Both deliver the same '
        'ToggleButtonsThemeData via .of(context). For a one-off subtree the '
        'inherited widget is lighter; for app-wide defaults the ThemeData '
        'route is canonical.',
    background: twinBg,
    body: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Route A: ToggleButtonsTheme inherited widget',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 8),
              themedToggle(
                theme: twinTheme,
                children: alignChildren(),
                initial: const <bool>[true, false, false, false],
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Route B: ThemeData.toggleButtonsTheme',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 8),
              Theme(
                data: Theme.of(context).copyWith(
                  toggleButtonsTheme: twinTheme,
                ),
                child: StatefulBuilder(
                  builder:
                      (BuildContext sbContext, StateSetter setState) {
                    final List<bool> sel = <bool>[
                      true,
                      false,
                      false,
                      false,
                    ];
                    return ToggleButtons(
                      isSelected: sel,
                      onPressed: (int idx) {
                        setState(() {
                          for (int i = 0; i < sel.length; i++) {
                            sel[i] = i == idx;
                          }
                        });
                      },
                      children: alignChildren(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 3 - NESTED SCOPE OVERRIDE
  // Outer ToggleButtonsTheme (teal). Inside, a child subtree introduces an
  // inner ToggleButtonsTheme that overrides ONLY fillColor/selectedColor.
  // Borders and unselected colors still come from the outer theme - merged
  // via copyWith.
  // ===========================================================================

  const ToggleButtonsThemeData outerTealTheme = ToggleButtonsThemeData(
    color: outerTealUnselectedFg,
    selectedColor: outerTealSelectedFg,
    fillColor: outerTealFill,
    borderColor: outerTealBorder,
    selectedBorderColor: outerTealBorder,
    borderWidth: 1.5,
    borderRadius: BorderRadius.all(Radius.circular(10)),
    constraints: BoxConstraints(minHeight: 40, minWidth: 64),
  );

  final Widget section3Nested = sectionCard(
    title: '3. Nested scope - inner theme overrides one field',
    description:
        'The OUTER ToggleButtonsTheme paints both ToggleButtons in teal by '
        'default. The second ToggleButtons sits inside another '
        'ToggleButtonsTheme that overrides only fillColor and selectedColor '
        'to amber. Other fields (borders, unselected color, radius, '
        'constraints) still come from the outer theme because we used the '
        'inherited theme as a starting point. This is the "narrow override" '
        'pattern: scope something tightly without rewriting the whole theme.',
    background: outerTealBg,
    body: ToggleButtonsTheme(
      data: outerTealTheme,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Outer theme only:',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
          const SizedBox(height: 8),
          StatefulBuilder(
            builder: (BuildContext sbContext, StateSetter setState) {
              final List<bool> sel = <bool>[false, true, false];
              return ToggleButtons(
                isSelected: sel,
                onPressed: (int idx) {
                  setState(() {
                    for (int i = 0; i < sel.length; i++) {
                      sel[i] = i == idx;
                    }
                  });
                },
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Text('Low'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Text('Medium'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Text('High'),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 16),
          const Text(
            'Inner theme overriding only fill / selected color:',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
          const SizedBox(height: 8),
          Builder(
            builder: (BuildContext innerContext) {
              // Read the outer theme via .of(context) and copyWith only the
              // fields we want to change. This is the canonical merge pattern.
              final ToggleButtonsThemeData inherited =
                  ToggleButtonsTheme.of(innerContext);
              final ToggleButtonsThemeData overlay = ToggleButtonsThemeData(
                color: inherited.color,
                selectedColor: innerAmberSelectedFg,
                disabledColor: inherited.disabledColor,
                fillColor: innerAmberFill,
                focusColor: inherited.focusColor,
                highlightColor: inherited.highlightColor,
                hoverColor: inherited.hoverColor,
                splashColor: inherited.splashColor,
                borderColor: inherited.borderColor,
                selectedBorderColor: inherited.selectedBorderColor,
                disabledBorderColor: inherited.disabledBorderColor,
                borderRadius: inherited.borderRadius,
                borderWidth: inherited.borderWidth,
                constraints: inherited.constraints,
                textStyle: inherited.textStyle,
              );
              return ToggleButtonsTheme(
                data: overlay,
                child: StatefulBuilder(
                  builder:
                      (BuildContext sbContext, StateSetter setState) {
                    final List<bool> sel = <bool>[false, true, false];
                    return ToggleButtons(
                      isSelected: sel,
                      onPressed: (int idx) {
                        setState(() {
                          for (int i = 0; i < sel.length; i++) {
                            sel[i] = i == idx;
                          }
                        });
                      },
                      children: const <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Text('Low'),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Text('Medium'),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Text('High'),
                        ),
                      ],
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    ),
  );

  // ===========================================================================
  // SECTION 4 - SIBLING SECTIONS
  // Two sibling ToggleButtonsTheme scopes side-by-side. Each receives a
  // different theme; neither leaks across the boundary. This is the canonical
  // "scoped subtree" guarantee of an inherited widget.
  // ===========================================================================

  const ToggleButtonsThemeData sibPurpleTheme = ToggleButtonsThemeData(
    color: sibPurpleUnselectedFg,
    selectedColor: sibPurpleSelectedFg,
    fillColor: sibPurpleFill,
    borderColor: sibPurpleBorder,
    selectedBorderColor: sibPurpleBorder,
    borderWidth: 1.5,
    borderRadius: BorderRadius.all(Radius.circular(20)),
    constraints: BoxConstraints(minHeight: 40, minWidth: 70),
  );

  const ToggleButtonsThemeData sibGreenTheme = ToggleButtonsThemeData(
    color: sibGreenUnselectedFg,
    selectedColor: sibGreenSelectedFg,
    fillColor: sibGreenFill,
    borderColor: sibGreenBorder,
    selectedBorderColor: sibGreenBorder,
    borderWidth: 1,
    borderRadius: BorderRadius.all(Radius.circular(4)),
    constraints: BoxConstraints(minHeight: 36, minWidth: 60),
  );

  final Widget section4Siblings = sectionCard(
    title: '4. Sibling scopes - independent themes',
    description:
        'Two ToggleButtonsTheme widgets sit side-by-side as siblings. The '
        'left subtree renders pill-shaped purple toggles; the right subtree '
        'renders sharp-cornered green toggles. Neither theme bleeds across. '
        'This shows that ToggleButtonsTheme strictly scopes its data to its '
        'own subtree - sibling subtrees see their own ancestors, never their '
        'cousins.',
    background: const Color(0xFFFAFAFA),
    body: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: sibPurpleBg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Sibling A (purple, pill shape)',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 8),
                themedToggle(
                  theme: sibPurpleTheme,
                  children: viewChildren(),
                  initial: const <bool>[true, false, false, false],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: sibGreenBg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Sibling B (green, sharp corners)',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 8),
                themedToggle(
                  theme: sibGreenTheme,
                  children: alignChildren(),
                  initial: const <bool>[false, false, true, false],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 5 - .of(context) READOUT
  // Display each resolved field of the inherited ToggleButtonsThemeData in a
  // debug card. This is what every descendant ToggleButtons sees when it
  // resolves its own appearance.
  // ===========================================================================

  const ToggleButtonsThemeData readoutTheme = ToggleButtonsThemeData(
    color: readoutUnselectedFg,
    selectedColor: readoutSelectedFg,
    fillColor: readoutFill,
    borderColor: readoutBorder,
    selectedBorderColor: readoutBorder,
    borderWidth: 2,
    borderRadius: BorderRadius.all(Radius.circular(6)),
    constraints: BoxConstraints(minHeight: 44, minWidth: 80),
    textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
  );

  String describeColor(Color? c) {
    if (c == null) return '(inherited / null)';
    return '#'
        '${c.value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
  }

  String describeRadius(BorderRadius? r) {
    if (r == null) return '(inherited / null)';
    return 'tl=${r.topLeft.x.toStringAsFixed(0)} '
        'tr=${r.topRight.x.toStringAsFixed(0)} '
        'br=${r.bottomRight.x.toStringAsFixed(0)} '
        'bl=${r.bottomLeft.x.toStringAsFixed(0)}';
  }

  String describeConstraints(BoxConstraints? c) {
    if (c == null) return '(inherited / null)';
    return 'minH=${c.minHeight.toStringAsFixed(0)} '
        'minW=${c.minWidth.toStringAsFixed(0)} '
        'maxH=${c.maxHeight == double.infinity ? 'inf' : c.maxHeight.toStringAsFixed(0)} '
        'maxW=${c.maxWidth == double.infinity ? 'inf' : c.maxWidth.toStringAsFixed(0)}';
  }

  Widget readoutLine(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 170,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }

  final Widget section5Readout = sectionCard(
    title: '5. ToggleButtonsTheme.of(context) readout',
    description:
        'Below, a Builder reads ToggleButtonsTheme.of(context) and displays '
        'every resolved field. This is exactly what each descendant '
        'ToggleButtons sees. Note that null fields fall through to '
        'Theme.of(context).toggleButtonsTheme; we keep most fields explicit '
        'here so the readout is concrete.',
    background: readoutBg,
    body: ToggleButtonsTheme(
      data: readoutTheme,
      child: Builder(
        builder: (BuildContext readContext) {
          final ToggleButtonsThemeData t =
              ToggleButtonsTheme.of(readContext);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              themedToggle(
                theme: t,
                children: viewChildren(),
                initial: const <bool>[false, true, false, false],
              ),
              const SizedBox(height: 14),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'ToggleButtonsTheme.of(context) =>',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 6),
                    readoutLine('color', describeColor(t.color)),
                    readoutLine(
                      'selectedColor',
                      describeColor(t.selectedColor),
                    ),
                    readoutLine(
                      'disabledColor',
                      describeColor(t.disabledColor),
                    ),
                    readoutLine('fillColor', describeColor(t.fillColor)),
                    readoutLine('focusColor', describeColor(t.focusColor)),
                    readoutLine(
                      'highlightColor',
                      describeColor(t.highlightColor),
                    ),
                    readoutLine('hoverColor', describeColor(t.hoverColor)),
                    readoutLine('splashColor', describeColor(t.splashColor)),
                    readoutLine('borderColor', describeColor(t.borderColor)),
                    readoutLine(
                      'selectedBorderColor',
                      describeColor(t.selectedBorderColor),
                    ),
                    readoutLine(
                      'disabledBorderColor',
                      describeColor(t.disabledBorderColor),
                    ),
                    readoutLine(
                      'borderWidth',
                      t.borderWidth?.toStringAsFixed(2) ??
                          '(inherited / null)',
                    ),
                    readoutLine(
                      'borderRadius',
                      describeRadius(
                        t.borderRadius is BorderRadius
                            ? t.borderRadius as BorderRadius
                            : null,
                      ),
                    ),
                    readoutLine(
                      'constraints',
                      describeConstraints(t.constraints),
                    ),
                    readoutLine(
                      'textStyle',
                      t.textStyle == null
                          ? '(inherited / null)'
                          : 'size=${t.textStyle!.fontSize ?? '-'} '
                              'weight=${t.textStyle!.fontWeight ?? '-'}',
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    ),
  );

  // ===========================================================================
  // SECTION 6 - PER-PAGE-SECTION THEMING
  // Top section: Pill style. Middle: Outlined / muted. Bottom: Chip / orange.
  // Each lives in its own ToggleButtonsTheme - one page, three different
  // toggle looks, zero interference.
  // ===========================================================================

  const ToggleButtonsThemeData pillTheme = ToggleButtonsThemeData(
    color: pillUnselectedFg,
    selectedColor: pillSelectedFg,
    fillColor: pillFill,
    borderColor: pillBorder,
    selectedBorderColor: pillBorder,
    borderWidth: 1.5,
    borderRadius: BorderRadius.all(Radius.circular(28)),
    constraints: BoxConstraints(minHeight: 44, minWidth: 80),
  );

  const ToggleButtonsThemeData outlinedTheme = ToggleButtonsThemeData(
    color: outlinedUnselectedFg,
    selectedColor: outlinedSelectedFg,
    fillColor: outlinedFill,
    borderColor: outlinedBorder,
    selectedBorderColor: outlinedBorder,
    borderWidth: 1,
    borderRadius: BorderRadius.all(Radius.circular(0)),
    constraints: BoxConstraints(minHeight: 36, minWidth: 70),
  );

  const ToggleButtonsThemeData chipTheme = ToggleButtonsThemeData(
    color: chipUnselectedFg,
    selectedColor: chipSelectedFg,
    fillColor: chipFill,
    borderColor: chipBorder,
    selectedBorderColor: chipBorder,
    borderWidth: 1,
    borderRadius: BorderRadius.all(Radius.circular(6)),
    constraints: BoxConstraints(minHeight: 32, minWidth: 56),
  );

  final Widget section6PerPage = sectionCard(
    title: '6. Per-page-section theming',
    description:
        'A single page can host multiple toggle styles by giving each region '
        'its own ToggleButtonsTheme. This card shows three regions stacked '
        'vertically: Pill, Outlined, and Chip. Each region is wrapped in its '
        'own inherited theme - no global state and no per-widget overrides.',
    background: const Color(0xFFFAFAFA),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: pillBg,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Top - Pill style',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 8),
              themedToggle(
                theme: pillTheme,
                children: viewChildren(),
                initial: const <bool>[false, true, false, false],
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: outlinedBg,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Middle - Outlined style',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 8),
              themedToggle(
                theme: outlinedTheme,
                children: alignChildren(),
                initial: const <bool>[true, false, false, false],
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: chipBg,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Bottom - Chip style',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 8),
              themedToggle(
                theme: chipTheme,
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    child: Text('S'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    child: Text('M'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    child: Text('L'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    child: Text('XL'),
                  ),
                ],
                initial: const <bool>[false, false, true, false],
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 7 - ANIMATED THEME TRANSITION
  // TweenAnimationBuilder<ToggleButtonsThemeData> + ToggleButtonsThemeData.lerp
  // smoothly interpolates one theme into another, replacing the
  // ToggleButtonsTheme on every frame.
  // ===========================================================================

  const ToggleButtonsThemeData animStartTheme = ToggleButtonsThemeData(
    color: animStartUnselectedFg,
    selectedColor: animStartSelectedFg,
    fillColor: animStartFill,
    borderColor: animStartBorder,
    selectedBorderColor: animStartBorder,
    borderWidth: 1.5,
    borderRadius: BorderRadius.all(Radius.circular(8)),
    constraints: BoxConstraints(minHeight: 40, minWidth: 70),
  );

  const ToggleButtonsThemeData animEndTheme = ToggleButtonsThemeData(
    color: animEndUnselectedFg,
    selectedColor: animEndSelectedFg,
    fillColor: animEndFill,
    borderColor: animEndBorder,
    selectedBorderColor: animEndBorder,
    borderWidth: 2.5,
    borderRadius: BorderRadius.all(Radius.circular(28)),
    constraints: BoxConstraints(minHeight: 44, minWidth: 80),
  );

  final Widget section7Anim = sectionCard(
    title: '7. Animating between two themes',
    description:
        'Use TweenAnimationBuilder<ToggleButtonsThemeData> together with '
        'ToggleButtonsThemeData.lerp to smoothly morph from one theme to '
        'another. On every animation frame the builder receives an '
        'interpolated ToggleButtonsThemeData, which we drop into a '
        'ToggleButtonsTheme above the toggle. Tap the toggle on the right to '
        'flip the target theme; the inherited theme replays from one end to '
        'the other.',
    background: animStartBg,
    body: _AnimatedThemeDemo(
      startTheme: animStartTheme,
      endTheme: animEndTheme,
      children: viewChildren(),
    ),
  );

  // The demo's body lives in _AnimatedThemeDemo (declared at the bottom of
  // this file) because TweenAnimationBuilder needs a target value that
  // survives rebuild, which is awkward in a closure-only StatefulBuilder.
  // For reference, the original inline shape of the animation builder was:
  //
  //   TweenAnimationBuilder<double>(
  //     tween: Tween<double>(begin: 0, end: atEnd ? 1.0 : 0.0),
  //     duration: Duration(milliseconds: 600),
  //     curve: Curves.easeInOut,
  //     builder: (ctx, t, _) => ToggleButtonsTheme(
  //       data: ToggleButtonsThemeData.lerp(start, end, t),
  //       child: ...,
  //     ),
  //   )
  //
  // The widget below packages exactly that, with a button to flip atEnd.

  // ===========================================================================
  // SECTION 8 - SETTINGS PANEL
  // A toolbar of view-switchers themed to match the panel chrome. The
  // ToggleButtonsTheme sits inside the panel, scoped to its own subtree, so
  // the toolbar style follows the panel and not the surrounding app.
  // ===========================================================================

  const ToggleButtonsThemeData panelToolbarTheme = ToggleButtonsThemeData(
    color: panelToolbarUnselectedFg,
    selectedColor: panelToolbarSelectedFg,
    fillColor: panelToolbarFill,
    borderColor: panelToolbarBorder,
    selectedBorderColor: panelToolbarBorder,
    borderWidth: 1,
    borderRadius: BorderRadius.all(Radius.circular(8)),
    constraints: BoxConstraints(minHeight: 36, minWidth: 64),
  );

  final Widget section8Panel = sectionCard(
    title: '8. Settings panel - theme follows the chrome',
    description:
        'The panel below is a self-contained settings card. Its toolbar of '
        'view-switchers is wrapped in a ToggleButtonsTheme that matches the '
        'panel chrome. If we lifted this panel into a different page with a '
        'different ambient theme, the toolbar would still look the same - '
        'the inherited theme is local to the panel.',
    background: panelBg,
    body: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 10,
            ),
            decoration: const BoxDecoration(
              color: panelChrome,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: const Row(
              children: <Widget>[
                Icon(Icons.tune, color: Colors.white, size: 18),
                SizedBox(width: 8),
                Text(
                  'Display Settings',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'View',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 6),
                themedToggle(
                  theme: panelToolbarTheme,
                  children: viewChildren(),
                  initial: const <bool>[false, true, false, false],
                ),
                const SizedBox(height: 14),
                const Text(
                  'Density',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 6),
                themedToggle(
                  theme: panelToolbarTheme,
                  children: const <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      child: Text('Compact'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      child: Text('Cozy'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      child: Text('Comfortable'),
                    ),
                  ],
                  initial: const <bool>[false, true, false],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  // ===========================================================================
  // SECTION 9 - DECOUPLED CHILD WIDGET
  // _ThemedToolbar (declared at the bottom of this file as a top-level
  // private StatelessWidget) does NOT take any color or shape parameters.
  // It just builds a ToggleButtons. Its appearance comes ENTIRELY from
  // whichever ToggleButtonsTheme is closest in the BuildContext above it.
  // Below we drop the same _ThemedToolbar into two different inherited
  // themes, and it adapts to each without any prop drilling.
  // ===========================================================================

  const ToggleButtonsThemeData decoupledTheme = ToggleButtonsThemeData(
    color: decoupledUnselectedFg,
    selectedColor: decoupledSelectedFg,
    fillColor: decoupledFill,
    borderColor: decoupledBorder,
    selectedBorderColor: decoupledBorder,
    borderWidth: 1.5,
    borderRadius: BorderRadius.all(Radius.circular(10)),
    constraints: BoxConstraints(minHeight: 40, minWidth: 70),
  );

  final Widget section9Decoupled = sectionCard(
    title: '9. Decoupled child via .of(context)',
    description:
        'The same _ThemedToolbar widget is rendered twice: once inside a '
        'cyan ToggleButtonsTheme (top), once inside a green '
        'ToggleButtonsTheme (bottom). _ThemedToolbar takes ZERO style '
        'parameters - it just builds a ToggleButtons. The inherited theme '
        'around it determines everything. This is the prop-drilling-killer '
        'pattern: write themed widgets once, theme them anywhere.',
    background: decoupledBg,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Same widget, cyan ToggleButtonsTheme:',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
        ),
        const SizedBox(height: 8),
        ToggleButtonsTheme(
          data: decoupledTheme,
          child: const _ThemedToolbar(),
        ),
        const SizedBox(height: 16),
        const Text(
          'Same widget, sibling green ToggleButtonsTheme:',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
        ),
        const SizedBox(height: 8),
        ToggleButtonsTheme(
          data: sibGreenTheme,
          child: const _ThemedToolbar(),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 10 - REAL-WORLD MARKDOWN TOOLBAR
  // A B / I / U / S / link toolbar themed via ToggleButtonsTheme. This is
  // the canonical "real-world" use case for ToggleButtons in Material apps.
  // ===========================================================================

  const ToggleButtonsThemeData mdTheme = ToggleButtonsThemeData(
    color: mdUnselectedFg,
    selectedColor: mdSelectedFg,
    fillColor: mdFill,
    borderColor: mdBorder,
    selectedBorderColor: mdBorder,
    borderWidth: 1,
    borderRadius: BorderRadius.all(Radius.circular(6)),
    constraints: BoxConstraints(minHeight: 36, minWidth: 44),
  );

  final Widget section10Markdown = sectionCard(
    title: '10. Real-world recipe - markdown editor toolbar',
    description:
        'A multi-select toggle group for inline formatting (bold, italic, '
        'underline, strikethrough, link). The whole toolbar is wrapped in a '
        'single ToggleButtonsTheme. Tapping any button toggles its own '
        'state independently - typical of a formatting toolbar where '
        'multiple formats can be active at once. The theme decides the '
        'colors, borders, and radius; the toolbar widget only knows about '
        'icons and selection state.',
    background: mdBg,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black12),
          ),
          child: themedToggle(
            theme: mdTheme,
            isMultiSelect: true,
            children: const <Widget>[
              Padding(
                padding: EdgeInsets.all(6),
                child: Icon(Icons.format_bold),
              ),
              Padding(
                padding: EdgeInsets.all(6),
                child: Icon(Icons.format_italic),
              ),
              Padding(
                padding: EdgeInsets.all(6),
                child: Icon(Icons.format_underline),
              ),
              Padding(
                padding: EdgeInsets.all(6),
                child: Icon(Icons.format_strikethrough),
              ),
              Padding(
                padding: EdgeInsets.all(6),
                child: Icon(Icons.link),
              ),
            ],
            initial: const <bool>[true, false, false, false, false],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black12),
          ),
          child: const Text(
            '**Hello world** _from a themed toolbar_.\n'
            'The toolbar above is just a ToggleButtons inside a '
            'ToggleButtonsTheme - no color props on the buttons themselves.',
            style: TextStyle(fontSize: 13, height: 1.45),
          ),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 11 - DECISION GUIDE
  // ===========================================================================

  final Widget section11Decision = sectionCard(
    title: '11. Decision guide - which route to use',
    description:
        'When should you reach for ToggleButtonsTheme as an inherited widget '
        'versus setting ThemeData.toggleButtonsTheme on the application Theme?',
    background: const Color(0xFFF1F8E9),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        _GuideRow(
          marker: 'Use ToggleButtonsTheme(...) when',
          bullets: <String>[
            'A single screen, panel, or component needs custom toggle styling.',
            'You want to override only a few fields for a small subtree.',
            'You are animating a theme transition with TweenAnimationBuilder.',
            'You need siblings to look different without polluting the global Theme.',
            'You are writing a reusable widget that should be themable from outside.',
          ],
        ),
        SizedBox(height: 10),
        _GuideRow(
          marker: 'Use ThemeData.toggleButtonsTheme when',
          bullets: <String>[
            'You want every ToggleButtons in the app to look the same by default.',
            'The look is part of your app-wide design system / brand.',
            'You want a single source of truth that survives nesting changes.',
            'You expect lots of unrelated ToggleButtons widgets across screens.',
          ],
        ),
        SizedBox(height: 10),
        _GuideRow(
          marker: 'Combine both when',
          bullets: <String>[
            'A global default exists on ThemeData, and a particular subtree '
                'needs a tighter override - wrap that subtree in a '
                'ToggleButtonsTheme. The closer scope wins.',
          ],
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 12 - SUMMARY
  // ===========================================================================

  final Widget section12Summary = sectionCard(
    title: '12. Summary',
    description: '',
    background: const Color(0xFFFAFAFA),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Text(
          'ToggleButtonsTheme is an InheritedTheme for ToggleButtons.\n\n'
          'Lookup precedence:\n'
          '  1. nearest ToggleButtonsTheme above the ToggleButtons\n'
          '  2. Theme.of(context).toggleButtonsTheme (the ThemeData copy)\n\n'
          'Use the inherited widget for subtrees, panels, animations, sibling '
          'sections, and reusable themed widgets. Use ThemeData when the '
          'styling is global. Combine both when you need an app-wide default '
          'with localized overrides. The data class itself - all the '
          'ToggleButtonsThemeData fields, copyWith, lerp, equality, hash - is '
          'covered in detail in the sibling test file.',
          style: TextStyle(fontSize: 13, height: 1.45),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SCAFFOLD
  // ===========================================================================

  return MaterialApp(
    title: 'ToggleButtonsTheme deep demo',
    theme: ThemeData(
      colorSchemeSeed: const Color(0xFF1976D2),
      useMaterial3: true,
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('ToggleButtonsTheme - inherited-widget deep demo'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              section1Intro,
              section2Twin,
              section3Nested,
              section4Siblings,
              section5Readout,
              section6PerPage,
              section7Anim,
              section8Panel,
              section9Decoupled,
              section10Markdown,
              section11Decision,
              section12Summary,
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    ),
  );
}

// ============================================================================
// PRIVATE WIDGET - declared at top level so it can be const-instantiated
// inside the build() function above. _ThemedToolbar takes no style
// parameters - everything comes from ToggleButtonsTheme.of(context) above it.
// ============================================================================

class _ThemedToolbar extends StatefulWidget {
  const _ThemedToolbar();

  @override
  State<_ThemedToolbar> createState() => _ThemedToolbarState();
}

class _ThemedToolbarState extends State<_ThemedToolbar> {
  final List<bool> _selected = <bool>[true, false, false];

  @override
  Widget build(BuildContext context) {
    // Note: we do NOT need to read ToggleButtonsTheme.of(context) here
    // explicitly - ToggleButtons does that internally. We could read it
    // for diagnostics or per-widget overrides, but the point of this
    // section is the absence of any explicit theme handoff.
    return ToggleButtons(
      isSelected: _selected,
      onPressed: (int idx) {
        setState(() {
          for (int i = 0; i < _selected.length; i++) {
            _selected[i] = i == idx;
          }
        });
      },
      children: const <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Text('Read'),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Text('Write'),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Text('Admin'),
        ),
      ],
    );
  }
}

class _GuideRow extends StatelessWidget {
  const _GuideRow({required this.marker, required this.bullets});

  final String marker;
  final List<String> bullets;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          marker,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 4),
        ...bullets.map(
          (String b) => Padding(
            padding: const EdgeInsets.fromLTRB(8, 2, 0, 2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('  - '),
                Expanded(
                  child: Text(
                    b,
                    style: const TextStyle(fontSize: 13, height: 1.4),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// _AnimatedThemeDemo - section 7 packaged as a real StatefulWidget. We need
// this rather than a closure-only StatefulBuilder because TweenAnimationBuilder
// reacts to changes in the *target* end value of its tween. That target must
// survive across rebuilds, which means it needs to live in real State, not in
// a local variable redeclared on every build.
// ============================================================================

class _AnimatedThemeDemo extends StatefulWidget {
  const _AnimatedThemeDemo({
    required this.startTheme,
    required this.endTheme,
    required this.children,
  });

  final ToggleButtonsThemeData startTheme;
  final ToggleButtonsThemeData endTheme;
  final List<Widget> children;

  @override
  State<_AnimatedThemeDemo> createState() => _AnimatedThemeDemoState();
}

class _AnimatedThemeDemoState extends State<_AnimatedThemeDemo> {
  bool _atEnd = false;
  final List<bool> _selected = <bool>[true, false, false, false];

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: _atEnd ? 1.0 : 0.0),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
      builder: (BuildContext animContext, double t, Widget? _) {
        final ToggleButtonsThemeData lerped =
            ToggleButtonsThemeData.lerp(
                  widget.startTheme,
                  widget.endTheme,
                  t,
                ) ??
                widget.startTheme;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Interpolation t = ${t.toStringAsFixed(2)}',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                fontFamily: 'monospace',
              ),
            ),
            const SizedBox(height: 10),
            ToggleButtonsTheme(
              data: lerped,
              child: ToggleButtons(
                isSelected: _selected,
                onPressed: (int idx) {
                  setState(() {
                    for (int i = 0; i < _selected.length; i++) {
                      _selected[i] = i == idx;
                    }
                  });
                },
                children: widget.children,
              ),
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: () => setState(() => _atEnd = !_atEnd),
              icon: const Icon(Icons.swap_horiz),
              label: Text(_atEnd ? 'Animate to start' : 'Animate to end'),
            ),
          ],
        );
      },
    );
  }
}
