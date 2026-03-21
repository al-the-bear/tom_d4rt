// D4rt test script: Tests GridTileBar from material
import 'package:flutter/material.dart';

Widget _buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 18),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF00695C), Color(0xFF26A69A)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Color(0x5500695C),
          blurRadius: 8,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        letterSpacing: 0.5,
      ),
    ),
  );
}

Widget _buildInfoCard(String label, String description) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(bottom: 10),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Color(0xFFE0F2F1),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Color(0xFF80CBC4), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Color(0xFF004D40),
          ),
        ),
        SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(
            fontSize: 13,
            color: Color(0xFF00695C),
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

Widget _buildSubHeader(String title) {
  return Padding(
    padding: EdgeInsets.only(top: 12, bottom: 6),
    child: Row(
      children: [
        Container(
          width: 4,
          height: 22,
          decoration: BoxDecoration(
            color: Color(0xFF26A69A),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF004D40),
          ),
        ),
      ],
    ),
  );
}

Widget _buildPropertyRow(String name, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 140,
          child: Text(
            name,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF00796B),
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF37474F),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildDemoContainer(String label, Widget child) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(bottom: 12),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFFFAFAFA),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Color(0xFFBDBDBD), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF616161),
          ),
        ),
        SizedBox(height: 8),
        child,
      ],
    ),
  );
}

Widget _buildBasicTitleSection() {
  print('Building basic GridTileBar with title only...');
  final bar = GridTileBar(
    title: Text('Basic Title'),
  );
  print('  Created bar with title only');

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFE8F5E9),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF81C784), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Basic GridTileBar - Title Only',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1B5E20),
          ),
        ),
        SizedBox(height: 8),
        Text(
          'The simplest GridTileBar with just a title widget.',
          style: TextStyle(fontSize: 13, color: Color(0xFF388E3C)),
        ),
        SizedBox(height: 12),
        Container(
          color: Color(0xFF424242),
          child: bar,
        ),
        SizedBox(height: 12),
        Container(
          color: Color(0xFF1B5E20),
          child: GridTileBar(
            title: Text('Green Background Title'),
          ),
        ),
        SizedBox(height: 8),
        Container(
          color: Color(0xFF212121),
          child: GridTileBar(
            title: Text(
              'Styled Title Text',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.amber,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildTitleSubtitleSection() {
  print('Building GridTileBar with title and subtitle...');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFE3F2FD),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF90CAF9), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'GridTileBar - Title + Subtitle',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0D47A1),
          ),
        ),
        SizedBox(height: 8),
        Text(
          'GridTileBar supports both title and subtitle widgets for richer content.',
          style: TextStyle(fontSize: 13, color: Color(0xFF1565C0)),
        ),
        SizedBox(height: 12),
        Container(
          color: Color(0xFF37474F),
          child: GridTileBar(
            title: Text('Photo Title'),
            subtitle: Text('Captured in 2024'),
          ),
        ),
        SizedBox(height: 10),
        Container(
          color: Color(0xFF263238),
          child: GridTileBar(
            title: Text(
              'Landscape View',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'Mountain scenery at sunset',
              style: TextStyle(color: Color(0xFFB0BEC5)),
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
          color: Color(0xFF1A237E),
          child: GridTileBar(
            title: Text(
              'Night Sky',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            subtitle: Text(
              'Stars photographed from the alps',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF9FA8DA),
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildLeadingTrailingSection() {
  print('Building GridTileBar with leading and trailing icons...');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFFCE4EC),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFF48FB1), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'GridTileBar - Leading + Title + Trailing',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF880E4F),
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Leading and trailing widgets add actions or decoration around the title area.',
          style: TextStyle(fontSize: 13, color: Color(0xFFC2185B)),
        ),
        SizedBox(height: 12),
        Container(
          color: Color(0xFF424242),
          child: GridTileBar(
            leading: Icon(Icons.photo, color: Colors.white),
            title: Text('Photo Gallery'),
            trailing: Icon(Icons.favorite, color: Colors.red),
          ),
        ),
        SizedBox(height: 10),
        Container(
          color: Color(0xFF37474F),
          child: GridTileBar(
            leading: Icon(Icons.music_note, color: Colors.amber),
            title: Text('Music Collection'),
            subtitle: Text('32 tracks'),
            trailing: Icon(Icons.play_arrow, color: Colors.white),
          ),
        ),
        SizedBox(height: 10),
        Container(
          color: Color(0xFF212121),
          child: GridTileBar(
            leading: CircleAvatar(
              backgroundColor: Colors.teal,
              radius: 18,
              child: Text(
                'JD',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            title: Text('John Doe'),
            subtitle: Text('Profile picture'),
            trailing: Icon(Icons.more_vert, color: Colors.white70),
          ),
        ),
        SizedBox(height: 10),
        Container(
          color: Color(0xFF311B92),
          child: GridTileBar(
            leading: Icon(Icons.video_library, color: Color(0xFFB388FF)),
            title: Text('Video Clips'),
            subtitle: Text('12 items'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.share, color: Colors.white60, size: 20),
                SizedBox(width: 8),
                Icon(Icons.bookmark, color: Colors.white60, size: 20),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildBackgroundColorSection() {
  print('Building GridTileBar with various background colors...');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFFFF3E0),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFFFCC80), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'GridTileBar - Background Colors',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFFE65100),
          ),
        ),
        SizedBox(height: 8),
        Text(
          'The backgroundColor property changes the bar overlay.',
          style: TextStyle(fontSize: 13, color: Color(0xFFEF6C00)),
        ),
        SizedBox(height: 12),
        GridTileBar(
          backgroundColor: Color(0xCC000000),
          title: Text('Black 80% opacity'),
          subtitle: Text('Most common overlay'),
        ),
        SizedBox(height: 6),
        GridTileBar(
          backgroundColor: Color(0xCC1B5E20),
          title: Text('Dark Green'),
          subtitle: Text('Nature theme'),
          leading: Icon(Icons.park, color: Colors.white),
        ),
        SizedBox(height: 6),
        GridTileBar(
          backgroundColor: Color(0xCC0D47A1),
          title: Text('Dark Blue'),
          subtitle: Text('Ocean theme'),
          trailing: Icon(Icons.water, color: Colors.white),
        ),
        SizedBox(height: 6),
        GridTileBar(
          backgroundColor: Color(0xCCBF360C),
          title: Text('Dark Red'),
          subtitle: Text('Fire theme'),
          leading: Icon(Icons.whatshot, color: Colors.amber),
        ),
        SizedBox(height: 6),
        GridTileBar(
          backgroundColor: Color(0xCC4A148C),
          title: Text('Deep Purple'),
          subtitle: Text('Galaxy theme'),
          leading: Icon(Icons.auto_awesome, color: Color(0xFFE1BEE7)),
          trailing: Icon(Icons.star, color: Color(0xFFFFD54F)),
        ),
        SizedBox(height: 6),
        GridTileBar(
          backgroundColor: Color(0xCC827717),
          title: Text('Olive Tinted'),
          subtitle: Text('Vintage style'),
        ),
        SizedBox(height: 6),
        GridTileBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'Transparent background',
            style: TextStyle(color: Color(0xFFE65100)),
          ),
          subtitle: Text(
            'No overlay applied',
            style: TextStyle(color: Color(0xFFFF8F00)),
          ),
        ),
      ],
    ),
  );
}

Widget _buildGridTileHeaderFooterSection() {
  print('Building GridTileBar inside GridTile as header and footer...');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFE8EAF6),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF9FA8DA), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'GridTileBar Inside GridTile',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A237E),
          ),
        ),
        SizedBox(height: 8),
        Text(
          'GridTileBar is typically used as a GridTile header or footer.',
          style: TextStyle(fontSize: 13, color: Color(0xFF283593)),
        ),
        SizedBox(height: 12),
        SizedBox(
          height: 220,
          child: GridTile(
            header: GridTileBar(
              backgroundColor: Color(0xAA000000),
              leading: Icon(Icons.photo_camera, color: Colors.white),
              title: Text('Header Bar'),
              subtitle: Text('Top overlay'),
            ),
            footer: GridTileBar(
              backgroundColor: Color(0xAA000000),
              title: Text('Footer Bar'),
              subtitle: Text('Bottom overlay'),
              trailing: Icon(Icons.info_outline, color: Colors.white),
            ),
            child: Container(
              color: Color(0xFF4CAF50),
              child: Center(
                child: Text(
                  'Image Area',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: GridTile(
            footer: GridTileBar(
              backgroundColor: Color(0xDD1A237E),
              title: Text('Footer Only Tile'),
              subtitle: Text('No header bar here'),
              leading: Icon(Icons.landscape, color: Colors.white),
              trailing: Icon(Icons.favorite_border, color: Colors.pink),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF42A5F5), Color(0xFF1565C0)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Center(
                child: Icon(Icons.image, color: Colors.white70, size: 60),
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: GridTile(
            header: GridTileBar(
              backgroundColor: Color(0xDDBF360C),
              leading: Icon(Icons.videocam, color: Colors.white),
              title: Text('Header Only Tile'),
              trailing: Icon(Icons.download, color: Colors.white),
            ),
            child: Container(
              color: Color(0xFFFF8A65),
              child: Center(
                child: Icon(Icons.play_circle_outline, color: Colors.white, size: 54),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildGridOfTilesSection() {
  print('Building grid of tiles with various GridTileBar configs...');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFF3E5F5),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFCE93D8), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Grid of Tiles with GridTileBars',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4A148C),
          ),
        ),
        SizedBox(height: 8),
        Text(
          'A 2-column grid where each tile uses a different GridTileBar style.',
          style: TextStyle(fontSize: 13, color: Color(0xFF6A1B9A)),
        ),
        SizedBox(height: 12),
        SizedBox(
          height: 520,
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 0.9,
            physics: NeverScrollableScrollPhysics(),
            children: [
              GridTile(
                footer: GridTileBar(
                  backgroundColor: Color(0xCC000000),
                  title: Text('Sunrise'),
                  subtitle: Text('Morning glow'),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFFF8F00), Color(0xFFFFD54F)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              GridTile(
                footer: GridTileBar(
                  backgroundColor: Color(0xCC0D47A1),
                  leading: Icon(Icons.water_drop, color: Colors.white),
                  title: Text('Ocean'),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF0288D1), Color(0xFF01579B)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              GridTile(
                header: GridTileBar(
                  backgroundColor: Color(0xCC1B5E20),
                  title: Text('Forest'),
                  trailing: Icon(Icons.eco, color: Colors.lightGreen),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF2E7D32), Color(0xFF81C784)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              GridTile(
                footer: GridTileBar(
                  backgroundColor: Color(0xCC4A148C),
                  leading: Icon(Icons.nightlight_round, color: Colors.white),
                  title: Text('Night'),
                  subtitle: Text('Stargazing'),
                  trailing: Icon(Icons.star, color: Color(0xFFFFD54F)),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF1A237E), Color(0xFF4A148C)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(8),
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

Widget _buildTextStylesSection() {
  print('Building GridTileBar with various text styles...');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFEFEBE9),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFBCAAA4), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'GridTileBar - Text Styles',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF3E2723),
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Title and subtitle can be any widget, enabling rich text styling.',
          style: TextStyle(fontSize: 13, color: Color(0xFF5D4037)),
        ),
        SizedBox(height: 12),
        GridTileBar(
          backgroundColor: Color(0xFF212121),
          title: Text(
            'Bold Title',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          subtitle: Text(
            'Light subtitle text',
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 12,
              color: Color(0xFF9E9E9E),
            ),
          ),
        ),
        SizedBox(height: 8),
        GridTileBar(
          backgroundColor: Color(0xFF37474F),
          title: Text(
            'Italic Title',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 16,
              color: Color(0xFFB2EBF2),
            ),
          ),
          subtitle: Text(
            'Uppercase subtitle',
            style: TextStyle(
              fontSize: 11,
              letterSpacing: 2.0,
              color: Color(0xFF80CBC4),
            ),
          ),
        ),
        SizedBox(height: 8),
        GridTileBar(
          backgroundColor: Color(0xFF1B5E20),
          title: Text(
            'Large Title',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          subtitle: Text(
            'Small subtitle beneath',
            style: TextStyle(
              fontSize: 10,
              color: Color(0xFFA5D6A7),
            ),
          ),
        ),
        SizedBox(height: 8),
        GridTileBar(
          backgroundColor: Color(0xFF880E4F),
          title: Text(
            'Colored Title',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFFF8BBD0),
            ),
          ),
          subtitle: Text(
            'Different colored subtitle',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFFE1BEE7),
            ),
          ),
        ),
        SizedBox(height: 8),
        GridTileBar(
          backgroundColor: Color(0xFF004D40),
          title: Row(
            children: [
              Icon(Icons.bookmark, color: Colors.amber, size: 16),
              SizedBox(width: 6),
              Text(
                'Row as Title',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          subtitle: Text(
            'Title can be any widget',
            style: TextStyle(
              fontSize: 11,
              color: Color(0xFF80CBC4),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildStandaloneSection() {
  print('Building standalone GridTileBars outside of GridTile...');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFE0F7FA),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF80DEEA), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Standalone GridTileBars',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF006064),
          ),
        ),
        SizedBox(height: 8),
        Text(
          'GridTileBar can render outside of a GridTile as a standalone widget.',
          style: TextStyle(fontSize: 13, color: Color(0xFF00838F)),
        ),
        SizedBox(height: 12),
        GridTileBar(
          backgroundColor: Color(0xFF006064),
          leading: Icon(Icons.folder, color: Colors.white),
          title: Text('Documents'),
          subtitle: Text('42 files'),
          trailing: Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 16),
        ),
        SizedBox(height: 8),
        GridTileBar(
          backgroundColor: Color(0xFF4E342E),
          leading: CircleAvatar(
            backgroundColor: Color(0xFF8D6E63),
            radius: 16,
            child: Icon(Icons.person, color: Colors.white, size: 18),
          ),
          title: Text('User Profile'),
          subtitle: Text('Active now'),
          trailing: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: Color(0xFF4CAF50),
              shape: BoxShape.circle,
            ),
          ),
        ),
        SizedBox(height: 8),
        GridTileBar(
          backgroundColor: Color(0xFF1565C0),
          leading: Icon(Icons.cloud, color: Colors.white),
          title: Text('Cloud Storage'),
          subtitle: Text('75% used'),
          trailing: SizedBox(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(
              value: 0.75,
              strokeWidth: 3,
              color: Colors.white,
              backgroundColor: Color(0xFF0D47A1),
            ),
          ),
        ),
        SizedBox(height: 8),
        GridTileBar(
          backgroundColor: Color(0xFF33691E),
          leading: Icon(Icons.check_circle, color: Color(0xFF76FF03)),
          title: Text('Task Complete'),
          subtitle: Text('All items finished'),
        ),
        SizedBox(height: 8),
        GridTileBar(
          backgroundColor: Color(0xFFBF360C),
          leading: Icon(Icons.warning, color: Color(0xFFFFD54F)),
          title: Text('Warning'),
          subtitle: Text('Storage almost full'),
          trailing: Icon(Icons.close, color: Colors.white70),
        ),
      ],
    ),
  );
}

Widget _buildPropertyReferenceSection() {
  print('Building property reference section...');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFF1F8E9),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFAED581), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'GridTileBar Property Reference',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF33691E),
          ),
        ),
        SizedBox(height: 12),
        _buildPropertyRow('backgroundColor', 'Color? - The background color of the bar'),
        _buildPropertyRow('leading', 'Widget? - Widget to place before the title'),
        _buildPropertyRow('title', 'Widget? - The primary content of the bar'),
        _buildPropertyRow('subtitle', 'Widget? - Additional content below the title'),
        _buildPropertyRow('trailing', 'Widget? - Widget to place after the title'),
        SizedBox(height: 16),
        Text(
          'Usage Notes',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF33691E),
          ),
        ),
        SizedBox(height: 8),
        _buildPropertyRow('Typical use', 'As header or footer of GridTile'),
        _buildPropertyRow('Standalone', 'Can also be used outside GridTile'),
        _buildPropertyRow('Default bg', 'No background color (transparent)'),
        _buildPropertyRow('Title default', 'White text on dark backgrounds'),
        _buildPropertyRow('Subtitle style', 'Slightly smaller, muted color'),
        _buildPropertyRow('Leading size', 'Constrained to fit bar height'),
        _buildPropertyRow('Trailing size', 'Constrained to fit bar height'),
        _buildPropertyRow('Layout', 'Row layout: leading - title/subtitle - trailing'),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('GridTileBar test executing');
  print('========================================');
  print('Testing GridTileBar from material library');
  print('========================================');

  // Debug output for property verification
  print('');
  print('--- Basic GridTileBar Construction ---');
  final basicBar = GridTileBar(
    title: Text('Test Title'),
  );
  print('  Basic bar created successfully');
  print('  Type: $basicBar');

  print('');
  print('--- Full GridTileBar Construction ---');
  final fullBar = GridTileBar(
    backgroundColor: Color(0xCC000000),
    leading: Icon(Icons.photo),
    title: Text('Full Bar'),
    subtitle: Text('With all properties'),
    trailing: Icon(Icons.star),
  );
  print('  Full bar created successfully');
  print('  Type: $fullBar');

  print('');
  print('--- Multiple Background Colors ---');
  List<Color> bgColors = [
    Color(0xCC000000),
    Color(0xCC1A237E),
    Color(0xCC1B5E20),
    Color(0xCCBF360C),
    Color(0xCC4A148C),
    Colors.transparent,
  ];
  List<String> colorNames = [
    'Black 80%',
    'Dark Indigo',
    'Dark Green',
    'Dark Red',
    'Deep Purple',
    'Transparent',
  ];
  int colorIndex = 0;
  while (colorIndex < bgColors.length) {
    Color c = bgColors[colorIndex];
    String name = colorNames[colorIndex];
    GridTileBar testBar = GridTileBar(
      backgroundColor: c,
      title: Text(name),
    );
    print('  Created bar with $name background');
    colorIndex = colorIndex + 1;
  }

  print('');
  print('--- GridTileBar with Various Widget Types ---');
  final barWithCircleAvatar = GridTileBar(
    leading: CircleAvatar(
      backgroundColor: Colors.teal,
      child: Text('A'),
    ),
    title: Text('Avatar leading'),
  );
  print('  Bar with CircleAvatar leading created');

  final barWithRowTitle = GridTileBar(
    title: Row(
      children: [
        Icon(Icons.star, color: Colors.amber, size: 16),
        SizedBox(width: 4),
        Text('Row title widget'),
      ],
    ),
  );
  print('  Bar with Row as title created');

  final barWithTrailingRow = GridTileBar(
    title: Text('Multi trailing'),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.share, color: Colors.white, size: 18),
        SizedBox(width: 6),
        Icon(Icons.bookmark, color: Colors.white, size: 18),
      ],
    ),
  );
  print('  Bar with Row as trailing created');

  print('');
  print('--- GridTile with Header and Footer ---');
  final tileWithBoth = GridTile(
    header: GridTileBar(
      backgroundColor: Color(0xAA000000),
      title: Text('Header'),
    ),
    footer: GridTileBar(
      backgroundColor: Color(0xAA000000),
      title: Text('Footer'),
    ),
    child: Container(color: Colors.blue),
  );
  print('  GridTile with header and footer bar created');

  final tileFooterOnly = GridTile(
    footer: GridTileBar(
      backgroundColor: Color(0xCC000000),
      title: Text('Footer only'),
      subtitle: Text('No header'),
    ),
    child: Container(color: Colors.green),
  );
  print('  GridTile with footer only created');

  final tileHeaderOnly = GridTile(
    header: GridTileBar(
      backgroundColor: Color(0xCC000000),
      leading: Icon(Icons.image, color: Colors.white),
      title: Text('Header only'),
    ),
    child: Container(color: Colors.orange),
  );
  print('  GridTile with header only created');

  print('');
  print('--- Standalone GridTileBar Rendering ---');
  final standaloneBar = GridTileBar(
    backgroundColor: Color(0xFF424242),
    leading: Icon(Icons.folder, color: Colors.white),
    title: Text('Standalone'),
    subtitle: Text('Not inside a GridTile'),
    trailing: Icon(Icons.chevron_right, color: Colors.white),
  );
  print('  Standalone bar created');
  print('  Type: $standaloneBar');

  print('');
  print('========================================');
  print('GridTileBar test completed successfully');
  print('========================================');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title banner
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF00695C), Color(0xFF00897B), Color(0xFF26A69A)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Color(0x4400695C),
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'GridTileBar',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Material Design widget for GridTile headers and footers',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFFB2DFDB),
                ),
              ),
              SizedBox(height: 4),
              Text(
                'package:flutter/material.dart',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF80CBC4),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),

        // Overview
        _buildInfoCard(
          'Overview',
          'GridTileBar is a material design widget that provides a title area '
          'for a GridTile. It is typically used as the header or footer of a '
          'GridTile widget, displaying a title, subtitle, leading widget, and '
          'trailing widget on a colored background.',
        ),
        _buildInfoCard(
          'Key Properties',
          'backgroundColor: Background color of the bar\n'
          'leading: Widget placed before the title area\n'
          'title: Primary content widget of the bar\n'
          'subtitle: Secondary content widget below the title\n'
          'trailing: Widget placed after the title area',
        ),

        // Section 1: Basic title
        _buildSectionHeader('1. Basic GridTileBar - Title Only'),
        _buildBasicTitleSection(),

        // Section 2: Title + Subtitle
        _buildSectionHeader('2. GridTileBar - Title + Subtitle'),
        _buildTitleSubtitleSection(),

        // Section 3: Leading + Title + Trailing
        _buildSectionHeader('3. Leading + Title + Trailing Icons'),
        _buildLeadingTrailingSection(),

        // Section 4: Background colors
        _buildSectionHeader('4. Background Color Variations'),
        _buildBackgroundColorSection(),

        // Section 5: Inside GridTile
        _buildSectionHeader('5. GridTileBar in GridTile (Header/Footer)'),
        _buildGridTileHeaderFooterSection(),

        // Section 6: Grid of tiles
        _buildSectionHeader('6. Grid with Various GridTileBar Configs'),
        _buildGridOfTilesSection(),

        // Section 7: Text styles
        _buildSectionHeader('7. Text Styles and Typography'),
        _buildTextStylesSection(),

        // Section 8: Standalone
        _buildSectionHeader('8. Standalone GridTileBars'),
        _buildStandaloneSection(),

        // Section 9: Property reference
        _buildSectionHeader('9. Property Reference'),
        _buildPropertyReferenceSection(),

        // Section 10: Summary
        _buildSectionHeader('10. Summary'),
        _buildInfoCard(
          'GridTileBar in Practice',
          'GridTileBar is most commonly used with GridTile to create photo '
          'galleries, card grids, and tile-based layouts. It provides a '
          'convenient way to overlay text and icons on tile content. The '
          'backgroundColor property is crucial for readability when placed '
          'over images.',
        ),
        _buildInfoCard(
          'Layout Behavior',
          'GridTileBar uses a Row layout internally:\n'
          '- leading is placed first (left side)\n'
          '- title and subtitle stack vertically in the center\n'
          '- trailing is placed last (right side)\n'
          'The bar stretches to fill the available width.',
        ),
        _buildInfoCard(
          'Best Practices',
          '- Always set backgroundColor for overlays on images\n'
          '- Use semi-transparent black (0xAA000000 or 0xCC000000) for legibility\n'
          '- Keep title text concise for narrow tiles\n'
          '- Use leading for avatars or icons, trailing for actions\n'
          '- Test with different tile sizes to ensure text fits',
        ),

        SizedBox(height: 24),
      ],
    ),
  );
}
