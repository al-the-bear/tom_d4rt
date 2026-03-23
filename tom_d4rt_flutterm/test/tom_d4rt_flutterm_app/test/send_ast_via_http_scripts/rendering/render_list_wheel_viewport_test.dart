// ignore_for_file: avoid_print
// Deep demo: RenderListWheelViewport via ListWheelScrollView
// Tests cylindrical wheel-style scrollable lists with various configurations
// Covers diameterRatio, offAxisFraction, magnifier, squeeze, perspective, etc.

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('[ListWheelViewport] Starting deep demo build');

  // -- Helper builders --

  Widget buildHeader() {
    print('[ListWheelViewport] Building header');
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF6A1B9A), Color(0xFF8E24AA), Color(0xFFAB47BC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color(0x406A1B9A),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'RenderListWheelViewport Demo',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Cylindrical wheel-style scrollable lists with ListWheelScrollView',
            style: TextStyle(fontSize: 14, color: Color(0xCCFFFFFF)),
          ),
        ],
      ),
    );
  }

  Widget buildSectionTitle(String title, String subtitle) {
    print('[ListWheelViewport] Building section: $title');
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 24, bottom: 12),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF7B1FA2), Color(0xFF9C27B0)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(fontSize: 12, color: Color(0xBBFFFFFF)),
          ),
        ],
      ),
    );
  }

  Widget buildWheelContainer(Widget child, double height) {
    return Container(
      height: height,
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Color(0xFFF3E5F5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFCE93D8), width: 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }

  Widget buildItemCard(String label, int index, Color color) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        '$label #$index',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 3),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xFF6A1B9A),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 13, color: Color(0xFF424242)),
            ),
          ),
        ],
      ),
    );
  }

  // Colors for items
  List<Color> itemColors = [
    Color(0xFF7B1FA2),
    Color(0xFF512DA8),
    Color(0xFF303F9F),
    Color(0xFF1976D2),
    Color(0xFF0097A7),
    Color(0xFF00796B),
    Color(0xFF388E3C),
    Color(0xFF689F38),
    Color(0xFFFBC02D),
    Color(0xFFF57C00),
    Color(0xFFE64A19),
    Color(0xFFC62828),
  ];

  // -- Section 1: Basic ListWheelScrollView with different itemExtent --
  print('[ListWheelViewport] Section 1: Basic items with itemExtent');

  Widget section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionTitle(
        '1. Basic ListWheelScrollView',
        'Simple wheel with itemExtent = 60',
      ),
      buildInfoRow('itemExtent', '60.0 (height of each child)'),
      buildInfoRow('children', '12 colored cards'),
      buildWheelContainer(
        ListWheelScrollView(
          itemExtent: 60,
          children: List.generate(12, (i) {
            print('[ListWheelViewport] Building basic item $i');
            return buildItemCard('Item', i, itemColors[i % itemColors.length]);
          }),
        ),
        220,
      ),
      SizedBox(height: 8),
      buildInfoRow('itemExtent', '100.0 (larger items)'),
      buildWheelContainer(
        ListWheelScrollView(
          itemExtent: 100,
          children: List.generate(8, (i) {
            return Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    itemColors[i % itemColors.length],
                    itemColors[(i + 3) % itemColors.length],
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Large Item $i',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            );
          }),
        ),
        250,
      ),
    ],
  );

  // -- Section 2: diameterRatio parameter --
  print('[ListWheelViewport] Section 2: diameterRatio');

  Widget section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionTitle(
        '2. diameterRatio (Cylinder Tightness)',
        'Controls how tight the cylinder curve is',
      ),
      buildInfoRow('diameterRatio', '0.8 (tight cylinder)'),
      buildWheelContainer(
        ListWheelScrollView(
          itemExtent: 50,
          diameterRatio: 0.8,
          children: List.generate(10, (i) {
            print('[ListWheelViewport] diameterRatio=0.8 item $i');
            return buildItemCard('Tight', i, Color(0xFF1565C0));
          }),
        ),
        200,
      ),
      buildInfoRow('diameterRatio', '2.0 (default, medium curve)'),
      buildWheelContainer(
        ListWheelScrollView(
          itemExtent: 50,
          diameterRatio: 2.0,
          children: List.generate(10, (i) {
            return buildItemCard('Default', i, Color(0xFF2E7D32));
          }),
        ),
        200,
      ),
      buildInfoRow('diameterRatio', '5.0 (flatter, wider cylinder)'),
      buildWheelContainer(
        ListWheelScrollView(
          itemExtent: 50,
          diameterRatio: 5.0,
          children: List.generate(10, (i) {
            return buildItemCard('Flat', i, Color(0xFFE65100));
          }),
        ),
        200,
      ),
    ],
  );

  // -- Section 3: offAxisFraction (tilting) --
  print('[ListWheelViewport] Section 3: offAxisFraction');

  Widget section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionTitle(
        '3. offAxisFraction (Wheel Tilt)',
        'Shifts the wheel left or right off-center',
      ),
      buildInfoRow('offAxisFraction', '-0.5 (tilted left)'),
      buildWheelContainer(
        ListWheelScrollView(
          itemExtent: 55,
          offAxisFraction: -0.5,
          children: List.generate(10, (i) {
            print('[ListWheelViewport] offAxis=-0.5 item $i');
            return buildItemCard('Left', i, Color(0xFF6A1B9A));
          }),
        ),
        200,
      ),
      buildInfoRow('offAxisFraction', '0.0 (centered, default)'),
      buildWheelContainer(
        ListWheelScrollView(
          itemExtent: 55,
          offAxisFraction: 0.0,
          children: List.generate(10, (i) {
            return buildItemCard('Center', i, Color(0xFF00838F));
          }),
        ),
        200,
      ),
      buildInfoRow('offAxisFraction', '0.5 (tilted right)'),
      buildWheelContainer(
        ListWheelScrollView(
          itemExtent: 55,
          offAxisFraction: 0.5,
          children: List.generate(10, (i) {
            return buildItemCard('Right', i, Color(0xFFC62828));
          }),
        ),
        200,
      ),
    ],
  );

  // -- Section 4: useMagnifier and magnification --
  print('[ListWheelViewport] Section 4: Magnifier');

  Widget section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionTitle(
        '4. Magnifier Effect',
        'Enlarges the center item for selection emphasis',
      ),
      buildInfoRow('useMagnifier', 'true'),
      buildInfoRow('magnification', '1.5 (50% larger center item)'),
      buildWheelContainer(
        ListWheelScrollView(
          itemExtent: 50,
          useMagnifier: true,
          magnification: 1.5,
          children: List.generate(12, (i) {
            print('[ListWheelViewport] magnifier item $i');
            return Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              decoration: BoxDecoration(
                color: itemColors[i % itemColors.length],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Magnified #$i',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            );
          }),
        ),
        220,
      ),
      buildInfoRow('magnification', '2.0 (double size center)'),
      buildWheelContainer(
        ListWheelScrollView(
          itemExtent: 45,
          useMagnifier: true,
          magnification: 2.0,
          children: List.generate(10, (i) {
            return Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 24, vertical: 3),
              decoration: BoxDecoration(
                color: Color(0xFF0277BD),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'Zoom #$i',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            );
          }),
        ),
        200,
      ),
    ],
  );

  // -- Section 5: overAndUnderCenterOpacity --
  print('[ListWheelViewport] Section 5: overAndUnderCenterOpacity');

  Widget section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionTitle(
        '5. overAndUnderCenterOpacity',
        'Fades items above and below the center selection',
      ),
      buildInfoRow('overAndUnderCenterOpacity', '0.3 (heavy fade)'),
      buildWheelContainer(
        ListWheelScrollView(
          itemExtent: 55,
          overAndUnderCenterOpacity: 0.3,
          children: List.generate(10, (i) {
            print('[ListWheelViewport] opacity=0.3 item $i');
            return Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: Color(0xFF4527A0),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Faded #$i',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            );
          }),
        ),
        220,
      ),
      buildInfoRow('overAndUnderCenterOpacity', '1.0 (no fade, default)'),
      buildWheelContainer(
        ListWheelScrollView(
          itemExtent: 55,
          overAndUnderCenterOpacity: 1.0,
          children: List.generate(10, (i) {
            return Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: Color(0xFF00695C),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Visible #$i',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            );
          }),
        ),
        220,
      ),
    ],
  );

  // -- Section 6: squeeze parameter --
  print('[ListWheelViewport] Section 6: squeeze');

  Widget section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionTitle(
        '6. squeeze Parameter',
        'Controls how many items fit in the viewport',
      ),
      buildInfoRow('squeeze', '0.5 (items spread apart)'),
      buildWheelContainer(
        ListWheelScrollView(
          itemExtent: 50,
          squeeze: 0.5,
          children: List.generate(10, (i) {
            print('[ListWheelViewport] squeeze=0.5 item $i');
            return buildItemCard('Spread', i, Color(0xFF1B5E20));
          }),
        ),
        200,
      ),
      buildInfoRow('squeeze', '1.0 (default spacing)'),
      buildWheelContainer(
        ListWheelScrollView(
          itemExtent: 50,
          squeeze: 1.0,
          children: List.generate(10, (i) {
            return buildItemCard('Normal', i, Color(0xFF4E342E));
          }),
        ),
        200,
      ),
      buildInfoRow('squeeze', '2.0 (items packed tighter)'),
      buildWheelContainer(
        ListWheelScrollView(
          itemExtent: 50,
          squeeze: 2.0,
          children: List.generate(10, (i) {
            return buildItemCard('Packed', i, Color(0xFF880E4F));
          }),
        ),
        200,
      ),
    ],
  );

  // -- Section 7: perspective parameter --
  print('[ListWheelViewport] Section 7: perspective');

  Widget section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionTitle(
        '7. perspective Parameter',
        'Controls 3D depth effect (0 = flat, max ~0.01)',
      ),
      buildInfoRow('perspective', '0.001 (subtle 3D)'),
      buildWheelContainer(
        ListWheelScrollView(
          itemExtent: 55,
          perspective: 0.001,
          children: List.generate(10, (i) {
            print('[ListWheelViewport] perspective=0.001 item $i');
            return buildItemCard('Subtle', i, Color(0xFF283593));
          }),
        ),
        200,
      ),
      buildInfoRow('perspective', '0.003 (default depth)'),
      buildWheelContainer(
        ListWheelScrollView(
          itemExtent: 55,
          perspective: 0.003,
          children: List.generate(10, (i) {
            return buildItemCard('Default', i, Color(0xFF00695C));
          }),
        ),
        200,
      ),
      buildInfoRow('perspective', '0.008 (strong 3D depth)'),
      buildWheelContainer(
        ListWheelScrollView(
          itemExtent: 55,
          perspective: 0.008,
          children: List.generate(10, (i) {
            return buildItemCard('Deep', i, Color(0xFFBF360C));
          }),
        ),
        200,
      ),
    ],
  );

  // -- Section 8: renderChildrenOutsideViewport --
  print('[ListWheelViewport] Section 8: renderChildrenOutsideViewport');

  Widget section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionTitle(
        '8. renderChildrenOutsideViewport',
        'When true, renders children even if outside visible area (requires clipBehavior: Clip.none)',
      ),
      buildInfoRow('renderChildrenOutsideViewport', 'true'),
      buildInfoRow('clipBehavior', 'Clip.none'),
      Container(
        height: 250,
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Color(0xFFF3E5F5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xFFCE93D8), width: 1),
        ),
        child: ListWheelScrollView(
          itemExtent: 65,
          renderChildrenOutsideViewport: true,
          clipBehavior: Clip.none,
          diameterRatio: 1.5,
          children: List.generate(15, (i) {
            print('[ListWheelViewport] outsideViewport item $i');
            return Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    itemColors[i % itemColors.length],
                    itemColors[(i + 2) % itemColors.length],
                  ],
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x33000000),
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.visibility, color: Colors.white, size: 18),
                  SizedBox(width: 8),
                  Text(
                    'Overflow Item $i',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
      buildInfoRow('Note', 'Items render beyond container boundaries'),
    ],
  );

  // -- Section 9: CupertinoPicker (built on ListWheelScrollView) --
  print('[ListWheelViewport] Section 9: CupertinoPicker');

  List<String> fruitNames = [
    'Apple',
    'Banana',
    'Cherry',
    'Date',
    'Elderberry',
    'Fig',
    'Grape',
    'Honeydew',
    'Kiwi',
    'Lemon',
    'Mango',
    'Nectarine',
    'Orange',
    'Papaya',
    'Quince',
  ];

  List<String> monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  Widget section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionTitle(
        '9. CupertinoPicker',
        'iOS-style picker built on ListWheelScrollView internally',
      ),
      buildInfoRow('Widget', 'CupertinoPicker (fruit selection)'),
      buildInfoRow('itemExtent', '36.0'),
      Container(
        height: 220,
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Color(0xFFFFF3E0),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xFFFFCC80), width: 1),
        ),
        clipBehavior: Clip.antiAlias,
        child: CupertinoPicker(
          itemExtent: 36,
          diameterRatio: 1.2,
          magnification: 1.2,
          useMagnifier: true,
          squeeze: 1.2,
          onSelectedItemChanged: (int index) {
            print(
              '[ListWheelViewport] CupertinoPicker fruit selected: ${fruitNames[index]}',
            );
          },
          children: List.generate(fruitNames.length, (i) {
            return Center(
              child: Text(
                fruitNames[i],
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFFE65100),
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }),
        ),
      ),
      SizedBox(height: 12),
      buildInfoRow('Widget', 'CupertinoPicker (month selection)'),
      Container(
        height: 200,
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Color(0xFFE8EAF6),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xFF9FA8DA), width: 1),
        ),
        clipBehavior: Clip.antiAlias,
        child: CupertinoPicker(
          itemExtent: 40,
          diameterRatio: 1.5,
          onSelectedItemChanged: (int index) {
            print(
              '[ListWheelViewport] CupertinoPicker month selected: ${monthNames[index]}',
            );
          },
          children: List.generate(monthNames.length, (i) {
            return Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.calendar_month,
                    size: 16,
                    color: Color(0xFF283593),
                  ),
                  SizedBox(width: 8),
                  Text(
                    monthNames[i],
                    style: TextStyle(
                      fontSize: 17,
                      color: Color(0xFF283593),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    ],
  );

  // -- Section 10: Combined configuration showcase --
  print('[ListWheelViewport] Section 10: Combined config showcase');

  Widget section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionTitle(
        '10. Combined Configuration',
        'Multiple parameters combined for a rich wheel experience',
      ),
      buildInfoRow('diameterRatio', '1.2'),
      buildInfoRow('offAxisFraction', '0.2'),
      buildInfoRow('useMagnifier', 'true'),
      buildInfoRow('magnification', '1.3'),
      buildInfoRow('overAndUnderCenterOpacity', '0.5'),
      buildInfoRow('squeeze', '1.1'),
      buildInfoRow('perspective', '0.005'),
      buildWheelContainer(
        ListWheelScrollView(
          itemExtent: 70,
          diameterRatio: 1.2,
          offAxisFraction: 0.2,
          useMagnifier: true,
          magnification: 1.3,
          overAndUnderCenterOpacity: 0.5,
          squeeze: 1.1,
          perspective: 0.005,
          children: List.generate(12, (i) {
            print('[ListWheelViewport] combined config item $i');
            return Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    itemColors[i % itemColors.length],
                    itemColors[(i + 4) % itemColors.length],
                    itemColors[(i + 8) % itemColors.length],
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x44000000),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star_rounded, color: Colors.white, size: 22),
                  SizedBox(width: 10),
                  Text(
                    'Combined #$i',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
        280,
      ),
    ],
  );

  // -- Assemble all sections --
  print('[ListWheelViewport] Assembling all sections into scroll view');

  Widget result = SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildHeader(),
        section1,
        section2,
        section3,
        section4,
        section5,
        section6,
        section7,
        section8,
        section9,
        section10,
        SizedBox(height: 32),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFEDE7F6),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Color(0xFFB39DDB), width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'RenderListWheelViewport Summary',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4527A0),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'RenderListWheelViewport is the render object behind ListWheelScrollView. '
                'It renders children along a cylindrical surface, providing a wheel-like '
                'scrolling experience. Parameters control cylinder shape, magnification, '
                'opacity, squeeze, and perspective depth.',
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF616161),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 24),
      ],
    ),
  );

  print('[ListWheelViewport] Deep demo build complete');
  return result;
}
