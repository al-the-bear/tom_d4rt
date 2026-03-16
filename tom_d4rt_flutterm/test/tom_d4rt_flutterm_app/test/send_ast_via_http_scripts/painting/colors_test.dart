// D4rt test script: Tests HSLColor, HSVColor, ColorSwatch
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ColorsTest test executing');

  // HSLColor
  final hslColor = HSLColor.fromAHSL(1.0, 210.0, 0.8, 0.5);
  print('HSLColor alpha: ${hslColor.alpha}');
  print('HSLColor hue: ${hslColor.hue}');
  print('HSLColor saturation: ${hslColor.saturation}');
  print('HSLColor lightness: ${hslColor.lightness}');

  final hslToColor = hslColor.toColor();
  print('HSLColor.toColor(): $hslToColor');

  // HSLColor with different values
  final hslRed = HSLColor.fromAHSL(1.0, 0.0, 1.0, 0.5);
  final hslRedColor = hslRed.toColor();
  print('HSLColor red hue=0: $hslRedColor');

  // HSLColor withLightness
  final hslLight = hslColor.withLightness(0.8);
  print('HSLColor withLightness(0.8): ${hslLight.toColor()}');

  // HSVColor
  final hsvColor = HSVColor.fromAHSV(1.0, 120.0, 0.9, 0.8);
  print('HSVColor alpha: ${hsvColor.alpha}');
  print('HSVColor hue: ${hsvColor.hue}');
  print('HSVColor saturation: ${hsvColor.saturation}');
  print('HSVColor value: ${hsvColor.value}');

  final hsvToColor = hsvColor.toColor();
  print('HSVColor.toColor(): $hsvToColor');

  // HSVColor with different values
  final hsvBlue = HSVColor.fromAHSV(1.0, 240.0, 0.7, 0.9);
  final hsvBlueColor = hsvBlue.toColor();
  print('HSVColor blue hue=240: $hsvBlueColor');

  // HSVColor withValue
  final hsvDark = hsvColor.withValue(0.3);
  print('HSVColor withValue(0.3): ${hsvDark.toColor()}');

  // ColorSwatch
  final swatch = ColorSwatch<int>(
    0xFF4CAF50,
    {
      50: Color(0xFFE8F5E9),
      100: Color(0xFFC8E6C9),
      200: Color(0xFFA5D6A7),
      300: Color(0xFF81C784),
      400: Color(0xFF66BB6A),
      500: Color(0xFF4CAF50),
      600: Color(0xFF43A047),
      700: Color(0xFF388E3C),
      800: Color(0xFF2E7D32),
      900: Color(0xFF1B5E20),
    },
  );
  print('ColorSwatch value: $swatch');
  print('ColorSwatch[50]: ${swatch[50]}');
  print('ColorSwatch[500]: ${swatch[500]}');
  print('ColorSwatch[900]: ${swatch[900]}');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 200.0,
        height: 40.0,
        color: hslToColor,
        child: Center(
          child: Text(
            'HSLColor (h:210, s:0.8, l:0.5)',
            style: TextStyle(color: Colors.white, fontSize: 11.0),
          ),
        ),
      ),
      SizedBox(height: 4.0),
      Container(
        width: 200.0,
        height: 40.0,
        color: hslLight.toColor(),
        child: Center(
          child: Text(
            'HSLColor lightness=0.8',
            style: TextStyle(fontSize: 11.0),
          ),
        ),
      ),
      SizedBox(height: 4.0),
      Container(
        width: 200.0,
        height: 40.0,
        color: hsvToColor,
        child: Center(
          child: Text(
            'HSVColor (h:120, s:0.9, v:0.8)',
            style: TextStyle(color: Colors.white, fontSize: 11.0),
          ),
        ),
      ),
      SizedBox(height: 4.0),
      Container(
        width: 200.0,
        height: 40.0,
        color: hsvDark.toColor(),
        child: Center(
          child: Text(
            'HSVColor value=0.3',
            style: TextStyle(color: Colors.white, fontSize: 11.0),
          ),
        ),
      ),
      SizedBox(height: 8.0),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 30.0, height: 30.0, color: swatch[50]),
          Container(width: 30.0, height: 30.0, color: swatch[200]),
          Container(width: 30.0, height: 30.0, color: swatch[400]),
          Container(width: 30.0, height: 30.0, color: swatch[600]),
          Container(width: 30.0, height: 30.0, color: swatch[900]),
        ],
      ),
      SizedBox(height: 4.0),
      Text('ColorSwatch samples', style: TextStyle(fontSize: 11.0)),
    ],
  );
}
