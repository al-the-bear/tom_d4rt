// D4rt test script: Tests EndDrawerButtonIcon from material
import 'package:flutter/material.dart';

Widget _buildSectionHeader(String title) {
  debugPrint('Section: $title');
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.brown.shade700,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      title,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
    ),
  );
}

Widget _buildInfoCard(String label, String value) {
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
        Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        SizedBox(width: 8),
        Expanded(
          child: Text(value, style: TextStyle(fontSize: 14, color: Colors.grey.shade700)),
        ),
      ],
    ),
  );
}

Widget _buildBasicEndDrawerIcon() {
  debugPrint('Building basic EndDrawerButtonIcon');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.brown.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Default EndDrawerButtonIcon',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.brown.shade800)),
        SizedBox(height: 12),
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.brown.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.brown.shade200),
              ),
              child: EndDrawerButtonIcon(),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('EndDrawerButtonIcon()',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.brown.shade700)),
                  SizedBox(height: 4),
                  Text('The default menu icon shown for end drawer actions',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildInAppBarDemo() {
  debugPrint('Building AppBar demo with EndDrawerButtonIcon');
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.brown.shade200),
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: [
        Container(
          height: 56,
          color: Colors.brown.shade700,
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              Icon(Icons.arrow_back, color: Colors.white, size: 24),
              SizedBox(width: 12),
              Text('AppBar with End Drawer',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.white)),
              Expanded(child: SizedBox()),
              Icon(Icons.search, color: Colors.white, size: 24),
              SizedBox(width: 8),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: EndDrawerButtonIcon(),
              ),
            ],
          ),
        ),
        Container(
          height: 120,
          color: Colors.grey.shade100,
          alignment: Alignment.center,
          child: Text('Page Content Area',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade500)),
        ),
      ],
    ),
  );
}

Widget _buildSizeComparison() {
  debugPrint('Building size comparison');
  List<double> sizes = [16, 20, 24, 28, 32, 40, 48];

  List<Widget> items = [];
  for (int i = 0; i < sizes.length; i = i + 1) {
    double sz = sizes[i];
    items.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 52,
              height: 52,
              child: Center(
                child: SizedBox(
                  width: sz,
                  height: sz,
                  child: FittedBox(
                    child: EndDrawerButtonIcon(),
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            Text('${sz.toInt()} x ${sz.toInt()}',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.brown.shade700)),
            SizedBox(width: 8),
            Container(
              width: sz,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.brown.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.brown.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.brown.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Size Variations',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.brown.shade800)),
        SizedBox(height: 4),
        Text('EndDrawerButtonIcon rendered at different sizes using FittedBox',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
        SizedBox(height: 8),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: items),
      ],
    ),
  );
}

Widget _buildColorVariations() {
  debugPrint('Building color variations');
  List<String> colorNames = ['Brown', 'Blue', 'Green', 'Red', 'Purple', 'Orange', 'Teal', 'Pink'];
  List<Color> bgColors = [
    Colors.brown.shade700, Colors.blue.shade700, Colors.green.shade700, Colors.red.shade700,
    Colors.purple.shade700, Colors.orange.shade700, Colors.teal.shade700, Colors.pink.shade700,
  ];

  List<Widget> items = [];
  for (int i = 0; i < colorNames.length; i = i + 1) {
    items.add(
      Container(
        margin: EdgeInsets.only(right: 8, bottom: 8),
        child: Column(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: bgColors[i],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: IconTheme(
                  data: IconThemeData(color: Colors.white, size: 24),
                  child: EndDrawerButtonIcon(),
                ),
              ),
            ),
            SizedBox(height: 4),
            Text(colorNames[i],
              style: TextStyle(fontSize: 10, color: Colors.grey.shade600)),
          ],
        ),
      ),
    );
  }

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.brown.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Color Themes',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.brown.shade800)),
        SizedBox(height: 4),
        Text('EndDrawerButtonIcon with IconTheme in different colored backgrounds',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
        SizedBox(height: 12),
        Wrap(children: items),
      ],
    ),
  );
}

Widget _buildCompareDrawerIcons() {
  debugPrint('Building DrawerButtonIcon vs EndDrawerButtonIcon comparison');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.brown.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('DrawerButtonIcon vs EndDrawerButtonIcon',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.brown.shade800)),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade700,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconTheme(
                        data: IconThemeData(color: Colors.white, size: 28),
                        child: DrawerButtonIcon(),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('DrawerButtonIcon',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.blue.shade700)),
                    SizedBox(height: 4),
                    Text('Leading side (start)',
                      style: TextStyle(fontSize: 10, color: Colors.grey.shade600)),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.brown.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.brown.shade200),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.brown.shade700,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconTheme(
                        data: IconThemeData(color: Colors.white, size: 28),
                        child: EndDrawerButtonIcon(),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('EndDrawerButtonIcon',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.brown.shade700)),
                    SizedBox(height: 4),
                    Text('Trailing side (end)',
                      style: TextStyle(fontSize: 10, color: Colors.grey.shade600)),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.amber.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, size: 16, color: Colors.amber.shade800),
              SizedBox(width: 8),
              Expanded(
                child: Text('DrawerButtonIcon is for the leading drawer, EndDrawerButtonIcon is for the trailing end drawer',
                  style: TextStyle(fontSize: 11, color: Colors.amber.shade900)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildAppBarContexts() {
  debugPrint('Building different AppBar contexts');

  Widget _buildMockAppBar(String title, Color appBarColor, bool showLeading, bool showEnd) {
    List<Widget> leftItems = [];
    if (showLeading) {
      leftItems.add(
        Container(
          padding: EdgeInsets.all(6),
          child: IconTheme(
            data: IconThemeData(color: Colors.white, size: 20),
            child: DrawerButtonIcon(),
          ),
        ),
      );
    }
    leftItems.add(SizedBox(width: 8));
    leftItems.add(
      Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
    );

    List<Widget> rightItems = [];
    if (showEnd) {
      rightItems.add(
        Container(
          padding: EdgeInsets.all(6),
          child: IconTheme(
            data: IconThemeData(color: Colors.white, size: 20),
            child: EndDrawerButtonIcon(),
          ),
        ),
      );
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      height: 48,
      decoration: BoxDecoration(
        color: appBarColor,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Row(children: leftItems),
          Expanded(child: SizedBox()),
          Row(children: rightItems),
        ],
      ),
    );
  }

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.brown.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('AppBar Context Demos',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.brown.shade800)),
        SizedBox(height: 4),
        Text('EndDrawerButtonIcon in various AppBar configurations',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
        SizedBox(height: 12),
        _buildMockAppBar('Both drawers', Colors.brown.shade700, true, true),
        _buildMockAppBar('End drawer only', Colors.blue.shade700, false, true),
        _buildMockAppBar('Start drawer only', Colors.green.shade700, true, false),
        _buildMockAppBar('No drawers', Colors.grey.shade700, false, false),
      ],
    ),
  );
}

Widget _buildStandaloneShowcase() {
  debugPrint('Building standalone showcase');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.brown.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Standalone Display',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.brown.shade800)),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.brown.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: EndDrawerButtonIcon(),
                  ),
                ),
                SizedBox(height: 4),
                Text('Circle', style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
              ],
            ),
            Column(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.brown.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: EndDrawerButtonIcon(),
                  ),
                ),
                SizedBox(height: 4),
                Text('Rounded', style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
              ],
            ),
            Column(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.brown.shade100,
                  ),
                  child: Center(
                    child: EndDrawerButtonIcon(),
                  ),
                ),
                SizedBox(height: 4),
                Text('Square', style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
              ],
            ),
            Column(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.brown.shade300, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: EndDrawerButtonIcon(),
                  ),
                ),
                SizedBox(height: 4),
                Text('Outlined', style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildRtlComparison() {
  debugPrint('Building RTL comparison');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.brown.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('LTR vs RTL Layout',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.brown.shade800)),
        SizedBox(height: 4),
        Text('End drawer icon position changes with text direction',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('LTR (Left-to-Right)',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.blue.shade700)),
              SizedBox(height: 8),
              Container(
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.blue.shade700,
                  borderRadius: BorderRadius.circular(6),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    IconTheme(
                      data: IconThemeData(color: Colors.white, size: 20),
                      child: DrawerButtonIcon(),
                    ),
                    SizedBox(width: 8),
                    Text('Title', style: TextStyle(color: Colors.white, fontSize: 14)),
                    Expanded(child: SizedBox()),
                    Text('end ->', style: TextStyle(color: Colors.white70, fontSize: 10)),
                    SizedBox(width: 4),
                    IconTheme(
                      data: IconThemeData(color: Colors.white, size: 20),
                      child: EndDrawerButtonIcon(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.green.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('RTL (Right-to-Left)',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.green.shade700)),
              SizedBox(height: 8),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.green.shade700,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      IconTheme(
                        data: IconThemeData(color: Colors.white, size: 20),
                        child: DrawerButtonIcon(),
                      ),
                      SizedBox(width: 8),
                      Text('العنوان', style: TextStyle(color: Colors.white, fontSize: 14)),
                      Expanded(child: SizedBox()),
                      Text('<- end', style: TextStyle(color: Colors.white70, fontSize: 10)),
                      SizedBox(width: 4),
                      IconTheme(
                        data: IconThemeData(color: Colors.white, size: 20),
                        child: EndDrawerButtonIcon(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildThemedContexts() {
  debugPrint('Building themed contexts');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.brown.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Themed Contexts',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.brown.shade800)),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              IconTheme(
                data: IconThemeData(color: Colors.black87, size: 24),
                child: EndDrawerButtonIcon(),
              ),
              SizedBox(width: 12),
              Text('Light theme (dark icon on light bg)',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade800)),
            ],
          ),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade700),
          ),
          child: Row(
            children: [
              IconTheme(
                data: IconThemeData(color: Colors.white, size: 24),
                child: EndDrawerButtonIcon(),
              ),
              SizedBox(width: 12),
              Text('Dark theme (light icon on dark bg)',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade300)),
            ],
          ),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.amber.shade100,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.amber.shade400),
          ),
          child: Row(
            children: [
              IconTheme(
                data: IconThemeData(color: Colors.amber.shade800, size: 24),
                child: EndDrawerButtonIcon(),
              ),
              SizedBox(width: 12),
              Text('Custom theme (amber icon on amber bg)',
                style: TextStyle(fontSize: 13, color: Colors.amber.shade900)),
            ],
          ),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.indigo.shade900,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.indigo.shade400),
          ),
          child: Row(
            children: [
              IconTheme(
                data: IconThemeData(color: Colors.cyan.shade200, size: 24),
                child: EndDrawerButtonIcon(),
              ),
              SizedBox(width: 12),
              Text('High contrast theme',
                style: TextStyle(fontSize: 13, color: Colors.cyan.shade200)),
            ],
          ),
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('EndDrawerButtonIcon deep demo test executing');
  debugPrint('=== EndDrawerButtonIcon Visual Demo ===');
  Widget result = MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('EndDrawerButtonIcon Deep Demo'),
        backgroundColor: Colors.brown.shade700,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('1. Basic EndDrawerButtonIcon'),
            _buildBasicEndDrawerIcon(),
            SizedBox(height: 16),
            _buildSectionHeader('2. In AppBar Context'),
            _buildInAppBarDemo(),
            SizedBox(height: 16),
            _buildSectionHeader('3. Size Variations'),
            _buildSizeComparison(),
            SizedBox(height: 16),
            _buildSectionHeader('4. Color Themes'),
            _buildColorVariations(),
            SizedBox(height: 16),
            _buildSectionHeader('5. Drawer vs EndDrawer Icon'),
            _buildCompareDrawerIcons(),
            SizedBox(height: 16),
            _buildSectionHeader('6. AppBar Configurations'),
            _buildAppBarContexts(),
            SizedBox(height: 16),
            _buildSectionHeader('7. Standalone Shapes'),
            _buildStandaloneShowcase(),
            SizedBox(height: 16),
            _buildSectionHeader('8. LTR vs RTL'),
            _buildRtlComparison(),
            SizedBox(height: 16),
            _buildSectionHeader('9. Themed Contexts'),
            _buildThemedContexts(),
            SizedBox(height: 32),
            _buildInfoCard('Widget', 'EndDrawerButtonIcon'),
            _buildInfoCard('Package', 'package:flutter/material.dart'),
            _buildInfoCard('Purpose', 'Icon for opening the end drawer (trailing side)'),
            _buildInfoCard('Comparison', 'DrawerButtonIcon (leading) vs EndDrawerButtonIcon (trailing)'),
            _buildInfoCard('Usage', 'Typically placed in AppBar actions for end drawer access'),
            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );
  print('EndDrawerButtonIcon deep demo completed');
  return result;
}
