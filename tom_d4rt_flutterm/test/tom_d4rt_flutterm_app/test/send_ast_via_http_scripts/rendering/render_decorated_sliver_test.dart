// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// Deep demo: RenderDecoratedSliver via DecoratedSliver widget
// Tests DecoratedSliver with various Decoration types, positions, and sliver children
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== RenderDecoratedSliver Deep Demo ===');
  print('DecoratedSliver paints a Decoration before or after its sliver child');

  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          SizedBox(height: 24.0),

          // Section 1: Basic DecoratedSliver with BoxDecoration color
          _buildSectionTitle('1. Basic DecoratedSliver with Color'),
          _buildBasicColorSection(context),
          SizedBox(height: 24.0),

          // Section 2: DecoratedSliver with gradient
          _buildSectionTitle('2. DecoratedSliver with Gradient'),
          _buildGradientSection(context),
          SizedBox(height: 24.0),

          // Section 3: DecoratedSliver with border and borderRadius
          _buildSectionTitle('3. Border and BorderRadius'),
          _buildBorderSection(context),
          SizedBox(height: 24.0),

          // Section 4: DecoratedSliver with boxShadow
          _buildSectionTitle('4. BoxShadow Decoration'),
          _buildBoxShadowSection(context),
          SizedBox(height: 24.0),

          // Section 5: DecorationPosition background vs foreground
          _buildSectionTitle('5. Background vs Foreground Position'),
          _buildPositionComparisonSection(context),
          SizedBox(height: 24.0),

          // Section 6: DecoratedSliver wrapping SliverList
          _buildSectionTitle('6. DecoratedSliver with SliverList'),
          _buildSliverListSection(context),
          SizedBox(height: 24.0),

          // Section 7: DecoratedSliver wrapping SliverGrid
          _buildSectionTitle('7. DecoratedSliver with SliverGrid'),
          _buildSliverGridSection(context),
          SizedBox(height: 24.0),

          // Section 8: DecoratedSliver wrapping SliverToBoxAdapter
          _buildSectionTitle('8. DecoratedSliver with SliverToBoxAdapter'),
          _buildSliverToBoxAdapterSection(context),
          SizedBox(height: 24.0),

          // Section 9: DecoratedSliver wrapping SliverPadding
          _buildSectionTitle('9. DecoratedSliver with SliverPadding'),
          _buildSliverPaddingSection(context),
          SizedBox(height: 24.0),

          // Section 10: Multiple DecoratedSlivers in same scroll view
          _buildSectionTitle('10. Multiple DecoratedSlivers Together'),
          _buildMultipleDecoratedSliversSection(context),
          SizedBox(height: 24.0),

          // Section 11: Different decoration types
          _buildSectionTitle('11. Various Decoration Styles'),
          _buildVariousDecorationsSection(context),
          SizedBox(height: 24.0),

          // Section 12: Comparison with DecoratedBox
          _buildSectionTitle('12. DecoratedSliver vs DecoratedBox'),
          _buildComparisonSection(context),
          SizedBox(height: 24.0),

          // Section 13: Complex nested decorations
          _buildSectionTitle('13. Complex Nested Decorations'),
          _buildComplexNestedSection(context),
          SizedBox(height: 32.0),

          _buildFooter(),
        ],
      ),
    ),
  );
}

Widget _buildHeader() {
  print('[Header] Building header with gradient');
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF6A1B9A), Color(0xFF8E24AA), Color(0xFFAB47BC)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Color(0x406A1B9A),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'RenderDecoratedSliver Demo',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'DecoratedSliver paints a Decoration either before or after its sliver child.\n'
          'It wraps any sliver widget and applies BoxDecoration, gradients, borders, shadows.',
          style: TextStyle(fontSize: 14.0, color: Color(0xCCFFFFFF)),
        ),
      ],
    ),
  );
}

Widget _buildSectionTitle(String title) {
  print('[Section] ' + title);
  return Padding(
    padding: EdgeInsets.only(bottom: 12.0),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF7B1FA2), Color(0xFFCE93D8)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    ),
  );
}

Widget _buildFooter() {
  print('[Footer] Building footer');
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFF3E5F5),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFF7B1FA2), width: 1.0),
    ),
    child: Text(
      'End of RenderDecoratedSliver Demo - All sections rendered',
      style: TextStyle(fontSize: 13.0, color: Color(0xFF4A148C)),
      textAlign: TextAlign.center,
    ),
  );
}

// Section 1: Basic color decoration
Widget _buildBasicColorSection(BuildContext context) {
  print('[Section 1] Basic DecoratedSliver with color fill');
  return SizedBox(
    height: 200.0,
    child: CustomScrollView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      slivers: [
        DecoratedSliver(
          decoration: BoxDecoration(color: Color(0xFFE1BEE7)),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((BuildContext ctx, int index) {
              print('[Section 1] Building item ' + index.toString());
              return ListTile(
                leading: Icon(Icons.circle, color: Color(0xFF6A1B9A)),
                title: Text('Color decorated item ' + index.toString()),
                subtitle: Text('Simple background color via DecoratedSliver'),
              );
            }, childCount: 5),
          ),
        ),
      ],
    ),
  );
}

// Section 2: Gradient decoration
Widget _buildGradientSection(BuildContext context) {
  print('[Section 2] DecoratedSliver with gradient decoration');
  return SizedBox(
    height: 220.0,
    child: CustomScrollView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      slivers: [
        DecoratedSliver(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFCE93D8), Color(0xFF80CBC4)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((BuildContext ctx, int index) {
              print('[Section 2] Gradient item ' + index.toString());
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                child: Row(
                  children: [
                    Icon(Icons.gradient, color: Color(0xFF4A148C)),
                    SizedBox(width: 12.0),
                    Text(
                      'Gradient sliver item ' + index.toString(),
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }, childCount: 6),
          ),
        ),
      ],
    ),
  );
}

// Section 3: Border and borderRadius
Widget _buildBorderSection(BuildContext context) {
  print('[Section 3] DecoratedSliver with border and borderRadius');
  return SizedBox(
    height: 200.0,
    child: CustomScrollView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      slivers: [
        DecoratedSliver(
          decoration: BoxDecoration(
            color: Color(0xFFFFF3E0),
            border: Border.all(color: Color(0xFFE65100), width: 2.0),
            borderRadius: BorderRadius.circular(12.0),
          ),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((BuildContext ctx, int index) {
              print('[Section 3] Border item ' + index.toString());
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                child: Text(
                  'Bordered sliver item ' + index.toString(),
                  style: TextStyle(fontSize: 14.0, color: Color(0xFFBF360C)),
                ),
              );
            }, childCount: 6),
          ),
        ),
      ],
    ),
  );
}

// Section 4: BoxShadow decoration
Widget _buildBoxShadowSection(BuildContext context) {
  print('[Section 4] DecoratedSliver with boxShadow');
  return Padding(
    padding: EdgeInsets.all(8.0),
    child: SizedBox(
      height: 180.0,
      child: CustomScrollView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        slivers: [
          DecoratedSliver(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                  color: Color(0x4D9C27B0),
                  blurRadius: 16.0,
                  spreadRadius: 2.0,
                  offset: Offset(0.0, 6.0),
                ),
                BoxShadow(
                  color: Color(0x1A000000),
                  blurRadius: 4.0,
                  offset: Offset(0.0, 2.0),
                ),
              ],
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((
                BuildContext ctx,
                int index,
              ) {
                print('[Section 4] Shadow item ' + index.toString());
                return ListTile(
                  leading: Icon(Icons.wb_sunny, color: Color(0xFFFF8F00)),
                  title: Text('Shadowed sliver item ' + index.toString()),
                );
              }, childCount: 4),
            ),
          ),
        ],
      ),
    ),
  );
}

// Section 5: Background vs foreground position
Widget _buildPositionComparisonSection(BuildContext context) {
  print('[Section 5] Comparing DecorationPosition.background vs foreground');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'DecorationPosition.background (default):',
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.0),
      ),
      SizedBox(height: 6.0),
      SizedBox(
        height: 140.0,
        child: CustomScrollView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          slivers: [
            DecoratedSliver(
              decoration: BoxDecoration(
                color: Color(0xFFBBDEFB),
                borderRadius: BorderRadius.circular(8.0),
              ),
              position: DecorationPosition.background,
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((
                  BuildContext ctx,
                  int index,
                ) {
                  print('[Section 5a] Background pos item ' + index.toString());
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Background decoration item ' + index.toString(),
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Color(0xFF0D47A1),
                      ),
                    ),
                  );
                }, childCount: 3),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 16.0),
      Text(
        'DecorationPosition.foreground:',
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.0),
      ),
      SizedBox(height: 6.0),
      SizedBox(
        height: 140.0,
        child: CustomScrollView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          slivers: [
            DecoratedSliver(
              decoration: BoxDecoration(
                color: Color(0x33E91E63),
                border: Border.all(color: Color(0xFFE91E63), width: 2.0),
                borderRadius: BorderRadius.circular(8.0),
              ),
              position: DecorationPosition.foreground,
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((
                  BuildContext ctx,
                  int index,
                ) {
                  print('[Section 5b] Foreground pos item ' + index.toString());
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Foreground decoration item ' + index.toString(),
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Color(0xFF880E4F),
                      ),
                    ),
                  );
                }, childCount: 3),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// Section 6: DecoratedSliver with SliverList
Widget _buildSliverListSection(BuildContext context) {
  print('[Section 6] DecoratedSliver wrapping SliverList with many items');
  List<String> items = [
    'Alpha',
    'Beta',
    'Gamma',
    'Delta',
    'Epsilon',
    'Zeta',
    'Eta',
    'Theta',
  ];
  return SizedBox(
    height: 300.0,
    child: CustomScrollView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      slivers: [
        DecoratedSliver(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [Color(0xFFE8EAF6), Color(0xFFC5CAE9)],
              center: Alignment.center,
              radius: 1.2,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((BuildContext ctx, int index) {
              String itemName = items[index];
              print('[Section 6] SliverList item: ' + itemName);
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color(0xFF283593),
                    child: Text(
                      itemName.substring(0, 1),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(itemName),
                  subtitle: Text('Greek letter #' + index.toString()),
                  trailing: Icon(Icons.arrow_forward_ios, size: 14.0),
                ),
              );
            }, childCount: items.length),
          ),
        ),
      ],
    ),
  );
}

// Section 7: DecoratedSliver wrapping SliverGrid
Widget _buildSliverGridSection(BuildContext context) {
  print('[Section 7] DecoratedSliver wrapping SliverGrid');
  return SizedBox(
    height: 260.0,
    child: CustomScrollView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      slivers: [
        DecoratedSliver(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE0F7FA), Color(0xFFB2EBF2), Color(0xFF80DEEA)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Color(0xFF00ACC1), width: 1.5),
          ),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              childAspectRatio: 1.2,
            ),
            delegate: SliverChildBuilderDelegate((BuildContext ctx, int index) {
              print('[Section 7] Grid item ' + index.toString());
              List<IconData> icons = [
                Icons.star,
                Icons.favorite,
                Icons.bolt,
                Icons.palette,
                Icons.music_note,
                Icons.camera,
                Icons.cloud,
                Icons.rocket_launch,
                Icons.diamond,
              ];
              IconData icon = icons[index % icons.length];
              return Container(
                margin: EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x1A000000),
                      blurRadius: 4.0,
                      offset: Offset(0.0, 2.0),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, color: Color(0xFF00838F), size: 28.0),
                    SizedBox(height: 4.0),
                    Text(
                      'Grid ' + index.toString(),
                      style: TextStyle(fontSize: 11.0),
                    ),
                  ],
                ),
              );
            }, childCount: 9),
          ),
        ),
      ],
    ),
  );
}

// Section 8: DecoratedSliver with SliverToBoxAdapter
Widget _buildSliverToBoxAdapterSection(BuildContext context) {
  print('[Section 8] DecoratedSliver with SliverToBoxAdapter');
  return SizedBox(
    height: 180.0,
    child: CustomScrollView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      slivers: [
        DecoratedSliver(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFCE4EC), Color(0xFFF8BBD0)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          sliver: SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SliverToBoxAdapter Content',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFC2185B),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'This is a regular widget wrapped inside a SliverToBoxAdapter, '
                    'which is then wrapped by DecoratedSliver to add a gradient background.',
                    style: TextStyle(fontSize: 13.0, color: Color(0xFF880E4F)),
                  ),
                  SizedBox(height: 12.0),
                  Row(
                    children: [
                      Icon(Icons.info_outline, color: Color(0xFFAD1457)),
                      SizedBox(width: 8.0),
                      Text(
                        'Decorated non-scrollable sliver content',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Color(0xFFAD1457),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// Section 9: DecoratedSliver wrapping SliverPadding
Widget _buildSliverPaddingSection(BuildContext context) {
  print('[Section 9] DecoratedSliver wrapping SliverPadding');
  return SizedBox(
    height: 200.0,
    child: CustomScrollView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      slivers: [
        DecoratedSliver(
          decoration: BoxDecoration(
            color: Color(0xFFF1F8E9),
            border: Border.all(color: Color(0xFF558B2F), width: 1.5),
            borderRadius: BorderRadius.circular(10.0),
          ),
          sliver: SliverPadding(
            padding: EdgeInsets.all(12.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((
                BuildContext ctx,
                int index,
              ) {
                print('[Section 9] Padded sliver item ' + index.toString());
                return Container(
                  margin: EdgeInsets.only(bottom: 6.0),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.eco, color: Color(0xFF33691E), size: 20.0),
                      SizedBox(width: 10.0),
                      Text(
                        'Padded sliver child ' + index.toString(),
                        style: TextStyle(color: Color(0xFF33691E)),
                      ),
                    ],
                  ),
                );
              }, childCount: 4),
            ),
          ),
        ),
      ],
    ),
  );
}

// Section 10: Multiple DecoratedSlivers in same scroll view
Widget _buildMultipleDecoratedSliversSection(BuildContext context) {
  print('[Section 10] Multiple DecoratedSlivers in one CustomScrollView');
  return SizedBox(
    height: 360.0,
    child: CustomScrollView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      slivers: [
        // First decorated sliver - purple theme
        DecoratedSliver(
          decoration: BoxDecoration(
            color: Color(0xFFEDE7F6),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
            ),
          ),
          sliver: SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Section A - Purple Theme',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A148C),
                ),
              ),
            ),
          ),
        ),
        DecoratedSliver(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFD1C4E9), Color(0xFFB39DDB)],
            ),
          ),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((BuildContext ctx, int index) {
              print('[Section 10a] Purple item ' + index.toString());
              return ListTile(
                dense: true,
                leading: Icon(
                  Icons.square,
                  color: Color(0xFF6A1B9A),
                  size: 16.0,
                ),
                title: Text('Purple list item ' + index.toString()),
              );
            }, childCount: 3),
          ),
        ),
        // Second decorated sliver - teal theme
        DecoratedSliver(
          decoration: BoxDecoration(color: Color(0xFFE0F2F1)),
          sliver: SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Section B - Teal Theme',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF004D40),
                ),
              ),
            ),
          ),
        ),
        DecoratedSliver(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF80CBC4), Color(0xFF4DB6AC)],
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12.0),
              bottomRight: Radius.circular(12.0),
            ),
          ),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((BuildContext ctx, int index) {
              print('[Section 10b] Teal item ' + index.toString());
              return ListTile(
                dense: true,
                leading: Icon(
                  Icons.circle,
                  color: Color(0xFF00695C),
                  size: 16.0,
                ),
                title: Text('Teal list item ' + index.toString()),
              );
            }, childCount: 3),
          ),
        ),
      ],
    ),
  );
}

// Section 11: Various decoration styles
Widget _buildVariousDecorationsSection(BuildContext context) {
  print('[Section 11] Showcasing various decoration styles');
  return Column(
    children: [
      // Radial gradient decoration
      Text(
        'Radial Gradient:',
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.0),
      ),
      SizedBox(height: 6.0),
      SizedBox(
        height: 120.0,
        child: CustomScrollView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          slivers: [
            DecoratedSliver(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    Color(0xFFFFF9C4),
                    Color(0xFFFFEE58),
                    Color(0xFFFDD835),
                  ],
                  center: Alignment.topRight,
                  radius: 1.5,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              sliver: SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    'Radial gradient decoration behind sliver content. '
                    'The gradient radiates from the top-right corner.',
                    style: TextStyle(fontSize: 13.0, color: Color(0xFFF57F17)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 16.0),
      // Sweep gradient decoration
      Text(
        'Sweep Gradient:',
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.0),
      ),
      SizedBox(height: 6.0),
      SizedBox(
        height: 120.0,
        child: CustomScrollView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          slivers: [
            DecoratedSliver(
              decoration: BoxDecoration(
                gradient: SweepGradient(
                  colors: [
                    Color(0xFFE8EAF6),
                    Color(0xFFC5CAE9),
                    Color(0xFF9FA8DA),
                    Color(0xFFE8EAF6),
                  ],
                  center: Alignment.center,
                ),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Color(0xFF3F51B5), width: 1.0),
              ),
              sliver: SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    'Sweep gradient decoration creates a circular color sweep effect '
                    'behind the sliver content, visible in the background.',
                    style: TextStyle(fontSize: 13.0, color: Color(0xFF1A237E)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 16.0),
      // Thick border with rounded corners
      Text(
        'Thick Rounded Border:',
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.0),
      ),
      SizedBox(height: 6.0),
      SizedBox(
        height: 100.0,
        child: CustomScrollView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          slivers: [
            DecoratedSliver(
              decoration: BoxDecoration(
                color: Color(0xFFFFF8E1),
                border: Border.all(color: Color(0xFFFF6F00), width: 3.0),
                borderRadius: BorderRadius.circular(20.0),
              ),
              sliver: SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Thick rounded border on DecoratedSliver',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFE65100),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// Section 12: Comparison with DecoratedBox
Widget _buildComparisonSection(BuildContext context) {
  print('[Section 12] Comparing DecoratedSliver with DecoratedBox');
  BoxDecoration sharedDecoration = BoxDecoration(
    gradient: LinearGradient(
      colors: [Color(0xFFB3E5FC), Color(0xFF81D4FA)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(color: Color(0xFF0277BD), width: 1.5),
    boxShadow: [
      BoxShadow(
        color: Color(0x330277BD),
        blurRadius: 8.0,
        offset: Offset(0.0, 3.0),
      ),
    ],
  );
  print('[Section 12] Using identical BoxDecoration for both');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'DecoratedBox (non-sliver):',
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.0),
      ),
      SizedBox(height: 6.0),
      DecoratedBox(
        decoration: sharedDecoration,
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'This uses DecoratedBox',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF01579B),
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  'A regular box widget with decoration applied. '
                  'Works with any box child widget.',
                  style: TextStyle(fontSize: 12.0, color: Color(0xFF0277BD)),
                ),
              ],
            ),
          ),
        ),
      ),
      SizedBox(height: 16.0),
      Text(
        'DecoratedSliver (sliver version):',
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.0),
      ),
      SizedBox(height: 6.0),
      SizedBox(
        height: 120.0,
        child: CustomScrollView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          slivers: [
            DecoratedSliver(
              decoration: sharedDecoration,
              sliver: SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'This uses DecoratedSliver',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF01579B),
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        'The sliver equivalent of DecoratedBox. '
                        'Must wrap a sliver child and live inside a CustomScrollView.',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Color(0xFF0277BD),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 8.0),
      Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Text(
          'Both share the same BoxDecoration. DecoratedSliver uses '
          'RenderDecoratedSliver internally to paint the decoration '
          'around sliver geometry instead of box constraints.',
          style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic),
        ),
      ),
    ],
  );
}

// Section 13: Complex nested decorations
Widget _buildComplexNestedSection(BuildContext context) {
  print('[Section 13] Complex nested decorated slivers');
  return SizedBox(
    height: 400.0,
    child: CustomScrollView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      slivers: [
        // Header decorated sliver
        DecoratedSliver(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF311B92), Color(0xFF4527A0), Color(0xFF512DA8)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          sliver: SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.auto_awesome, color: Colors.amber, size: 28.0),
                  SizedBox(width: 12.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Complex Layout',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Multiple decoration styles combined',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Color(0xB3FFFFFF),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        // Body with subtle background
        DecoratedSliver(
          decoration: BoxDecoration(color: Color(0xFFF5F5F5)),
          sliver: SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                childAspectRatio: 1.8,
              ),
              delegate: SliverChildBuilderDelegate((
                BuildContext ctx,
                int index,
              ) {
                print('[Section 13] Complex grid item ' + index.toString());
                List<Color> cardColors = [
                  Color(0xFFE8EAF6),
                  Color(0xFFE0F2F1),
                  Color(0xFFFFF3E0),
                  Color(0xFFFCE4EC),
                  Color(0xFFF1F8E9),
                  Color(0xFFE3F2FD),
                ];
                List<String> labels = [
                  'Analytics',
                  'Reports',
                  'Settings',
                  'Profile',
                  'Storage',
                  'Network',
                ];
                Color cardColor = cardColors[index % cardColors.length];
                String label = labels[index % labels.length];
                return Container(
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Color(0x1A000000)),
                  ),
                  child: Center(
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }, childCount: 6),
            ),
          ),
        ),
        // Footer decorated sliver
        DecoratedSliver(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF512DA8), Color(0xFF4527A0), Color(0xFF311B92)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16.0),
              bottomRight: Radius.circular(16.0),
            ),
          ),
          sliver: SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Color(0xFF69F0AE),
                    size: 18.0,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    'All decorated slivers rendered successfully',
                    style: TextStyle(fontSize: 12.0, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
