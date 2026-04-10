// ignore_for_file: avoid_print
// D4rt test script: Deep demo for WidgetsLocalizations from widgets.
import 'package:flutter/material.dart';

const List<_LocaleCard> _locales = <_LocaleCard>[
  _LocaleCard(
    localeCode: 'en',
    name: 'English',
    scriptPreview: 'Control panel / Navigation / Search',
    textDirection: TextDirection.ltr,
    color: Color(0xFF0A5E74),
    icon: Icons.language,
  ),
  _LocaleCard(
    localeCode: 'ar',
    name: 'Arabic',
    scriptPreview: 'لوحة التحكم / التنقل / البحث',
    textDirection: TextDirection.rtl,
    color: Color(0xFF74480A),
    icon: Icons.translate,
  ),
  _LocaleCard(
    localeCode: 'he',
    name: 'Hebrew',
    scriptPreview: 'לוח בקרה / ניווט / חיפוש',
    textDirection: TextDirection.rtl,
    color: Color(0xFF36418A),
    icon: Icons.book,
  ),
  _LocaleCard(
    localeCode: 'fa',
    name: 'Persian',
    scriptPreview: 'داشبورد / پیمایش / جستجو',
    textDirection: TextDirection.rtl,
    color: Color(0xFF416215),
    icon: Icons.auto_stories,
  ),
  _LocaleCard(
    localeCode: 'ur',
    name: 'Urdu',
    scriptPreview: 'ڈیش بورڈ / نیویگیشن / تلاش',
    textDirection: TextDirection.rtl,
    color: Color(0xFF7A1E4D),
    icon: Icons.menu_book,
  ),
];

const List<_DirectionRule> _directionRules = <_DirectionRule>[
  _DirectionRule(
    title: 'Edge anchoring',
    ltrBehavior: 'Leading widgets anchor left and trailing widgets anchor right.',
    rtlBehavior: 'Leading widgets anchor right and trailing widgets anchor left.',
  ),
  _DirectionRule(
    title: 'Padding resolution',
    ltrBehavior: 'EdgeInsetsDirectional.start resolves to left side.',
    rtlBehavior: 'EdgeInsetsDirectional.start resolves to right side.',
  ),
  _DirectionRule(
    title: 'Iconography flow',
    ltrBehavior: 'Chevron-right often indicates forward progression.',
    rtlBehavior: 'Chevron-left may indicate forward progression.',
  ),
  _DirectionRule(
    title: 'List tile density',
    ltrBehavior: 'Leading avatar appears on left in default tile layouts.',
    rtlBehavior: 'Leading avatar appears on right when direction flips.',
  ),
  _DirectionRule(
    title: 'Page transitions',
    ltrBehavior: 'Horizontal transitions generally move left-to-right for back.',
    rtlBehavior: 'Transitions mirror to preserve semantic forward direction.',
  ),
];

dynamic build(BuildContext context) {
  final WidgetsLocalizations inherited = WidgetsLocalizations.of(context);
  final TextDirection inheritedDirection = inherited.textDirection;

  final ValueNotifier<int> selectedLocale = ValueNotifier<int>(0);
  final ValueNotifier<bool> forceDirectionalPadding = ValueNotifier<bool>(true);
  final ValueNotifier<bool> mirrorNavigationIcons = ValueNotifier<bool>(true);
  final ValueNotifier<int> selectedRule = ValueNotifier<int>(2);

  print('WidgetsLocalizations deep demo executing');
  print('Inherited text direction: $inheritedDirection');

  return Theme(
    data: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4D6A1E)),
      cardTheme: const CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
    ),
    child: DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[Color(0xFFFBF9EE), Color(0xFFEAF5F8)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 22, 20, 24),
        children: <Widget>[
          _buildTopHeader(inheritedDirection),
          const SizedBox(height: 16),
          _buildDirectionOverview(inheritedDirection),
          const SizedBox(height: 16),
          _buildLocaleChooser(selectedLocale),
          const SizedBox(height: 16),
          _buildDirectionalWorkbench(
            selectedLocale: selectedLocale,
            forceDirectionalPadding: forceDirectionalPadding,
            mirrorNavigationIcons: mirrorNavigationIcons,
          ),
          const SizedBox(height: 16),
          _buildRuleExplorer(selectedRule),
          const SizedBox(height: 16),
          _buildScriptComparison(selectedLocale),
          const SizedBox(height: 16),
          _buildLocalizationDelegateRecipe(),
          const SizedBox(height: 16),
          _buildValidationSummary(),
        ],
      ),
    ),
  );
}

Widget _buildTopHeader(TextDirection inheritedDirection) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Wrap(
            spacing: 10,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              const CircleAvatar(
                radius: 25,
                backgroundColor: Color(0xFF4D6A1E),
                child: Icon(Icons.g_translate, color: Colors.white),
              ),
              const Text(
                'WidgetsLocalizations Deep Demo',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
              ),
              Chip(
                avatar: const Icon(Icons.swap_horiz),
                label: Text('Inherited: ${inheritedDirection.name}'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'This demo explores how WidgetsLocalizations and Directionality '
            'influence visual flow, component alignment, and navigation semantics '
            'across LTR and RTL interfaces.',
          ),
        ],
      ),
    ),
  );
}

Widget _buildDirectionOverview(TextDirection inheritedDirection) {
  final List<_OverviewRow> rows = <_OverviewRow>[
    _OverviewRow('WidgetsLocalizations.of(context)', 'resolved'),
    _OverviewRow('Inherited text direction', inheritedDirection.name),
    _OverviewRow('Directionality.of(context)', inheritedDirection.name),
    _OverviewRow('TextDirection.values', TextDirection.values.length.toString()),
  ];

  return Card(
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Context Resolution Snapshot',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          Table(
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(2.5),
              1: FlexColumnWidth(1.5),
            },
            children: rows
                .map(
                  (_OverviewRow row) => TableRow(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7),
                        child: Text(row.label),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7),
                        child: Text(
                          row.value,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ],
      ),
    ),
  );
}

Widget _buildLocaleChooser(ValueNotifier<int> selectedLocale) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: ValueListenableBuilder<int>(
        valueListenable: selectedLocale,
        builder: (BuildContext context, int selected, Widget? child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Locale Selector',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: <Widget>[
                  for (int i = 0; i < _locales.length; i++)
                    ChoiceChip(
                      selected: i == selected,
                      avatar: Icon(_locales[i].icon, size: 18),
                      label: Text('${_locales[i].name} (${_locales[i].localeCode})'),
                      onSelected: (_) => selectedLocale.value = i,
                    ),
                ],
              ),
              const SizedBox(height: 12),
              _LocalePreviewBanner(locale: _locales[selected]),
            ],
          );
        },
      ),
    ),
  );
}

Widget _buildDirectionalWorkbench({
  required ValueNotifier<int> selectedLocale,
  required ValueNotifier<bool> forceDirectionalPadding,
  required ValueNotifier<bool> mirrorNavigationIcons,
}) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: ValueListenableBuilder3<int, bool, bool>(
        first: selectedLocale,
        second: forceDirectionalPadding,
        third: mirrorNavigationIcons,
        builder: (BuildContext context, int localeIndex, bool useDirectional,
            bool mirrorIcons) {
          final _LocaleCard locale = _locales[localeIndex];
          final bool rtl = locale.textDirection == TextDirection.rtl;
          final EdgeInsetsGeometry padding = useDirectional
              ? const EdgeInsetsDirectional.fromSTEB(18, 10, 10, 10)
              : const EdgeInsets.fromLTRB(18, 10, 10, 10);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Directional Workbench',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
              ),
              const SizedBox(height: 8),
              SwitchListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                title: const Text('Use EdgeInsetsDirectional in sample card'),
                value: useDirectional,
                onChanged: (bool next) => forceDirectionalPadding.value = next,
              ),
              SwitchListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                title: const Text('Mirror navigation arrow for RTL selection'),
                value: mirrorIcons,
                onChanged: (bool next) => mirrorNavigationIcons.value = next,
              ),
              const SizedBox(height: 8),
              Directionality(
                textDirection: locale.textDirection,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: locale.color.withValues(alpha: 0.6)),
                    color: locale.color.withValues(alpha: 0.09),
                  ),
                  child: Padding(
                    padding: padding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundColor: locale.color,
                              child: Icon(locale.icon, color: Colors.white),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                locale.scriptPreview,
                                style: const TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                            Icon(
                              rtl && mirrorIcons
                                  ? Icons.arrow_back
                                  : Icons.arrow_forward,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          rtl
                              ? 'RTL context is active: visual leading edge is right.'
                              : 'LTR context is active: visual leading edge is left.',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    ),
  );
}

Widget _buildRuleExplorer(ValueNotifier<int> selectedRule) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: ValueListenableBuilder<int>(
        valueListenable: selectedRule,
        builder: (BuildContext context, int ruleIndex, Widget? child) {
          final _DirectionRule rule = _directionRules[ruleIndex];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Direction Rule Explorer',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: <Widget>[
                  for (int i = 0; i < _directionRules.length; i++)
                    FilterChip(
                      selected: i == ruleIndex,
                      onSelected: (_) => selectedRule.value = i,
                      label: Text(_directionRules[i].title),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFD0D8DD)),
                  color: const Color(0xFFF8FBFC),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        rule.title,
                        style:
                            const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                      const SizedBox(height: 6),
                      Text('LTR: ${rule.ltrBehavior}'),
                      const SizedBox(height: 4),
                      Text('RTL: ${rule.rtlBehavior}'),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    ),
  );
}

Widget _buildScriptComparison(ValueNotifier<int> selectedLocale) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: ValueListenableBuilder<int>(
        valueListenable: selectedLocale,
        builder: (BuildContext context, int index, Widget? child) {
          final _LocaleCard active = _locales[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Script and Layout Comparison',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: <Widget>[
                  _ComparisonCard(
                    title: 'Raw Script',
                    description: active.scriptPreview,
                    direction: active.textDirection,
                    color: active.color,
                    icon: active.icon,
                  ),
                  _ComparisonCard(
                    title: 'Mirrored Controls',
                    description: active.textDirection == TextDirection.rtl
                        ? 'Primary action should appear on right to preserve leading semantics.'
                        : 'Primary action should appear on left in common LTR dashboards.',
                    direction: active.textDirection,
                    color: active.color.withValues(alpha: 0.8),
                    icon: Icons.compare_arrows,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    ),
  );
}

Widget _buildLocalizationDelegateRecipe() {
  const List<_SnippetCard> snippets = <_SnippetCard>[
    _SnippetCard(
      title: 'MaterialApp delegates',
      code: 'MaterialApp(\n  localizationsDelegates: const [\n    GlobalWidgetsLocalizations.delegate,\n    GlobalMaterialLocalizations.delegate,\n  ],\n)',
      note: 'Global delegates provide stock translations and text direction.',
    ),
    _SnippetCard(
      title: 'Locale support declaration',
      code: 'supportedLocales: const [\n  Locale(\'en\'),\n  Locale(\'ar\'),\n  Locale(\'he\'),\n],',
      note: 'Order can reflect product priorities but should include all targets.',
    ),
    _SnippetCard(
      title: 'Direction read in widgets layer',
      code: 'final dir = WidgetsLocalizations.of(context).textDirection;\nfinal isRtl = dir == TextDirection.rtl;',
      note: 'Use in custom widgets that need direction-aware behavior.',
    ),
  ];

  return Card(
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Delegate and Integration Recipes',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
          ),
          const SizedBox(height: 10),
          for (final _SnippetCard snippet in snippets)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFD4DFE3)),
                  color: const Color(0xFFF9FCFD),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        snippet.title,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFF162226),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          snippet.code,
                          style: const TextStyle(
                            color: Color(0xFFD8F4FF),
                            fontFamily: 'monospace',
                            height: 1.3,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(snippet.note),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    ),
  );
}

Widget _buildValidationSummary() {
  const List<String> bullets = <String>[
    'Inherited WidgetsLocalizations is inspected and surfaced in dashboard summary.',
    'Locale chooser switches between LTR and RTL examples with visible mirroring.',
    'Rule explorer documents behavior differences in concise language.',
    'Directional padding toggle demonstrates practical layout pitfalls.',
    'Delegate recipe cards provide copy-ready setup snippets.',
  ];

  return Card(
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Demo Validation Checklist',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
          ),
          const SizedBox(height: 8),
          for (final String item in bullets)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Icon(Icons.check_circle, size: 16),
                  const SizedBox(width: 8),
                  Expanded(child: Text(item)),
                ],
              ),
            ),
        ],
      ),
    ),
  );
}

class _LocalePreviewBanner extends StatelessWidget {
  const _LocalePreviewBanner({required this.locale});

  final _LocaleCard locale;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: locale.color.withValues(alpha: 0.5)),
        color: locale.color.withValues(alpha: 0.1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: locale.color,
              child: Icon(locale.icon, color: Colors.white),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${locale.name} (${locale.localeCode})',
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 2),
                  Text(locale.scriptPreview),
                ],
              ),
            ),
            Chip(label: Text(locale.textDirection.name.toUpperCase())),
          ],
        ),
      ),
    );
  }
}

class _ComparisonCard extends StatelessWidget {
  const _ComparisonCard({
    required this.title,
    required this.description,
    required this.direction,
    required this.color,
    required this.icon,
  });

  final String title;
  final String description;
  final TextDirection direction;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Directionality(
        textDirection: direction,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withValues(alpha: 0.5)),
            color: color.withValues(alpha: 0.08),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(icon, color: color),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(description),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LocaleCard {
  const _LocaleCard({
    required this.localeCode,
    required this.name,
    required this.scriptPreview,
    required this.textDirection,
    required this.color,
    required this.icon,
  });

  final String localeCode;
  final String name;
  final String scriptPreview;
  final TextDirection textDirection;
  final Color color;
  final IconData icon;
}

class _DirectionRule {
  const _DirectionRule({
    required this.title,
    required this.ltrBehavior,
    required this.rtlBehavior,
  });

  final String title;
  final String ltrBehavior;
  final String rtlBehavior;
}

class _SnippetCard {
  const _SnippetCard({
    required this.title,
    required this.code,
    required this.note,
  });

  final String title;
  final String code;
  final String note;
}

class _OverviewRow {
  const _OverviewRow(this.label, this.value);

  final String label;
  final String value;
}

class ValueListenableBuilder3<A, B, C> extends StatelessWidget {
  const ValueListenableBuilder3({
    super.key,
    required this.first,
    required this.second,
    required this.third,
    required this.builder,
  });

  final ValueNotifier<A> first;
  final ValueNotifier<B> second;
  final ValueNotifier<C> third;
  final Widget Function(BuildContext context, A a, B b, C c) builder;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<A>(
      valueListenable: first,
      builder: (BuildContext context, A a, Widget? _) {
        return ValueListenableBuilder<B>(
          valueListenable: second,
          builder: (BuildContext context, B b, Widget? midChild) {
            return ValueListenableBuilder<C>(
              valueListenable: third,
              builder: (BuildContext context, C c, Widget? child) {
                return builder(context, a, b, c);
              },
            );
          },
        );
      },
    );
  }
}
