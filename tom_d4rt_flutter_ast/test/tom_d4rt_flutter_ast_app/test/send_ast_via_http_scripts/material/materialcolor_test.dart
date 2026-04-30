// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests MaterialColor, MaterialAccentColor from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MaterialColor test executing');

  // ========== MATERIALCOLOR ==========
  print('--- MaterialColor Tests ---');

  // Test predefined MaterialColors
  final primaryBlue = Colors.blue;
  print('Colors.blue: primary=${primaryBlue.value}');

  // Test MaterialColor shade access
  print('Blue shades:');
  print('  shade50: ${Colors.blue.shade50}');
  print('  shade100: ${Colors.blue.shade100}');
  print('  shade200: ${Colors.blue.shade200}');
  print('  shade300: ${Colors.blue.shade300}');
  print('  shade400: ${Colors.blue.shade400}');
  print('  shade500: ${Colors.blue.shade500}');
  print('  shade600: ${Colors.blue.shade600}');
  print('  shade700: ${Colors.blue.shade700}');
  print('  shade800: ${Colors.blue.shade800}');
  print('  shade900: ${Colors.blue.shade900}');

  // Test custom MaterialColor
  final customMaterial = MaterialColor(0xFF4CAF50, <int, Color>{
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
  });
  print('Custom MaterialColor created');
  print('Custom shade500: ${customMaterial.shade500}');
  print('Custom shade100: ${customMaterial.shade100}');
  print('Custom shade900: ${customMaterial.shade900}');

  // Test all predefined MaterialColors
  final redColor = Colors.red;
  final pinkColor = Colors.pink;
  final purpleColor = Colors.purple;
  final deepPurpleColor = Colors.deepPurple;
  final indigoColor = Colors.indigo;
  final blueColor = Colors.blue;
  final lightBlueColor = Colors.lightBlue;
  final cyanColor = Colors.cyan;
  final tealColor = Colors.teal;
  final greenColor = Colors.green;
  final lightGreenColor = Colors.lightGreen;
  final limeColor = Colors.lime;
  final yellowColor = Colors.yellow;
  final amberColor = Colors.amber;
  final orangeColor = Colors.orange;
  final deepOrangeColor = Colors.deepOrange;
  final brownColor = Colors.brown;
  final greyColor = Colors.grey;
  final blueGreyColor = Colors.blueGrey;
  print(
    'All predefined MaterialColors: red=$redColor, pink=$pinkColor, purple=$purpleColor',
  );
  print('deepPurple=$deepPurpleColor, indigo=$indigoColor, blue=$blueColor');
  print('lightBlue=$lightBlueColor, cyan=$cyanColor, teal=$tealColor');
  print('green=$greenColor, lightGreen=$lightGreenColor, lime=$limeColor');
  print('yellow=$yellowColor, amber=$amberColor, orange=$orangeColor');
  print(
    'deepOrange=$deepOrangeColor, brown=$brownColor, grey=$greyColor, blueGrey=$blueGreyColor',
  );

  // ========== MATERIALACCENTCOLOR ==========
  print('--- MaterialAccentColor Tests ---');

  // Test predefined MaterialAccentColors
  final accentBlue = Colors.blueAccent;
  print('Colors.blueAccent: ${accentBlue.value}');

  // Test MaterialAccentColor shade access
  print('Blue accent shades:');
  print('  shade100: ${Colors.blueAccent.shade100}');
  print('  shade200: ${Colors.blueAccent.shade200}');
  print('  shade400: ${Colors.blueAccent.shade400}');
  print('  shade700: ${Colors.blueAccent.shade700}');

  // Test custom MaterialAccentColor
  final customAccent = MaterialAccentColor(0xFF448AFF, <int, Color>{
    100: Color(0xFF82B1FF),
    200: Color(0xFF448AFF),
    400: Color(0xFF2979FF),
    700: Color(0xFF2962FF),
  });
  print('Custom MaterialAccentColor created');
  print('Custom accent shade200: ${customAccent.shade200}');
  print('Custom accent shade400: ${customAccent.shade400}');
  print('Custom accent shade700: ${customAccent.shade700}');

  // Test all predefined MaterialAccentColors
  final redAccent = Colors.redAccent;
  final pinkAccent = Colors.pinkAccent;
  final purpleAccent = Colors.purpleAccent;
  final deepPurpleAccent = Colors.deepPurpleAccent;
  final indigoAccent = Colors.indigoAccent;
  final lightBlueAccent = Colors.lightBlueAccent;
  final cyanAccent = Colors.cyanAccent;
  final tealAccent = Colors.tealAccent;
  final greenAccent = Colors.greenAccent;
  final lightGreenAccent = Colors.lightGreenAccent;
  final limeAccent = Colors.limeAccent;
  final yellowAccent = Colors.yellowAccent;
  final amberAccent = Colors.amberAccent;
  final orangeAccent = Colors.orangeAccent;
  final deepOrangeAccent = Colors.deepOrangeAccent;
  print(
    'All predefined MaterialAccentColors: red=$redAccent, pink=$pinkAccent',
  );
  print(
    'purple=$purpleAccent, deepPurple=$deepPurpleAccent, indigo=$indigoAccent',
  );
  print('lightBlue=$lightBlueAccent, cyan=$cyanAccent, teal=$tealAccent');
  print('green=$greenAccent, lightGreen=$lightGreenAccent, lime=$limeAccent');
  print(
    'yellow=$yellowAccent, amber=$amberAccent, orange=$orangeAccent, deepOrange=$deepOrangeAccent',
  );

  // Test color usage in widgets
  print('--- Color Usage in Widgets ---');

  print('MaterialColor test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'MaterialColor Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),

        Text(
          'MaterialColor Shades (Blue):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            Container(
              width: 50,
              height: 50,
              color: Colors.blue.shade50,
              child: Center(child: Text('50')),
            ),
            Container(
              width: 50,
              height: 50,
              color: Colors.blue.shade100,
              child: Center(child: Text('100')),
            ),
            Container(
              width: 50,
              height: 50,
              color: Colors.blue.shade200,
              child: Center(child: Text('200')),
            ),
            Container(
              width: 50,
              height: 50,
              color: Colors.blue.shade300,
              child: Center(child: Text('300')),
            ),
            Container(
              width: 50,
              height: 50,
              color: Colors.blue.shade400,
              child: Center(
                child: Text('400', style: TextStyle(color: Colors.white)),
              ),
            ),
            Container(
              width: 50,
              height: 50,
              color: Colors.blue.shade500,
              child: Center(
                child: Text('500', style: TextStyle(color: Colors.white)),
              ),
            ),
            Container(
              width: 50,
              height: 50,
              color: Colors.blue.shade600,
              child: Center(
                child: Text('600', style: TextStyle(color: Colors.white)),
              ),
            ),
            Container(
              width: 50,
              height: 50,
              color: Colors.blue.shade700,
              child: Center(
                child: Text('700', style: TextStyle(color: Colors.white)),
              ),
            ),
            Container(
              width: 50,
              height: 50,
              color: Colors.blue.shade800,
              child: Center(
                child: Text('800', style: TextStyle(color: Colors.white)),
              ),
            ),
            Container(
              width: 50,
              height: 50,
              color: Colors.blue.shade900,
              child: Center(
                child: Text('900', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),

        SizedBox(height: 24.0),
        Text(
          'MaterialAccentColor Shades:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            Container(
              width: 60,
              height: 50,
              color: Colors.blueAccent.shade100,
              child: Center(child: Text('100')),
            ),
            Container(
              width: 60,
              height: 50,
              color: Colors.blueAccent.shade200,
              child: Center(
                child: Text('200', style: TextStyle(color: Colors.white)),
              ),
            ),
            Container(
              width: 60,
              height: 50,
              color: Colors.blueAccent.shade400,
              child: Center(
                child: Text('400', style: TextStyle(color: Colors.white)),
              ),
            ),
            Container(
              width: 60,
              height: 50,
              color: Colors.blueAccent.shade700,
              child: Center(
                child: Text('700', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),

        SizedBox(height: 24.0),
        Text(
          'Custom MaterialColor:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            Container(
              width: 50,
              height: 50,
              color: customMaterial.shade50,
              child: Center(child: Text('50')),
            ),
            Container(
              width: 50,
              height: 50,
              color: customMaterial.shade200,
              child: Center(child: Text('200')),
            ),
            Container(
              width: 50,
              height: 50,
              color: customMaterial.shade500,
              child: Center(
                child: Text('500', style: TextStyle(color: Colors.white)),
              ),
            ),
            Container(
              width: 50,
              height: 50,
              color: customMaterial.shade700,
              child: Center(
                child: Text('700', style: TextStyle(color: Colors.white)),
              ),
            ),
            Container(
              width: 50,
              height: 50,
              color: customMaterial.shade900,
              child: Center(
                child: Text('900', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),

        SizedBox(height: 24.0),
        Text(
          'All MaterialColors:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            Container(width: 40, height: 40, color: Colors.red),
            Container(width: 40, height: 40, color: Colors.pink),
            Container(width: 40, height: 40, color: Colors.purple),
            Container(width: 40, height: 40, color: Colors.deepPurple),
            Container(width: 40, height: 40, color: Colors.indigo),
            Container(width: 40, height: 40, color: Colors.blue),
            Container(width: 40, height: 40, color: Colors.lightBlue),
            Container(width: 40, height: 40, color: Colors.cyan),
            Container(width: 40, height: 40, color: Colors.teal),
            Container(width: 40, height: 40, color: Colors.green),
            Container(width: 40, height: 40, color: Colors.lightGreen),
            Container(width: 40, height: 40, color: Colors.lime),
            Container(width: 40, height: 40, color: Colors.yellow),
            Container(width: 40, height: 40, color: Colors.amber),
            Container(width: 40, height: 40, color: Colors.orange),
            Container(width: 40, height: 40, color: Colors.deepOrange),
            Container(width: 40, height: 40, color: Colors.brown),
            Container(width: 40, height: 40, color: Colors.grey),
            Container(width: 40, height: 40, color: Colors.blueGrey),
          ],
        ),

        SizedBox(height: 24.0),
        Text(
          'All MaterialAccentColors:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            Container(width: 40, height: 40, color: Colors.redAccent),
            Container(width: 40, height: 40, color: Colors.pinkAccent),
            Container(width: 40, height: 40, color: Colors.purpleAccent),
            Container(width: 40, height: 40, color: Colors.deepPurpleAccent),
            Container(width: 40, height: 40, color: Colors.indigoAccent),
            Container(width: 40, height: 40, color: Colors.blueAccent),
            Container(width: 40, height: 40, color: Colors.lightBlueAccent),
            Container(width: 40, height: 40, color: Colors.cyanAccent),
            Container(width: 40, height: 40, color: Colors.tealAccent),
            Container(width: 40, height: 40, color: Colors.greenAccent),
            Container(width: 40, height: 40, color: Colors.lightGreenAccent),
            Container(width: 40, height: 40, color: Colors.limeAccent),
            Container(width: 40, height: 40, color: Colors.yellowAccent),
            Container(width: 40, height: 40, color: Colors.amberAccent),
            Container(width: 40, height: 40, color: Colors.orangeAccent),
            Container(width: 40, height: 40, color: Colors.deepOrangeAccent),
          ],
        ),
      ],
    ),
  );
}
