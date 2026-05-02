// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Live demonstration of InheritedCupertinoTheme
// ----------------------------------------------------------------------------
// InheritedCupertinoTheme is the InheritedWidget that propagates a
// CupertinoThemeData down the widget tree. Most application code reaches it
// indirectly through CupertinoTheme.of(context). The widget CupertinoTheme
// builds an InheritedCupertinoTheme as its descendant, which is the actual
// inherited element looked up by .of(). This file builds six side-by-side
// scenarios so the visible difference is purely from theme inheritance.
// ----------------------------------------------------------------------------

import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('InheritedCupertinoTheme demo executing');

  // ===========================================================================
  // PALETTE CONSTANTS - referenced by individual scenarios
  // ===========================================================================

  const Color brandPrimary = Color(0xFFFF6F00);
  const Color brandScaffold = Color(0xFFFFF8E1);
  const Color brandText = Color(0xFF3E2723);
  const Color brandBar = Color(0xFFFFE0B2);

  const Color hcScaffold = Color(0xFF000000);
  const Color hcText = Color(0xFFFFFFFF);
  const Color hcPrimary = Color(0xFF00FFE0);
  const Color hcBar = Color(0xFF111111);

  const Color innerOverridePrimary = Color(0xFFE91E63);
  const Color innerOverrideScaffold = Color(0xFFFCE4EC);
  const Color innerOverrideText = Color(0xFF880E4F);
  const Color innerOverrideBar = Color(0xFFF8BBD0);

  // ===========================================================================
  // THEME DATA - one per scenario.
  // ===========================================================================

  final CupertinoThemeData lightTheme = CupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: CupertinoColors.activeBlue,
    scaffoldBackgroundColor: CupertinoColors.systemBackground,
    barBackgroundColor: CupertinoColors.systemGrey6,
    textTheme: const CupertinoTextThemeData(
      primaryColor: CupertinoColors.activeBlue,
      textStyle: TextStyle(
        fontFamily: '.SF Pro Text',
        fontSize: 15.0,
        color: CupertinoColors.label,
      ),
    ),
  );

  final CupertinoThemeData darkTheme = CupertinoThemeData(
    brightness: Brightness.dark,
    primaryColor: CupertinoColors.activeOrange,
    scaffoldBackgroundColor: CupertinoColors.black,
    barBackgroundColor: CupertinoColors.darkBackgroundGray,
    textTheme: const CupertinoTextThemeData(
      primaryColor: CupertinoColors.activeOrange,
      textStyle: TextStyle(
        fontFamily: '.SF Pro Text',
        fontSize: 15.0,
        color: CupertinoColors.white,
      ),
    ),
  );

  final CupertinoThemeData brandTheme = CupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: brandPrimary,
    scaffoldBackgroundColor: brandScaffold,
    barBackgroundColor: brandBar,
    textTheme: CupertinoTextThemeData(
      primaryColor: brandPrimary,
      textStyle: const TextStyle(
        fontFamily: '.SF Pro Text',
        fontSize: 16.0,
        color: brandText,
      ),
      navTitleTextStyle: const TextStyle(
        fontFamily: '.SF Pro Display',
        fontSize: 18.0,
        fontWeight: FontWeight.w700,
        color: brandText,
      ),
    ),
  );

  final CupertinoThemeData highContrastTheme = CupertinoThemeData(
    brightness: Brightness.dark,
    primaryColor: hcPrimary,
    scaffoldBackgroundColor: hcScaffold,
    barBackgroundColor: hcBar,
    textTheme: const CupertinoTextThemeData(
      primaryColor: hcPrimary,
      textStyle: TextStyle(
        fontFamily: '.SF Pro Text',
        fontSize: 17.0,
        color: hcText,
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  final CupertinoThemeData innerOverrideTheme = CupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: innerOverridePrimary,
    scaffoldBackgroundColor: innerOverrideScaffold,
    barBackgroundColor: innerOverrideBar,
    textTheme: CupertinoTextThemeData(
      primaryColor: innerOverridePrimary,
      textStyle: const TextStyle(
        fontFamily: '.SF Pro Text',
        fontSize: 14.0,
        color: innerOverrideText,
      ),
    ),
  );

  // ===========================================================================
  // PROGRAMMATIC SUMMARY - top-of-file readback row showing what each theme
  // resolves to. This is conceptually what CupertinoTheme.of(context) returns
  // once the tree is wrapped in CupertinoTheme.
  // ===========================================================================

  final List<Map<String, dynamic>> programmaticSummary =
      <Map<String, dynamic>>[
    <String, dynamic>{
      'scenario': '1. Default light',
      'brightness': lightTheme.brightness.toString(),
      'primaryColor': lightTheme.primaryColor.toString(),
      'scaffold': lightTheme.scaffoldBackgroundColor.toString(),
      'fontSize': lightTheme.textTheme.textStyle.fontSize.toString(),
    },
    <String, dynamic>{
      'scenario': '2. Default dark',
      'brightness': darkTheme.brightness.toString(),
      'primaryColor': darkTheme.primaryColor.toString(),
      'scaffold': darkTheme.scaffoldBackgroundColor.toString(),
      'fontSize': darkTheme.textTheme.textStyle.fontSize.toString(),
    },
    <String, dynamic>{
      'scenario': '3. Brand',
      'brightness': brandTheme.brightness.toString(),
      'primaryColor': brandTheme.primaryColor.toString(),
      'scaffold': brandTheme.scaffoldBackgroundColor.toString(),
      'fontSize': brandTheme.textTheme.textStyle.fontSize.toString(),
    },
    <String, dynamic>{
      'scenario': '4. High contrast',
      'brightness': highContrastTheme.brightness.toString(),
      'primaryColor': highContrastTheme.primaryColor.toString(),
      'scaffold': highContrastTheme.scaffoldBackgroundColor.toString(),
      'fontSize': highContrastTheme.textTheme.textStyle.fontSize.toString(),
    },
    <String, dynamic>{
      'scenario': '5. Outer (dark)',
      'brightness': darkTheme.brightness.toString(),
      'primaryColor': darkTheme.primaryColor.toString(),
      'scaffold': darkTheme.scaffoldBackgroundColor.toString(),
      'fontSize': darkTheme.textTheme.textStyle.fontSize.toString(),
    },
    <String, dynamic>{
      'scenario': '5. Inner override',
      'brightness': innerOverrideTheme.brightness.toString(),
      'primaryColor': innerOverrideTheme.primaryColor.toString(),
      'scaffold': innerOverrideTheme.scaffoldBackgroundColor.toString(),
      'fontSize': innerOverrideTheme.textTheme.textStyle.fontSize.toString(),
    },
  ];

  for (final Map<String, dynamic> row in programmaticSummary) {
    print('  ${row['scenario']} -> primary=${row['primaryColor']}');
  }

  // ===========================================================================
  // RETURN THE FULL APP TREE
  // ===========================================================================

  return CupertinoApp(
    debugShowCheckedModeBanner: false,
    title: 'InheritedCupertinoTheme demo',
    home: CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGrey6,
      navigationBar: const CupertinoNavigationBar(
        middle: Text('InheritedCupertinoTheme'),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // ============================================================
              // PAGE HEADER
              // ============================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF263238),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'InheritedCupertinoTheme',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 22.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 6.0),
                    Text(
                      'CupertinoTheme.of(context) reads from this '
                      'InheritedWidget. Wrapping a subtree with '
                      'CupertinoTheme(data: ...) re-publishes the data, '
                      'and any CupertinoTheme.of() call below sees the '
                      'closest ancestor.',
                      style: TextStyle(
                        color: Color(0xFFCFD8DC),
                        fontSize: 13.5,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14.0),

              // ============================================================
              // PROGRAMMATIC SUMMARY TABLE (top-of-file readback)
              // ============================================================
              _summaryTable(programmaticSummary),

              const SizedBox(height: 18.0),

              // ============================================================
              // SCENARIO 1 - DEFAULT LIGHT
              // ============================================================
              _scenarioCard(
                index: 1,
                title: 'Default light theme',
                accent: const Color(0xFF1976D2),
                explanation:
                    'A baseline CupertinoThemeData with brightness set to '
                    'Brightness.light. This is the canonical look for iOS '
                    'apps in light mode and the value most apps inherit '
                    'when no override is provided. Use it as a sanity '
                    'check that the inheritance plumbing actually wires '
                    'through CupertinoApp -> CupertinoTheme -> '
                    'InheritedCupertinoTheme.',
                themeData: lightTheme,
                bodyBackground: const Color(0xFFFFFFFF),
              ),

              const SizedBox(height: 14.0),

              // ============================================================
              // SCENARIO 2 - DEFAULT DARK
              // ============================================================
              _scenarioCard(
                index: 2,
                title: 'Default dark theme',
                accent: const Color(0xFF455A64),
                explanation:
                    'The same widget subtree wrapped in a dark '
                    'CupertinoThemeData. Notice that even widgets that '
                    'were not given an explicit colour change visibly: '
                    'CupertinoButton, CupertinoTextField, '
                    'CupertinoSwitch all read tints from '
                    'CupertinoTheme.of(context). That lookup goes '
                    'through InheritedCupertinoTheme.',
                themeData: darkTheme,
                bodyBackground: const Color(0xFF1C1C1E),
              ),

              const SizedBox(height: 14.0),

              // ============================================================
              // SCENARIO 3 - CUSTOM BRAND
              // ============================================================
              _scenarioCard(
                index: 3,
                title: 'Custom brand theme',
                accent: brandPrimary,
                explanation:
                    'Demonstrates a fully custom palette: orange primary, '
                    'cream scaffold, espresso text. By supplying a '
                    'CupertinoTextThemeData we also override the default '
                    'system font sizes / weights. Every descendant of '
                    'this CupertinoTheme will read the new values via '
                    'InheritedCupertinoTheme without us touching the '
                    'individual widgets.',
                themeData: brandTheme,
                bodyBackground: brandScaffold,
              ),

              const SizedBox(height: 14.0),

              // ============================================================
              // SCENARIO 4 - HIGH CONTRAST
              // ============================================================
              _scenarioCard(
                index: 4,
                title: 'High-contrast theme',
                accent: hcPrimary,
                explanation:
                    'A black scaffold with neon-cyan primary and bold '
                    'white text. Useful to validate contrast for '
                    'accessibility audits and demonstrates that an '
                    'InheritedCupertinoTheme will happily push through '
                    'extreme colour choices without per-widget code '
                    'changes.',
                themeData: highContrastTheme,
                bodyBackground: hcScaffold,
              ),

              const SizedBox(height: 14.0),

              // ============================================================
              // SCENARIO 5 - NESTED OVERRIDE
              // ============================================================
              _nestedScenarioCard(
                index: 5,
                title: 'Nested override (dark wraps brand)',
                accent: const Color(0xFF6A1B9A),
                outerTheme: darkTheme,
                innerTheme: innerOverrideTheme,
              ),

              const SizedBox(height: 14.0),

              // ============================================================
              // SCENARIO 6 - PROGRAMMATIC READBACK INSIDE BUILDERS
              // ============================================================
              _readbackScenarioCard(
                index: 6,
                accent: const Color(0xFF00897B),
                themes: <String, CupertinoThemeData>{
                  'light': lightTheme,
                  'dark': darkTheme,
                  'brand': brandTheme,
                  'highContrast': highContrastTheme,
                },
              ),

              const SizedBox(height: 24.0),

              // ============================================================
              // FOOTER
              // ============================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFECEFF1),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: const Color(0xFFB0BEC5)),
                ),
                child: const Text(
                  'Footer: every visible difference between cards above '
                  'is produced solely by InheritedCupertinoTheme. The '
                  'mini-tree of widgets is identical in each scenario; '
                  'only the wrapping CupertinoTheme(data: ...) changes.',
                  style: TextStyle(
                    color: Color(0xFF263238),
                    fontSize: 12.5,
                    height: 1.4,
                  ),
                ),
              ),

              const SizedBox(height: 24.0),
            ],
          ),
        ),
      ),
    ),
  );
}

// =============================================================================
// HELPER: programmatic summary table widget
// =============================================================================

Widget _summaryTable(List<Map<String, dynamic>> rows) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: const Color(0xFFE8EAF6),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: const Color(0xFF7986CB)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Text(
          'Programmatic summary (resolved CupertinoThemeData per scenario)',
          style: TextStyle(
            color: Color(0xFF1A237E),
            fontSize: 13.5,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8.0),
        for (final Map<String, dynamic> row in rows)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(
                  width: 130.0,
                  child: Text(
                    row['scenario'].toString(),
                    style: const TextStyle(
                      color: Color(0xFF283593),
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'primary=${row['primaryColor']}\n'
                    'scaffold=${row['scaffold']}\n'
                    'brightness=${row['brightness']}, '
                    'fontSize=${row['fontSize']}',
                    style: const TextStyle(
                      color: Color(0xFF1A237E),
                      fontSize: 11.0,
                      height: 1.35,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

// =============================================================================
// HELPER: a single scenario card.
// =============================================================================

Widget _scenarioCard({
  required int index,
  required String title,
  required Color accent,
  required String explanation,
  required CupertinoThemeData themeData,
  required Color bodyBackground,
}) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: const Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: const Color(0xFFCFD8DC)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // -- Title bar
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: accent,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
            ),
          ),
          child: Text(
            'Scenario $index — $title',
            style: const TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 15.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),

        // -- Explanation
        Padding(
          padding: const EdgeInsets.fromLTRB(14.0, 12.0, 14.0, 6.0),
          child: Text(
            explanation,
            style: const TextStyle(
              color: Color(0xFF37474F),
              fontSize: 12.5,
              height: 1.4,
            ),
          ),
        ),

        // -- Live mini-tree under CupertinoTheme(...)
        Padding(
          padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              color: bodyBackground,
              child: CupertinoTheme(
                data: themeData,
                child: _miniTree(),
              ),
            ),
          ),
        ),

        // -- Footer with resolved theme readback (uses Builder to pick up
        //    the closest InheritedCupertinoTheme).
        Padding(
          padding: const EdgeInsets.fromLTRB(14.0, 4.0, 14.0, 14.0),
          child: CupertinoTheme(
            data: themeData,
            child: Builder(
              builder: (BuildContext builderContext) {
                final CupertinoThemeData resolved =
                    CupertinoTheme.of(builderContext);
                return _resolvedFooter(resolved);
              },
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// HELPER: the nested-override scenario card, showing both outer- and
// inner-themed mini-trees stacked.
// =============================================================================

Widget _nestedScenarioCard({
  required int index,
  required String title,
  required Color accent,
  required CupertinoThemeData outerTheme,
  required CupertinoThemeData innerTheme,
}) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: const Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: const Color(0xFFCFD8DC)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // -- Title bar
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: accent,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
            ),
          ),
          child: Text(
            'Scenario $index — $title',
            style: const TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 15.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),

        // -- Explanation
        const Padding(
          padding: EdgeInsets.fromLTRB(14.0, 12.0, 14.0, 6.0),
          child: Text(
            'The outer subtree is wrapped in a dark CupertinoTheme. '
            'Inside that subtree we wrap a smaller region with another '
            'CupertinoTheme that supplies a pink/light brand override. '
            'Each region runs CupertinoTheme.of(context) and gets the '
            'CLOSEST ancestor InheritedCupertinoTheme. The outer '
            'mini-tree sees dark; the inner mini-tree sees the override.',
            style: TextStyle(
              color: Color(0xFF37474F),
              fontSize: 12.5,
              height: 1.4,
            ),
          ),
        ),

        // -- Outer block
        Padding(
          padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 4.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              color: const Color(0xFF1C1C1E),
              child: CupertinoTheme(
                data: outerTheme,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    // outer label
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 4.0),
                      child: Builder(
                        builder: (BuildContext outerCtx) {
                          final CupertinoThemeData outer =
                              CupertinoTheme.of(outerCtx);
                          return Text(
                            'OUTER (dark) - primary='
                            '${outer.primaryColor}',
                            style: const TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 12.0,
                              fontWeight: FontWeight.w700,
                            ),
                          );
                        },
                      ),
                    ),
                    _miniTree(),

                    // inner override block
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Container(
                          color: const Color(0xFFFCE4EC),
                          child: CupertinoTheme(
                            data: innerTheme,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                    12.0,
                                    10.0,
                                    12.0,
                                    4.0,
                                  ),
                                  child: Builder(
                                    builder: (BuildContext innerCtx) {
                                      final CupertinoThemeData inner =
                                          CupertinoTheme.of(innerCtx);
                                      return Text(
                                        'INNER (override) - primary='
                                        '${inner.primaryColor}',
                                        style: const TextStyle(
                                          color: Color(0xFF880E4F),
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                _miniTree(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // -- Footer table comparing outer vs inner resolved themes
        Padding(
          padding: const EdgeInsets.fromLTRB(14.0, 6.0, 14.0, 14.0),
          child: CupertinoTheme(
            data: outerTheme,
            child: Builder(
              builder: (BuildContext outerCtx) {
                final CupertinoThemeData outerResolved =
                    CupertinoTheme.of(outerCtx);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text(
                      'Outer resolved (CupertinoTheme.of in outer Builder):',
                      style: TextStyle(
                        color: Color(0xFF455A64),
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    _resolvedFooter(outerResolved),
                    const SizedBox(height: 10.0),
                    CupertinoTheme(
                      data: innerTheme,
                      child: Builder(
                        builder: (BuildContext innerCtx) {
                          final CupertinoThemeData innerResolved =
                              CupertinoTheme.of(innerCtx);
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const Text(
                                'Inner resolved (CupertinoTheme.of in inner '
                                'Builder):',
                                style: TextStyle(
                                  color: Color(0xFF455A64),
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              _resolvedFooter(innerResolved),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// HELPER: programmatic readback scenario - pure CupertinoTheme.of(context)
// reads, no live widgets. Demonstrates that InheritedCupertinoTheme is the
// thing CupertinoTheme.of(context) actually queries.
// =============================================================================

Widget _readbackScenarioCard({
  required int index,
  required Color accent,
  required Map<String, CupertinoThemeData> themes,
}) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: const Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: const Color(0xFFCFD8DC)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: accent,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
            ),
          ),
          child: Text(
            'Scenario $index — Programmatic readback via Builder',
            style: const TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 15.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(14.0, 12.0, 14.0, 6.0),
          child: Text(
            'For each theme below, we wrap a CupertinoTheme around a '
            'Builder, then call CupertinoTheme.of(builderContext) inside '
            'the Builder. The lookup walks up the element tree and finds '
            'the InheritedCupertinoTheme that the wrapping CupertinoTheme '
            'just inserted. We render the resolved values as plain text '
            'so the relationship is unambiguous.',
            style: TextStyle(
              color: Color(0xFF37474F),
              fontSize: 12.5,
              height: 1.4,
            ),
          ),
        ),
        for (final MapEntry<String, CupertinoThemeData> entry in themes.entries)
          Padding(
            padding: const EdgeInsets.fromLTRB(14.0, 4.0, 14.0, 8.0),
            child: CupertinoTheme(
              data: entry.value,
              child: Builder(
                builder: (BuildContext readbackCtx) {
                  final CupertinoThemeData resolved =
                      CupertinoTheme.of(readbackCtx);
                  return Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: const Color(0xFFBDBDBD)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'theme key: ${entry.key}',
                          style: const TextStyle(
                            color: Color(0xFF212121),
                            fontSize: 12.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        _resolvedFooter(resolved),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        const SizedBox(height: 8.0),
      ],
    ),
  );
}

// =============================================================================
// HELPER: the identical mini-tree of Cupertino widgets used in every scenario.
// =============================================================================

Widget _miniTree() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      // a) Cupertino navigation bar that picks up barBackgroundColor
      const CupertinoNavigationBar(
        automaticallyImplyLeading: false,
        middle: Text('Theme demo'),
      ),

      const SizedBox(height: 10.0),

      // b) Row of three buttons - filled, plain, tinted-style fallback.
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            CupertinoButton.filled(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 6.0,
              ),
              onPressed: _noop,
              child: const Text('Filled'),
            ),
            const SizedBox(width: 8.0),
            CupertinoButton(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 6.0,
              ),
              onPressed: _noop,
              child: const Text('Plain'),
            ),
            const SizedBox(width: 8.0),
            // CupertinoButton.tinted is not always available in older
            // Flutter versions; the manual filled+alpha fallback keeps
            // this demo portable.
            _TintedButtonFallback(onPressed: _noop, label: 'Tinted'),
          ],
        ),
      ),

      const SizedBox(height: 12.0),

      // c) CupertinoTextField with placeholder
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: CupertinoTextField(
          placeholder: 'Type something...',
          padding: const EdgeInsets.all(10.0),
        ),
      ),

      const SizedBox(height: 12.0),

      // d) Switch + Slider row
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            const CupertinoSwitch(value: true, onChanged: _noopBool),
            const SizedBox(width: 12.0),
            Expanded(
              child: CupertinoSlider(
                value: 0.5,
                onChanged: _noopDouble,
              ),
            ),
          ],
        ),
      ),

      const SizedBox(height: 8.0),

      // e) CupertinoListTile - leading icon, title, trailing chevron
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.0),
        child: CupertinoListTile(
          leading: Icon(CupertinoIcons.paintbrush),
          title: Text('Themed list tile'),
          trailing: CupertinoListTileChevron(),
        ),
      ),

      const SizedBox(height: 12.0),
    ],
  );
}

// =============================================================================
// HELPER: footer table of 4-5 resolved theme values for a single
// CupertinoThemeData instance.
// =============================================================================

Widget _resolvedFooter(CupertinoThemeData resolved) {
  final List<List<String>> rows = <List<String>>[
    <String>['primaryColor', resolved.primaryColor.toString()],
    <String>[
      'scaffoldBackgroundColor',
      resolved.scaffoldBackgroundColor.toString(),
    ],
    <String>['barBackgroundColor', resolved.barBackgroundColor.toString()],
    <String>[
      'textTheme.textStyle.fontSize',
      resolved.textTheme.textStyle.fontSize.toString(),
    ],
    <String>['brightness', resolved.brightness.toString()],
  ];

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: const Color(0xFFFAFAFA),
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: const Color(0xFFE0E0E0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        for (final List<String> row in rows)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(
                  width: 170.0,
                  child: Text(
                    row[0],
                    style: const TextStyle(
                      color: Color(0xFF455A64),
                      fontSize: 11.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    row[1],
                    style: const TextStyle(
                      color: Color(0xFF263238),
                      fontSize: 11.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

// =============================================================================
// FALLBACK: a small "tinted" button approximation that does not depend on
// CupertinoButton.tinted being present.
// =============================================================================

class _TintedButtonFallback extends StatelessWidget {
  const _TintedButtonFallback({required this.onPressed, required this.label});

  final VoidCallback onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    final CupertinoThemeData theme = CupertinoTheme.of(context);
    final Color tint = theme.primaryColor;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: tint.withOpacity(0.15),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: tint,
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// MISC NO-OP CALLBACKS - keeps interactive widgets non-interactive in the
// pure-render demo without dragging in StatefulWidgets.
// =============================================================================

void _noop() {}
void _noopBool(bool _) {}
void _noopDouble(double _) {}
