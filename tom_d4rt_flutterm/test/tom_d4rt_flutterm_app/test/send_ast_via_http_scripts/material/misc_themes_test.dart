// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ExpansionTileTheme, ExpansionTileThemeData, SegmentedButtonTheme, SegmentedButtonThemeData, BadgeTheme, BadgeThemeData, ActionIconTheme, ActionIconThemeData, TextSelectionTheme, TextSelectionThemeData, ScrollbarTheme, ScrollbarThemeData, MaterialBannerTheme, MaterialBannerThemeData, PageTransitionsTheme, PageTransitionsBuilder from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Misc themes test executing');

  // ========== EXPANSION TILE THEME DATA ==========
  print('--- ExpansionTileThemeData Tests ---');

  final expansionTileThemeData = ExpansionTileThemeData(
    backgroundColor: Colors.grey.shade50,
    collapsedBackgroundColor: Colors.white,
    tilePadding: EdgeInsets.symmetric(horizontal: 16.0),
    expandedAlignment: Alignment.centerLeft,
    childrenPadding: EdgeInsets.all(16.0),
    iconColor: Colors.blue,
    collapsedIconColor: Colors.grey,
    textColor: Colors.blue,
    collapsedTextColor: Colors.black87,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    collapsedShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    clipBehavior: Clip.antiAlias,
  );
  print('ExpansionTileThemeData created');
  print('  backgroundColor: ${expansionTileThemeData.backgroundColor}');
  print(
    '  collapsedBackgroundColor: ${expansionTileThemeData.collapsedBackgroundColor}',
  );
  print('  iconColor: ${expansionTileThemeData.iconColor}');
  print('  collapsedIconColor: ${expansionTileThemeData.collapsedIconColor}');
  print('  textColor: ${expansionTileThemeData.textColor}');
  print('  collapsedTextColor: ${expansionTileThemeData.collapsedTextColor}');
  print('  clipBehavior: ${expansionTileThemeData.clipBehavior}');
  print('  shape: ${expansionTileThemeData.shape}');

  // Test copyWith
  final copiedExpansionTileTheme = expansionTileThemeData.copyWith(
    backgroundColor: Colors.blue.shade50,
    iconColor: Colors.indigo,
  );
  print('ExpansionTileThemeData.copyWith created');
  print('  new backgroundColor: ${copiedExpansionTileTheme.backgroundColor}');
  print('  new iconColor: ${copiedExpansionTileTheme.iconColor}');

  // ========== SEGMENTED BUTTON THEME DATA ==========
  print('--- SegmentedButtonThemeData Tests ---');

  final segmentedButtonThemeData = SegmentedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return Colors.blue;
        return Colors.transparent;
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return Colors.white;
        return Colors.black87;
      }),
      side: WidgetStateProperty.all(BorderSide(color: Colors.blue)),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
      padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 16.0)),
    ),
    selectedIcon: Icon(Icons.check, size: 18.0),
  );
  print('SegmentedButtonThemeData created');
  print('  style: ${segmentedButtonThemeData.style}');
  print('  selectedIcon: ${segmentedButtonThemeData.selectedIcon}');

  // Test copyWith
  final copiedSegmentedTheme = segmentedButtonThemeData.copyWith(
    selectedIcon: Icon(Icons.done, size: 20.0),
  );
  print('SegmentedButtonThemeData.copyWith created');
  print('  new selectedIcon: ${copiedSegmentedTheme.selectedIcon}');

  // ========== BADGE THEME DATA ==========
  print('--- BadgeThemeData Tests ---');

  final badgeThemeData = BadgeThemeData(
    backgroundColor: Colors.red,
    textColor: Colors.white,
    smallSize: 6.0,
    largeSize: 16.0,
    textStyle: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w500),
    padding: EdgeInsets.symmetric(horizontal: 4.0),
    alignment: AlignmentDirectional.topEnd,
    offset: Offset(4.0, -4.0),
  );
  print('BadgeThemeData created');
  print('  backgroundColor: ${badgeThemeData.backgroundColor}');
  print('  textColor: ${badgeThemeData.textColor}');
  print('  smallSize: ${badgeThemeData.smallSize}');
  print('  largeSize: ${badgeThemeData.largeSize}');
  print('  alignment: ${badgeThemeData.alignment}');
  print('  offset: ${badgeThemeData.offset}');

  // Test copyWith
  final copiedBadgeTheme = badgeThemeData.copyWith(
    backgroundColor: Colors.orange,
    largeSize: 20.0,
  );
  print('BadgeThemeData.copyWith created');
  print('  new backgroundColor: ${copiedBadgeTheme.backgroundColor}');
  print('  new largeSize: ${copiedBadgeTheme.largeSize}');

  // ========== ACTION ICON THEME DATA ==========
  print('--- ActionIconThemeData Tests ---');

  final actionIconThemeData = ActionIconThemeData(
    backButtonIconBuilder: (context) => Icon(Icons.arrow_back_ios, size: 20.0),
    closeButtonIconBuilder: (context) => Icon(Icons.close, size: 20.0),
    drawerButtonIconBuilder: (context) => Icon(Icons.menu, size: 24.0),
    endDrawerButtonIconBuilder: (context) => Icon(Icons.menu_open, size: 24.0),
  );
  print('ActionIconThemeData created');
  print(
    '  backButtonIconBuilder: ${actionIconThemeData.backButtonIconBuilder}',
  );
  print(
    '  closeButtonIconBuilder: ${actionIconThemeData.closeButtonIconBuilder}',
  );
  print(
    '  drawerButtonIconBuilder: ${actionIconThemeData.drawerButtonIconBuilder}',
  );
  print(
    '  endDrawerButtonIconBuilder: ${actionIconThemeData.endDrawerButtonIconBuilder}',
  );

  // Test copyWith
  final copiedActionIconTheme = actionIconThemeData.copyWith(
    backButtonIconBuilder: (context) => Icon(Icons.arrow_back, size: 24.0),
  );
  print('ActionIconThemeData.copyWith created');
  print(
    '  new backButtonIconBuilder: ${copiedActionIconTheme.backButtonIconBuilder}',
  );

  // ========== TEXT SELECTION THEME DATA ==========
  print('--- TextSelectionThemeData Tests ---');

  final textSelectionThemeData = TextSelectionThemeData(
    cursorColor: Colors.blue,
    selectionColor: Colors.blue.shade100,
    selectionHandleColor: Colors.blue.shade700,
  );
  print('TextSelectionThemeData created');
  print('  cursorColor: ${textSelectionThemeData.cursorColor}');
  print('  selectionColor: ${textSelectionThemeData.selectionColor}');
  print(
    '  selectionHandleColor: ${textSelectionThemeData.selectionHandleColor}',
  );

  // Test copyWith
  final copiedTextSelectionTheme = textSelectionThemeData.copyWith(
    cursorColor: Colors.green,
  );
  print('TextSelectionThemeData.copyWith created');
  print('  new cursorColor: ${copiedTextSelectionTheme.cursorColor}');
  print(
    '  selectionColor preserved: ${copiedTextSelectionTheme.selectionColor}',
  );

  // ========== SCROLLBAR THEME DATA ==========
  print('--- ScrollbarThemeData Tests ---');

  final scrollbarThemeData = ScrollbarThemeData(
    thumbColor: WidgetStateProperty.all(Colors.grey.shade500),
    trackColor: WidgetStateProperty.all(Colors.grey.shade200),
    trackBorderColor: WidgetStateProperty.all(Colors.transparent),
    thickness: WidgetStateProperty.all(8.0),
    radius: Radius.circular(4.0),
    crossAxisMargin: 2.0,
    mainAxisMargin: 0.0,
    minThumbLength: 48.0,
    interactive: true,
    thumbVisibility: WidgetStateProperty.all(true),
    trackVisibility: WidgetStateProperty.all(false),
  );
  print('ScrollbarThemeData created');
  print('  radius: ${scrollbarThemeData.radius}');
  print('  crossAxisMargin: ${scrollbarThemeData.crossAxisMargin}');
  print('  mainAxisMargin: ${scrollbarThemeData.mainAxisMargin}');
  print('  minThumbLength: ${scrollbarThemeData.minThumbLength}');
  print('  interactive: ${scrollbarThemeData.interactive}');

  // Test copyWith
  final copiedScrollbarTheme = scrollbarThemeData.copyWith(
    radius: Radius.circular(8.0),
    interactive: false,
  );
  print('ScrollbarThemeData.copyWith created');
  print('  new radius: ${copiedScrollbarTheme.radius}');
  print('  new interactive: ${copiedScrollbarTheme.interactive}');

  // ========== MATERIAL BANNER THEME DATA ==========
  print('--- MaterialBannerThemeData Tests ---');

  final bannerThemeData = MaterialBannerThemeData(
    backgroundColor: Colors.yellow.shade50,
    surfaceTintColor: Colors.yellow.shade100,
    shadowColor: Colors.black12,
    dividerColor: Colors.yellow.shade200,
    contentTextStyle: TextStyle(fontSize: 14.0, color: Colors.black87),
    elevation: 0.0,
    padding: EdgeInsets.all(16.0),
    leadingPadding: EdgeInsets.only(right: 16.0),
  );
  print('MaterialBannerThemeData created');
  print('  backgroundColor: ${bannerThemeData.backgroundColor}');
  print('  surfaceTintColor: ${bannerThemeData.surfaceTintColor}');
  print('  dividerColor: ${bannerThemeData.dividerColor}');
  print('  elevation: ${bannerThemeData.elevation}');
  print('  padding: ${bannerThemeData.padding}');
  print('  leadingPadding: ${bannerThemeData.leadingPadding}');

  // Test copyWith
  final copiedBannerTheme = bannerThemeData.copyWith(
    backgroundColor: Colors.orange.shade50,
    elevation: 2.0,
  );
  print('MaterialBannerThemeData.copyWith created');
  print('  new backgroundColor: ${copiedBannerTheme.backgroundColor}');
  print('  new elevation: ${copiedBannerTheme.elevation}');

  // ========== PAGE TRANSITIONS THEME ==========
  print('--- PageTransitionsTheme Tests ---');

  final fadeBuilder = FadeUpwardsPageTransitionsBuilder();
  print('FadeUpwardsPageTransitionsBuilder created');

  final openUpwardsBuilder = OpenUpwardsPageTransitionsBuilder();
  print('OpenUpwardsPageTransitionsBuilder created');

  final zoomBuilder = ZoomPageTransitionsBuilder();
  print('ZoomPageTransitionsBuilder created');

  final predictiveBackBuilder = PredictiveBackPageTransitionsBuilder();
  print('PredictiveBackPageTransitionsBuilder created');

  final pageTransitionsTheme = PageTransitionsTheme(
    builders: {
      TargetPlatform.android: zoomBuilder,
      TargetPlatform.iOS: fadeBuilder,
      TargetPlatform.macOS: fadeBuilder,
      TargetPlatform.linux: openUpwardsBuilder,
      TargetPlatform.windows: openUpwardsBuilder,
    },
  );
  print('PageTransitionsTheme created');
  print('  builders count: ${pageTransitionsTheme.builders.length}');
  print(
    '  android builder: ${pageTransitionsTheme.builders[TargetPlatform.android]}',
  );
  print('  iOS builder: ${pageTransitionsTheme.builders[TargetPlatform.iOS]}');

  // ========== WRAP IN THEME WIDGET ==========
  print('--- Theme Integration ---');

  final themeData = ThemeData(
    expansionTileTheme: expansionTileThemeData,
    segmentedButtonTheme: segmentedButtonThemeData,
    badgeTheme: badgeThemeData,
    actionIconTheme: actionIconThemeData,
    textSelectionTheme: textSelectionThemeData,
    scrollbarTheme: scrollbarThemeData,
    bannerTheme: bannerThemeData,
    pageTransitionsTheme: pageTransitionsTheme,
  );
  print('ThemeData with misc themes created');

  return Theme(
    data: themeData,
    child: Builder(
      builder: (ctx) {
        final resolvedTheme = Theme.of(ctx);
        print('Theme.of resolved');
        print(
          '  expansionTileTheme.iconColor: ${resolvedTheme.expansionTileTheme.iconColor}',
        );
        print(
          '  badgeTheme.backgroundColor: ${resolvedTheme.badgeTheme.backgroundColor}',
        );
        print(
          '  textSelectionTheme.cursorColor: ${resolvedTheme.textSelectionTheme.cursorColor}',
        );
        print(
          '  scrollbarTheme.interactive: ${resolvedTheme.scrollbarTheme.interactive}',
        );
        print(
          '  bannerTheme.backgroundColor: ${resolvedTheme.bannerTheme.backgroundColor}',
        );

        return ExpansionTileTheme(
          data: expansionTileThemeData,
          child: SegmentedButtonTheme(
            data: segmentedButtonThemeData,
            child: BadgeTheme(
              data: badgeThemeData,
              child: TextSelectionTheme(
                data: textSelectionThemeData,
                child: ScrollbarTheme(
                  data: scrollbarThemeData,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Badge(label: Text('3'), child: Icon(Icons.mail)),
                      SizedBox(height: 8.0),
                      Text('Misc themes test passed'),
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
