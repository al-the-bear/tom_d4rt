// D4rt test script: Tests CircleAvatar from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('CircleAvatar test executing');

  // Test basic CircleAvatar with child text
  final avatarBasic = CircleAvatar(
    child: Text('AB'),
  );
  print('CircleAvatar basic with child text created');

  // Test CircleAvatar with backgroundColor
  final avatarBgColor = CircleAvatar(
    backgroundColor: Colors.blue,
    child: Text('BG', style: TextStyle(color: Colors.white)),
  );
  print('CircleAvatar with backgroundColor=blue created');

  // Test CircleAvatar with foregroundColor
  final avatarFgColor = CircleAvatar(
    backgroundColor: Colors.white,
    foregroundColor: Colors.red,
    child: Text('FG'),
  );
  print('CircleAvatar with foregroundColor=red created');

  // Test CircleAvatar with radius
  final avatarRadius = CircleAvatar(
    radius: 40.0,
    backgroundColor: Colors.green,
    child: Text('40', style: TextStyle(color: Colors.white, fontSize: 20.0)),
  );
  print('CircleAvatar with radius=40 created');

  // Test CircleAvatar with small radius
  final avatarSmall = CircleAvatar(
    radius: 16.0,
    backgroundColor: Colors.orange,
    child: Text('S', style: TextStyle(color: Colors.white, fontSize: 10.0)),
  );
  print('CircleAvatar with radius=16 (small) created');

  // Test CircleAvatar with large radius
  final avatarLarge = CircleAvatar(
    radius: 60.0,
    backgroundColor: Colors.purple,
    child: Text('XL', style: TextStyle(color: Colors.white, fontSize: 28.0)),
  );
  print('CircleAvatar with radius=60 (large) created');

  // Test CircleAvatar with minRadius
  final avatarMinRadius = CircleAvatar(
    minRadius: 20.0,
    backgroundColor: Colors.teal,
    child: Text('Min', style: TextStyle(color: Colors.white, fontSize: 10.0)),
  );
  print('CircleAvatar with minRadius=20 created');

  // Test CircleAvatar with maxRadius
  final avatarMaxRadius = CircleAvatar(
    maxRadius: 50.0,
    backgroundColor: Colors.indigo,
    child: Text('Max', style: TextStyle(color: Colors.white, fontSize: 16.0)),
  );
  print('CircleAvatar with maxRadius=50 created');

  // Test CircleAvatar with minRadius and maxRadius
  final avatarMinMax = CircleAvatar(
    minRadius: 25.0,
    maxRadius: 45.0,
    backgroundColor: Colors.brown,
    child: Text('MM', style: TextStyle(color: Colors.white)),
  );
  print('CircleAvatar with minRadius=25, maxRadius=45 created');

  // Test CircleAvatar with Icon child
  final avatarIcon = CircleAvatar(
    backgroundColor: Colors.red,
    child: Icon(Icons.person, color: Colors.white),
  );
  print('CircleAvatar with Icon child created');

  // Test CircleAvatar with multiple icons
  final avatarIcons = CircleAvatar(
    radius: 30.0,
    backgroundColor: Colors.deepPurple,
    child: Icon(Icons.star, color: Colors.yellow, size: 30.0),
  );
  print('CircleAvatar with star icon created');

  // Test CircleAvatar with number
  final avatarNumber = CircleAvatar(
    radius: 20.0,
    backgroundColor: Colors.cyan,
    child: Text('7', style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold)),
  );
  print('CircleAvatar with number child created');

  // Test CircleAvatar with foregroundColor and backgroundColor combined
  final avatarBothColors = CircleAvatar(
    backgroundColor: Colors.black,
    foregroundColor: Colors.amber,
    radius: 30.0,
    child: Text('AB', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
  );
  print('CircleAvatar with both colors created');

  // Test CircleAvatar nested inside ListTile
  final avatarInTile = ListTile(
    leading: CircleAvatar(
      backgroundColor: Colors.blue,
      child: Text('JD', style: TextStyle(color: Colors.white)),
    ),
    title: Text('John Doe'),
    subtitle: Text('john@example.com'),
  );
  print('CircleAvatar in ListTile created');

  print('All CircleAvatar tests completed');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('=== CircleAvatar Tests ===', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
        SizedBox(height: 8.0),
        Text('Basic:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: avatarBasic),
        SizedBox(height: 8.0),
        Text('Background color:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: avatarBgColor),
        SizedBox(height: 8.0),
        Text('Foreground color:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: avatarFgColor),
        SizedBox(height: 8.0),
        Text('Radius=40:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: avatarRadius),
        SizedBox(height: 8.0),
        Text('Small (radius=16):', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: avatarSmall),
        SizedBox(height: 8.0),
        Text('Large (radius=60):', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: avatarLarge),
        SizedBox(height: 8.0),
        Text('MinRadius=20:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: avatarMinRadius),
        SizedBox(height: 8.0),
        Text('MaxRadius=50:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: avatarMaxRadius),
        SizedBox(height: 8.0),
        Text('Min=25, Max=45:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: avatarMinMax),
        SizedBox(height: 8.0),
        Text('Icon child:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: avatarIcon),
        SizedBox(height: 8.0),
        Text('Star icon:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: avatarIcons),
        SizedBox(height: 8.0),
        Text('Number child:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: avatarNumber),
        SizedBox(height: 8.0),
        Text('Both colors:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: avatarBothColors),
        SizedBox(height: 8.0),
        Text('In ListTile:', style: TextStyle(fontWeight: FontWeight.bold)),
        avatarInTile,
        SizedBox(height: 16.0),
        Text('Key Points:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• CircleAvatar displays a circular widget'),
        Text('• backgroundColor sets the circle background'),
        Text('• foregroundColor sets text/icon color'),
        Text('• radius sets exact size, minRadius/maxRadius set range'),
        Text('• child can be Text, Icon, or any widget'),
        Text('• Commonly used in ListTile leading'),
      ],
    ),
  );
}
