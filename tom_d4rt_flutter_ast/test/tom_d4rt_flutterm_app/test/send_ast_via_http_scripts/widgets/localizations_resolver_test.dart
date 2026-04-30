// ignore_for_file: avoid_print
// D4rt deep demo: LocalizationsResolver — resolves localized resources in the widget tree
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ── Palette: Vermilion / Cinnabar ──────────────────────────────────
  const deepVermilion = Color(0xFFBF360C);
  const cinnabar = Color(0xFFD84315);
  const burntOrange = Color(0xFFE64A19);
  const mandarin = Color(0xFFF4511E);
  const tangerine = Color(0xFFFF5722);
  const salmon = Color(0xFFFF8A65);
  const peachBlush = Color(0xFFFFAB91);
  const cinnabarWhite = Color(0xFFFBE9E7);
  const tealContrast = Color(0xFF00897B);
  const navyContrast = Color(0xFF283593);

  // ── Helpers ────────────────────────────────────────────────────────
  Widget sectionBanner(String title, String subtitle, Color bg, Color fg) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20, bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [bg, bg.withValues(alpha: 0.78)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  color: fg, fontWeight: FontWeight.bold, fontSize: 16)),
          if (subtitle.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Text(subtitle,
                  style: TextStyle(
                      color: fg.withValues(alpha: 0.85), fontSize: 12)),
            ),
        ],
      ),
    );
  }

  Widget noteBox(String text, Color border, Color bg) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
        border: Border(left: BorderSide(color: border, width: 4)),
      ),
      child:
          Text(text, style: TextStyle(fontSize: 13, color: deepVermilion)),
    );
  }

  Widget dataRow(String label, String value, Color accent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 180,
            child: Text(label,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: accent)),
          ),
          Expanded(
            child: Text(value,
                style: TextStyle(fontSize: 13, color: deepVermilion)),
          ),
        ],
      ),
    );
  }

  Widget tag(String text, Color bg, Color fg) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(text, style: TextStyle(fontSize: 11, color: fg)),
    );
  }

  Widget apiCard(String name, String desc, IconData icon, Color accent) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cinnabarWhite,
        borderRadius: BorderRadius.circular(8),
        border: Border(left: BorderSide(color: accent, width: 3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 20, color: accent),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        fontFamily: 'monospace',
                        color: deepVermilion)),
                const SizedBox(height: 3),
                Text(desc,
                    style: TextStyle(fontSize: 12, color: cinnabar)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget flowStep(int num, String title, String detail, Color accent) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
        border: Border(left: BorderSide(color: accent, width: 3)),
      ),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text('$num',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: deepVermilion)),
                Text(detail,
                    style: TextStyle(fontSize: 11, color: cinnabar)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Gather data ────────────────────────────────────────────────────
  print('LocalizationsResolver deep demo executing');
  print('=' * 60);

  // Section 1 — what is it
  print('\n--- What is LocalizationsResolver ---');
  print('A typedef for a callback that resolves localized resources');
  print('Signature: Future<T> Function(Locale locale, Iterable<Locale> supportedLocales)');

  // Section 2 — context
  print('\n--- In context ---');
  print('Used as part of LocalizationsDelegate<T>');
  print('Called by the Localizations widget during locale resolution');

  // Section 3 — locale resolution
  print('\n--- Locale resolution ---');
  final currentLocale = Localizations.localeOf(context);
  print('Current locale: $currentLocale');
  print('Language: ${currentLocale.languageCode}');
  print('Country: ${currentLocale.countryCode ?? "(none)"}');

  // Section 4 — delegates
  print('\n--- Delegates in context ---');
  print('MaterialLocalizations available: ${Localizations.of<MaterialLocalizations>(context, MaterialLocalizations) != null}');
  print('WidgetsLocalizations available: ${Localizations.of<WidgetsLocalizations>(context, WidgetsLocalizations) != null}');

  // Section 5 — supported locales
  print('\n--- Common locales ---');
  for (final loc in [
    const Locale('en', 'US'),
    const Locale('en', 'GB'),
    const Locale('de', 'DE'),
    const Locale('fr', 'FR'),
    const Locale('ja'),
    const Locale('zh', 'CN'),
  ]) {
    print('  ${loc.languageCode}_${loc.countryCode ?? ""}: $loc');
  }

  print('\n${'=' * 60}');
  print('LocalizationsResolver deep demo completed');

  // ── Build ──────────────────────────────────────────────────────────
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── 1. Title banner ──────────────────────────────────────────
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [deepVermilion, cinnabar, burntOrange],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('LocalizationsResolver',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              Text('Callback typedef for resolving localized resources',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 14)),
              const SizedBox(height: 10),
              Wrap(children: [
                tag('Typedef', burntOrange, Colors.white),
                tag('Localization', mandarin, Colors.white),
                tag('Delegates', tangerine, Colors.white),
                tag('i18n', salmon, deepVermilion),
              ]),
            ],
          ),
        ),

        // ── 2. What is it ────────────────────────────────────────────
        sectionBanner('1 \u00b7 What Is LocalizationsResolver',
            'A function type for loading locale-specific resources',
            deepVermilion, Colors.white),
        noteBox(
          'LocalizationsResolver<T> is a typedef representing a callback '
          'function with signature: Future<T> Function(Locale locale, '
          'Iterable<Locale> supportedLocales). It is used inside '
          'LocalizationsDelegate to load the correct localized resources '
          'when the app\'s locale changes. The resolver receives the '
          'desired locale and the list of supported locales, and returns '
          'a Future of the resolved localizations object.',
          deepVermilion,
          cinnabarWhite,
        ),
        dataRow('Type', 'typedef (function type)', cinnabar),
        dataRow('Full signature', 'Future<T> Function(Locale, Iterable<Locale>)', burntOrange),
        dataRow('Returns', 'Future<T> — the localized resource object', mandarin),
        dataRow('Used in', 'LocalizationsDelegate<T>', tangerine),
        const SizedBox(height: 14),

        // ── 3. Function signature ────────────────────────────────────
        sectionBanner('2 \u00b7 Function Signature Breakdown',
            'Each parameter explained',
            cinnabar, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: cinnabarWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final param in [
                ('Locale locale', 'The locale requested by the system or user', Icons.language, deepVermilion),
                ('Iterable<Locale> supportedLocales', 'All locales the app declares support for', Icons.list, cinnabar),
                ('Returns: Future<T>', 'Async result with the localized resource object', Icons.output, burntOrange),
              ])
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: param.$4, width: 3)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: param.$4.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(param.$3, size: 18, color: param.$4),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(param.$1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    fontFamily: 'monospace',
                                    color: deepVermilion)),
                            const SizedBox(height: 2),
                            Text(param.$2,
                                style: TextStyle(
                                    fontSize: 11, color: mandarin)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 4. Current locale info ───────────────────────────────────
        sectionBanner('3 \u00b7 Current Locale',
            'Locale detected from this widget context',
            burntOrange, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [deepVermilion.withValues(alpha: 0.06), cinnabarWhite],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: peachBlush),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.language, size: 28, color: deepVermilion),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('$currentLocale',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: deepVermilion)),
                        Text('Active locale in this context',
                            style: TextStyle(
                                fontSize: 12, color: cinnabar)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: deepVermilion.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Text('Language',
                              style: TextStyle(
                                  fontSize: 10, color: cinnabar)),
                          const SizedBox(height: 2),
                          Text(currentLocale.languageCode,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: deepVermilion)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: cinnabar.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Text('Country',
                              style: TextStyle(
                                  fontSize: 10, color: cinnabar)),
                          const SizedBox(height: 2),
                          Text(currentLocale.countryCode ?? '\u2014',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: cinnabar)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: burntOrange.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Text('Script',
                              style: TextStyle(
                                  fontSize: 10, color: cinnabar)),
                          const SizedBox(height: 2),
                          Text(currentLocale.scriptCode ?? '\u2014',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: burntOrange)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 5. Localization flow ─────────────────────────────────────
        sectionBanner('4 \u00b7 Localization Resolution Flow',
            'How the resolver fits into the loading pipeline',
            deepVermilion, Colors.white),
        flowStep(1, 'System locale changes', 'Platform reports new locale to Flutter', deepVermilion),
        flowStep(2, 'Localizations widget rebuilds', 'Passes locale to each delegate', cinnabar),
        flowStep(3, 'isSupported() checked', 'Delegate confirms it handles this locale', burntOrange),
        flowStep(4, 'shouldReload() consulted', 'Skip loading if delegate unchanged', mandarin),
        flowStep(5, 'Resolver called', 'load(locale) invoked on the delegate', tangerine),
        flowStep(6, 'Future resolves', 'Localized resource object returned', salmon),
        flowStep(7, 'Widgets rebuild', 'Localizations.of<T>() returns new resources', peachBlush),
        const SizedBox(height: 14),

        // ── 6. Delegate relationship ─────────────────────────────────
        sectionBanner('5 \u00b7 Relationship With Delegates',
            'Where the resolver lives in the delegate pattern',
            cinnabar, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: cinnabarWhite,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final line in [
                ('MaterialApp', Colors.grey),
                ('  \u2514\u2500 localizationsDelegates:', deepVermilion),
                ('       \u251c\u2500 GlobalMaterialLocalizations.delegate', cinnabar),
                ('       \u251c\u2500 GlobalWidgetsLocalizations.delegate', burntOrange),
                ('       \u251c\u2500 GlobalCupertinoLocalizations.delegate', mandarin),
                ('       \u2514\u2500 AppLocalizations.delegate (custom)', tangerine),
                ('            \u2514\u2500 load() \u2192 LocalizationsResolver<T>', salmon),
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text(line.$1,
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'monospace',
                          color: line.$2)),
                ),
            ],
          ),
        ),
        noteBox(
          'Each LocalizationsDelegate has a load() method that acts as '
          'the resolver. It receives the locale and returns a Future of '
          'the localized resources. The typedef LocalizationsResolver<T> '
          'captures this function signature for type safety.',
          cinnabar,
          cinnabarWhite,
        ),
        const SizedBox(height: 14),

        // ── 7. Common locale gallery ─────────────────────────────────
        sectionBanner('6 \u00b7 Common Locales Gallery',
            'Frequently supported locale configurations',
            burntOrange, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: cinnabarWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              for (final loc in [
                ('en_US', '\ud83c\uddfa\ud83c\uddf8', 'English (US)', deepVermilion),
                ('en_GB', '\ud83c\uddec\ud83c\udde7', 'English (UK)', cinnabar),
                ('de_DE', '\ud83c\udde9\ud83c\uddea', 'German', burntOrange),
                ('fr_FR', '\ud83c\uddeb\ud83c\uddf7', 'French', mandarin),
                ('es_ES', '\ud83c\uddea\ud83c\uddf8', 'Spanish', tangerine),
                ('ja', '\ud83c\uddef\ud83c\uddf5', 'Japanese', salmon),
                ('zh_CN', '\ud83c\udde8\ud83c\uddf3', 'Chinese (Simplified)', tealContrast),
                ('ko', '\ud83c\uddf0\ud83c\uddf7', 'Korean', navyContrast),
                ('pt_BR', '\ud83c\udde7\ud83c\uddf7', 'Portuguese (BR)', deepVermilion),
                ('ar', '\ud83c\uddf8\ud83c\udde6', 'Arabic (RTL)', cinnabar),
              ])
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: loc.$4.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: loc.$4.withValues(alpha: 0.2)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(loc.$2, style: const TextStyle(fontSize: 20)),
                      const SizedBox(height: 2),
                      Text(loc.$1,
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'monospace',
                              color: loc.$4)),
                      Text(loc.$3,
                          style: TextStyle(
                              fontSize: 9, color: Colors.grey)),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 8. Delegate types ────────────────────────────────────────
        sectionBanner('7 \u00b7 Built-in Delegates',
            'Standard delegates Flutter provides',
            deepVermilion, Colors.white),
        apiCard('GlobalMaterialLocalizations', 'Material design text strings, formatters, and directionality', Icons.palette, deepVermilion),
        apiCard('GlobalWidgetsLocalizations', 'Text direction (LTR/RTL) for the Widgets layer', Icons.text_format, cinnabar),
        apiCard('GlobalCupertinoLocalizations', 'Cupertino (iOS-style) text strings and formatting', Icons.phone_iphone, burntOrange),
        apiCard('Custom delegate', 'Your app-specific LocalizationsDelegate<T>', Icons.extension, mandarin),
        const SizedBox(height: 14),

        // ── 9. Locale resolution strategy ────────────────────────────
        sectionBanner('8 \u00b7 Locale Resolution Strategy',
            'How Flutter picks the best match',
            cinnabar, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: cinnabarWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final strategy in [
                (1, 'Exact match', 'languageCode + countryCode', deepVermilion),
                (2, 'Language match', 'Same languageCode, any country', cinnabar),
                (3, 'Script match', 'Same scriptCode if specified', burntOrange),
                (4, 'Country fallback', 'Broader locale variant', mandarin),
                (5, 'First supported', 'supportedLocales[0] as last resort', tangerine),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: strategy.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: strategy.$4, width: 3)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: strategy.$4,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text('${strategy.$1}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(strategy.$2,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: deepVermilion)),
                            Text(strategy.$3,
                                style: TextStyle(
                                    fontSize: 11, color: mandarin)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 10. Resolver output examples ─────────────────────────────
        sectionBanner('9 \u00b7 Resolver Output Examples',
            'What the resolver returns for different locales',
            burntOrange, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: cinnabarWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(3),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(color: deepVermilion),
                children: [
                  for (final h in ['Input Locale', 'Resolved To', 'Example Strings'])
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(h,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 11)),
                    ),
                ],
              ),
              for (final row in [
                ('en_US', 'English (US)', 'OK, Cancel, Done'),
                ('en_GB', 'English (GB)', 'OK, Cancel, Done (same)'),
                ('de_DE', 'German', 'OK, Abbrechen, Fertig'),
                ('fr_FR', 'French', 'OK, Annuler, Termin\u00e9'),
                ('ja', 'Japanese', 'OK, \u30ad\u30e3\u30f3\u30bb\u30eb, \u5b8c\u4e86'),
                ('zh_CN', 'Chinese', '\u786e\u5b9a, \u53d6\u6d88, \u5b8c\u6210'),
              ])
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$1,
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'monospace',
                              color: deepVermilion)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$2,
                          style: TextStyle(
                              fontSize: 11, color: cinnabar)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$3,
                          style: TextStyle(
                              fontSize: 10, color: burntOrange)),
                    ),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 11. RTL support ──────────────────────────────────────────
        sectionBanner('10 \u00b7 Text Directionality',
            'How locale affects layout direction',
            deepVermilion, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: cinnabarWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final dir in [
                ('LTR', '\u2192', 'English, German, French, Chinese', deepVermilion, true),
                ('RTL', '\u2190', 'Arabic, Hebrew, Persian, Urdu', navyContrast, false),
              ])
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: dir.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: dir.$4, width: 3)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: dir.$4.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(dir.$2,
                            style: TextStyle(
                                fontSize: 22, color: dir.$4)),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(dir.$1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: dir.$4)),
                            Text(dir.$3,
                                style: TextStyle(
                                    fontSize: 12, color: cinnabar)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 12. Async loading visualization ──────────────────────────
        sectionBanner('11 \u00b7 Async Loading Behavior',
            'The resolver returns a Future — loading takes time',
            cinnabar, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: cinnabarWhite,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: peachBlush),
          ),
          child: Column(
            children: [
              for (final phase in [
                ('Request', 'load(Locale(\'de\', \'DE\'))', Icons.send, deepVermilion),
                ('Loading', 'Reading .arb file or initializing', Icons.hourglass_empty, cinnabar),
                ('Resolved', 'AppLocalizations_de instance ready', Icons.check_circle, tealContrast),
                ('Available', 'Localizations.of<AppLocalizations>(context)', Icons.visibility, burntOrange),
              ])
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: phase.$4, width: 3)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: phase.$4.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(phase.$3, size: 18, color: phase.$4),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(phase.$1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: deepVermilion)),
                            Text(phase.$2,
                                style: TextStyle(
                                    fontSize: 11,
                                    fontFamily: 'monospace',
                                    color: cinnabar)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 13. shouldReload decision ────────────────────────────────
        sectionBanner('12 \u00b7 shouldReload Decision',
            'When the resolver gets called again',
            burntOrange, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: cinnabarWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final scenario in [
                ('Locale changes', true, 'Always calls load() with new locale', deepVermilion),
                ('shouldReload returns true', true, 'Delegate updated, reload resources', cinnabar),
                ('shouldReload returns false', false, 'Keep cached resources', tealContrast),
                ('Hot reload', true, 'Development convenience', burntOrange),
                ('Same locale, same delegate', false, 'No need to reload', salmon),
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Icon(
                        scenario.$2 ? Icons.refresh : Icons.cached,
                        size: 18,
                        color: scenario.$2 ? scenario.$4 : tealContrast,
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 160,
                        child: Text(scenario.$1,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: deepVermilion)),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: scenario.$2
                              ? deepVermilion.withValues(alpha: 0.1)
                              : tealContrast.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(scenario.$2 ? 'RELOAD' : 'CACHED',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: scenario.$2
                                    ? deepVermilion
                                    : tealContrast)),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(scenario.$3,
                            style: TextStyle(
                                fontSize: 11, color: mandarin)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 14. Inheritance and type structure ───────────────────────
        sectionBanner('13 \u00b7 Type Structure',
            'Where LocalizationsResolver fits',
            deepVermilion, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: cinnabarWhite,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final level in [
                ('Function', 'Dart function type', Colors.grey),
                ('\u2514\u2500 LocalizationsResolver<T>', 'typedef alias', deepVermilion),
                ('     = Future<T> Function(', 'Parameters:', cinnabar),
                ('         Locale locale,', 'Requested locale', burntOrange),
                ('         Iterable<Locale> supported', 'All supported locales', mandarin),
                ('       )', '', Colors.grey),
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(level.$1,
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'monospace',
                                fontWeight: level.$1.contains('Resolver')
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: level.$3)),
                      ),
                      if (level.$2.isNotEmpty)
                        Expanded(
                          flex: 2,
                          child: Text(level.$2,
                              style: TextStyle(
                                  fontSize: 11,
                                  fontStyle: FontStyle.italic,
                                  color: salmon)),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        noteBox(
          'As a typedef, LocalizationsResolver does not appear in the '
          'class hierarchy. It is a function type alias — any function '
          'matching the signature can be used as a resolver.',
          deepVermilion,
          cinnabarWhite,
        ),
        const SizedBox(height: 14),

        // ── 15. Testing localization ─────────────────────────────────
        sectionBanner('14 \u00b7 Testing Considerations',
            'Tips for testing resolver behavior',
            cinnabar, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: cinnabarWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final tip in [
                ('\u2705', 'Wrap widgets in Localizations for tests', deepVermilion),
                ('\u2705', 'Test each supported locale explicitly', cinnabar),
                ('\u2705', 'Verify fallback when locale not supported', burntOrange),
                ('\u2705', 'Check RTL layout for Arabic/Hebrew locales', mandarin),
                ('\u26a0\ufe0f', 'Await resolver Future in widget tests', tangerine),
                ('\u26a0\ufe0f', 'Ensure delegates are provided in test harness', salmon),
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 22,
                        child: Text(tip.$1,
                            style: const TextStyle(fontSize: 14)),
                      ),
                      Expanded(
                        child: Text(tip.$2,
                            style: TextStyle(
                                fontSize: 12, color: tip.$3)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 16. Summary ──────────────────────────────────────────────
        sectionBanner('15 \u00b7 Summary',
            'Key takeaways', deepVermilion, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [deepVermilion, cinnabar],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final point in [
                'Typedef for Future<T> Function(Locale, Iterable<Locale>)',
                'Used inside LocalizationsDelegate to load resources',
                'Receives requested locale and all supported locales',
                'Returns localized resource object asynchronously',
                'Integrates with Localizations widget via delegates',
                'Supports LTR and RTL layouts via text directionality',
                'shouldReload controls when resolver runs again',
                'Essential for multi-language Flutter applications',
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\u2022  ',
                          style: TextStyle(
                              color: peachBlush,
                              fontWeight: FontWeight.bold,
                              fontSize: 14)),
                      Expanded(
                        child: Text(point,
                            style: TextStyle(
                                color: Colors.white, fontSize: 13)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    ),
  );
}
