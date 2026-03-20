// D4rt test script: Tests AnimatedIconData from material
// Displays icon variations and animated icon states at different progress values
import 'package:flutter/material.dart';

// Helper to build a section header
Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.orange.shade800,
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

// Helper to build an animated icon progress row
Widget buildAnimatedIconProgressRow(
  String label,
  AnimatedIconData iconData,
  Color color,
) {
  List<double> progressValues = [0.0, 0.2, 0.4, 0.6, 0.8, 1.0];

  return Card(
    elevation: 2,
    margin: EdgeInsets.symmetric(vertical: 6),
    child: Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: progressValues.map((progress) {
              return Column(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: color.withAlpha(25),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: color.withAlpha(60)),
                    ),
                    child: Center(
                      child: AnimatedIcon(
                        icon: iconData,
                        progress: AlwaysStoppedAnimation(progress),
                        color: color,
                        size: 28,
                      ),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${(progress * 100).toInt()}%',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                ],
              );
            }).toList(),
          ),
          SizedBox(height: 8),
          Container(
            height: 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              gradient: LinearGradient(colors: [color, color.withAlpha(60)]),
            ),
          ),
        ],
      ),
    ),
  );
}

// Helper to build a large icon showcase
Widget buildLargeIconShowcase(
  String label,
  AnimatedIconData iconData,
  double progress,
  Color bgColor,
  Color iconColor,
) {
  return Container(
    width: 100,
    margin: EdgeInsets.all(4),
    child: Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: bgColor.withAlpha(100),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: AnimatedIcon(
              icon: iconData,
              progress: AlwaysStoppedAnimation(progress),
              color: iconColor,
              size: 40,
            ),
          ),
        ),
        SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(fontSize: 11, color: Colors.grey.shade700),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

// Helper to build an icon info card
Widget buildIconInfoCard(
  String name,
  AnimatedIconData iconData,
  String description,
  Color color,
) {
  return Card(
    elevation: 2,
    margin: EdgeInsets.symmetric(vertical: 6),
    child: Container(
      padding: EdgeInsets.all(12),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color.withAlpha(40), color.withAlpha(15)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: AnimatedIcon(
                icon: iconData,
                progress: AlwaysStoppedAnimation(0.5),
                color: color,
                size: 32,
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                ),
                SizedBox(height: 6),
                Row(
                  children: [
                    buildProgressChip(iconData, 0.0, color),
                    SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward,
                      size: 12,
                      color: Colors.grey.shade400,
                    ),
                    SizedBox(width: 4),
                    buildProgressChip(iconData, 0.5, color),
                    SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward,
                      size: 12,
                      color: Colors.grey.shade400,
                    ),
                    SizedBox(width: 4),
                    buildProgressChip(iconData, 1.0, color),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildProgressChip(
  AnimatedIconData iconData,
  double progress,
  Color color,
) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
    decoration: BoxDecoration(
      color: color.withAlpha(20),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withAlpha(60)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedIcon(
          icon: iconData,
          progress: AlwaysStoppedAnimation(progress),
          color: color,
          size: 14,
        ),
        SizedBox(width: 3),
        Text(
          '${(progress * 100).toInt()}%',
          style: TextStyle(fontSize: 10, color: color),
        ),
      ],
    ),
  );
}

// Helper to build colored icon grid cell
Widget buildColoredIconCell(
  AnimatedIconData iconData,
  double progress,
  Color bgColor,
  Color iconColor,
  String tooltip,
) {
  return Tooltip(
    message: tooltip,
    child: Container(
      margin: EdgeInsets.all(4),
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: AnimatedIcon(
          icon: iconData,
          progress: AlwaysStoppedAnimation(progress),
          color: iconColor,
          size: 28,
        ),
      ),
    ),
  );
}

// Helper to build size comparison row
Widget buildSizeComparisonRow(
  AnimatedIconData iconData,
  String label,
  Color color,
) {
  List<double> sizes = [16, 24, 32, 40, 48, 56];
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: sizes.map((size) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedIcon(
                  icon: iconData,
                  progress: AlwaysStoppedAnimation(0.5),
                  color: color,
                  size: size,
                ),
                SizedBox(height: 4),
                Text(
                  '${size.toInt()}',
                  style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
                ),
              ],
            );
          }).toList(),
        ),
      ],
    ),
  );
}

// Helper to build start-end comparison row
Widget buildStartEndCompare(
  String label,
  AnimatedIconData iconData,
  Color color,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 140,
          child: Text(
            label,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withAlpha(20),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: AnimatedIcon(
              icon: iconData,
              progress: AlwaysStoppedAnimation(0.0),
              color: color,
              size: 24,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Icon(
            Icons.arrow_forward,
            size: 20,
            color: Colors.grey.shade400,
          ),
        ),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withAlpha(40),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: AnimatedIcon(
              icon: iconData,
              progress: AlwaysStoppedAnimation(1.0),
              color: color,
              size: 24,
            ),
          ),
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  debugPrint('=== AnimatedIconData Test Script ===');
  debugPrint('Testing AnimatedIconData with different icons and progress values');

  debugPrint('Available AnimatedIcons:');
  debugPrint('  - menu_arrow, menu_close, menu_home');
  debugPrint('  - play_pause, pause_play');
  debugPrint('  - close_menu, home_menu, arrow_menu');
  debugPrint('  - add_event, event_add');
  debugPrint('  - ellipsis_search, search_ellipsis');
  debugPrint('  - list_view, view_list');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange.shade700, Colors.deepOrange.shade600],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'AnimatedIconData Demo',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'All animated icons at various progress states',
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
            ],
          ),
        ),

        // Section 1: Progress Rows
        buildSectionHeader('1. Icon Animation Progress'),
        buildAnimatedIconProgressRow(
          'Menu -> Arrow',
          AnimatedIcons.menu_arrow,
          Colors.blue.shade700,
        ),
        buildAnimatedIconProgressRow(
          'Menu -> Close',
          AnimatedIcons.menu_close,
          Colors.red.shade700,
        ),
        buildAnimatedIconProgressRow(
          'Play -> Pause',
          AnimatedIcons.play_pause,
          Colors.green.shade700,
        ),
        buildAnimatedIconProgressRow(
          'Pause -> Play',
          AnimatedIcons.pause_play,
          Colors.purple.shade700,
        ),
        buildAnimatedIconProgressRow(
          'Close -> Menu',
          AnimatedIcons.close_menu,
          Colors.orange.shade700,
        ),
        buildAnimatedIconProgressRow(
          'Home -> Menu',
          AnimatedIcons.home_menu,
          Colors.teal.shade700,
        ),
        buildAnimatedIconProgressRow(
          'Arrow -> Menu',
          AnimatedIcons.arrow_menu,
          Colors.indigo.shade700,
        ),
        buildAnimatedIconProgressRow(
          'Add -> Event',
          AnimatedIcons.add_event,
          Colors.pink.shade700,
        ),
        buildAnimatedIconProgressRow(
          'Event -> Add',
          AnimatedIcons.event_add,
          Colors.brown.shade700,
        ),
        buildAnimatedIconProgressRow(
          'Ellipsis -> Search',
          AnimatedIcons.ellipsis_search,
          Colors.cyan.shade700,
        ),
        buildAnimatedIconProgressRow(
          'Search -> Ellipsis',
          AnimatedIcons.search_ellipsis,
          Colors.deepPurple.shade700,
        ),
        buildAnimatedIconProgressRow(
          'List -> View',
          AnimatedIcons.list_view,
          Colors.lime.shade800,
        ),
        buildAnimatedIconProgressRow(
          'View -> List',
          AnimatedIcons.view_list,
          Colors.amber.shade800,
        ),

        // Section 2: Large Icon Showcase
        buildSectionHeader('2. Large Icon Showcase (at 50%)'),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              buildLargeIconShowcase(
                'Menu/Arrow',
                AnimatedIcons.menu_arrow,
                0.5,
                Colors.blue.shade100,
                Colors.blue.shade700,
              ),
              buildLargeIconShowcase(
                'Menu/Close',
                AnimatedIcons.menu_close,
                0.5,
                Colors.red.shade100,
                Colors.red.shade700,
              ),
              buildLargeIconShowcase(
                'Play/Pause',
                AnimatedIcons.play_pause,
                0.5,
                Colors.green.shade100,
                Colors.green.shade700,
              ),
              buildLargeIconShowcase(
                'Close/Menu',
                AnimatedIcons.close_menu,
                0.5,
                Colors.orange.shade100,
                Colors.orange.shade700,
              ),
              buildLargeIconShowcase(
                'Home/Menu',
                AnimatedIcons.home_menu,
                0.5,
                Colors.teal.shade100,
                Colors.teal.shade700,
              ),
              buildLargeIconShowcase(
                'Add/Event',
                AnimatedIcons.add_event,
                0.5,
                Colors.pink.shade100,
                Colors.pink.shade700,
              ),
            ],
          ),
        ),

        // Section 3: Start and End State Comparison
        buildSectionHeader('3. Start (0%) vs End (100%) States'),
        buildStartEndCompare(
          'Menu / Arrow',
          AnimatedIcons.menu_arrow,
          Colors.blue.shade700,
        ),
        buildStartEndCompare(
          'Menu / Close',
          AnimatedIcons.menu_close,
          Colors.red.shade700,
        ),
        buildStartEndCompare(
          'Play / Pause',
          AnimatedIcons.play_pause,
          Colors.green.shade700,
        ),
        buildStartEndCompare(
          'Pause / Play',
          AnimatedIcons.pause_play,
          Colors.purple.shade700,
        ),
        buildStartEndCompare(
          'Home / Menu',
          AnimatedIcons.home_menu,
          Colors.teal.shade700,
        ),
        buildStartEndCompare(
          'Add / Event',
          AnimatedIcons.add_event,
          Colors.pink.shade700,
        ),
        buildStartEndCompare(
          'Ellipsis / Search',
          AnimatedIcons.ellipsis_search,
          Colors.cyan.shade700,
        ),
        buildStartEndCompare(
          'List / View',
          AnimatedIcons.list_view,
          Colors.lime.shade800,
        ),

        // Section 4: Icon Info Cards
        buildSectionHeader('4. Icon Details'),
        buildIconInfoCard(
          'AnimatedIcons.menu_arrow',
          AnimatedIcons.menu_arrow,
          'Hamburger menu icon morphing into a back arrow. Common in app bars.',
          Colors.blue.shade700,
        ),
        buildIconInfoCard(
          'AnimatedIcons.menu_close',
          AnimatedIcons.menu_close,
          'Hamburger menu icon morphing into a close (X) icon.',
          Colors.red.shade700,
        ),
        buildIconInfoCard(
          'AnimatedIcons.play_pause',
          AnimatedIcons.play_pause,
          'Play triangle morphing into pause bars for media controls.',
          Colors.green.shade700,
        ),
        buildIconInfoCard(
          'AnimatedIcons.ellipsis_search',
          AnimatedIcons.ellipsis_search,
          'Three-dot menu morphing into search icon for app bars.',
          Colors.cyan.shade700,
        ),
        buildIconInfoCard(
          'AnimatedIcons.list_view',
          AnimatedIcons.list_view,
          'List layout icon morphing into grid view for layout toggles.',
          Colors.lime.shade800,
        ),

        // Section 5: Color Grid
        buildSectionHeader('5. Color Variations Grid'),
        Wrap(
          children: [
            buildColoredIconCell(
              AnimatedIcons.menu_arrow,
              0.0,
              Colors.red.shade100,
              Colors.red.shade800,
              'Red 0%',
            ),
            buildColoredIconCell(
              AnimatedIcons.menu_arrow,
              0.25,
              Colors.orange.shade100,
              Colors.orange.shade800,
              'Orange 25%',
            ),
            buildColoredIconCell(
              AnimatedIcons.menu_arrow,
              0.5,
              Colors.yellow.shade100,
              Colors.yellow.shade900,
              'Yellow 50%',
            ),
            buildColoredIconCell(
              AnimatedIcons.menu_arrow,
              0.75,
              Colors.green.shade100,
              Colors.green.shade800,
              'Green 75%',
            ),
            buildColoredIconCell(
              AnimatedIcons.menu_arrow,
              1.0,
              Colors.blue.shade100,
              Colors.blue.shade800,
              'Blue 100%',
            ),
            buildColoredIconCell(
              AnimatedIcons.play_pause,
              0.0,
              Colors.indigo.shade100,
              Colors.indigo.shade800,
              'Indigo 0%',
            ),
            buildColoredIconCell(
              AnimatedIcons.play_pause,
              0.25,
              Colors.purple.shade100,
              Colors.purple.shade800,
              'Purple 25%',
            ),
            buildColoredIconCell(
              AnimatedIcons.play_pause,
              0.5,
              Colors.pink.shade100,
              Colors.pink.shade800,
              'Pink 50%',
            ),
            buildColoredIconCell(
              AnimatedIcons.play_pause,
              0.75,
              Colors.teal.shade100,
              Colors.teal.shade800,
              'Teal 75%',
            ),
            buildColoredIconCell(
              AnimatedIcons.play_pause,
              1.0,
              Colors.brown.shade100,
              Colors.brown.shade800,
              'Brown 100%',
            ),
            buildColoredIconCell(
              AnimatedIcons.menu_close,
              0.0,
              Colors.cyan.shade100,
              Colors.cyan.shade800,
              'Cyan 0%',
            ),
            buildColoredIconCell(
              AnimatedIcons.menu_close,
              0.33,
              Colors.lime.shade100,
              Colors.lime.shade800,
              'Lime 33%',
            ),
            buildColoredIconCell(
              AnimatedIcons.menu_close,
              0.66,
              Colors.amber.shade100,
              Colors.amber.shade800,
              'Amber 66%',
            ),
            buildColoredIconCell(
              AnimatedIcons.menu_close,
              1.0,
              Colors.deepOrange.shade100,
              Colors.deepOrange.shade800,
              'DpOrng 100%',
            ),
            buildColoredIconCell(
              AnimatedIcons.home_menu,
              0.5,
              Colors.grey.shade200,
              Colors.grey.shade800,
              'Grey 50%',
            ),
          ],
        ),

        // Section 6: Size Comparison
        buildSectionHeader('6. Size Comparison'),
        buildSizeComparisonRow(
          AnimatedIcons.menu_arrow,
          'Menu -> Arrow at various sizes',
          Colors.blue.shade700,
        ),
        buildSizeComparisonRow(
          AnimatedIcons.play_pause,
          'Play -> Pause at various sizes',
          Colors.green.shade700,
        ),
        buildSizeComparisonRow(
          AnimatedIcons.menu_close,
          'Menu -> Close at various sizes',
          Colors.red.shade700,
        ),
        buildSizeComparisonRow(
          AnimatedIcons.ellipsis_search,
          'Ellipsis -> Search at various sizes',
          Colors.cyan.shade700,
        ),

        // Section 7: Dark vs Light backgrounds
        buildSectionHeader('7. Dark vs Light Backgrounds'),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  children: [
                    Text(
                      'Light',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    AnimatedIcon(
                      icon: AnimatedIcons.menu_arrow,
                      progress: AlwaysStoppedAnimation(0.5),
                      color: Colors.black87,
                      size: 40,
                    ),
                    SizedBox(height: 8),
                    AnimatedIcon(
                      icon: AnimatedIcons.play_pause,
                      progress: AlwaysStoppedAnimation(0.5),
                      color: Colors.black87,
                      size: 40,
                    ),
                    SizedBox(height: 8),
                    AnimatedIcon(
                      icon: AnimatedIcons.menu_close,
                      progress: AlwaysStoppedAnimation(0.5),
                      color: Colors.black87,
                      size: 40,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      'Dark',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    AnimatedIcon(
                      icon: AnimatedIcons.menu_arrow,
                      progress: AlwaysStoppedAnimation(0.5),
                      color: Colors.white,
                      size: 40,
                    ),
                    SizedBox(height: 8),
                    AnimatedIcon(
                      icon: AnimatedIcons.play_pause,
                      progress: AlwaysStoppedAnimation(0.5),
                      color: Colors.white,
                      size: 40,
                    ),
                    SizedBox(height: 8),
                    AnimatedIcon(
                      icon: AnimatedIcons.menu_close,
                      progress: AlwaysStoppedAnimation(0.5),
                      color: Colors.white,
                      size: 40,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 32),
        Center(
          child: Text(
            'End of AnimatedIconData Demo',
            style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
          ),
        ),
        SizedBox(height: 16),
      ],
    ),
  );
}
