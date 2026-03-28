// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ThemeExtension from material
import 'package:flutter/material.dart';

// Example custom theme extension
class CustomColors extends ThemeExtension<CustomColors> {
  final Color? brandColor;
  final Color? dangerColor;

  const CustomColors({this.brandColor, this.dangerColor});

  @override
  CustomColors copyWith({Color? brandColor, Color? dangerColor}) {
    return CustomColors(
      brandColor: brandColor ?? this.brandColor,
      dangerColor: dangerColor ?? this.dangerColor,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) return this;
    return CustomColors(
      brandColor: Color.lerp(brandColor, other.brandColor, t),
      dangerColor: Color.lerp(dangerColor, other.dangerColor, t),
    );
  }
}

dynamic build(BuildContext context) {
  print('ThemeExtension test executing');
  print('=' * 50);

  // ThemeExtension overview
  print('ThemeExtension overview:');
  print('  - Abstract class for theme extensions');
  print('  - Add custom theme properties');
  print('  - Generic T extends ThemeExtension<T>');

  // Test custom extension
  print('\nTest custom extension:');
  final ext1 = CustomColors(
    brandColor: Colors.blue,
    dangerColor: Colors.red,
  );
  print('  Brand: ${ext1.brandColor}');
  print('  Danger: ${ext1.dangerColor}');

  // Test copyWith
  print('\nTest copyWith:');
  final ext2 = ext1.copyWith(brandColor: Colors.green);
  print('  New brand: ${ext2.brandColor}');
  print('  Danger unchanged: ${ext2.dangerColor}');

  // Test lerp
  print('\nTest lerp:');
  final ext3 = CustomColors(
    brandColor: Colors.purple,
    dangerColor: Colors.orange,
  );
  final lerped = ext1.lerp(ext3, 0.5);
  print('  Lerped type: ${lerped.runtimeType}');

  // Required methods
  print('\nRequired methods:');
  print('  - copyWith: create modified copy');
  print('  - lerp: interpolate between themes');

  // Usage in ThemeData
  print('\nUsage in ThemeData:');
  print('  ThemeData(');
  print('    extensions: [CustomColors(...)],');
  print('  )');

  // Accessing extension
  print('\nAccessing extension:');
  print('  Theme.of(context).extension<CustomColors>()');
  print('  Returns typed extension or null');

  // Best practices
  print('\nBest practices:');
  print('  - Define as immutable @immutable');
  print('  - Implement all colors/values');
  print('  - Use Color.lerp for colors');
  print('  - Handle null in lerp');

  print('\n' + '=' * 50);
  print('ThemeExtension test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ThemeExtension Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Type: Abstract class'),
      Text('Purpose: Custom theme data'),
    ],
  );
}
