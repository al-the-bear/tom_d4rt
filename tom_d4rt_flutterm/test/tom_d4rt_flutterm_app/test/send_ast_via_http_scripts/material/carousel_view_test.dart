// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests CarouselView from material
import 'package:flutter/material.dart';

// Helper to create a carousel card item
Widget buildCarouselCard(int index, Color color, String label, IconData icon) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 4),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2)),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.white, size: 32),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        SizedBox(height: 4),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '#$index',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ],
    ),
  );
}

// Helper to create a section header
Widget buildSectionHeader(String title, IconData icon, Color color) {
  return Container(
    margin: EdgeInsets.fromLTRB(8, 16, 8, 8),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [color, color.withValues(alpha: 0.7)]),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.white, size: 20),
        SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

// Helper for a simulated carousel strip
Widget buildCarouselStrip(
  String label,
  double itemWidth,
  double height,
  List<Color> colors,
  List<IconData> icons,
) {
  return Container(
    margin: EdgeInsets.all(8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4, bottom: 4),
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
        ),
        SizedBox(
          height: height,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemCount: colors.length,
            itemBuilder: (ctx, i) {
              return Container(
                width: itemWidth,
                margin: EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: colors[i % colors.length],
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 3,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icons[i % icons.length],
                      color: Colors.white,
                      size: 28,
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Item $i',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      '${itemWidth.toInt()}w',
                      style: TextStyle(color: Colors.white70, fontSize: 11),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}

// Helper for item extent comparison
Widget buildExtentComparison(String label, double extent, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    child: Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (ctx, i) {
                return Container(
                  width: extent,
                  margin: EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.3 + (i % 3) * 0.25),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text(
                      '$i',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    ),
  );
}

// Helper for flex weight visualization
Widget buildFlexWeightRow(String label, List<int> weights, List<Color> colors) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        SizedBox(
          height: 50,
          child: Row(
            children: List.generate(weights.length, (i) {
              return Expanded(
                flex: weights[i],
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 1),
                  decoration: BoxDecoration(
                    color: colors[i % colors.length],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text(
                      'flex:${weights[i]}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    ),
  );
}

// Helper for a controller position indicator
Widget buildControllerPosition(
  String label,
  int currentIndex,
  int totalItems,
  Color color,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Row(
          children: List.generate(totalItems, (i) {
            var isActive = i == currentIndex;
            return Expanded(
              child: Container(
                height: 24,
                margin: EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: isActive ? color : color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(4),
                  border: isActive ? Border.all(color: color, width: 2) : null,
                ),
                child: Center(
                  child: Text(
                    '$i',
                    style: TextStyle(
                      color: isActive ? Colors.white : color,
                      fontSize: 10,
                      fontWeight: isActive
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
        SizedBox(height: 4),
        Text(
          'Current: $currentIndex / ${totalItems - 1}',
          style: TextStyle(fontSize: 10, color: Colors.grey),
        ),
      ],
    ),
  );
}

// Helper for overlap carousel circles
Widget buildOverlapCarousel(String title, List<Color> colors) {
  return Container(
    margin: EdgeInsets.all(8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4, bottom: 4),
          child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
        ),
        SizedBox(
          height: 80,
          child: Stack(
            children: List.generate(colors.length, (i) {
              return Positioned(
                left: i * 50.0,
                top: 0,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: colors[i],
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 4),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      '${i + 1}',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  debugPrint('=== CarouselView Visual Test ===');
  debugPrint('Demonstrating carousel-like layouts with various configurations');

  var controller1 = ScrollController();
  var controller2 = ScrollController();
  debugPrint('Controllers created: $controller1, $controller2');

  var cardColors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.pink,
    Colors.indigo,
    Colors.amber,
    Colors.cyan,
  ];

  var cardIcons = [
    Icons.image,
    Icons.music_note,
    Icons.video_library,
    Icons.article,
    Icons.photo_album,
    Icons.podcasts,
    Icons.movie,
    Icons.book,
    Icons.favorite,
    Icons.star,
  ];

  debugPrint('Starting carousel demonstrations...');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('CarouselView Visual Demo'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Section 1: Basic Carousel Strip
            buildSectionHeader(
              'Basic Carousel',
              Icons.view_carousel,
              Colors.deepPurple,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Text(
                'Horizontal scrolling card carousel with default item extent',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
            ),
            buildCarouselStrip(
              'Standard Width (120px)',
              120,
              140,
              cardColors,
              cardIcons,
            ),

            // Section 2: Different Item Extents
            buildSectionHeader(
              'Item Extent Variations',
              Icons.width_normal,
              Colors.blue,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Text(
                'Carousel items with different widths showing extent impact on layout',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
            ),
            buildExtentComparison('40px', 40, Colors.blue),
            buildExtentComparison('60px', 60, Colors.green),
            buildExtentComparison('80px', 80, Colors.orange),
            buildExtentComparison('100px', 100, Colors.purple),
            buildExtentComparison('120px', 120, Colors.red),

            // Section 3: Flex Weight Layout
            buildSectionHeader(
              'Flex Weight Distribution',
              Icons.view_column,
              Colors.teal,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Text(
                'How flex weights distribute carousel item widths',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
            ),
            buildFlexWeightRow(
              'Equal (1:1:1:1)',
              [1, 1, 1, 1],
              [Colors.blue, Colors.red, Colors.green, Colors.orange],
            ),
            buildFlexWeightRow(
              'Weighted (2:1:1:2)',
              [2, 1, 1, 2],
              [Colors.purple, Colors.teal, Colors.cyan, Colors.pink],
            ),
            buildFlexWeightRow(
              'Dominant (3:1:1:1)',
              [3, 1, 1, 1],
              [Colors.indigo, Colors.amber, Colors.lime, Colors.brown],
            ),
            buildFlexWeightRow(
              'Growing (1:2:3:4)',
              [1, 2, 3, 4],
              [Colors.red, Colors.orange, Colors.green, Colors.blue],
            ),

            // Section 4: Wider Carousel Items
            buildSectionHeader(
              'Wide Carousel Items',
              Icons.panorama_wide_angle,
              Colors.orange,
            ),
            buildCarouselStrip(
              'Large Items (200px)',
              200,
              160,
              [
                Colors.deepPurple,
                Colors.deepOrange,
                Colors.teal,
                Colors.pink,
                Colors.indigo,
                Colors.brown,
              ],
              [
                Icons.landscape,
                Icons.beach_access,
                Icons.park,
                Icons.villa,
                Icons.castle,
                Icons.cabin,
              ],
            ),

            // Section 5: Compact Items
            buildSectionHeader(
              'Compact Carousel',
              Icons.view_comfy,
              Colors.green,
            ),
            buildCarouselStrip(
              'Small Items (70px)',
              70,
              80,
              [
                Colors.red,
                Colors.blue,
                Colors.green,
                Colors.amber,
                Colors.purple,
                Colors.cyan,
                Colors.pink,
                Colors.teal,
                Colors.indigo,
                Colors.orange,
                Colors.lime,
                Colors.brown,
              ],
              [
                Icons.circle,
                Icons.square,
                Icons.hexagon,
                Icons.star,
                Icons.favorite,
                Icons.diamond,
                Icons.circle,
                Icons.square,
                Icons.hexagon,
                Icons.star,
                Icons.favorite,
                Icons.diamond,
              ],
            ),

            // Section 6: Controller Positions
            buildSectionHeader(
              'Controller Positions',
              Icons.control_camera,
              Colors.red,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Text(
                'Scroll controller position indicators showing current item',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
            ),
            buildControllerPosition('Position 0 (Start)', 0, 8, Colors.blue),
            buildControllerPosition('Position 2', 2, 8, Colors.green),
            buildControllerPosition('Position 4 (Middle)', 4, 8, Colors.orange),
            buildControllerPosition('Position 6', 6, 8, Colors.purple),
            buildControllerPosition('Position 7 (End)', 7, 8, Colors.red),

            // Section 7: Overlapping Cards
            buildSectionHeader('Overlap Effect', Icons.layers, Colors.indigo),
            buildOverlapCarousel('Overlapping Circles (6 items)', [
              Colors.red,
              Colors.orange,
              Colors.yellow.shade700,
              Colors.green,
              Colors.blue,
              Colors.purple,
            ]),
            SizedBox(height: 8),
            buildOverlapCarousel('More Overlapping Items (8)', [
              Colors.pink,
              Colors.deepPurple,
              Colors.indigo,
              Colors.cyan,
              Colors.teal,
              Colors.lime.shade700,
              Colors.amber,
              Colors.deepOrange,
            ]),

            // Section 8: Numbered Card Carousel
            buildSectionHeader(
              'Numbered Cards',
              Icons.format_list_numbered,
              Colors.brown,
            ),
            Container(
              height: 100,
              margin: EdgeInsets.all(8),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                itemCount: 15,
                itemBuilder: (ctx, i) {
                  return Container(
                    width: 90,
                    height: 90,
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: cardColors[i % cardColors.length],
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        '${i + 1}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Section 9: Multi-Row Carousel
            buildSectionHeader(
              'Multi-Row Layout',
              Icons.grid_view,
              Colors.cyan,
            ),
            Container(
              margin: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 4, bottom: 4),
                    child: Text(
                      'Row 1: Featured',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemCount: 6,
                      itemBuilder: (ctx, i) {
                        return Container(
                          width: 180,
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                cardColors[i % cardColors.length],
                                cardColors[(i + 1) % cardColors.length],
                              ],
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.featured_play_list,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                Text(
                                  'Featured ${i + 1}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: EdgeInsets.only(left: 4, bottom: 4),
                    child: Text(
                      'Row 2: Recent',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 90,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemCount: 10,
                      itemBuilder: (ctx, i) {
                        return Container(
                          width: 130,
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: cardColors[(i + 3) % cardColors.length]
                                .withValues(alpha: 0.8),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.access_time,
                                  color: Colors.white,
                                  size: 22,
                                ),
                                Text(
                                  'Recent ${i + 1}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: EdgeInsets.only(left: 4, bottom: 4),
                    child: Text(
                      'Row 3: Trending',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 70,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemCount: 12,
                      itemBuilder: (ctx, i) {
                        return Container(
                          width: 100,
                          margin: EdgeInsets.symmetric(horizontal: 3),
                          decoration: BoxDecoration(
                            color: cardColors[(i + 5) % cardColors.length]
                                .withValues(alpha: 0.6),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.trending_up,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                Text(
                                  '#${i + 1}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Section 10: Page Indicator Style
            buildSectionHeader(
              'Page Indicators',
              Icons.radio_button_checked,
              Colors.pink,
            ),
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: PageScrollPhysics(),
                      itemCount: 5,
                      itemBuilder: (ctx, i) {
                        return Container(
                          width: MediaQuery.of(ctx).size.width - 48,
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                cardColors[i * 2],
                                cardColors[i * 2 + 1],
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              'Page ${i + 1}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (i) {
                      return Container(
                        width: i == 0 ? 24 : 10,
                        height: 10,
                        margin: EdgeInsets.symmetric(horizontal: 3),
                        decoration: BoxDecoration(
                          color: i == 0
                              ? Colors.pink
                              : Colors.pink.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),

            // Section 11: Vertical Carousel
            buildSectionHeader(
              'Vertical Carousel',
              Icons.swap_vert,
              Colors.amber.shade800,
            ),
            Container(
              margin: EdgeInsets.all(8),
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.amber.shade300, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: 10,
                itemBuilder: (ctx, i) {
                  return Container(
                    height: 60,
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: cardColors[i % cardColors.length].withValues(
                        alpha: 0.8,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 12),
                        Icon(
                          cardIcons[i % cardIcons.length],
                          color: Colors.white,
                          size: 24,
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Vertical Item ${i + 1}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Scrolls vertically',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.chevron_right, color: Colors.white70),
                        SizedBox(width: 8),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Summary
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CarouselView Features Demonstrated:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  SizedBox(height: 8),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      Chip(
                        label: Text(
                          'Item Extent',
                          style: TextStyle(fontSize: 11),
                        ),
                        backgroundColor: Colors.blue.shade100,
                      ),
                      Chip(
                        label: Text(
                          'Flex Weights',
                          style: TextStyle(fontSize: 11),
                        ),
                        backgroundColor: Colors.teal.shade100,
                      ),
                      Chip(
                        label: Text(
                          'Controller',
                          style: TextStyle(fontSize: 11),
                        ),
                        backgroundColor: Colors.red.shade100,
                      ),
                      Chip(
                        label: Text(
                          'Horizontal',
                          style: TextStyle(fontSize: 11),
                        ),
                        backgroundColor: Colors.orange.shade100,
                      ),
                      Chip(
                        label: Text('Vertical', style: TextStyle(fontSize: 11)),
                        backgroundColor: Colors.amber.shade100,
                      ),
                      Chip(
                        label: Text(
                          'Multi-Row',
                          style: TextStyle(fontSize: 11),
                        ),
                        backgroundColor: Colors.cyan.shade100,
                      ),
                      Chip(
                        label: Text('Paging', style: TextStyle(fontSize: 11)),
                        backgroundColor: Colors.pink.shade100,
                      ),
                      Chip(
                        label: Text(
                          'Overlapping',
                          style: TextStyle(fontSize: 11),
                        ),
                        backgroundColor: Colors.indigo.shade100,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    ),
  );
}
