// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TabBarTheme, SliderTheme, SliderThemeData, SwitchTheme, SwitchThemeData, CheckboxTheme, CheckboxThemeData, RadioTheme, RadioThemeData, ProgressIndicatorTheme, ProgressIndicatorThemeData from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Input themes test executing');

  // ========== TAB BAR THEME DATA ==========
  print('--- TabBarThemeData Tests ---');

  final tabBarTheme = TabBarThemeData(
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(color: Colors.blue, width: 3.0),
    ),
    indicatorColor: Colors.blue,
    indicatorSize: TabBarIndicatorSize.tab,
    labelColor: Colors.blue,
    unselectedLabelColor: Colors.grey,
    labelStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
    unselectedLabelStyle: TextStyle(fontSize: 14.0),
    labelPadding: EdgeInsets.symmetric(horizontal: 16.0),
    dividerColor: Colors.grey.shade300,
    dividerHeight: 1.0,
    overlayColor: WidgetStateProperty.all(Colors.blue.withValues(alpha: 0.1)),
    tabAlignment: TabAlignment.fill,
  );
  print('TabBarThemeData created');
  print('  indicatorColor: ${tabBarTheme.indicatorColor}');
  print('  indicatorSize: ${tabBarTheme.indicatorSize}');
  print('  labelColor: ${tabBarTheme.labelColor}');
  print('  unselectedLabelColor: ${tabBarTheme.unselectedLabelColor}');
  print('  dividerColor: ${tabBarTheme.dividerColor}');
  print('  dividerHeight: ${tabBarTheme.dividerHeight}');
  print('  tabAlignment: ${tabBarTheme.tabAlignment}');

  // Test copyWith
  final copiedTabBarTheme = tabBarTheme.copyWith(
    labelColor: Colors.indigo,
    indicatorColor: Colors.indigo,
  );
  print('TabBarThemeData.copyWith created');
  print('  new labelColor: ${copiedTabBarTheme.labelColor}');
  print('  new indicatorColor: ${copiedTabBarTheme.indicatorColor}');

  // ========== SLIDER THEME DATA ==========
  print('--- SliderThemeData Tests ---');

  final sliderThemeData = SliderThemeData(
    activeTrackColor: Colors.blue,
    inactiveTrackColor: Colors.blue.shade100,
    disabledActiveTrackColor: Colors.grey,
    disabledInactiveTrackColor: Colors.grey.shade200,
    thumbColor: Colors.blue,
    disabledThumbColor: Colors.grey.shade400,
    overlayColor: Colors.blue.withValues(alpha: 0.2),
    activeTickMarkColor: Colors.blue.shade800,
    inactiveTickMarkColor: Colors.blue.shade200,
    valueIndicatorColor: Colors.blue.shade700,
    valueIndicatorTextStyle: TextStyle(fontSize: 14.0, color: Colors.white),
    trackHeight: 4.0,
    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
    overlayShape: RoundSliderOverlayShape(overlayRadius: 24.0),
    tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: 2.0),
    valueIndicatorShape: PaddleSliderValueIndicatorShape(),
    trackShape: RoundedRectSliderTrackShape(),
    showValueIndicator: ShowValueIndicator.onlyForDiscrete,
  );
  print('SliderThemeData created');
  print('  activeTrackColor: ${sliderThemeData.activeTrackColor}');
  print('  thumbColor: ${sliderThemeData.thumbColor}');
  print('  trackHeight: ${sliderThemeData.trackHeight}');
  print('  showValueIndicator: ${sliderThemeData.showValueIndicator}');

  // Test copyWith
  final copiedSliderTheme = sliderThemeData.copyWith(
    activeTrackColor: Colors.green,
    thumbColor: Colors.green,
  );
  print('SliderThemeData.copyWith created');
  print('  new activeTrackColor: ${copiedSliderTheme.activeTrackColor}');
  print('  new thumbColor: ${copiedSliderTheme.thumbColor}');

  // ========== SWITCH THEME DATA ==========
  print('--- SwitchThemeData Tests ---');

  final switchThemeData = SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) return Colors.blue;
      return Colors.grey;
    }),
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) return Colors.blue.shade200;
      return Colors.grey.shade300;
    }),
    trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
    overlayColor: WidgetStateProperty.all(Colors.blue.withValues(alpha: 0.1)),
    splashRadius: 20.0,
    thumbIcon: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected))
        return Icon(Icons.check, size: 14.0);
      return null;
    }),
  );
  print('SwitchThemeData created');
  print('  splashRadius: ${switchThemeData.splashRadius}');
  print('  thumbColor: ${switchThemeData.thumbColor}');
  print('  trackColor: ${switchThemeData.trackColor}');

  // Test copyWith
  final copiedSwitchTheme = switchThemeData.copyWith(splashRadius: 24.0);
  print('SwitchThemeData.copyWith created');
  print('  new splashRadius: ${copiedSwitchTheme.splashRadius}');

  // ========== CHECKBOX THEME DATA ==========
  print('--- CheckboxThemeData Tests ---');

  final checkboxThemeData = CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) return Colors.blue;
      return Colors.transparent;
    }),
    checkColor: WidgetStateProperty.all(Colors.white),
    overlayColor: WidgetStateProperty.all(Colors.blue.withValues(alpha: 0.1)),
    splashRadius: 20.0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
    side: BorderSide(color: Colors.grey, width: 2.0),
    visualDensity: VisualDensity.compact,
  );
  print('CheckboxThemeData created');
  print('  splashRadius: ${checkboxThemeData.splashRadius}');
  print('  shape: ${checkboxThemeData.shape}');
  print('  side: ${checkboxThemeData.side}');
  print('  visualDensity: ${checkboxThemeData.visualDensity}');

  // Test copyWith
  final copiedCheckboxTheme = checkboxThemeData.copyWith(splashRadius: 24.0);
  print('CheckboxThemeData.copyWith created');
  print('  new splashRadius: ${copiedCheckboxTheme.splashRadius}');

  // ========== RADIO THEME DATA ==========
  print('--- RadioThemeData Tests ---');

  final radioThemeData = RadioThemeData(
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) return Colors.blue;
      return Colors.grey;
    }),
    overlayColor: WidgetStateProperty.all(Colors.blue.withValues(alpha: 0.1)),
    splashRadius: 20.0,
    visualDensity: VisualDensity.compact,
  );
  print('RadioThemeData created');
  print('  splashRadius: ${radioThemeData.splashRadius}');
  print('  fillColor: ${radioThemeData.fillColor}');
  print('  visualDensity: ${radioThemeData.visualDensity}');

  // Test copyWith
  final copiedRadioTheme = radioThemeData.copyWith(splashRadius: 24.0);
  print('RadioThemeData.copyWith created');
  print('  new splashRadius: ${copiedRadioTheme.splashRadius}');

  // ========== PROGRESS INDICATOR THEME DATA ==========
  print('--- ProgressIndicatorThemeData Tests ---');

  final progressThemeData = ProgressIndicatorThemeData(
    color: Colors.blue,
    linearTrackColor: Colors.blue.shade100,
    circularTrackColor: Colors.blue.shade50,
    linearMinHeight: 4.0,
    refreshBackgroundColor: Colors.grey.shade200,
  );
  print('ProgressIndicatorThemeData created');
  print('  color: ${progressThemeData.color}');
  print('  linearTrackColor: ${progressThemeData.linearTrackColor}');
  print('  circularTrackColor: ${progressThemeData.circularTrackColor}');
  print('  linearMinHeight: ${progressThemeData.linearMinHeight}');
  print(
    '  refreshBackgroundColor: ${progressThemeData.refreshBackgroundColor}',
  );

  // Test copyWith
  final copiedProgressTheme = progressThemeData.copyWith(
    color: Colors.green,
    linearMinHeight: 6.0,
  );
  print('ProgressIndicatorThemeData.copyWith created');
  print('  new color: ${copiedProgressTheme.color}');
  print('  new linearMinHeight: ${copiedProgressTheme.linearMinHeight}');

  // ========== WRAP IN THEME WIDGET ==========
  print('--- Theme Integration ---');

  final themeData = ThemeData(
    tabBarTheme: tabBarTheme,
    sliderTheme: sliderThemeData,
    switchTheme: switchThemeData,
    checkboxTheme: checkboxThemeData,
    radioTheme: radioThemeData,
    progressIndicatorTheme: progressThemeData,
  );
  print('ThemeData with input themes created');

  return Theme(
    data: themeData,
    child: Builder(
      builder: (ctx) {
        final resolvedTheme = Theme.of(ctx);
        print('Theme.of resolved');
        print(
          '  tabBarTheme.labelColor: ${resolvedTheme.tabBarTheme.labelColor}',
        );
        print(
          '  sliderTheme.thumbColor: ${resolvedTheme.sliderTheme.thumbColor}',
        );
        print(
          '  checkboxTheme.splashRadius: ${resolvedTheme.checkboxTheme.splashRadius}',
        );
        print(
          '  progressIndicatorTheme.color: ${resolvedTheme.progressIndicatorTheme.color}',
        );

        return SliderTheme(
          data: sliderThemeData,
          child: SwitchTheme(
            data: switchThemeData,
            child: CheckboxTheme(
              data: checkboxThemeData,
              child: RadioTheme(
                data: radioThemeData,
                child: ProgressIndicatorTheme(
                  data: progressThemeData,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      LinearProgressIndicator(value: 0.6),
                      SizedBox(height: 8.0),
                      Text('Input themes test passed'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}
