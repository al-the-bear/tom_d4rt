// D4rt test script: Tests MenuStyle styling class from material
import 'package:flutter/material.dart';

Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.indigo.shade700,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}

Widget buildInfoCard(String label, String value) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Row(
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
          ),
        ),
      ],
    ),
  );
}

Widget buildDescriptionBox(String text) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.indigo.shade50,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.indigo.shade200),
    ),
    child: Text(
      text,
      style: TextStyle(fontSize: 14, color: Colors.indigo.shade900),
    ),
  );
}

Widget buildOverviewSection() {
  print('Building overview section for MenuStyle');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.style, color: Colors.indigo, size: 28),
            SizedBox(width: 12),
            Text(
              'MenuStyle',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        buildDescriptionBox(
          'MenuStyle describes the visual properties of menus in Flutter. It controls '
          'appearance attributes like backgroundColor, elevation, padding, shape, shadow, '
          'and more. MenuStyle is used by MenuAnchor, DropdownMenu, and MenuBar widgets '
          'to customize their popup menu appearance.',
        ),
        SizedBox(height: 12),
        buildInfoCard('Type', 'Immutable styling class'),
        buildInfoCard('Used By', 'MenuAnchor, DropdownMenu, MenuBar'),
        buildInfoCard('Properties', 'WidgetStateProperty-based for state handling'),
        buildInfoCard('Purpose', 'Define visual styling for popup menus'),
      ],
    ),
  );
}

Widget buildBackgroundColorSection() {
  print('Building MenuStyle backgroundColor section');
  
  MenuStyle lightStyle = MenuStyle(
    backgroundColor: WidgetStateProperty.all(Colors.white),
    elevation: WidgetStateProperty.all(4.0),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );
  
  MenuStyle blueStyle = MenuStyle(
    backgroundColor: WidgetStateProperty.all(Colors.blue.shade50),
    elevation: WidgetStateProperty.all(4.0),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );
  
  MenuStyle darkStyle = MenuStyle(
    backgroundColor: WidgetStateProperty.all(Colors.grey.shade900),
    elevation: WidgetStateProperty.all(4.0),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'MenuStyle with backgroundColor',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Customize the menu background color',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Icon(Icons.light_mode, color: Colors.grey),
                    SizedBox(height: 8),
                    Text('Light', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue.shade200),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Icon(Icons.water_drop, color: Colors.blue),
                    SizedBox(height: 8),
                    Text('Blue', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Icon(Icons.dark_mode, color: Colors.white),
                    SizedBox(height: 8),
                    Text('Dark', style: TextStyle(fontSize: 12, color: Colors.white)),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        buildInfoCard('Property', 'backgroundColor'),
        buildInfoCard('Type', 'WidgetStateProperty<Color?>'),
        buildInfoCard('Usage', 'WidgetStateProperty.all(Color)'),
      ],
    ),
  );
}

Widget buildElevationSection() {
  print('Building MenuStyle elevation section');
  
  List<double> elevations = [0, 4, 8, 16];
  
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'MenuStyle with elevation',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Control the shadow depth of menus',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: elevations.map((elevation) {
            return Column(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15 + (elevation * 0.01)),
                        blurRadius: elevation,
                        spreadRadius: elevation / 4,
                        offset: Offset(0, elevation / 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(Icons.menu, color: Colors.indigo),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '${elevation.toInt()}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo.shade700,
                  ),
                ),
              ],
            );
          }).toList(),
        ),
        SizedBox(height: 16),
        buildInfoCard('Property', 'elevation'),
        buildInfoCard('Type', 'WidgetStateProperty<double?>'),
        buildInfoCard('Default', '3.0 (Material 3)'),
      ],
    ),
  );
}

Widget buildPaddingSection() {
  print('Building MenuStyle padding section');
  
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'MenuStyle with padding',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Adjust internal spacing within the menu',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.indigo.shade200),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 30,
                          color: Colors.indigo.shade100,
                          child: Center(child: Text('Item', style: TextStyle(fontSize: 11))),
                        ),
                        Container(
                          height: 30,
                          color: Colors.indigo.shade200,
                          child: Center(child: Text('Item', style: TextStyle(fontSize: 11))),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('Padding: 4', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.indigo.shade200),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 30,
                          color: Colors.indigo.shade100,
                          child: Center(child: Text('Item', style: TextStyle(fontSize: 11))),
                        ),
                        Container(
                          height: 30,
                          color: Colors.indigo.shade200,
                          child: Center(child: Text('Item', style: TextStyle(fontSize: 11))),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('Padding: 12', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.indigo.shade200),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 30,
                          color: Colors.indigo.shade100,
                          child: Center(child: Text('Item', style: TextStyle(fontSize: 11))),
                        ),
                        Container(
                          height: 30,
                          color: Colors.indigo.shade200,
                          child: Center(child: Text('Item', style: TextStyle(fontSize: 11))),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('Padding: 20', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        buildInfoCard('Property', 'padding'),
        buildInfoCard('Type', 'WidgetStateProperty<EdgeInsetsGeometry?>'),
        buildInfoCard('Usage', 'EdgeInsets.symmetric(), EdgeInsets.all()'),
      ],
    ),
  );
}

Widget buildShapeBorderRadiusSection() {
  print('Building MenuStyle shape/borderRadius section');
  
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'MenuStyle with shape/borderRadius',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Define the outline and corner styling of menus',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade100,
                    borderRadius: BorderRadius.circular(0),
                    border: Border.all(color: Colors.indigo.shade400),
                  ),
                  child: Center(child: Icon(Icons.crop_square, color: Colors.indigo)),
                ),
                SizedBox(height: 8),
                Text('0 radius', style: TextStyle(fontSize: 11)),
              ],
            ),
            Column(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.indigo.shade400),
                  ),
                  child: Center(child: Icon(Icons.rounded_corner, color: Colors.indigo)),
                ),
                SizedBox(height: 8),
                Text('8 radius', style: TextStyle(fontSize: 11)),
              ],
            ),
            Column(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade100,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.indigo.shade400),
                  ),
                  child: Center(child: Icon(Icons.panorama_fish_eye, color: Colors.indigo)),
                ),
                SizedBox(height: 8),
                Text('20 radius', style: TextStyle(fontSize: 11)),
              ],
            ),
            Column(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade100,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.indigo.shade400),
                  ),
                  child: Center(child: Icon(Icons.circle, color: Colors.indigo)),
                ),
                SizedBox(height: 8),
                Text('Stadium', style: TextStyle(fontSize: 11)),
              ],
            ),
          ],
        ),
        SizedBox(height: 16),
        buildInfoCard('Property', 'shape'),
        buildInfoCard('Type', 'WidgetStateProperty<OutlinedBorder?>'),
        buildInfoCard('Options', 'RoundedRectangleBorder, StadiumBorder, CircleBorder'),
      ],
    ),
  );
}

Widget buildShadowColorSection() {
  print('Building MenuStyle shadowColor section');
  
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'MenuStyle with shadowColor',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Customize the color of the menu shadow',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(child: Icon(Icons.menu, color: Colors.grey)),
                ),
                SizedBox(height: 8),
                Text('Black', style: TextStyle(fontSize: 11)),
              ],
            ),
            Column(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.indigo.withValues(alpha: 0.4),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(child: Icon(Icons.menu, color: Colors.indigo)),
                ),
                SizedBox(height: 8),
                Text('Indigo', style: TextStyle(fontSize: 11)),
              ],
            ),
            Column(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withValues(alpha: 0.4),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(child: Icon(Icons.menu, color: Colors.green)),
                ),
                SizedBox(height: 8),
                Text('Green', style: TextStyle(fontSize: 11)),
              ],
            ),
            Column(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withValues(alpha: 0.4),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(child: Icon(Icons.menu, color: Colors.red)),
                ),
                SizedBox(height: 8),
                Text('Red', style: TextStyle(fontSize: 11)),
              ],
            ),
          ],
        ),
        SizedBox(height: 16),
        buildInfoCard('Property', 'shadowColor'),
        buildInfoCard('Type', 'WidgetStateProperty<Color?>'),
        buildInfoCard('Effect', 'Colors the shadow beneath the menu'),
      ],
    ),
  );
}

Widget buildSurfaceTintColorSection() {
  print('Building MenuStyle surfaceTintColor section');
  
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'MenuStyle with surfaceTintColor',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Apply a tint overlay to the menu surface (Material 3)',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        buildDescriptionBox(
          'surfaceTintColor blends with backgroundColor to create elevation-based '
          'tinting in Material 3. Higher elevations result in more tint applied to '
          'the surface. Set to Colors.transparent to disable tinting.',
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Container(
                  width: 80,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Center(
                    child: Text('None', style: TextStyle(fontSize: 11)),
                  ),
                ),
                SizedBox(height: 8),
                Text('transparent', style: TextStyle(fontSize: 10)),
              ],
            ),
            Column(
              children: [
                Container(
                  width: 80,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Color.lerp(Colors.white, Colors.indigo, 0.05),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.indigo.shade100),
                  ),
                  child: Center(
                    child: Text('Light', style: TextStyle(fontSize: 11)),
                  ),
                ),
                SizedBox(height: 8),
                Text('indigo (low)', style: TextStyle(fontSize: 10)),
              ],
            ),
            Column(
              children: [
                Container(
                  width: 80,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Color.lerp(Colors.white, Colors.indigo, 0.15),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.indigo.shade200),
                  ),
                  child: Center(
                    child: Text('Medium', style: TextStyle(fontSize: 11, color: Colors.white)),
                  ),
                ),
                SizedBox(height: 8),
                Text('indigo (high)', style: TextStyle(fontSize: 10)),
              ],
            ),
          ],
        ),
        SizedBox(height: 12),
        buildInfoCard('Property', 'surfaceTintColor'),
        buildInfoCard('Type', 'WidgetStateProperty<Color?>'),
        buildInfoCard('Material 3', 'Creates elevation-based surface tinting'),
      ],
    ),
  );
}

Widget buildMenuAnchorSection() {
  print('Building MenuAnchor using MenuStyle section');
  
  MenuStyle customMenuStyle = MenuStyle(
    backgroundColor: WidgetStateProperty.all(Colors.indigo.shade50),
    elevation: WidgetStateProperty.all(8.0),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    padding: WidgetStateProperty.all(EdgeInsets.symmetric(vertical: 8)),
  );
  
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'MenuAnchor using MenuStyle',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Apply MenuStyle to a MenuAnchor widget',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'MenuAnchor Example Structure',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 12),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'MenuAnchor(\n'
                  '  style: MenuStyle(\n'
                  '    backgroundColor: WSP.all(Colors.indigo),\n'
                  '    elevation: WSP.all(8.0),\n'
                  '    shape: WSP.all(RoundedRectangleBorder(\n'
                  '      borderRadius: BorderRadius.circular(12),\n'
                  '    )),\n'
                  '  ),\n'
                  '  menuChildren: [...],\n'
                  '  builder: (context, controller, child) => ...,\n'
                  ')',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    color: Colors.green.shade300,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.indigo.shade200),
                ),
                child: Column(
                  children: [
                    Icon(Icons.touch_app, color: Colors.indigo, size: 32),
                    SizedBox(height: 8),
                    Text('Anchor Button', style: TextStyle(fontSize: 12)),
                    SizedBox(height: 4),
                    Text(
                      'Click to open menu',
                      style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 8),
            Icon(Icons.arrow_forward, color: Colors.grey),
            SizedBox(width: 8),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade50,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.edit, size: 16, color: Colors.indigo),
                        SizedBox(width: 8),
                        Text('Edit', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                    Divider(height: 8),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.delete, size: 16, color: Colors.indigo),
                        SizedBox(width: 8),
                        Text('Delete', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        buildInfoCard('Widget', 'MenuAnchor'),
        buildInfoCard('Style Property', 'style: MenuStyle'),
        buildInfoCard('Purpose', 'Popup menu attached to an anchor widget'),
      ],
    ),
  );
}

Widget buildDropdownMenuSection() {
  print('Building DropdownMenu using MenuStyle section');
  
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'DropdownMenu using MenuStyle',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Style the dropdown popup menu in DropdownMenu',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'DropdownMenu Example Structure',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 12),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'DropdownMenu<String>(\n'
                  '  menuStyle: MenuStyle(\n'
                  '    backgroundColor: WSP.all(Colors.white),\n'
                  '    elevation: WSP.all(6.0),\n'
                  '    shape: WSP.all(RoundedRectangleBorder(\n'
                  '      borderRadius: BorderRadius.circular(8),\n'
                  '    )),\n'
                  '  ),\n'
                  '  dropdownMenuEntries: [...],\n'
                  '  onSelected: (value) => ...,\n'
                  ')',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    color: Colors.green.shade300,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Select option', style: TextStyle(color: Colors.grey.shade600)),
                    Icon(Icons.arrow_drop_down, color: Colors.grey),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                color: Colors.indigo.shade50,
                child: Text('Option 1'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Text('Option 2'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Text('Option 3'),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        buildInfoCard('Widget', 'DropdownMenu'),
        buildInfoCard('Style Property', 'menuStyle: MenuStyle'),
        buildInfoCard('Purpose', 'Filterable dropdown with text field'),
      ],
    ),
  );
}

Widget buildMultipleMenusComparisonSection() {
  print('Building multiple styled menus comparison section');
  
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Multiple Styled Menus Comparison',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Compare different MenuStyle configurations side by side',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Default',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildMiniMenuItem('New'),
                        _buildMiniMenuItem('Open'),
                        _buildMiniMenuItem('Save'),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'elevation: 3\nradius: 4',
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Elevated',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo.shade700,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade50,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.indigo.withValues(alpha: 0.3),
                          blurRadius: 12,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        children: [
                          _buildStyledMenuItem('New', Colors.indigo),
                          _buildStyledMenuItem('Open', Colors.indigo),
                          _buildStyledMenuItem('Save', Colors.indigo),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'elevation: 12\nradius: 12',
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Bordered',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade700,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.teal, width: 2),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Column(
                        children: [
                          _buildStyledMenuItem('New', Colors.teal),
                          _buildStyledMenuItem('Open', Colors.teal),
                          _buildStyledMenuItem('Save', Colors.teal),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'elevation: 0\nborder: 2px',
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        buildInfoCard('Comparison', '3 different MenuStyle configurations'),
        buildInfoCard('Key Differences', 'elevation, shape, background, borders'),
      ],
    ),
  );
}

Widget _buildMiniMenuItem(String text) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    child: Text(text, style: TextStyle(fontSize: 12)),
  );
}

Widget _buildStyledMenuItem(String text, MaterialColor color) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    child: Row(
      children: [
        Icon(Icons.circle, size: 8, color: color),
        SizedBox(width: 8),
        Text(text, style: TextStyle(fontSize: 12, color: color.shade700)),
      ],
    ),
  );
}

Widget buildPropertiesGridSection() {
  print('Building MenuStyle properties grid section');
  
  List<Map<String, String>> properties = [
    {'name': 'backgroundColor', 'type': 'Color?', 'desc': 'Surface color'},
    {'name': 'shadowColor', 'type': 'Color?', 'desc': 'Shadow color'},
    {'name': 'surfaceTintColor', 'type': 'Color?', 'desc': 'M3 tint overlay'},
    {'name': 'elevation', 'type': 'double?', 'desc': 'Shadow depth'},
    {'name': 'padding', 'type': 'EdgeInsetsGeometry?', 'desc': 'Inner spacing'},
    {'name': 'minimumSize', 'type': 'Size?', 'desc': 'Minimum dimensions'},
    {'name': 'maximumSize', 'type': 'Size?', 'desc': 'Maximum dimensions'},
    {'name': 'side', 'type': 'BorderSide?', 'desc': 'Border styling'},
    {'name': 'shape', 'type': 'OutlinedBorder?', 'desc': 'Shape/corners'},
    {'name': 'alignment', 'type': 'AlignmentGeometry?', 'desc': 'Content align'},
  ];
  
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'MenuStyle Properties Grid',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'All available MenuStyle properties at a glance',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade700,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(7),
                    topRight: Radius.circular(7),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        'Property',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Type',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        'Description',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ...properties.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, String> prop = entry.value;
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: index % 2 == 0 ? Colors.white : Colors.grey.shade50,
                    border: Border(
                      top: BorderSide(color: Colors.grey.shade200),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          prop['name']!,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 11,
                            color: Colors.indigo.shade800,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          prop['type']!,
                          style: TextStyle(
                            fontSize: 11,
                            fontFamily: 'monospace',
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          prop['desc']!,
                          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),
        SizedBox(height: 12),
        buildDescriptionBox(
          'All properties use WidgetStateProperty<T> allowing state-based styling '
          '(pressed, hovered, focused, disabled). Use WidgetStateProperty.all() for '
          'constant values or WidgetStateProperty.resolveWith() for state-dependent values.',
        ),
      ],
    ),
  );
}

Widget buildCopyWithSection() {
  print('Building MenuStyle.copyWith section');
  
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'MenuStyle.copyWith() Usage',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Create modified copies of MenuStyle',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'MenuStyle baseStyle = MenuStyle(\n'
            '  backgroundColor: WSP.all(Colors.white),\n'
            '  elevation: WSP.all(4.0),\n'
            ');\n\n'
            'MenuStyle modifiedStyle = baseStyle.copyWith(\n'
            '  backgroundColor: WSP.all(Colors.blue.shade50),\n'
            '  elevation: WSP.all(8.0),\n'
            ');',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: Colors.green.shade300,
            ),
          ),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text('Base', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Icon(Icons.menu, color: Colors.grey),
                    Text('elevation: 4', style: TextStyle(fontSize: 10)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Icon(Icons.arrow_forward, color: Colors.grey),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text('Modified', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Icon(Icons.menu, color: Colors.blue),
                    Text('elevation: 8', style: TextStyle(fontSize: 10)),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        buildInfoCard('Method', 'MenuStyle.copyWith()'),
        buildInfoCard('Returns', 'New MenuStyle with specified overrides'),
        buildInfoCard('Use Case', 'Deriving variations from a base style'),
      ],
    ),
  );
}

Widget buildMergeSection() {
  print('Building MenuStyle.merge section');
  
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'MenuStyle.merge() Usage',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Combine two MenuStyle objects',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        buildDescriptionBox(
          'MenuStyle.merge() combines two styles where the second style overrides '
          'properties from the first. Useful for applying theme defaults with custom overrides.',
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'MenuStyle themeStyle = MenuStyle(\n'
            '  backgroundColor: WSP.all(Colors.white),\n'
            '  elevation: WSP.all(4.0),\n'
            '  padding: WSP.all(EdgeInsets.all(8)),\n'
            ');\n\n'
            'MenuStyle customStyle = MenuStyle(\n'
            '  backgroundColor: WSP.all(Colors.indigo.shade50),\n'
            ');\n\n'
            'MenuStyle merged = MenuStyle.merge(\n'
            '  themeStyle,\n'
            '  customStyle,\n'
            '); // bg=indigo, elev=4, pad=8',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: Colors.green.shade300,
            ),
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  children: [
                    Text('Theme', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                    Container(
                      margin: EdgeInsets.only(top: 4),
                      height: 30,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: Icon(Icons.add, size: 18, color: Colors.grey),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade50,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.indigo.shade200),
                ),
                child: Column(
                  children: [
                    Text('Custom', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                    Container(
                      margin: EdgeInsets.only(top: 4),
                      height: 30,
                      color: Colors.indigo.shade100,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: Icon(Icons.arrow_forward, size: 18, color: Colors.grey),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade50,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.indigo.shade300),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text('Merged', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                    Container(
                      margin: EdgeInsets.only(top: 4),
                      height: 30,
                      color: Colors.indigo.shade100,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        buildInfoCard('Method', 'MenuStyle.merge(style1, style2)'),
        buildInfoCard('Behavior', 'style2 properties override style1'),
        buildInfoCard('Use Case', 'Theme defaults + localized overrides'),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('Building MenuStyle demo');
  return Scaffold(
    appBar: AppBar(
      title: Text('MenuStyle Demo'),
      backgroundColor: Colors.indigo.shade700,
      foregroundColor: Colors.white,
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSectionHeader('1. Overview of MenuStyle'),
          buildOverviewSection(),
          buildSectionHeader('2. MenuStyle with backgroundColor'),
          buildBackgroundColorSection(),
          buildSectionHeader('3. MenuStyle with elevation'),
          buildElevationSection(),
          buildSectionHeader('4. MenuStyle with padding'),
          buildPaddingSection(),
          buildSectionHeader('5. MenuStyle with shape/borderRadius'),
          buildShapeBorderRadiusSection(),
          buildSectionHeader('6. MenuStyle with shadowColor'),
          buildShadowColorSection(),
          buildSectionHeader('7. MenuStyle with surfaceTintColor'),
          buildSurfaceTintColorSection(),
          buildSectionHeader('8. MenuAnchor using MenuStyle'),
          buildMenuAnchorSection(),
          buildSectionHeader('9. DropdownMenu using MenuStyle'),
          buildDropdownMenuSection(),
          buildSectionHeader('10. Multiple Styled Menus Comparison'),
          buildMultipleMenusComparisonSection(),
          buildSectionHeader('11. MenuStyle Properties Grid'),
          buildPropertiesGridSection(),
          buildSectionHeader('12. MenuStyle.copyWith() Usage'),
          buildCopyWithSection(),
          buildSectionHeader('13. MenuStyle.merge() Usage'),
          buildMergeSection(),
          SizedBox(height: 32),
        ],
      ),
    ),
  );
}
