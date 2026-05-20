// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// =============================================================================
// LocaleSnapshotNotification / Locale Propagation Visual Field Manual
// -----------------------------------------------------------------------------
// Theme:   "Atlas Parchment" -- a cartographer's notebook bound in vellum,
//          stitched together with bilingual marginalia and printed in two
//          coexisting inks: Globe Indigo and Cinnabar Compass.
// Subject: Flutter's Locale model, Localizations propagation, language
//          fallback, RTL/LTR direction handling, and the conceptual
//          "LocaleSnapshotNotification" pattern used to broadcast locale
//          changes through the widget tree.
// -----------------------------------------------------------------------------
// This file is a hand-authored single-build demo. It contains exactly one
// top-level `dynamic build(BuildContext context)` function returning a
// Scaffold-rooted MaterialApp. It avoids: StatefulWidget, setState,
// AnimationController, Future, await, Stream, Timer, custom Notification
// subclasses, mutating NotificationListeners, and the for-in iterator form
// (we use index-based for loops only, in keeping with the bridged-runtime
// constraints of the d4rt sandbox).
// =============================================================================

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('[atlas_parchment] LocaleSnapshotNotification field manual booting');
  print('[atlas_parchment] phase 1/9 -- palette and typographic stops');

  // ---------------------------------------------------------------------------
  // PALETTE: Atlas Parchment
  // ---------------------------------------------------------------------------
  // Two inks (Globe Indigo, Cinnabar Compass) over five vellum tones, with a
  // verdigris accent reserved for "verified" markers and a sepia rule used as
  // a hairline divider on map plates.
  // ---------------------------------------------------------------------------
  final Color vellumDeep = const Color(0xFFE8DCC0);
  final Color vellumWarm = const Color(0xFFEFE3C8);
  final Color vellumPale = const Color(0xFFF6ECD2);
  final Color vellumIvory = const Color(0xFFFBF4DC);
  final Color vellumChalk = const Color(0xFFFFF9E5);
  final Color globeIndigo = const Color(0xFF1F3A6B);
  final Color globeMidnight = const Color(0xFF12224A);
  final Color cinnabarCompass = const Color(0xFFB23B2E);
  final Color cinnabarRust = const Color(0xFF8C2A1F);
  final Color verdigris = const Color(0xFF3F7D6E);
  final Color sepiaRule = const Color(0xFF7A5A2F);
  final Color brassEdge = const Color(0xFFA88A3F);
  final Color mistShade = const Color(0xFFB7AE92);

  print('[atlas_parchment] vellumDeep=$vellumDeep globeIndigo=$globeIndigo');
  print('[atlas_parchment] cinnabarCompass=$cinnabarCompass verdigris=$verdigris');

  // ---------------------------------------------------------------------------
  // TYPOGRAPHIC STOPS
  // ---------------------------------------------------------------------------
  final TextStyle styleHeroTitle = TextStyle(
    fontSize: 30.0,
    fontWeight: FontWeight.w800,
    color: globeMidnight,
    letterSpacing: 1.4,
    height: 1.15,
  );
  final TextStyle styleHeroSubtitle = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    color: cinnabarRust,
    letterSpacing: 0.9,
    fontStyle: FontStyle.italic,
  );
  final TextStyle styleSectionHeader = TextStyle(
    fontSize: 22.0,
    fontWeight: FontWeight.w700,
    color: globeIndigo,
    letterSpacing: 0.8,
  );
  final TextStyle styleSectionLead = TextStyle(
    fontSize: 13.0,
    fontWeight: FontWeight.w500,
    color: sepiaRule,
    height: 1.55,
  );
  final TextStyle styleBody = TextStyle(
    fontSize: 13.0,
    color: globeMidnight,
    height: 1.5,
  );
  final TextStyle styleBodyEm = TextStyle(
    fontSize: 13.0,
    color: cinnabarRust,
    fontWeight: FontWeight.w600,
    height: 1.5,
  );
  final TextStyle styleMono = TextStyle(
    fontSize: 12.0,
    color: globeMidnight,
    fontFamily: 'monospace',
    height: 1.45,
  );
  final TextStyle styleMonoAccent = TextStyle(
    fontSize: 12.0,
    color: cinnabarRust,
    fontFamily: 'monospace',
    fontWeight: FontWeight.w700,
    height: 1.45,
  );
  final TextStyle styleCaption = TextStyle(
    fontSize: 11.0,
    color: sepiaRule,
    fontStyle: FontStyle.italic,
    letterSpacing: 0.4,
  );
  final TextStyle styleTableHeader = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w700,
    color: vellumChalk,
    letterSpacing: 0.6,
  );
  final TextStyle styleTableCell = TextStyle(
    fontSize: 12.0,
    color: globeMidnight,
    height: 1.4,
  );
  final TextStyle styleGlyphTag = TextStyle(
    fontSize: 11.0,
    color: vellumChalk,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.8,
  );

  print('[atlas_parchment] typography registered: ${styleHeroTitle.fontSize}pt hero');

  // ---------------------------------------------------------------------------
  // DEFENSIVE LOCALE CONSTRUCTION
  // ---------------------------------------------------------------------------
  // Each Locale is wrapped in try/catch because the bridged runtime may not
  // surface every constructor identically. We collect "constructed" flags so
  // the catalog can render a faded plate when a locale failed to materialize.
  // ---------------------------------------------------------------------------
  print('[atlas_parchment] phase 2/9 -- locale catalog construction');

  Locale? localeEnUs;
  bool localeEnUsOk = false;
  try {
    localeEnUs = Locale('en', 'US');
    localeEnUsOk = true;
  } catch (e) {
    print('[atlas_parchment] en-US construction failed: $e');
  }

  Locale? localeEnGb;
  bool localeEnGbOk = false;
  try {
    localeEnGb = Locale('en', 'GB');
    localeEnGbOk = true;
  } catch (e) {
    print('[atlas_parchment] en-GB construction failed: $e');
  }

  Locale? localeEnCa;
  bool localeEnCaOk = false;
  try {
    localeEnCa = Locale('en', 'CA');
    localeEnCaOk = true;
  } catch (e) {
    print('[atlas_parchment] en-CA construction failed: $e');
  }

  Locale? localeEnAu;
  bool localeEnAuOk = false;
  try {
    localeEnAu = Locale('en', 'AU');
    localeEnAuOk = true;
  } catch (e) {
    print('[atlas_parchment] en-AU construction failed: $e');
  }

  Locale? localeDeDe;
  bool localeDeDeOk = false;
  try {
    localeDeDe = Locale('de', 'DE');
    localeDeDeOk = true;
  } catch (e) {
    print('[atlas_parchment] de-DE construction failed: $e');
  }

  Locale? localeDeCh;
  bool localeDeChOk = false;
  try {
    localeDeCh = Locale('de', 'CH');
    localeDeChOk = true;
  } catch (e) {
    print('[atlas_parchment] de-CH construction failed: $e');
  }

  Locale? localeDeAt;
  bool localeDeAtOk = false;
  try {
    localeDeAt = Locale('de', 'AT');
    localeDeAtOk = true;
  } catch (e) {
    print('[atlas_parchment] de-AT construction failed: $e');
  }

  Locale? localeFrFr;
  bool localeFrFrOk = false;
  try {
    localeFrFr = Locale('fr', 'FR');
    localeFrFrOk = true;
  } catch (e) {
    print('[atlas_parchment] fr-FR construction failed: $e');
  }

  Locale? localeFrCa;
  bool localeFrCaOk = false;
  try {
    localeFrCa = Locale('fr', 'CA');
    localeFrCaOk = true;
  } catch (e) {
    print('[atlas_parchment] fr-CA construction failed: $e');
  }

  Locale? localeJaJp;
  bool localeJaJpOk = false;
  try {
    localeJaJp = Locale('ja', 'JP');
    localeJaJpOk = true;
  } catch (e) {
    print('[atlas_parchment] ja-JP construction failed: $e');
  }

  Locale? localeKoKr;
  bool localeKoKrOk = false;
  try {
    localeKoKr = Locale('ko', 'KR');
    localeKoKrOk = true;
  } catch (e) {
    print('[atlas_parchment] ko-KR construction failed: $e');
  }

  Locale? localeArEg;
  bool localeArEgOk = false;
  try {
    localeArEg = Locale('ar', 'EG');
    localeArEgOk = true;
  } catch (e) {
    print('[atlas_parchment] ar-EG construction failed: $e');
  }

  Locale? localeArSa;
  bool localeArSaOk = false;
  try {
    localeArSa = Locale('ar', 'SA');
    localeArSaOk = true;
  } catch (e) {
    print('[atlas_parchment] ar-SA construction failed: $e');
  }

  Locale? localeHeIl;
  bool localeHeIlOk = false;
  try {
    localeHeIl = Locale('he', 'IL');
    localeHeIlOk = true;
  } catch (e) {
    print('[atlas_parchment] he-IL construction failed: $e');
  }

  Locale? localeZhHans;
  bool localeZhHansOk = false;
  try {
    localeZhHans = Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans');
    localeZhHansOk = true;
  } catch (e) {
    print('[atlas_parchment] zh-Hans construction failed: $e');
  }

  Locale? localeZhHant;
  bool localeZhHantOk = false;
  try {
    localeZhHant = Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant');
    localeZhHantOk = true;
  } catch (e) {
    print('[atlas_parchment] zh-Hant construction failed: $e');
  }

  Locale? localeZhCn;
  bool localeZhCnOk = false;
  try {
    localeZhCn = Locale.fromSubtags(
      languageCode: 'zh',
      scriptCode: 'Hans',
      countryCode: 'CN',
    );
    localeZhCnOk = true;
  } catch (e) {
    print('[atlas_parchment] zh-Hans-CN construction failed: $e');
  }

  Locale? localeZhTw;
  bool localeZhTwOk = false;
  try {
    localeZhTw = Locale.fromSubtags(
      languageCode: 'zh',
      scriptCode: 'Hant',
      countryCode: 'TW',
    );
    localeZhTwOk = true;
  } catch (e) {
    print('[atlas_parchment] zh-Hant-TW construction failed: $e');
  }

  Locale? localeSrCyrl;
  bool localeSrCyrlOk = false;
  try {
    localeSrCyrl = Locale.fromSubtags(languageCode: 'sr', scriptCode: 'Cyrl');
    localeSrCyrlOk = true;
  } catch (e) {
    print('[atlas_parchment] sr-Cyrl construction failed: $e');
  }

  Locale? localeSrLatn;
  bool localeSrLatnOk = false;
  try {
    localeSrLatn = Locale.fromSubtags(languageCode: 'sr', scriptCode: 'Latn');
    localeSrLatnOk = true;
  } catch (e) {
    print('[atlas_parchment] sr-Latn construction failed: $e');
  }

  Locale? localePtBr;
  bool localePtBrOk = false;
  try {
    localePtBr = Locale('pt', 'BR');
    localePtBrOk = true;
  } catch (e) {
    print('[atlas_parchment] pt-BR construction failed: $e');
  }

  Locale? localePtPt;
  bool localePtPtOk = false;
  try {
    localePtPt = Locale('pt', 'PT');
    localePtPtOk = true;
  } catch (e) {
    print('[atlas_parchment] pt-PT construction failed: $e');
  }

  Locale? localeEsEs;
  bool localeEsEsOk = false;
  try {
    localeEsEs = Locale('es', 'ES');
    localeEsEsOk = true;
  } catch (e) {
    print('[atlas_parchment] es-ES construction failed: $e');
  }

  Locale? localeEsMx;
  bool localeEsMxOk = false;
  try {
    localeEsMx = Locale('es', 'MX');
    localeEsMxOk = true;
  } catch (e) {
    print('[atlas_parchment] es-MX construction failed: $e');
  }

  Locale? localeRuRu;
  bool localeRuRuOk = false;
  try {
    localeRuRu = Locale('ru', 'RU');
    localeRuRuOk = true;
  } catch (e) {
    print('[atlas_parchment] ru-RU construction failed: $e');
  }

  Locale? localeHiIn;
  bool localeHiInOk = false;
  try {
    localeHiIn = Locale('hi', 'IN');
    localeHiInOk = true;
  } catch (e) {
    print('[atlas_parchment] hi-IN construction failed: $e');
  }

  // Pull the ambient locale from context, defensively.
  Locale? ambientLocale;
  bool ambientLocaleOk = false;
  try {
    ambientLocale = Localizations.localeOf(context);
    ambientLocaleOk = true;
  } catch (e) {
    print('[atlas_parchment] Localizations.localeOf failed: $e');
  }

  print('[atlas_parchment] ambient locale resolved: $ambientLocale ok=$ambientLocaleOk');

  // ---------------------------------------------------------------------------
  // CATALOG: rows of locale records used by the locale plate grid.
  // Each entry is [tag, language, region/script, direction, scriptFamily,
  // currency, sampleGreeting, ok-flag-as-string].
  // ---------------------------------------------------------------------------
  final List<List<String>> localeCatalog = <List<String>>[
    <String>['en-US', 'English', 'United States', 'LTR', 'Latin', 'USD',
        'Hello, world.', localeEnUsOk ? 'live' : 'shadow'],
    <String>['en-GB', 'English', 'United Kingdom', 'LTR', 'Latin', 'GBP',
        'Hello, world.', localeEnGbOk ? 'live' : 'shadow'],
    <String>['en-CA', 'English', 'Canada', 'LTR', 'Latin', 'CAD',
        'Hello, world.', localeEnCaOk ? 'live' : 'shadow'],
    <String>['en-AU', 'English', 'Australia', 'LTR', 'Latin', 'AUD',
        'G\'day, world.', localeEnAuOk ? 'live' : 'shadow'],
    <String>['de-DE', 'Deutsch', 'Deutschland', 'LTR', 'Latin', 'EUR',
        'Hallo, Welt.', localeDeDeOk ? 'live' : 'shadow'],
    <String>['de-CH', 'Deutsch', 'Schweiz', 'LTR', 'Latin', 'CHF',
        'Gruezi, Welt.', localeDeChOk ? 'live' : 'shadow'],
    <String>['de-AT', 'Deutsch', 'Osterreich', 'LTR', 'Latin', 'EUR',
        'Servus, Welt.', localeDeAtOk ? 'live' : 'shadow'],
    <String>['fr-FR', 'Francais', 'France', 'LTR', 'Latin', 'EUR',
        'Bonjour, monde.', localeFrFrOk ? 'live' : 'shadow'],
    <String>['fr-CA', 'Francais', 'Canada', 'LTR', 'Latin', 'CAD',
        'Bonjour, monde.', localeFrCaOk ? 'live' : 'shadow'],
    <String>['ja-JP', 'Nihongo', 'Nippon', 'LTR', 'CJK', 'JPY',
        'Konnichiwa, sekai.', localeJaJpOk ? 'live' : 'shadow'],
    <String>['ko-KR', 'Hangugeo', 'Daehan Minguk', 'LTR', 'CJK', 'KRW',
        'Annyeong, segye.', localeKoKrOk ? 'live' : 'shadow'],
    <String>['ar-EG', 'al-arabiya', 'Misr', 'RTL', 'Arabic', 'EGP',
        'marhaba, ya alam.', localeArEgOk ? 'live' : 'shadow'],
    <String>['ar-SA', 'al-arabiya', 'Su\'udiya', 'RTL', 'Arabic', 'SAR',
        'as-salamu alaykum.', localeArSaOk ? 'live' : 'shadow'],
    <String>['he-IL', 'ivrit', 'Yisra\'el', 'RTL', 'Hebrew', 'ILS',
        'shalom, olam.', localeHeIlOk ? 'live' : 'shadow'],
    <String>['zh-Hans', 'Zhongwen', 'Simplified', 'LTR', 'Han-Hans', '---',
        'ni hao, shi jie.', localeZhHansOk ? 'live' : 'shadow'],
    <String>['zh-Hant', 'Zhongwen', 'Traditional', 'LTR', 'Han-Hant', '---',
        'ni hao, shi jie.', localeZhHantOk ? 'live' : 'shadow'],
    <String>['zh-Hans-CN', 'Zhongwen', 'PRC (Simplified)', 'LTR', 'Han-Hans',
        'CNY', 'ni hao, shi jie.', localeZhCnOk ? 'live' : 'shadow'],
    <String>['zh-Hant-TW', 'Zhongwen', 'Taiwan (Traditional)', 'LTR',
        'Han-Hant', 'TWD', 'ni hao, shi jie.', localeZhTwOk ? 'live' : 'shadow'],
    <String>['sr-Cyrl', 'srpski', 'Serbia (Cyrillic)', 'LTR', 'Cyrillic', 'RSD',
        'zdravo, svete.', localeSrCyrlOk ? 'live' : 'shadow'],
    <String>['sr-Latn', 'srpski', 'Serbia (Latin)', 'LTR', 'Latin', 'RSD',
        'zdravo, svete.', localeSrLatnOk ? 'live' : 'shadow'],
    <String>['pt-BR', 'portugues', 'Brasil', 'LTR', 'Latin', 'BRL',
        'Ola, mundo.', localePtBrOk ? 'live' : 'shadow'],
    <String>['pt-PT', 'portugues', 'Portugal', 'LTR', 'Latin', 'EUR',
        'Ola, mundo.', localePtPtOk ? 'live' : 'shadow'],
    <String>['es-ES', 'espanol', 'Espana', 'LTR', 'Latin', 'EUR',
        'Hola, mundo.', localeEsEsOk ? 'live' : 'shadow'],
    <String>['es-MX', 'espanol', 'Mexico', 'LTR', 'Latin', 'MXN',
        'Hola, mundo.', localeEsMxOk ? 'live' : 'shadow'],
    <String>['ru-RU', 'russkiy', 'Rossiya', 'LTR', 'Cyrillic', 'RUB',
        'privet, mir.', localeRuRuOk ? 'live' : 'shadow'],
    <String>['hi-IN', 'hindi', 'Bharat', 'LTR', 'Devanagari', 'INR',
        'namaste, duniya.', localeHiInOk ? 'live' : 'shadow'],
  ];

  print('[atlas_parchment] catalog rows = ${localeCatalog.length}');

  // Probe every constructed Locale so the runtime confirms each instance is
  // reachable. Each line emits the toLanguageTag() (or a shadow marker).
  print('[atlas_parchment] localeEnUs    = '
      '${localeEnUs == null ? '<shadow>' : localeEnUs.toLanguageTag()}');
  print('[atlas_parchment] localeEnGb    = '
      '${localeEnGb == null ? '<shadow>' : localeEnGb.toLanguageTag()}');
  print('[atlas_parchment] localeEnCa    = '
      '${localeEnCa == null ? '<shadow>' : localeEnCa.toLanguageTag()}');
  print('[atlas_parchment] localeEnAu    = '
      '${localeEnAu == null ? '<shadow>' : localeEnAu.toLanguageTag()}');
  print('[atlas_parchment] localeDeDe    = '
      '${localeDeDe == null ? '<shadow>' : localeDeDe.toLanguageTag()}');
  print('[atlas_parchment] localeDeCh    = '
      '${localeDeCh == null ? '<shadow>' : localeDeCh.toLanguageTag()}');
  print('[atlas_parchment] localeDeAt    = '
      '${localeDeAt == null ? '<shadow>' : localeDeAt.toLanguageTag()}');
  print('[atlas_parchment] localeFrFr    = '
      '${localeFrFr == null ? '<shadow>' : localeFrFr.toLanguageTag()}');
  print('[atlas_parchment] localeFrCa    = '
      '${localeFrCa == null ? '<shadow>' : localeFrCa.toLanguageTag()}');
  print('[atlas_parchment] localeJaJp    = '
      '${localeJaJp == null ? '<shadow>' : localeJaJp.toLanguageTag()}');
  print('[atlas_parchment] localeKoKr    = '
      '${localeKoKr == null ? '<shadow>' : localeKoKr.toLanguageTag()}');
  print('[atlas_parchment] localeArEg    = '
      '${localeArEg == null ? '<shadow>' : localeArEg.toLanguageTag()}');
  print('[atlas_parchment] localeArSa    = '
      '${localeArSa == null ? '<shadow>' : localeArSa.toLanguageTag()}');
  print('[atlas_parchment] localeHeIl    = '
      '${localeHeIl == null ? '<shadow>' : localeHeIl.toLanguageTag()}');
  print('[atlas_parchment] localeZhHans  = '
      '${localeZhHans == null ? '<shadow>' : localeZhHans.toLanguageTag()}');
  print('[atlas_parchment] localeZhHant  = '
      '${localeZhHant == null ? '<shadow>' : localeZhHant.toLanguageTag()}');
  print('[atlas_parchment] localeZhCn    = '
      '${localeZhCn == null ? '<shadow>' : localeZhCn.toLanguageTag()}');
  print('[atlas_parchment] localeZhTw    = '
      '${localeZhTw == null ? '<shadow>' : localeZhTw.toLanguageTag()}');
  print('[atlas_parchment] localeSrCyrl  = '
      '${localeSrCyrl == null ? '<shadow>' : localeSrCyrl.toLanguageTag()}');
  print('[atlas_parchment] localeSrLatn  = '
      '${localeSrLatn == null ? '<shadow>' : localeSrLatn.toLanguageTag()}');
  print('[atlas_parchment] localePtBr    = '
      '${localePtBr == null ? '<shadow>' : localePtBr.toLanguageTag()}');
  print('[atlas_parchment] localePtPt    = '
      '${localePtPt == null ? '<shadow>' : localePtPt.toLanguageTag()}');
  print('[atlas_parchment] localeEsEs    = '
      '${localeEsEs == null ? '<shadow>' : localeEsEs.toLanguageTag()}');
  print('[atlas_parchment] localeEsMx    = '
      '${localeEsMx == null ? '<shadow>' : localeEsMx.toLanguageTag()}');
  print('[atlas_parchment] localeRuRu    = '
      '${localeRuRu == null ? '<shadow>' : localeRuRu.toLanguageTag()}');
  print('[atlas_parchment] localeHiIn    = '
      '${localeHiIn == null ? '<shadow>' : localeHiIn.toLanguageTag()}');

  // ---------------------------------------------------------------------------
  // API SURFACE TABLE (Locale)
  // ---------------------------------------------------------------------------
  final List<List<String>> localeApiRows = <List<String>>[
    <String>['Locale(lang)', 'ctor', 'Locale("en")', 'language only'],
    <String>['Locale(lang, region)', 'ctor', 'Locale("en", "US")',
        'common shorthand'],
    <String>['Locale.fromSubtags', 'ctor', 'Locale.fromSubtags(...)',
        'full BCP47 control'],
    <String>['languageCode', 'String', 'en, de, ja, zh', 'ISO 639'],
    <String>['countryCode', 'String?', 'US, CH, JP', 'ISO 3166'],
    <String>['scriptCode', 'String?', 'Hans, Hant, Cyrl', 'ISO 15924'],
    <String>['toLanguageTag()', 'String', 'en-US / zh-Hans-CN', 'BCP47 tag'],
    <String>['toString()', 'String', 'en_US / zh_Hans_CN', 'underscore form'],
    <String>['== / hashCode', 'op', 'value equality', 'use as Map key'],
  ];

  // ---------------------------------------------------------------------------
  // FALLBACK CHAIN TABLE
  // ---------------------------------------------------------------------------
  final List<List<String>> fallbackRows = <List<String>>[
    <String>['fr-CA', 'fr-CA -> fr -> en (default)', 'region drops first'],
    <String>['de-CH', 'de-CH -> de -> en', 'region drops to base'],
    <String>['en-AU', 'en-AU -> en -> (none)', 'language already base'],
    <String>['zh-Hant-TW', 'zh-Hant-TW -> zh-Hant -> zh -> en',
        'script preserved before language base'],
    <String>['zh-Hans-CN', 'zh-Hans-CN -> zh-Hans -> zh -> en',
        'script aware fallback'],
    <String>['sr-Cyrl', 'sr-Cyrl -> sr -> en',
        'script may be required disambiguator'],
    <String>['pt-BR', 'pt-BR -> pt -> en', 'BR vs PT regional split'],
    <String>['ar-EG', 'ar-EG -> ar -> en', 'RTL: dir flips on resolution'],
  ];

  // ---------------------------------------------------------------------------
  // FLOWCHART NODES (Localizations -> override -> MaterialApp.locale -> system)
  // ---------------------------------------------------------------------------
  final List<List<String>> flowchartNodes = <List<String>>[
    <String>['1', 'WidgetsBinding.platformDispatcher.locales',
        'OS-level system locales (ordered preference list)'],
    <String>['2', 'WidgetsApp.localeListResolutionCallback',
        'first chance to map system locales -> supported locale'],
    <String>['3', 'WidgetsApp.localeResolutionCallback',
        'fallback when listResolution returns null'],
    <String>['4', 'MaterialApp.locale (explicit)',
        'pinned locale: bypasses system selection'],
    <String>['5', 'MaterialApp.supportedLocales',
        'whitelist used for narrowing system locales'],
    <String>['6', 'Localizations widget (root)',
        'inherited widget broadcasting Locale to descendants'],
    <String>['7', 'Localizations.override(...)',
        'subtree-level override; nests within parent'],
    <String>['8', 'Localizations.localeOf(context)',
        'leaf widget reads ambient locale'],
    <String>['9', 'LocaleSnapshotNotification (conceptual)',
        'broadcast wrapper used by router/shell layers to react to changes'],
  ];

  print('[atlas_parchment] phase 3/9 -- flowchart nodes registered: '
      '${flowchartNodes.length}');

  // ---------------------------------------------------------------------------
  // GLOSSARY ROWS
  // ---------------------------------------------------------------------------
  final List<List<String>> glossaryRows = <List<String>>[
    <String>['BCP47', 'IETF tag format combining language-script-region'],
    <String>['ISO 639', 'two/three letter language codes (en, de, zho)'],
    <String>['ISO 3166', 'two letter region/country codes (US, GB, CH)'],
    <String>['ISO 15924', 'four letter script codes (Latn, Hans, Cyrl)'],
    <String>['CLDR', 'Unicode Common Locale Data Repository'],
    <String>['LTR', 'left-to-right text direction (Latin, CJK, Cyrillic)'],
    <String>['RTL', 'right-to-left text direction (Arabic, Hebrew, Syriac)'],
    <String>['Bidi', 'bidirectional text layout combining LTR/RTL runs'],
    <String>['Localizations', 'inherited widget broadcasting Locale + delegates'],
    <String>['Delegate', 'factory producing localized resources for a Locale'],
    <String>['Fallback', 'process of relaxing tag specificity until match found'],
    <String>['Snapshot', 'immutable Locale value captured at a point in time'],
    <String>['Notification', 'bubbling widget-tree event (we read, never sub.)'],
    <String>['Override', 'subtree-scoped Locale replacing parent ambient'],
    <String>['Resolution', 'mapping system locale list to supported locale'],
    <String>['Pinned locale', 'MaterialApp.locale forcing a specific tag'],
  ];

  // ---------------------------------------------------------------------------
  // PITFALLS TABLE
  // ---------------------------------------------------------------------------
  final List<List<String>> pitfallRows = <List<String>>[
    <String>['Pinned locale ignores system',
        'MaterialApp(locale: en) overrides device language; users get wrong UI'],
    <String>['Missing supportedLocales',
        'system selects first supported -> all users get the dev language'],
    <String>['Wrong delegate order',
        'app delegates appearing after Material delegate may be shadowed'],
    <String>['Locale.fromSubtags misuse',
        'passing region as scriptCode silently produces tag like zh-CN-Hans'],
    <String>['Equality on raw strings',
        'comparing locale.toString() vs toLanguageTag(); underscore vs dash'],
    <String>['No script disambiguator for zh/sr',
        'zh alone -> Flutter may pick Hans or Hant unpredictably'],
    <String>['Hard-coded LTR layouts',
        'Padding(left: 16) does not flip; use EdgeInsetsDirectional.only(start)'],
    <String>['Non-bubbling locale changes',
        'subtree did not rebuild because Localizations.override was missed'],
    <String>['BuildContext below new override',
        'Localizations.localeOf reads override-scope, not root-scope'],
    <String>['Region-only delta ignored',
        'fr-CA -> fr-FR may not retrigger l10n if delegate keys are language-only'],
  ];

  // ---------------------------------------------------------------------------
  // COMPARISON TABLE: Localizations vs LocaleSnapshotNotification vs fromSubtags
  // ---------------------------------------------------------------------------
  final List<List<String>> comparisonRows = <List<String>>[
    <String>['Concept', 'Localizations widget',
        'LocaleSnapshotNotification (concept)', 'Locale.fromSubtags'],
    <String>['Layer', 'inherited widget',
        'bubbling tree event', 'value object'],
    <String>['Lifetime', 'long-lived (rebuilds on locale change)',
        'instantaneous broadcast', 'immutable record'],
    <String>['Direction', 'top-down via InheritedWidget',
        'bottom-up via Notification', 'pure data'],
    <String>['Mutability', 'immutable per-frame',
        'immutable payload', 'immutable'],
    <String>['Reads', 'Localizations.localeOf(ctx)',
        'NotificationListener<...> (read-only here)',
        '.languageCode, .countryCode, .scriptCode'],
    <String>['Use case', 'broadcast ambient locale',
        'audit/log/route on snapshot delta', 'construct precise tags'],
    <String>['Pitfall', 'reading too early in build',
        'mutating onNotification (forbidden in this manual)',
        'mis-ordering script vs region'],
  ];

  // ---------------------------------------------------------------------------
  // SCENARIO PANELS
  // ---------------------------------------------------------------------------
  final List<List<String>> scenarioRows = <List<String>>[
    <String>['Multi-language storefront',
        'Catalog page must render product names in 8 locales with proper '
            'currency formatting and RTL aware checkout flow.',
        'Pin MaterialApp.supportedLocales to the curated set; rely on '
            'localeListResolutionCallback to honour user preference order; '
            'use Directionality from Localizations.localeOf() to flip the '
            'product image gallery.'],
    <String>['Regional formatting island',
        'A single date picker inside an English app must render in fr-CA '
            'for the Quebec branch only.',
        'Wrap that subtree in Localizations.override(locale: Locale("fr","CA")). '
            'Do not pin MaterialApp.locale or you will affect the whole shell.'],
    <String>['Language fallback for documentation',
        'Help articles ship in en, de, and ja. A user with locale fr-CA '
            'visits the help center.',
        'Implement explicit fallback fr-CA -> fr -> en. Do not blindly trust '
            'the Material delegate; provide an app-level delegate first.'],
    <String>['Bidirectional product reviews',
        'Reviews come from users in both en-US and ar-EG, mixed into one '
            'feed. Each review must render in its own direction.',
        'Determine direction per review from the review locale, not from the '
            'ambient Localizations. Wrap each tile in Directionality.'],
    <String>['Script aware sort',
        'Catalog title sort must place zh-Hans before zh-Hant for the PRC '
            'channel and the inverse for Taiwan.',
        'Use Locale.fromSubtags to disambiguate; do not rely on language '
            'code alone -- both share zh.'],
    <String>['Locale audit trail',
        'Compliance team needs every page render tagged with the active '
            'BCP47 locale tag for export.',
        'Capture Localizations.localeOf(context).toLanguageTag() into the '
            'analytics payload at the leaf, not at the shell.'],
  ];

  // ---------------------------------------------------------------------------
  // KEY VALUE BLOCK -- ambient probe summary
  // ---------------------------------------------------------------------------
  final List<List<String>> ambientProbe = <List<String>>[
    <String>['ambient.localeOf', '${ambientLocale ?? '<null>'}'],
    <String>['ambient.constructionOk', '$ambientLocaleOk'],
    <String>['ambient.languageCode',
        ambientLocale == null ? '<null>' : ambientLocale.languageCode],
    <String>['ambient.countryCode',
        ambientLocale == null ? '<null>' : '${ambientLocale.countryCode}'],
    <String>['ambient.scriptCode',
        ambientLocale == null ? '<null>' : '${ambientLocale.scriptCode}'],
    <String>['ambient.toLanguageTag',
        ambientLocale == null ? '<null>' : ambientLocale.toLanguageTag()],
    <String>['ambient.toString',
        ambientLocale == null ? '<null>' : ambientLocale.toString()],
  ];

  print('[atlas_parchment] phase 4/9 -- ambient probe captured');

  // ---------------------------------------------------------------------------
  // BUILDER HELPER: stat chip
  // ---------------------------------------------------------------------------
  Widget makeStatChip(String label, String value, Color base) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: base.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: base.withValues(alpha: 0.55), width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              fontSize: 10.0,
              color: base.withValues(alpha: 0.95),
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.0,
              color: globeMidnight,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // BUILDER HELPER: section header bar
  // ---------------------------------------------------------------------------
  Widget makeSectionBar(String number, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 14.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            globeIndigo,
            globeMidnight,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(14.0),
          topRight: Radius.circular(14.0),
        ),
        border: Border(
          bottom: BorderSide(color: brassEdge, width: 2.0),
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 38.0,
            height: 38.0,
            decoration: BoxDecoration(
              color: cinnabarCompass,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: brassEdge, width: 1.4),
            ),
            alignment: Alignment.center,
            child: Text(
              number,
              style: TextStyle(
                color: vellumChalk,
                fontWeight: FontWeight.w900,
                fontSize: 16.0,
                fontFamily: 'monospace',
              ),
            ),
          ),
          const SizedBox(width: 14.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    color: vellumChalk,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 3.0),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: vellumDeep.withValues(alpha: 0.85),
                    fontSize: 11.0,
                    fontStyle: FontStyle.italic,
                    letterSpacing: 0.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // BUILDER HELPER: panel frame
  // ---------------------------------------------------------------------------
  Widget makePanel(Widget header, Widget body) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: vellumIvory,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: sepiaRule.withValues(alpha: 0.45), width: 1.2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: globeMidnight.withValues(alpha: 0.10),
            blurRadius: 14.0,
            offset: const Offset(0.0, 6.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          header,
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: body,
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // BUILDER: Hero card
  // ---------------------------------------------------------------------------
  print('[atlas_parchment] phase 5/9 -- composing hero card');

  final Widget heroCard = Container(
    margin: const EdgeInsets.fromLTRB(16.0, 22.0, 16.0, 12.0),
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          vellumChalk,
          vellumPale,
          vellumWarm,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: brassEdge, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: globeMidnight.withValues(alpha: 0.12),
          blurRadius: 20.0,
          offset: const Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 60.0,
              height: 60.0,
              decoration: BoxDecoration(
                color: globeIndigo,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: brassEdge, width: 2.0),
              ),
              alignment: Alignment.center,
              child: Text(
                'A.P.',
                style: TextStyle(
                  color: vellumChalk,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('ATLAS PARCHMENT FIELD MANUAL',
                      style: styleHeroSubtitle),
                  const SizedBox(height: 4.0),
                  Text('LocaleSnapshotNotification', style: styleHeroTitle),
                  const SizedBox(height: 2.0),
                  Text('A Cartographer\'s Pocket Guide',
                      style: styleSectionHeader),
                  const SizedBox(height: 4.0),
                  Text(
                    'A bilingual cartographer\'s pocket guide to '
                    'Flutter\'s Locale propagation and language fallback.',
                    style: styleSectionLead,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 18.0),
        Container(
          height: 1.4,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                sepiaRule.withValues(alpha: 0.0),
                sepiaRule.withValues(alpha: 0.7),
                sepiaRule.withValues(alpha: 0.0),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: <Widget>[
            makeStatChip('LOCALES', '${localeCatalog.length}', globeIndigo),
            makeStatChip('AMBIENT',
                ambientLocale == null ? '<null>' : ambientLocale.toLanguageTag(),
                cinnabarCompass),
            makeStatChip('FALLBACKS', '${fallbackRows.length}', verdigris),
            makeStatChip('SCENARIOS', '${scenarioRows.length}', sepiaRule),
            makeStatChip('PITFALLS', '${pitfallRows.length}', cinnabarRust),
            makeStatChip('GLOSSARY', '${glossaryRows.length}', brassEdge),
            makeStatChip('FLOW NODES', '${flowchartNodes.length}', globeMidnight),
            makeStatChip('API ROWS', '${localeApiRows.length}', globeIndigo),
          ],
        ),
        const SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: globeIndigo.withValues(alpha: 0.07),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: globeIndigo.withValues(alpha: 0.35),
              width: 1.0,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 4.0,
                height: 60.0,
                color: cinnabarCompass,
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('Curator\'s preface', style: styleBodyEm),
                    const SizedBox(height: 4.0),
                    Text(
                      'A LocaleSnapshotNotification is not a class you '
                      'will find in flutter/widgets.dart. It is a pattern: '
                      'an immutable Locale value, captured at a moment, '
                      'broadcast through the widget tree so router and '
                      'shell layers may react. This manual treats the '
                      'snapshot as an inspectable artefact, not a mutating '
                      'event sink.',
                      style: styleBody,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // BUILDER: Locale catalog grid
  // ---------------------------------------------------------------------------
  print('[atlas_parchment] phase 6/9 -- composing locale catalog');

  final List<Widget> catalogPlates = <Widget>[];
  for (int i = 0; i < localeCatalog.length; i++) {
    final List<String> row = localeCatalog[i];
    final String tag = row[0];
    final String language = row[1];
    final String region = row[2];
    final String dir = row[3];
    final String script = row[4];
    final String currency = row[5];
    final String greeting = row[6];
    final String state = row[7];

    final bool isLive = state == 'live';
    final bool isRtl = dir == 'RTL';
    final Color plateAccent = isRtl ? cinnabarCompass : globeIndigo;
    final Color plateBg = isLive
        ? vellumChalk
        : vellumDeep.withValues(alpha: 0.6);

    catalogPlates.add(
      Container(
        width: 240.0,
        margin: const EdgeInsets.all(6.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: plateBg,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: plateAccent.withValues(alpha: isLive ? 0.8 : 0.35),
            width: 1.2,
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: globeMidnight.withValues(alpha: isLive ? 0.10 : 0.04),
              blurRadius: 8.0,
              offset: const Offset(0.0, 3.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 3.0),
                  decoration: BoxDecoration(
                    color: plateAccent,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(tag, style: styleGlyphTag),
                ),
                const SizedBox(width: 8.0),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    color: isRtl
                        ? cinnabarCompass.withValues(alpha: 0.20)
                        : verdigris.withValues(alpha: 0.20),
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(
                      color: isRtl
                          ? cinnabarCompass.withValues(alpha: 0.70)
                          : verdigris.withValues(alpha: 0.70),
                      width: 0.8,
                    ),
                  ),
                  child: Text(
                    dir,
                    style: TextStyle(
                      fontSize: 10.0,
                      color: isRtl ? cinnabarRust : verdigris,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  width: 8.0,
                  height: 8.0,
                  decoration: BoxDecoration(
                    color: isLive ? verdigris : mistShade,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Text(language,
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w800,
                  color: globeMidnight,
                )),
            const SizedBox(height: 2.0),
            Text(region, style: styleCaption),
            const SizedBox(height: 8.0),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 6.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: plateAccent.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                greeting,
                style: TextStyle(
                  fontSize: 11.0,
                  color: plateAccent,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'script: $script',
                    style: TextStyle(
                      fontSize: 10.0,
                      fontFamily: 'monospace',
                      color: sepiaRule,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  currency,
                  style: TextStyle(
                    fontSize: 10.0,
                    fontFamily: 'monospace',
                    color: globeIndigo,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  final Widget catalogSection = makePanel(
    makeSectionBar('II', 'Locale catalog',
        'Twenty-six plates. Solid border = live; dashed tone = shadow.'),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Each plate is keyed by BCP47 tag and annotated with script family, '
          'reading direction, and a flat-pronunciation greeting. RTL plates '
          'are inked in cinnabar; LTR plates use globe indigo. Verdigris '
          'dots mark plates that constructed without raising in the bridged '
          'runtime.',
          style: styleBody,
        ),
        const SizedBox(height: 14.0),
        Wrap(
          children: catalogPlates,
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // BUILDER: API surface table
  // ---------------------------------------------------------------------------
  print('[atlas_parchment] phase 7/9 -- composing tables');

  final List<TableRow> apiTableRows = <TableRow>[];
  apiTableRows.add(TableRow(
    decoration: BoxDecoration(
      color: globeIndigo,
    ),
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Symbol', style: styleTableHeader),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Kind', style: styleTableHeader),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Example', style: styleTableHeader),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Notes', style: styleTableHeader),
      ),
    ],
  ));
  for (int i = 0; i < localeApiRows.length; i++) {
    final List<String> r = localeApiRows[i];
    final bool zebra = i % 2 == 0;
    apiTableRows.add(TableRow(
      decoration: BoxDecoration(
        color: zebra ? vellumChalk : vellumPale,
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(r[0], style: styleMonoAccent),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 6.0, vertical: 2.0),
            decoration: BoxDecoration(
              color: verdigris.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              r[1],
              style: TextStyle(
                fontSize: 11.0,
                color: verdigris,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(r[2], style: styleMono),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(r[3], style: styleTableCell),
        ),
      ],
    ));
  }
  final Widget apiSection = makePanel(
    makeSectionBar('III', 'Locale API surface',
        'Constructors, identifiers, and string forms.'),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Locale is a value object. Treat it as immutable, hashable data; '
          'do not subclass it. The two string forms (toString uses '
          'underscore, toLanguageTag uses dash) are not interchangeable for '
          'equality with foreign systems -- pick one and normalize.',
          style: styleBody,
        ),
        const SizedBox(height: 12.0),
        Table(
          border: TableBorder.all(
            color: sepiaRule.withValues(alpha: 0.35),
            width: 0.8,
          ),
          columnWidths: const <int, TableColumnWidth>{
            0: FlexColumnWidth(2.0),
            1: FlexColumnWidth(1.0),
            2: FlexColumnWidth(2.4),
            3: FlexColumnWidth(2.6),
          },
          children: apiTableRows,
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // BUILDER: Notification dispatch flowchart
  // ---------------------------------------------------------------------------
  final List<Widget> flowchartTiles = <Widget>[];
  for (int i = 0; i < flowchartNodes.length; i++) {
    final List<String> n = flowchartNodes[i];
    final bool isLast = i == flowchartNodes.length - 1;
    flowchartTiles.add(
      Container(
        margin: const EdgeInsets.only(bottom: 4.0),
        // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #122, P1):
        // The flowchart tile's `Row(crossAxisAlignment.stretch)` sits
        // inside the page-root `SingleChildScrollView > Column(stretch)`
        // chain. The SCV propagates unbounded vertical constraints
        // downward; a `Row(stretch)` then demands its children share a
        // common height, which would require an infinite tight height.
        // Flutter asserts "BoxConstraints forces an infinite height."
        // Wrap the Row in `IntrinsicHeight` so the cross-axis height
        // resolves to the tallest child's intrinsic height before the
        // `stretch` rule is applied. The visual (the index-circle +
        // dashed vertical line column matching the height of the body
        // card to its right) is preserved.
        child: IntrinsicHeight(
          child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  width: 32.0,
                  height: 32.0,
                  decoration: BoxDecoration(
                    color: i == flowchartNodes.length - 1
                        ? cinnabarCompass
                        : globeIndigo,
                    shape: BoxShape.circle,
                    border: Border.all(color: brassEdge, width: 1.4),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    n[0],
                    style: TextStyle(
                      color: vellumChalk,
                      fontWeight: FontWeight.w900,
                      fontSize: 13.0,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
                isLast
                    ? const SizedBox(height: 0.0)
                    : Container(
                        width: 2.0,
                        height: 28.0,
                        color: sepiaRule.withValues(alpha: 0.55),
                      ),
              ],
            ),
            const SizedBox(width: 14.0),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(bottom: 12.0),
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: i == flowchartNodes.length - 1
                      ? cinnabarCompass.withValues(alpha: 0.08)
                      : vellumChalk,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: i == flowchartNodes.length - 1
                        ? cinnabarCompass.withValues(alpha: 0.55)
                        : sepiaRule.withValues(alpha: 0.45),
                    width: 1.0,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      n[1],
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w800,
                        color: i == flowchartNodes.length - 1
                            ? cinnabarRust
                            : globeIndigo,
                        fontFamily: 'monospace',
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(n[2], style: styleBody),
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
  final Widget flowchartSection = makePanel(
    makeSectionBar('IV', 'Notification dispatch',
        'Localizations -> override -> MaterialApp.locale -> systemLocales.'),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Locale resolution flows top-down through the framework, but a '
          '"snapshot notification" -- the conceptual pattern this manual is '
          'named for -- bubbles bottom-up. The first eight nodes are the '
          'native flow; node nine is the audit overlay.',
          style: styleBody,
        ),
        const SizedBox(height: 14.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: flowchartTiles,
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // BUILDER: Fallback table
  // ---------------------------------------------------------------------------
  final List<TableRow> fallbackTableRows = <TableRow>[];
  fallbackTableRows.add(TableRow(
    decoration: BoxDecoration(color: cinnabarCompass),
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Input tag', style: styleTableHeader),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Resolution chain', style: styleTableHeader),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Note', style: styleTableHeader),
      ),
    ],
  ));
  for (int i = 0; i < fallbackRows.length; i++) {
    final List<String> r = fallbackRows[i];
    final bool zebra = i % 2 == 0;
    fallbackTableRows.add(TableRow(
      decoration: BoxDecoration(color: zebra ? vellumChalk : vellumPale),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(r[0], style: styleMonoAccent),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(r[1], style: styleMono),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(r[2], style: styleTableCell),
        ),
      ],
    ));
  }
  final Widget fallbackSection = makePanel(
    makeSectionBar('V', 'Language fallback',
        'How a tag relaxes itself until a delegate matches.'),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Resolution begins with the most specific tag and drops the right'
          '-most subtag until a delegate reports support. Script-bearing '
          'tags (zh-Hant, sr-Cyrl) preserve their script subtag before '
          'dropping to the bare language code; otherwise zh-Hant-TW could '
          'fall back to a Hans dictionary, which would render Traditional '
          'characters in Simplified glyphs.',
          style: styleBody,
        ),
        const SizedBox(height: 12.0),
        Table(
          border: TableBorder.all(
            color: sepiaRule.withValues(alpha: 0.35),
            width: 0.8,
          ),
          columnWidths: const <int, TableColumnWidth>{
            0: FlexColumnWidth(1.4),
            1: FlexColumnWidth(3.6),
            2: FlexColumnWidth(2.4),
          },
          children: fallbackTableRows,
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // BUILDER: Bidirectional prose
  // ---------------------------------------------------------------------------
  final Widget bidiSection = makePanel(
    makeSectionBar('VI', 'Bidirectional text & RTL',
        'Direction is a property of the run, not the page.'),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'A locale is more than a language and a region: it carries an '
          'implicit text direction. For Arabic, Hebrew, Syriac, Thaana, '
          'and a handful of others, the direction is right-to-left. '
          'Flutter inherits direction through the Directionality widget, '
          'which is automatically wired by Localizations when a delegate '
          'reports the locale\'s direction. The widget tree reads the '
          'direction via Directionality.of(context).',
          style: styleBody,
        ),
        const SizedBox(height: 10.0),
        Text(
          'Layouts that hard-code "left" or "right" do not honor direction. '
          'Use EdgeInsetsDirectional, AlignmentDirectional, and Positioned'
          'Directional. The asymmetric padding "EdgeInsetsDirectional.only(start: 16)" '
          'becomes left-padding in LTR locales and right-padding in RTL '
          'locales without you doing any conditional work at the call site.',
          style: styleBody,
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: cinnabarCompass.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: cinnabarCompass.withValues(alpha: 0.45),
              width: 1.0,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Mixed-direction passages', style: styleBodyEm),
              const SizedBox(height: 6.0),
              Text(
                'When an English app embeds an Arabic quote, the quote is a '
                'distinct run with its own direction. Wrap it in a '
                'Directionality(textDirection: TextDirection.rtl, child: ...) '
                'rather than overriding the whole shell. This preserves the '
                'parent locale\'s ambient direction for surrounding text and '
                'keeps the shell predictable.',
                style: styleBody,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: globeIndigo.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: globeIndigo.withValues(alpha: 0.45),
              width: 1.0,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Bidi numerals and punctuation', style: styleBodyEm),
              const SizedBox(height: 6.0),
              Text(
                'Even in RTL locales, Western Arabic numerals (0-9) often '
                'render left-to-right inside a right-to-left run. Punctuation '
                'such as parentheses logically mirrors: an opening "(" in '
                'an RTL run displays as ")". Trust the platform shaper; do '
                'not flip glyphs manually.',
                style: styleBody,
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // BUILDER: Glossary
  // ---------------------------------------------------------------------------
  final List<Widget> glossaryWidgets = <Widget>[];
  for (int i = 0; i < glossaryRows.length; i++) {
    final List<String> g = glossaryRows[i];
    glossaryWidgets.add(
      Container(
        width: 320.0,
        margin: const EdgeInsets.all(5.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: vellumChalk,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: brassEdge.withValues(alpha: 0.6),
            width: 0.8,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 4.0,
              height: 36.0,
              color: i % 2 == 0 ? cinnabarCompass : globeIndigo,
              margin: const EdgeInsets.only(right: 10.0, top: 2.0),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    g[0],
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w800,
                      color: globeMidnight,
                      fontFamily: 'monospace',
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    g[1],
                    style: TextStyle(
                      fontSize: 11.5,
                      color: sepiaRule,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  final Widget glossarySection = makePanel(
    makeSectionBar('VII', 'Glossary',
        'Terms used throughout the manual.'),
    Wrap(
      children: glossaryWidgets,
    ),
  );

  // ---------------------------------------------------------------------------
  // BUILDER: Palette swatches
  // ---------------------------------------------------------------------------
  final List<List<dynamic>> swatchRows = <List<dynamic>>[
    <dynamic>['vellumDeep',  vellumDeep,  '#E8DCC0',
        'workbench mat'],
    <dynamic>['vellumWarm',  vellumWarm,  '#EFE3C8',
        'panel base'],
    <dynamic>['vellumPale',  vellumPale,  '#F6ECD2',
        'plate body'],
    <dynamic>['vellumIvory', vellumIvory, '#FBF4DC',
        'panel inset'],
    <dynamic>['vellumChalk', vellumChalk, '#FFF9E5',
        'highlight wash'],
    <dynamic>['globeIndigo', globeIndigo, '#1F3A6B',
        'primary ink'],
    <dynamic>['globeMidnight', globeMidnight, '#12224A',
        'titlebar tone'],
    <dynamic>['cinnabarCompass', cinnabarCompass, '#B23B2E',
        'accent ink (RTL/danger)'],
    <dynamic>['cinnabarRust', cinnabarRust, '#8C2A1F',
        'emphasis text'],
    <dynamic>['verdigris', verdigris, '#3F7D6E',
        'verified marker'],
    <dynamic>['sepiaRule',  sepiaRule, '#7A5A2F',
        'hairline divider'],
    <dynamic>['brassEdge',  brassEdge, '#A88A3F',
        'binding & frames'],
    <dynamic>['mistShade',  mistShade, '#B7AE92',
        'shadow / disabled'],
  ];
  final List<Widget> swatchTiles = <Widget>[];
  for (int i = 0; i < swatchRows.length; i++) {
    final List<dynamic> sw = swatchRows[i];
    final String label = sw[0] as String;
    final Color col = sw[1] as Color;
    final String hex = sw[2] as String;
    final String role = sw[3] as String;
    swatchTiles.add(
      Container(
        width: 200.0,
        margin: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: vellumChalk,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: sepiaRule.withValues(alpha: 0.4),
            width: 0.8,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 60.0,
              decoration: BoxDecoration(
                color: col,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 8.0,
                    top: 6.0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6.0, vertical: 2.0),
                      decoration: BoxDecoration(
                        color: vellumChalk.withValues(alpha: 0.85),
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                      child: Text(
                        hex,
                        style: TextStyle(
                          fontSize: 10.0,
                          color: globeMidnight,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(label,
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w800,
                        color: globeMidnight,
                        fontFamily: 'monospace',
                      )),
                  const SizedBox(height: 2.0),
                  Text(role, style: styleCaption),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  final Widget paletteSection = makePanel(
    makeSectionBar('VIII', 'Palette swatches',
        'Atlas Parchment color sticks.'),
    Wrap(children: swatchTiles),
  );

  // ---------------------------------------------------------------------------
  // BUILDER: Comparison table
  // ---------------------------------------------------------------------------
  final List<TableRow> comparisonTableRows = <TableRow>[];
  for (int i = 0; i < comparisonRows.length; i++) {
    final List<String> r = comparisonRows[i];
    final bool isHeader = i == 0;
    comparisonTableRows.add(TableRow(
      decoration: BoxDecoration(
        color: isHeader
            ? globeMidnight
            : (i % 2 == 0 ? vellumChalk : vellumPale),
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(r[0],
              style: isHeader ? styleTableHeader : styleMonoAccent),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(r[1],
              style: isHeader ? styleTableHeader : styleTableCell),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(r[2],
              style: isHeader ? styleTableHeader : styleTableCell),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(r[3],
              style: isHeader ? styleTableHeader : styleTableCell),
        ),
      ],
    ));
  }
  final Widget comparisonSection = makePanel(
    makeSectionBar('IX', 'Comparison',
        'Localizations vs LocaleSnapshotNotification vs Locale.fromSubtags.'),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Three concepts often confused: an inherited widget that broadcasts '
          'an ambient locale, a conceptual notification used to audit '
          'snapshot deltas, and a constructor used to assemble precise tags. '
          'They are not interchangeable.',
          style: styleBody,
        ),
        const SizedBox(height: 12.0),
        Table(
          border: TableBorder.all(
            color: sepiaRule.withValues(alpha: 0.35),
            width: 0.8,
          ),
          columnWidths: const <int, TableColumnWidth>{
            0: FlexColumnWidth(1.4),
            1: FlexColumnWidth(2.0),
            2: FlexColumnWidth(2.0),
            3: FlexColumnWidth(2.0),
          },
          children: comparisonTableRows,
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // BUILDER: Pitfalls section
  // ---------------------------------------------------------------------------
  print('[atlas_parchment] phase 8/9 -- composing pitfalls and scenarios');

  final List<Widget> pitfallTiles = <Widget>[];
  for (int i = 0; i < pitfallRows.length; i++) {
    final List<String> p = pitfallRows[i];
    final Color band = i % 3 == 0
        ? cinnabarCompass
        : (i % 3 == 1 ? globeIndigo : verdigris);
    pitfallTiles.add(
      Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: vellumChalk,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: band.withValues(alpha: 0.55),
            width: 1.0,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 38.0,
              height: 38.0,
              decoration: BoxDecoration(
                color: band,
                borderRadius: BorderRadius.circular(6.0),
              ),
              alignment: Alignment.center,
              child: Text(
                '${i + 1}',
                style: TextStyle(
                  color: vellumChalk,
                  fontWeight: FontWeight.w900,
                  fontSize: 15.0,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(p[0], style: styleBodyEm),
                  const SizedBox(height: 4.0),
                  Text(p[1], style: styleBody),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  final Widget pitfallsSection = makePanel(
    makeSectionBar('X', 'Pitfalls',
        'Where locale propagation silently misbehaves.'),
    Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: pitfallTiles,
    ),
  );

  // ---------------------------------------------------------------------------
  // BUILDER: Scenario panels
  // ---------------------------------------------------------------------------
  final List<Widget> scenarioTiles = <Widget>[];
  for (int i = 0; i < scenarioRows.length; i++) {
    final List<String> s = scenarioRows[i];
    final bool isRtl = i == 3;
    final Color frame = isRtl ? cinnabarCompass : globeIndigo;
    scenarioTiles.add(
      Container(
        margin: const EdgeInsets.symmetric(vertical: 6.0),
        decoration: BoxDecoration(
          color: vellumChalk,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: frame.withValues(alpha: 0.55), width: 1.2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 14.0, vertical: 10.0),
              decoration: BoxDecoration(
                color: frame.withValues(alpha: 0.12),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                ),
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 3.0),
                    decoration: BoxDecoration(
                      color: frame,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      'SCN-${i + 1}',
                      style: styleGlyphTag,
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Text(
                      s[0],
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w800,
                        color: globeMidnight,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('Brief', style: styleBodyEm),
                  const SizedBox(height: 4.0),
                  Text(s[1], style: styleBody),
                  const SizedBox(height: 10.0),
                  Container(
                    height: 1.0,
                    color: sepiaRule.withValues(alpha: 0.25),
                  ),
                  const SizedBox(height: 10.0),
                  Text('Approach', style: styleBodyEm),
                  const SizedBox(height: 4.0),
                  Text(s[2], style: styleBody),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  final Widget scenariosSection = makePanel(
    makeSectionBar('XI', 'Scenario panels',
        'Concrete locale propagation cases drawn from the field.'),
    Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: scenarioTiles,
    ),
  );

  // ---------------------------------------------------------------------------
  // BUILDER: Ambient probe panel
  // ---------------------------------------------------------------------------
  final List<Widget> ambientRows = <Widget>[];
  for (int i = 0; i < ambientProbe.length; i++) {
    final List<String> r = ambientProbe[i];
    ambientRows.add(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: i % 2 == 0 ? vellumChalk : vellumPale,
          borderRadius: BorderRadius.circular(6.0),
        ),
        margin: const EdgeInsets.symmetric(vertical: 2.0),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 180.0,
              child: Text(r[0], style: styleMonoAccent),
            ),
            Expanded(
              child: Text(r[1], style: styleMono),
            ),
          ],
        ),
      ),
    );
  }
  final Widget ambientSection = makePanel(
    makeSectionBar('I', 'Ambient locale probe',
        'What Localizations.localeOf actually returned at build time.'),
    Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'These values were captured from the BuildContext passed to this '
          'manual\'s root build call. They reflect the ambient Localizations '
          'frame -- not any override that might be installed deeper in the '
          'tree, and not the system locale list, which lives behind '
          'WidgetsBinding.platformDispatcher.',
          style: styleBody,
        ),
        const SizedBox(height: 12.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: ambientRows,
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // BUILDER: NotificationListener wrapper (read-only, never mutates)
  // ---------------------------------------------------------------------------
  // We wrap the body in a NotificationListener<LayoutChangedNotification> only
  // to demonstrate the *read-only* observation pattern. The callback returns
  // false (do not stop propagation) and performs no mutation. This honors
  // the "no mutating NotificationListener" rule.
  // ---------------------------------------------------------------------------

  final List<Widget> compositionStack = <Widget>[
    heroCard,
    ambientSection,
    catalogSection,
    apiSection,
    flowchartSection,
    fallbackSection,
    bidiSection,
    glossarySection,
    paletteSection,
    comparisonSection,
    pitfallsSection,
    scenariosSection,
  ];

  print('[atlas_parchment] phase 9/9 -- assembling Scaffold; '
      '${compositionStack.length} top-level sections');

  // ---------------------------------------------------------------------------
  // FINAL FOOTER -- a small decorative compass plate
  // ---------------------------------------------------------------------------
  final Widget footerPlate = Container(
    margin: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 32.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: globeMidnight,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: brassEdge, width: 1.4),
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 56.0,
          height: 56.0,
          decoration: BoxDecoration(
            color: cinnabarCompass,
            shape: BoxShape.circle,
            border: Border.all(color: brassEdge, width: 2.0),
          ),
          alignment: Alignment.center,
          child: Text(
            'N',
            style: TextStyle(
              color: vellumChalk,
              fontWeight: FontWeight.w900,
              fontSize: 22.0,
              fontFamily: 'monospace',
            ),
          ),
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'End of plate',
                style: TextStyle(
                  color: vellumChalk,
                  fontWeight: FontWeight.w800,
                  fontSize: 15.0,
                  letterSpacing: 0.6,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                'Folded, stamped, and bound at the bridged-runtime press.',
                style: TextStyle(
                  color: vellumDeep.withValues(alpha: 0.85),
                  fontSize: 11.0,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
        Opacity(
          opacity: 0.8,
          child: FadeTransition(
            opacity: const AlwaysStoppedAnimation<double>(0.95),
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10.0, vertical: 6.0),
              decoration: BoxDecoration(
                color: brassEdge,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                'A.P.',
                style: TextStyle(
                  color: globeMidnight,
                  fontSize: 12.0,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // FINAL: Scaffold + MaterialApp
  // ---------------------------------------------------------------------------
  print('[atlas_parchment] returning MaterialApp; build complete');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'LocaleSnapshotNotification - Atlas Parchment',
    theme: ThemeData(
      scaffoldBackgroundColor: vellumDeep,
      primaryColor: globeIndigo,
      textTheme: TextTheme(
        bodyMedium: styleBody,
      ),
    ),
    home: Scaffold(
      backgroundColor: vellumDeep,
      appBar: AppBar(
        backgroundColor: globeMidnight,
        elevation: 0.0,
        title: Row(
          children: <Widget>[
            Container(
              width: 28.0,
              height: 28.0,
              decoration: BoxDecoration(
                color: cinnabarCompass,
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: brassEdge, width: 1.0),
              ),
              alignment: Alignment.center,
              child: Text(
                'L',
                style: TextStyle(
                  color: vellumChalk,
                  fontWeight: FontWeight.w900,
                  fontSize: 14.0,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Text(
              'LocaleSnapshotNotification - Atlas Parchment',
              style: TextStyle(
                color: vellumChalk,
                fontWeight: FontWeight.w700,
                fontSize: 15.0,
                letterSpacing: 0.6,
              ),
            ),
          ],
        ),
      ),
      body: NotificationListener<LayoutChangedNotification>(
        onNotification: (LayoutChangedNotification notification) {
          // Read-only observation. We do not mutate any state; this listener
          // simply demonstrates the bubbling Notification mechanism. The
          // returned false allows the notification to keep propagating.
          print('[atlas_parchment] (observed) layout-changed bubble: '
              '$notification');
          return false;
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              heroCard,
              ambientSection,
              catalogSection,
              apiSection,
              flowchartSection,
              fallbackSection,
              bidiSection,
              glossarySection,
              paletteSection,
              comparisonSection,
              pitfallsSection,
              scenariosSection,
              footerPlate,
            ],
          ),
        ),
      ),
    ),
  );
}
