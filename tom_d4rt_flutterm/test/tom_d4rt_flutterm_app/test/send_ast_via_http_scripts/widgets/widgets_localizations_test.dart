// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests WidgetsLocalizations from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('WidgetsLocalizations test executing');
  print('=' * 50);

  // WidgetsLocalizations for widgets text direction
  print('WidgetsLocalizations overview:');
  print('  - Abstract class for widget localization');
  print('  - Provides textDirection for widgets layer');
  print('  - Used by Directionality widget');

  // Access via context
  print('\nAccessing WidgetsLocalizations:');
  final localizations = WidgetsLocalizations.of(context);
  print('  WidgetsLocalizations.of(context): $localizations');

  // Text direction
  print('\nText direction:');
  final textDirection = localizations.textDirection;
  print('  textDirection: $textDirection');
  print('  isLTR: ${textDirection == TextDirection.ltr}');
  print('  isRTL: ${textDirection == TextDirection.rtl}');

  // TextDirection enum values
  print('\nTextDirection values:');
  for (final dir in TextDirection.values) {
    print('  - ${dir.name}');
  }

  // DefaultWidgetsLocalizations
  print('\nDefaultWidgetsLocalizations:');
  print('  - Default implementation');
  print('  - Returns TextDirection.ltr');
  print('  - Used when no Localizations widget');

  // Setup in app
  print('\nSetup in app:');
  print('  MaterialApp(');
  print('    localizationsDelegates: [');
  print('      GlobalWidgetsLocalizations.delegate,');
  print('      GlobalMaterialLocalizations.delegate,');
  print('    ],');
  print('    supportedLocales: [Locale(\'en\'), Locale(\'ar\')],');
  print('  )');

  // Directionality usage
  print('\nDirectionality widget:');
  print('  Directionality(');
  print('    textDirection: TextDirection.rtl,');
  print('    child: MyWidget(),');
  print('  )');

  // Getting direction from context
  print('\nAlternative access:');
  print('  Directionality.of(context)');
  final directionality = Directionality.of(context);
  print('  Result: $directionality');

  // RTL languages
  print('\nRTL languages:');
  print('  - Arabic (ar)');
  print('  - Hebrew (he)');
  print('  - Persian/Farsi (fa)');
  print('  - Urdu (ur)');

  print('\n' + '=' * 50);
  print('WidgetsLocalizations test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'WidgetsLocalizations Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: abstract localization'),
      Text('Property: textDirection'),
      Text('Current: $textDirection'),
    ],
  );
}
