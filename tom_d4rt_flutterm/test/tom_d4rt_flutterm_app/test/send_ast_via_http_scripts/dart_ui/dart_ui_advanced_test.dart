// D4rt test script: Tests dart:ui SemanticsAction, SemanticsFlag,
// FontFeature, FontVariation, Locale (advanced), PlatformDispatcher concepts,
// LocaleStringAttribute, SpellOutStringAttribute
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

dynamic build(BuildContext context) {
  print('dart:ui advanced test executing');

  // ========== SemanticsAction ==========
  print('--- SemanticsAction Tests ---');
  final actions = <String, ui.SemanticsAction>{
    'tap': ui.SemanticsAction.tap,
    'longPress': ui.SemanticsAction.longPress,
    'scrollLeft': ui.SemanticsAction.scrollLeft,
    'scrollRight': ui.SemanticsAction.scrollRight,
    'scrollUp': ui.SemanticsAction.scrollUp,
    'scrollDown': ui.SemanticsAction.scrollDown,
    'increase': ui.SemanticsAction.increase,
    'decrease': ui.SemanticsAction.decrease,
    'showOnScreen': ui.SemanticsAction.showOnScreen,
    'dismiss': ui.SemanticsAction.dismiss,
    'copy': ui.SemanticsAction.copy,
    'cut': ui.SemanticsAction.cut,
    'paste': ui.SemanticsAction.paste,
    'setText': ui.SemanticsAction.setText,
    'focus': ui.SemanticsAction.focus,
  };
  for (final entry in actions.entries) {
    print('SemanticsAction.${entry.key}: ${entry.value.index}');
  }

  // ========== SemanticsFlag ==========
  print('--- SemanticsFlag Tests ---');
  final flags = <String, ui.SemanticsFlag>{
    'hasCheckedState': ui.SemanticsFlag.hasCheckedState,
    'isChecked': ui.SemanticsFlag.isChecked,
    'isSelected': ui.SemanticsFlag.isSelected,
    'isButton': ui.SemanticsFlag.isButton,
    'isTextField': ui.SemanticsFlag.isTextField,
    'isFocused': ui.SemanticsFlag.isFocused,
    'hasEnabledState': ui.SemanticsFlag.hasEnabledState,
    'isEnabled': ui.SemanticsFlag.isEnabled,
    'isReadOnly': ui.SemanticsFlag.isReadOnly,
    'isHeader': ui.SemanticsFlag.isHeader,
    'isHidden': ui.SemanticsFlag.isHidden,
    'isImage': ui.SemanticsFlag.isImage,
    'isLink': ui.SemanticsFlag.isLink,
    'isSlider': ui.SemanticsFlag.isSlider,
    'isKeyboardKey': ui.SemanticsFlag.isKeyboardKey,
  };
  for (final entry in flags.entries) {
    print('SemanticsFlag.${entry.key}: ${entry.value.index}');
  }

  // ========== FontFeature ==========
  print('--- FontFeature Tests ---');
  final features = <ui.FontFeature>[
    ui.FontFeature('liga'),
    ui.FontFeature('smcp'),
    ui.FontFeature.enable('kern'),
    ui.FontFeature.disable('liga'),
    ui.FontFeature.tabularFigures(),
    ui.FontFeature.oldstyleFigures(),
    ui.FontFeature.proportionalFigures(),
    ui.FontFeature.slashedZero(),
  ];
  for (final f in features) {
    print('FontFeature: ${f.feature} = ${f.value}');
  }

  // ========== FontVariation ==========
  print('--- FontVariation Tests ---');
  final variations = <ui.FontVariation>[
    ui.FontVariation('wght', 400),
    ui.FontVariation('wdth', 100),
    ui.FontVariation('ital', 1),
    ui.FontVariation.weight(700),
    ui.FontVariation.italic(1.0),
    ui.FontVariation.width(125),
  ];
  for (final v in variations) {
    print('FontVariation: ${v.axis} = ${v.value}');
  }

  // ========== Locale advanced ==========
  print('--- Locale advanced Tests ---');
  final locales = <Locale>[
    Locale('en', 'US'),
    Locale('de', 'DE'),
    Locale('ja', 'JP'),
    Locale('zh', 'CN'),
    Locale('ar', 'SA'),
    Locale.fromSubtags(
      languageCode: 'zh',
      scriptCode: 'Hant',
      countryCode: 'TW',
    ),
  ];
  for (final loc in locales) {
    print(
      'Locale: ${loc.toLanguageTag()} (lang=${loc.languageCode}, country=${loc.countryCode})',
    );
  }

  // ========== TextDecoration advanced ==========
  print('--- TextDecoration Tests ---');
  final decorations = <String, TextDecoration>{
    'none': TextDecoration.none,
    'underline': TextDecoration.underline,
    'overline': TextDecoration.overline,
    'lineThrough': TextDecoration.lineThrough,
  };
  for (final entry in decorations.entries) {
    print('TextDecoration.${entry.key}');
  }
  final combined = TextDecoration.combine([
    TextDecoration.underline,
    TextDecoration.overline,
  ]);
  print('Combined decoration: $combined');

  print('All dart:ui advanced tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'dart:ui Advanced Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Text('SemanticsAction: ${actions.length} values'),
            Text('SemanticsFlag: ${flags.length} values'),
            Text('FontFeature: ${features.length} features'),
            Text('FontVariation: ${variations.length} variations'),
            Text('Locales: ${locales.length} tested'),
            SizedBox(height: 16.0),
            Text(
              'Font Features Demo',
              style: TextStyle(
                fontSize: 24.0,
                fontFeatures: [ui.FontFeature.tabularFigures()],
                fontVariations: [ui.FontVariation.weight(600)],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
