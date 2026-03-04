// D4rt test script: Tests TextTheme, Typography — material text styling
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Material text theme test executing');

  // ========== TextTheme ==========
  print('--- TextTheme Tests ---');

  final textTheme = TextTheme(
    displayLarge: TextStyle(fontSize: 57.0, fontWeight: FontWeight.w400),
    displayMedium: TextStyle(fontSize: 45.0, fontWeight: FontWeight.w400),
    displaySmall: TextStyle(fontSize: 36.0, fontWeight: FontWeight.w400),
    headlineLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w400),
    headlineMedium: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w400),
    headlineSmall: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w400),
    titleLarge: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w500),
    titleMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
    titleSmall: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
    bodyLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
    bodyMedium: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
    bodySmall: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400),
    labelLarge: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
    labelMedium: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500),
    labelSmall: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w500),
  );
  print('TextTheme displayLarge fontSize: ${textTheme.displayLarge!.fontSize}');
  print('TextTheme bodyMedium fontSize: ${textTheme.bodyMedium!.fontSize}');
  print('TextTheme labelSmall fontSize: ${textTheme.labelSmall!.fontSize}');

  // TextTheme copyWith
  final modified = textTheme.copyWith(
    bodyLarge: TextStyle(fontSize: 18.0, color: Colors.blue),
  );
  print('TextTheme copyWith bodyLarge fontSize: ${modified.bodyLarge!.fontSize}');

  // TextTheme apply
  final applied = textTheme.apply(fontSizeFactor: 1.2, bodyColor: Colors.red);
  print('TextTheme apply fontSizeFactor 1.2 displayLarge: ${applied.displayLarge!.fontSize}');

  // TextTheme merge
  final merged = textTheme.merge(TextTheme(
    bodyLarge: TextStyle(color: Colors.green),
  ));
  print('TextTheme merged bodyLarge color: ${merged.bodyLarge!.color}');

  // ========== Typography ==========
  print('--- Typography Tests ---');

  final typography = Typography.material2021();
  print('Typography.material2021 black bodyMedium: ${typography.black.bodyMedium}');
  print('Typography.material2021 white bodyMedium: ${typography.white.bodyMedium}');

  final typographyEn = Typography.material2021(platform: TargetPlatform.android);
  print('Typography.material2021 (android) englishLike bodyLarge: ${typographyEn.englishLike.bodyLarge}');

  final typographyOld = Typography.material2018();
  print('Typography.material2018 black bodyMedium: ${typographyOld.black.bodyMedium}');

  // ========== VisualDensity ==========
  print('--- VisualDensity Tests ---');

  final vdStandard = VisualDensity.standard;
  print('VisualDensity.standard horizontal: ${vdStandard.horizontal}, vertical: ${vdStandard.vertical}');

  final vdCompact = VisualDensity.compact;
  print('VisualDensity.compact horizontal: ${vdCompact.horizontal}, vertical: ${vdCompact.vertical}');

  final vdComfortable = VisualDensity.comfortable;
  print('VisualDensity.comfortable horizontal: ${vdComfortable.horizontal}, vertical: ${vdComfortable.vertical}');

  final vdAdaptive = VisualDensity.adaptivePlatformDensity;
  print('VisualDensity.adaptivePlatformDensity: h=${vdAdaptive.horizontal}, v=${vdAdaptive.vertical}');

  final vdCustom = VisualDensity(horizontal: -2.0, vertical: 1.0);
  print('VisualDensity custom effectiveConstraints: ${vdCustom.effectiveConstraints(BoxConstraints(minWidth: 48.0, minHeight: 48.0))}');

  // ========== MaterialTapTargetSize ==========
  print('--- MaterialTapTargetSize Tests ---');

  print('MaterialTapTargetSize.padded: ${MaterialTapTargetSize.padded}');
  print('MaterialTapTargetSize.shrinkWrap: ${MaterialTapTargetSize.shrinkWrap}');

  print('All material text theme tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Material Text Theme Test',
                style: textTheme.headlineMedium),
            SizedBox(height: 8.0),
            Text('displayLarge', style: textTheme.displayLarge),
            Text('headlineMedium', style: textTheme.headlineMedium),
            Text('titleLarge', style: textTheme.titleLarge),
            Text('bodyLarge', style: textTheme.bodyLarge),
            Text('bodyMedium', style: textTheme.bodyMedium),
            Text('labelSmall', style: textTheme.labelSmall),
            SizedBox(height: 16.0),
            Text('VisualDensity standard: ${vdStandard.horizontal}x${vdStandard.vertical}'),
            Text('VisualDensity compact: ${vdCompact.horizontal}x${vdCompact.vertical}'),
          ],
        ),
      ),
    ),
  );
}
