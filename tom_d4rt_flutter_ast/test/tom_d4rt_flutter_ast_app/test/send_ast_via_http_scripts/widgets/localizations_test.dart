// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// ============================================================================
// LOCALIZATIONS — A DEEP DIVE DEMO SCRIPT (D4rt-friendly snapshot tree)
// ============================================================================
//
// THEME: "Atlas Walnut"
//
// A ten-color palette of warm browns, leathered tans, indigo-night
// accents, and parchment-cream highlights — the colors of an old atlas
// rebound in walnut leather. The theme is used throughout to anchor
// the visual hierarchy for each section of this Localizations tour.
//
// SUBJECT: `Localizations` from `package:flutter/widgets.dart`.
//
// `Localizations` is an InheritedWidget that publishes locale-specific
// values, typically obtained through registered LocalizationsDelegate
// instances. It sits high in the widget tree (often inserted by
// `MaterialApp` or `WidgetsApp` automatically) and is read lower in
// the tree using `Localizations.localeOf(context)` and
// `Localizations.of<T>(context, T)`.
//
// CONSTRUCTOR:
//   Localizations({
//     Key? key,
//     required Locale locale,
//     required List<LocalizationsDelegate<dynamic>> delegates,
//     Widget? child,
//   })
//
// STATIC ACCESSORS:
//   Localizations.localeOf(BuildContext context) -> Locale
//   Localizations.of<T>(BuildContext context, Type type) -> T?
//
// TYPICAL USE:
//   MaterialApp(
//     locale: Locale('de', 'CH'),
//     supportedLocales: [Locale('en'), Locale('de'), Locale('de', 'CH')],
//     localizationsDelegates: const [
//       GlobalMaterialLocalizations.delegate,
//       GlobalWidgetsLocalizations.delegate,
//       GlobalCupertinoLocalizations.delegate,
//     ],
//     home: HomePage(),
//   )
//
// CONSTRAINTS (D4rt sandbox):
//   - build() runs ONCE; emit a SNAPSHOT widget tree only.
//   - No StatefulWidget, no setState, no controllers, no streams.
//   - We do construct >= 12 Locale instances and read their fields.
//   - We do call Localizations.localeOf() and MaterialLocalizations.of().
//   - No `for-in` over BridgedInstance objects.
//   - No `.value` reads on Tween.animate.
//   - Use `.withValues(alpha: ...)` for color alpha tweaks.
//
// FILE STRUCTURE (12 visual sections):
//   1.  Title banner with palette swatches.
//   2.  Prose anatomy of the localization pipeline.
//   3.  Property anatomy (locale, delegates, child).
//   4.  Locale gallery (12+ Locale instances with cards).
//   5.  Live readout from Localizations.localeOf(context).
//   6.  MaterialLocalizations.of(context) field readout.
//   7.  Direction matrix (LTR-en, LTR-ja, RTL-ar, RTL-he).
//   8.  Locale fallback diagram (de-CH -> de -> en).
//   9.  DO/AVOID callouts (6+ rules).
//   10. Code-snippet recipe cards (5 recipes).
//   11. Glossary (12+ terms).
//   12. Recap footer.
// ============================================================================

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Atlas Walnut palette — ten-plus colors. We define them as top-level
// constants so they can be referenced by any helper function below.
// ---------------------------------------------------------------------------

const Color atlasWalnutShell = Color(0xFF2B1B10);     // Deepest binding leather
const Color atlasWalnutHide = Color(0xFF4A2E1C);      // Spine ridges
const Color atlasWalnutBark = Color(0xFF6B4226);      // Worn cover edge
const Color atlasWalnutLeaf = Color(0xFF8A5A36);      // Endpaper ink
const Color atlasWalnutTan = Color(0xFFB48458);       // Aged tan strap
const Color atlasWalnutSand = Color(0xFFD7B48C);      // Map dunes
const Color atlasWalnutCream = Color(0xFFEFE3CF);     // Parchment cream
const Color atlasWalnutMist = Color(0xFFF6EEDD);      // Page edge
const Color atlasWalnutInk = Color(0xFF1B1410);       // Cartographer ink
const Color atlasWalnutNight = Color(0xFF1F2A44);     // Compass-rose night
const Color atlasWalnutSea = Color(0xFF2F5468);       // Painted ocean
const Color atlasWalnutMoss = Color(0xFF4D6B3A);      // Forest stamp
const Color atlasWalnutEmber = Color(0xFFB45A2A);     // Border ember
const Color atlasWalnutGold = Color(0xFFD9A441);      // Title gilding

// ---------------------------------------------------------------------------
// ENTRY POINT
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  print('[atlas-walnut] Localizations deep-dive demo starting');
  print('[atlas-walnut] Theme: warm walnut + parchment + compass night');
  print('[atlas-walnut] D4rt mode: snapshot build, no Stateful, no setState');
  print('[atlas-walnut] Target widget: Localizations (InheritedWidget)');
  print('[atlas-walnut] Constructor: ({locale, delegates, child})');
  print('[atlas-walnut] Reading Localizations.localeOf(context)...');

  // -------------------------------------------------------------------------
  // Live readouts. We capture these BEFORE building the tree so we can also
  // print the actual values to the test console. This proves the demo is
  // exercising the real Localizations inheritance path.
  // -------------------------------------------------------------------------
  Locale liveLocale;
  String liveLocaleString;
  String liveLanguageCode;
  String liveCountryCode;
  String liveScriptCode;
  try {
    liveLocale = Localizations.localeOf(context);
    liveLocaleString = liveLocale.toString();
    liveLanguageCode = liveLocale.languageCode;
    liveCountryCode = liveLocale.countryCode ?? '(none)';
    liveScriptCode = liveLocale.scriptCode ?? '(none)';
    print('[atlas-walnut] localeOf -> $liveLocaleString');
    print('[atlas-walnut] localeOf.languageCode -> $liveLanguageCode');
    print('[atlas-walnut] localeOf.countryCode -> $liveCountryCode');
    print('[atlas-walnut] localeOf.scriptCode -> $liveScriptCode');
  } catch (e) {
    liveLocale = const Locale('en', 'US');
    liveLocaleString = 'en_US (fallback)';
    liveLanguageCode = 'en';
    liveCountryCode = 'US';
    liveScriptCode = '(none)';
    print('[atlas-walnut] localeOf threw: $e — falling back to en_US');
  }

  // MaterialLocalizations readouts. These can throw if no MaterialApp is
  // ancestor; we wrap and supply reasonable defaults so the demo still
  // renders something useful.
  String mlOk;
  String mlCancel;
  String mlClose;
  String mlNextMonth;
  String mlPreviousMonth;
  String mlBackButtonTooltip;
  String mlOpenAppDrawerTooltip;
  String mlSearchFieldLabel;
  try {
    final ml = MaterialLocalizations.of(context);
    mlOk = ml.okButtonLabel;
    mlCancel = ml.cancelButtonLabel;
    mlClose = ml.closeButtonLabel;
    mlNextMonth = ml.nextMonthTooltip;
    mlPreviousMonth = ml.previousMonthTooltip;
    mlBackButtonTooltip = ml.backButtonTooltip;
    mlOpenAppDrawerTooltip = ml.openAppDrawerTooltip;
    mlSearchFieldLabel = ml.searchFieldLabel;
    print('[atlas-walnut] MaterialLocalizations.okButtonLabel -> $mlOk');
    print('[atlas-walnut] MaterialLocalizations.cancelButtonLabel -> $mlCancel');
    print('[atlas-walnut] MaterialLocalizations.closeButtonLabel -> $mlClose');
    print('[atlas-walnut] MaterialLocalizations.nextMonthTooltip -> $mlNextMonth');
  } catch (e) {
    mlOk = 'OK';
    mlCancel = 'Cancel';
    mlClose = 'Close';
    mlNextMonth = 'Next month';
    mlPreviousMonth = 'Previous month';
    mlBackButtonTooltip = 'Back';
    mlOpenAppDrawerTooltip = 'Open navigation menu';
    mlSearchFieldLabel = 'Search';
    print('[atlas-walnut] MaterialLocalizations.of threw: $e — using defaults');
  }

  print('[atlas-walnut] Composing 12-section snapshot tree...');

  return Scaffold(
    backgroundColor: atlasWalnutMist,
    appBar: AppBar(
      backgroundColor: atlasWalnutShell,
      foregroundColor: atlasWalnutCream,
      elevation: 0,
      title: Text(
        'Localizations — Atlas Walnut',
        style: TextStyle(
          color: atlasWalnutCream,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
        ),
      ),
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _section1TitleBanner(),
          const SizedBox(height: 28.0),
          _section2ProseAnatomy(),
          const SizedBox(height: 28.0),
          _section3PropertyAnatomy(),
          const SizedBox(height: 28.0),
          _section4LocaleGallery(),
          const SizedBox(height: 28.0),
          _section5LiveReadout(
            liveLocaleString: liveLocaleString,
            liveLanguageCode: liveLanguageCode,
            liveCountryCode: liveCountryCode,
            liveScriptCode: liveScriptCode,
          ),
          const SizedBox(height: 28.0),
          _section6MaterialLocalizationsReadout(
            ok: mlOk,
            cancel: mlCancel,
            close: mlClose,
            nextMonth: mlNextMonth,
            previousMonth: mlPreviousMonth,
            backButton: mlBackButtonTooltip,
            openDrawer: mlOpenAppDrawerTooltip,
            searchField: mlSearchFieldLabel,
          ),
          const SizedBox(height: 28.0),
          _section7DirectionMatrix(),
          const SizedBox(height: 28.0),
          _section8FallbackDiagram(),
          const SizedBox(height: 28.0),
          _section9DoAvoid(),
          const SizedBox(height: 28.0),
          _section10CodeRecipes(),
          const SizedBox(height: 28.0),
          _section11Glossary(),
          const SizedBox(height: 28.0),
          _section12RecapFooter(),
          const SizedBox(height: 48.0),
        ],
      ),
    ),
  );
}

// ===========================================================================
// SECTION 1 — TITLE BANNER WITH PALETTE SWATCHES
// ===========================================================================

Widget _section1TitleBanner() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          atlasWalnutShell,
          atlasWalnutHide,
          atlasWalnutBark,
          atlasWalnutNight,
        ],
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: atlasWalnutInk.withValues(alpha: 0.45),
          blurRadius: 24.0,
          offset: const Offset(0, 10),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 56.0,
              height: 56.0,
              decoration: BoxDecoration(
                color: atlasWalnutGold,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: atlasWalnutCream, width: 2.0),
              ),
              alignment: Alignment.center,
              child: Text(
                'L',
                style: TextStyle(
                  color: atlasWalnutShell,
                  fontWeight: FontWeight.w900,
                  fontSize: 30.0,
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Localizations',
                    style: TextStyle(
                      color: atlasWalnutCream,
                      fontSize: 28.0,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(height: 6.0),
                  Text(
                    'A locale-aware InheritedWidget that publishes '
                    'delegate-resolved values to its descendants.',
                    style: TextStyle(
                      color: atlasWalnutSand,
                      fontSize: 14.0,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        Text(
          'Atlas Walnut palette',
          style: TextStyle(
            color: atlasWalnutMist,
            fontSize: 12.0,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.4,
          ),
        ),
        const SizedBox(height: 10.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: [
            _swatch('Shell', atlasWalnutShell, atlasWalnutCream),
            _swatch('Hide', atlasWalnutHide, atlasWalnutCream),
            _swatch('Bark', atlasWalnutBark, atlasWalnutCream),
            _swatch('Leaf', atlasWalnutLeaf, atlasWalnutCream),
            _swatch('Tan', atlasWalnutTan, atlasWalnutShell),
            _swatch('Sand', atlasWalnutSand, atlasWalnutShell),
            _swatch('Cream', atlasWalnutCream, atlasWalnutShell),
            _swatch('Mist', atlasWalnutMist, atlasWalnutShell),
            _swatch('Ink', atlasWalnutInk, atlasWalnutCream),
            _swatch('Night', atlasWalnutNight, atlasWalnutCream),
            _swatch('Sea', atlasWalnutSea, atlasWalnutCream),
            _swatch('Moss', atlasWalnutMoss, atlasWalnutCream),
            _swatch('Ember', atlasWalnutEmber, atlasWalnutCream),
            _swatch('Gold', atlasWalnutGold, atlasWalnutShell),
          ],
        ),
      ],
    ),
  );
}

Widget _swatch(String name, Color color, Color fg) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: atlasWalnutCream.withValues(alpha: 0.25)),
    ),
    child: Text(
      name,
      style: TextStyle(
        color: fg,
        fontSize: 12.0,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.6,
      ),
    ),
  );
}

// ===========================================================================
// SECTION 2 — PROSE ANATOMY OF THE LOCALIZATION PIPELINE
// ===========================================================================

Widget _section2ProseAnatomy() {
  return _proseCard(
    title: 'Anatomy of the localization pipeline',
    paragraphs: [
      'A Flutter app loads localized text and formatting through a chain of '
          'cooperating actors. At the top of the chain, the `WidgetsApp` (or '
          '`MaterialApp`/`CupertinoApp`) is configured with a `locale`, a '
          '`supportedLocales` list, and a list of `localizationsDelegates`.',
      'When the app starts, Flutter resolves the desired locale by consulting '
          'the platform locale, the app-supplied `locale` override, and the '
          '`supportedLocales` list. The resolved locale becomes the `Locale` '
          'value carried by the framework `Localizations` widget.',
      'The `Localizations` widget then asks each `LocalizationsDelegate` to '
          '`load(locale)`. Each delegate returns a typed bundle (for example, '
          '`MaterialLocalizations`, `WidgetsLocalizations`, '
          '`CupertinoLocalizations`, and any app-specific bundles).',
      'Descendants in the widget tree access these bundles via static '
          'lookups: `Localizations.of<MaterialLocalizations>(context, '
          'MaterialLocalizations)` or the well-known wrappers '
          '`MaterialLocalizations.of(context)`, '
          '`Localizations.localeOf(context)`, etc.',
      'When the locale changes — for example, because the user switched the '
          'system language — `Localizations` rebuilds with a new locale and '
          're-runs `load()` on each delegate, propagating new values down the '
          'tree via the InheritedWidget update protocol.',
      'Fallback ordering follows ISO 639/3166 conventions: a request for '
          '`de-CH` matches `de-CH`, then `de`, then the first supported '
          'locale. When no match exists, Flutter falls back to the first '
          'locale in `supportedLocales` (typically English).',
    ],
  );
}

// ===========================================================================
// SECTION 3 — PROPERTY ANATOMY
// ===========================================================================

Widget _section3PropertyAnatomy() {
  return _proseCard(
    title: 'Properties of the Localizations widget',
    paragraphs: [
      'locale (Locale, required): the active locale that descendants will see '
          'when they call Localizations.localeOf(context). Drives the '
          'per-delegate load() calls and the InheritedWidget identity.',
      'delegates (List<LocalizationsDelegate<dynamic>>, required): each '
          'delegate is responsible for producing one type of localized data '
          '(strings, formatters, calendars, directionality, plural rules). '
          'Order matters when delegates contend for the same type.',
      'child (Widget, optional): the subtree that will be able to look up '
          'localized values via Localizations.of/localeOf. The child is '
          'usually a Navigator or app shell, never a leaf widget.',
      'Static methods: Localizations.of<T>(BuildContext, Type) and '
          'Localizations.localeOf(BuildContext). Both register the calling '
          'element as a dependency on the nearest Localizations ancestor, so '
          'rebuilds happen automatically when the locale changes.',
      'Key behavior: Localizations is itself a StatefulWidget internally, '
          'but consumers always treat it as an inherited boundary. Never '
          'instantiate it manually below a MaterialApp — let the framework '
          'do it.',
    ],
  );
}

// ===========================================================================
// SECTION 4 — LOCALE GALLERY
// ===========================================================================

Widget _section4LocaleGallery() {
  // Define 14 distinct Locale instances. We DO instantiate them and read
  // their fields into Text widgets so the demo exercises the real API.
  const List<Locale> locales = <Locale>[
    Locale('en'),
    Locale('en', 'GB'),
    Locale('en', 'US'),
    Locale('de'),
    Locale('de', 'AT'),
    Locale('de', 'CH'),
    Locale('fr', 'FR'),
    Locale('fr', 'CA'),
    Locale('es', 'ES'),
    Locale('es', 'MX'),
    Locale('pt', 'BR'),
    Locale('it', 'IT'),
    Locale('nl', 'NL'),
    Locale('ja', 'JP'),
    Locale('ko', 'KR'),
    Locale('zh', 'CN'),
    Locale('zh', 'TW'),
    Locale('ar', 'SA'),
    Locale('he', 'IL'),
    Locale('ru', 'RU'),
    Locale('tr', 'TR'),
    Locale('hi', 'IN'),
  ];

  print('[atlas-walnut] Locale gallery: ${locales.length} locales constructed');
  for (int i = 0; i < locales.length; i++) {
    final l = locales[i];
    print('[atlas-walnut]   [$i] ${l.toString()} '
        'lang=${l.languageCode} country=${l.countryCode ?? '-'}');
  }

  final List<Widget> cards = <Widget>[];
  for (int i = 0; i < locales.length; i++) {
    cards.add(_localeCard(locales[i], _displayName(locales[i])));
  }

  return _container(
    title: 'Locale gallery',
    subtitle: '${locales.length} `Locale` values, freshly constructed',
    child: Wrap(
      spacing: 14.0,
      runSpacing: 14.0,
      children: cards,
    ),
  );
}

String _displayName(Locale l) {
  final lang = l.languageCode;
  final country = l.countryCode;
  if (lang == 'en' && country == null) return 'English';
  if (lang == 'en' && country == 'GB') return 'English (UK)';
  if (lang == 'en' && country == 'US') return 'English (US)';
  if (lang == 'de' && country == null) return 'Deutsch';
  if (lang == 'de' && country == 'AT') return 'Deutsch (Austria)';
  if (lang == 'de' && country == 'CH') return 'Deutsch (Switzerland)';
  if (lang == 'fr' && country == 'FR') return 'Francais (France)';
  if (lang == 'fr' && country == 'CA') return 'Francais (Canada)';
  if (lang == 'es' && country == 'ES') return 'Espanol (Spain)';
  if (lang == 'es' && country == 'MX') return 'Espanol (Mexico)';
  if (lang == 'pt' && country == 'BR') return 'Portugues (Brasil)';
  if (lang == 'it' && country == 'IT') return 'Italiano';
  if (lang == 'nl' && country == 'NL') return 'Nederlands';
  if (lang == 'ja') return 'Japanese';
  if (lang == 'ko') return 'Korean';
  if (lang == 'zh' && country == 'CN') return 'Chinese (Simplified)';
  if (lang == 'zh' && country == 'TW') return 'Chinese (Traditional)';
  if (lang == 'ar') return 'Arabic (RTL)';
  if (lang == 'he') return 'Hebrew (RTL)';
  if (lang == 'ru') return 'Russian';
  if (lang == 'tr') return 'Turkish';
  if (lang == 'hi') return 'Hindi';
  return '$lang${country == null ? '' : '_$country'}';
}

Widget _localeCard(Locale locale, String displayName) {
  return Container(
    width: 220.0,
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: atlasWalnutCream,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: atlasWalnutBark.withValues(alpha: 0.3)),
      boxShadow: [
        BoxShadow(
          color: atlasWalnutInk.withValues(alpha: 0.08),
          blurRadius: 6.0,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 36.0,
              height: 36.0,
              decoration: BoxDecoration(
                color: atlasWalnutNight,
                borderRadius: BorderRadius.circular(8.0),
              ),
              alignment: Alignment.center,
              child: Text(
                locale.languageCode.toUpperCase(),
                style: TextStyle(
                  color: atlasWalnutGold,
                  fontWeight: FontWeight.w800,
                  fontSize: 14.0,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                displayName,
                style: TextStyle(
                  color: atlasWalnutShell,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        _kv('toString', locale.toString()),
        _kv('languageCode', locale.languageCode),
        _kv('countryCode', locale.countryCode ?? '(none)'),
        _kv('scriptCode', locale.scriptCode ?? '(none)'),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 5 — LIVE READOUT
// ===========================================================================

Widget _section5LiveReadout({
  required String liveLocaleString,
  required String liveLanguageCode,
  required String liveCountryCode,
  required String liveScriptCode,
}) {
  return _container(
    title: 'Live readout: Localizations.localeOf(context)',
    subtitle: 'Resolved at build() time from the test app ancestor.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _readoutTile(
                label: 'Locale.toString()',
                value: liveLocaleString,
                accent: atlasWalnutNight,
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: _readoutTile(
                label: 'languageCode',
                value: liveLanguageCode,
                accent: atlasWalnutSea,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _readoutTile(
                label: 'countryCode',
                value: liveCountryCode,
                accent: atlasWalnutMoss,
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: _readoutTile(
                label: 'scriptCode',
                value: liveScriptCode,
                accent: atlasWalnutEmber,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: atlasWalnutMist,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: atlasWalnutBark.withValues(alpha: 0.2)),
          ),
          child: Text(
            'Tip: every call to Localizations.localeOf(context) registers '
            'the calling Element as a dependency on the nearest '
            'Localizations ancestor. When the locale changes, Flutter '
            'rebuilds everyone who has subscribed.',
            style: TextStyle(
              color: atlasWalnutShell,
              fontSize: 12.5,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _readoutTile({
  required String label,
  required String value,
  required Color accent,
}) {
  return Container(
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: atlasWalnutCream,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: accent.withValues(alpha: 0.55), width: 1.4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: accent,
            fontSize: 11.0,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          value,
          style: TextStyle(
            color: atlasWalnutShell,
            fontSize: 16.0,
            fontWeight: FontWeight.w800,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 6 — MaterialLocalizations.of(context) FIELD READOUT
// ===========================================================================

Widget _section6MaterialLocalizationsReadout({
  required String ok,
  required String cancel,
  required String close,
  required String nextMonth,
  required String previousMonth,
  required String backButton,
  required String openDrawer,
  required String searchField,
}) {
  return _container(
    title: 'MaterialLocalizations.of(context) field readout',
    subtitle: 'Strings actually resolved from the active delegate.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _materialFieldRow('okButtonLabel', ok),
        _materialFieldRow('cancelButtonLabel', cancel),
        _materialFieldRow('closeButtonLabel', close),
        _materialFieldRow('nextMonthTooltip', nextMonth),
        _materialFieldRow('previousMonthTooltip', previousMonth),
        _materialFieldRow('backButtonTooltip', backButton),
        _materialFieldRow('openAppDrawerTooltip', openDrawer),
        _materialFieldRow('searchFieldLabel', searchField),
      ],
    ),
  );
}

Widget _materialFieldRow(String name, String value) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8.0),
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: atlasWalnutCream,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: atlasWalnutTan.withValues(alpha: 0.45)),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 200.0,
          child: Text(
            name,
            style: TextStyle(
              color: atlasWalnutNight,
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
            ),
          ),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: atlasWalnutShell,
              fontSize: 13.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 7 — DIRECTION MATRIX
// ===========================================================================

Widget _section7DirectionMatrix() {
  return _container(
    title: 'Direction matrix',
    subtitle: 'Inferred TextDirection per locale group.',
    child: Wrap(
      spacing: 14.0,
      runSpacing: 14.0,
      children: [
        _directionCard(const Locale('en', 'US'), TextDirection.ltr,
            'LTR — Latin script (en_US)'),
        _directionCard(const Locale('ja', 'JP'), TextDirection.ltr,
            'LTR — CJK script (ja_JP)'),
        _directionCard(const Locale('ar', 'SA'), TextDirection.rtl,
            'RTL — Arabic script (ar_SA)'),
        _directionCard(const Locale('he', 'IL'), TextDirection.rtl,
            'RTL — Hebrew script (he_IL)'),
      ],
    ),
  );
}

Widget _directionCard(Locale locale, TextDirection direction, String summary) {
  final isRtl = direction == TextDirection.rtl;
  return Container(
    width: 260.0,
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: atlasWalnutCream,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(
        color: isRtl ? atlasWalnutEmber : atlasWalnutSea,
        width: 1.4,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: isRtl ? atlasWalnutEmber : atlasWalnutSea,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                isRtl ? 'RTL' : 'LTR',
                style: TextStyle(
                  color: atlasWalnutCream,
                  fontSize: 11.0,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Text(
              locale.toString(),
              style: TextStyle(
                color: atlasWalnutShell,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Text(
          summary,
          style: TextStyle(
            color: atlasWalnutShell,
            fontSize: 12.5,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 10.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: atlasWalnutMist,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'lang=${locale.languageCode}  '
            'country=${locale.countryCode ?? '-'}',
            style: TextStyle(
              color: atlasWalnutNight,
              fontSize: 11.5,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 8 — FALLBACK DIAGRAM (de-CH -> de -> en)
// ===========================================================================

Widget _section8FallbackDiagram() {
  return _container(
    title: 'Locale fallback chain',
    subtitle: 'How `de-CH` resolves when not directly supported.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _fallbackLayer(
          label: 'requested',
          locale: const Locale('de', 'CH'),
          color: atlasWalnutEmber,
          note: 'User-preferred locale: Swiss German.',
        ),
        _fallbackArrow('no exact match in supportedLocales'),
        _fallbackLayer(
          label: 'language match',
          locale: const Locale('de'),
          color: atlasWalnutMoss,
          note: 'Falls back to language-only match: German.',
        ),
        _fallbackArrow('still nothing? continue down chain'),
        _fallbackLayer(
          label: 'final fallback',
          locale: const Locale('en'),
          color: atlasWalnutSea,
          note: 'First entry in supportedLocales — English.',
        ),
      ],
    ),
  );
}

Widget _fallbackLayer({
  required String label,
  required Locale locale,
  required Color color,
  required String note,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color, width: 1.6),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 10.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            label.toUpperCase(),
            style: TextStyle(
              color: atlasWalnutCream,
              fontSize: 10.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.0,
            ),
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                locale.toString(),
                style: TextStyle(
                  color: atlasWalnutShell,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                note,
                style: TextStyle(
                  color: atlasWalnutShell,
                  fontSize: 12.0,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _fallbackArrow(String note) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Icon(Icons.arrow_downward,
            color: atlasWalnutBark, size: 18.0),
        const SizedBox(width: 8.0),
        Text(
          note,
          style: TextStyle(
            color: atlasWalnutBark,
            fontSize: 11.5,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 9 — DO/AVOID CALLOUTS
// ===========================================================================

Widget _section9DoAvoid() {
  return _container(
    title: 'DO and AVOID',
    subtitle: 'Field-tested rules for working with Localizations.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _doRow('DO register every delegate your app uses, including the '
            'three Global* delegates (Material, Widgets, Cupertino).'),
        _doRow('DO list every supported locale in `supportedLocales` so '
            'fallback can find a match.'),
        _doRow('DO call Localizations.of<T>(context, T) only inside build '
            'methods or methods called from build, never from constructors.'),
        _doRow('DO ship a custom delegate when you have app-specific '
            'strings; do not store them in app state.'),
        _avoidRow('AVOID hard-coding strings in widget trees — your '
            'translators have nothing to translate against.'),
        _avoidRow('AVOID instantiating the Localizations widget yourself '
            'underneath MaterialApp; it is already there.'),
        _avoidRow('AVOID assuming en-US semantics when formatting numbers, '
            'dates, plurals, or RTL layouts — always use locale-aware '
            'helpers from the localized bundle.'),
      ],
    ),
  );
}

Widget _doRow(String text) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: atlasWalnutMoss.withValues(alpha: 0.14),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: atlasWalnutMoss, width: 1.2),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check_circle, color: atlasWalnutMoss, size: 20.0),
        const SizedBox(width: 10.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: atlasWalnutShell,
              fontSize: 13.0,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _avoidRow(String text) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: atlasWalnutEmber.withValues(alpha: 0.14),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: atlasWalnutEmber, width: 1.2),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.do_not_disturb_on,
            color: atlasWalnutEmber, size: 20.0),
        const SizedBox(width: 10.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: atlasWalnutShell,
              fontSize: 13.0,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 10 — CODE-SNIPPET RECIPE CARDS
// ===========================================================================

Widget _section10CodeRecipes() {
  return _container(
    title: 'Code recipes',
    subtitle: 'Five concrete patterns you will use repeatedly.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _recipe(
          n: '1',
          title: 'MaterialApp.locale override',
          code:
              "MaterialApp(\n"
              "  locale: const Locale('de', 'CH'),\n"
              "  supportedLocales: const [\n"
              "    Locale('en'),\n"
              "    Locale('de'),\n"
              "    Locale('de', 'CH'),\n"
              "  ],\n"
              "  localizationsDelegates: const [\n"
              "    GlobalMaterialLocalizations.delegate,\n"
              "    GlobalWidgetsLocalizations.delegate,\n"
              "    GlobalCupertinoLocalizations.delegate,\n"
              "  ],\n"
              "  home: HomePage(),\n"
              ")",
        ),
        _recipe(
          n: '2',
          title: 'Reading the active locale',
          code:
              "Widget build(BuildContext context) {\n"
              "  final locale = Localizations.localeOf(context);\n"
              "  return Text('Locale = \$locale');\n"
              "}",
        ),
        _recipe(
          n: '3',
          title: 'Reading a typed delegate bundle',
          code:
              "final ml = Localizations.of<MaterialLocalizations>(\n"
              "  context, MaterialLocalizations,\n"
              ")!;\n"
              "Text(ml.okButtonLabel);",
        ),
        _recipe(
          n: '4',
          title: 'Custom LocalizationsDelegate',
          code:
              "class AppL10nDelegate\n"
              "    extends LocalizationsDelegate<AppL10n> {\n"
              "  const AppL10nDelegate();\n"
              "  @override bool isSupported(Locale l) =>\n"
              "      ['en','de','fr'].contains(l.languageCode);\n"
              "  @override Future<AppL10n> load(Locale l) async =>\n"
              "      AppL10n.load(l);\n"
              "  @override bool shouldReload(_) => false;\n"
              "}",
        ),
        _recipe(
          n: '5',
          title: 'Direction-aware padding via locale',
          code:
              "final dir = Directionality.of(context);\n"
              "final start = dir == TextDirection.rtl ? 0.0 : 16.0;\n"
              "final end = dir == TextDirection.rtl ? 16.0 : 0.0;\n"
              "Padding(padding: EdgeInsets.only(left: start, right: end));",
        ),
      ],
    ),
  );
}

Widget _recipe({required String n, required String title, required String code}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 14.0),
    decoration: BoxDecoration(
      color: atlasWalnutCream,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: atlasWalnutBark.withValues(alpha: 0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 12.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: atlasWalnutNight,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 26.0,
                height: 26.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: atlasWalnutGold,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  n,
                  style: TextStyle(
                    color: atlasWalnutShell,
                    fontWeight: FontWeight.w800,
                    fontSize: 13.0,
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: atlasWalnutCream,
                    fontWeight: FontWeight.w700,
                    fontSize: 13.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: atlasWalnutInk,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(12.0),
              bottomRight: Radius.circular(12.0),
            ),
          ),
          child: Text(
            code,
            style: TextStyle(
              color: atlasWalnutSand,
              fontSize: 11.5,
              fontFamily: 'monospace',
              height: 1.55,
            ),
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 11 — GLOSSARY
// ===========================================================================

Widget _section11Glossary() {
  final terms = <List<String>>[
    [
      'Locale',
      'A language-and-region tag like `en_US` or `de_CH`. May also '
          'include a script tag (`zh_Hans_CN`).'
    ],
    [
      'languageCode',
      'The ISO 639-1 (or 639-2/3) language portion of a Locale, '
          'always lowercase, e.g. "en", "de".'
    ],
    [
      'countryCode',
      'The ISO 3166-1 region portion of a Locale, always uppercase, '
          'e.g. "US", "CH".'
    ],
    [
      'scriptCode',
      'Optional ISO 15924 script tag, e.g. "Hans" (Simplified Chinese) '
          'or "Hant" (Traditional Chinese).'
    ],
    [
      'LocalizationsDelegate',
      'Object that knows how to load a typed bundle for a given Locale '
          'and decide which locales it supports.'
    ],
    [
      'MaterialLocalizations',
      'Bundle of Material-specific strings (button labels, tooltips, '
          'date pickers) accessed via `MaterialLocalizations.of`.'
    ],
    [
      'WidgetsLocalizations',
      'Bundle of fundamental widget strings (text direction, '
          'reorderable item labels) used by the widgets layer.'
    ],
    [
      'CupertinoLocalizations',
      'Cupertino counterpart to MaterialLocalizations; used by '
          'Cupertino widgets like CupertinoDatePicker.'
    ],
    [
      'supportedLocales',
      'List of Locales the app advertises it can render. Drives the '
          'fallback resolution algorithm.'
    ],
    [
      'localeListResolutionCallback',
      'App-supplied function that picks the active Locale from the '
          'platform-preferred list.'
    ],
    [
      'localeResolutionCallback',
      'Older single-locale variant of `localeListResolutionCallback`. '
          'Prefer the list-based callback.'
    ],
    [
      'TextDirection',
      'Either `TextDirection.ltr` or `TextDirection.rtl`. Provided by '
          '`Directionality`, which `Localizations` populates per locale.'
    ],
    [
      'Directionality',
      'InheritedWidget that publishes the active TextDirection. '
          'Most apps never set it directly — Localizations does.'
    ],
    [
      'Localizations.localeOf',
      'Static helper that returns the active Locale and registers a '
          'rebuild dependency on the Localizations ancestor.'
    ],
    [
      'Localizations.of',
      'Generic static lookup for typed bundles like '
          '`MaterialLocalizations` or app-defined `AppL10n`.'
    ],
  ];

  final List<Widget> rows = <Widget>[];
  for (int i = 0; i < terms.length; i++) {
    final t = terms[i];
    rows.add(_glossaryRow(t[0], t[1]));
  }

  return _container(
    title: 'Glossary',
    subtitle: '${terms.length} terms you will see again and again.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: rows,
    ),
  );
}

Widget _glossaryRow(String term, String def) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: atlasWalnutCream,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: atlasWalnutBark.withValues(alpha: 0.25)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          term,
          style: TextStyle(
            color: atlasWalnutNight,
            fontSize: 13.0,
            fontWeight: FontWeight.w800,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          def,
          style: TextStyle(
            color: atlasWalnutShell,
            fontSize: 12.5,
            height: 1.45,
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 12 — RECAP FOOTER
// ===========================================================================

Widget _section12RecapFooter() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [atlasWalnutNight, atlasWalnutShell],
      ),
      borderRadius: BorderRadius.circular(18.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recap',
          style: TextStyle(
            color: atlasWalnutGold,
            fontSize: 18.0,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.6,
          ),
        ),
        const SizedBox(height: 10.0),
        Text(
          'Localizations is the InheritedWidget at the top of every Flutter '
          'app that publishes a Locale and a set of locale-resolved '
          'delegate bundles. You almost never instantiate it yourself: '
          'WidgetsApp/MaterialApp/CupertinoApp do it for you. Lower in '
          'the tree, you read it through Localizations.localeOf, '
          'Localizations.of<T>, or convenience wrappers like '
          'MaterialLocalizations.of.',
          style: TextStyle(
            color: atlasWalnutCream,
            fontSize: 13.0,
            height: 1.55,
          ),
        ),
        const SizedBox(height: 14.0),
        Text(
          'Atlas Walnut closes here — leather edges, painted oceans, '
          'compass-rose night. Bind your locales like an old atlas and '
          'they will outlast every release.',
          style: TextStyle(
            color: atlasWalnutSand,
            fontSize: 12.5,
            fontStyle: FontStyle.italic,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SHARED HELPERS — generic container, prose card, key-value text
// ===========================================================================

Widget _container({
  required String title,
  required String subtitle,
  required Widget child,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: atlasWalnutMist,
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: atlasWalnutBark.withValues(alpha: 0.25)),
      boxShadow: [
        BoxShadow(
          color: atlasWalnutInk.withValues(alpha: 0.06),
          blurRadius: 10.0,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: atlasWalnutShell,
            fontSize: 18.0,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          subtitle,
          style: TextStyle(
            color: atlasWalnutBark,
            fontSize: 12.5,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 14.0),
        child,
      ],
    ),
  );
}

Widget _proseCard({
  required String title,
  required List<String> paragraphs,
}) {
  final List<Widget> children = <Widget>[];
  children.add(Text(
    title,
    style: TextStyle(
      color: atlasWalnutShell,
      fontSize: 18.0,
      fontWeight: FontWeight.w800,
    ),
  ));
  children.add(const SizedBox(height: 12.0));
  for (int i = 0; i < paragraphs.length; i++) {
    children.add(Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: atlasWalnutCream,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: atlasWalnutTan.withValues(alpha: 0.4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 22.0,
            height: 22.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: atlasWalnutNight,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              '${i + 1}',
              style: TextStyle(
                color: atlasWalnutGold,
                fontSize: 11.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Text(
              paragraphs[i],
              style: TextStyle(
                color: atlasWalnutShell,
                fontSize: 13.0,
                height: 1.55,
              ),
            ),
          ),
        ],
      ),
    ));
  }
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: atlasWalnutMist,
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: atlasWalnutBark.withValues(alpha: 0.25)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    ),
  );
}

Widget _kv(String key, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 86.0,
          child: Text(
            key,
            style: TextStyle(
              color: atlasWalnutBark,
              fontSize: 11.0,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: atlasWalnutShell,
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}
