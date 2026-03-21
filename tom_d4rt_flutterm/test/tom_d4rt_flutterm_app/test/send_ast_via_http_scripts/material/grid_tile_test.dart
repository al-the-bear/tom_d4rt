// D4rt test script: Tests GridTile from material
import 'package:flutter/material.dart';

Widget _buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 18),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Color(0x551565C0),
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
      color: Color(0xFFE3F2FD),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Color(0xFF90CAF9), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Color(0xFF0D47A1),
          ),
        ),
        SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(fontSize: 13, color: Color(0xFF1565C0), height: 1.4),
        ),
      ],
    ),
  );
}

Widget buildSubHeader(String title) {
  return Padding(
    padding: EdgeInsets.only(top: 12, bottom: 6),
    child: Row(
      children: [
        Container(
          width: 4,
          height: 22,
          decoration: BoxDecoration(
            color: Color(0xFF42A5F5),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF0D47A1),
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
              color: Color(0xFF1565C0),
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 13, color: Color(0xFF37474F)),
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

Widget _buildBasicChildSection() {
  print('Building basic GridTile with colored container child...');
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
          'GridTile - Basic Child Only',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0D47A1),
          ),
        ),
        SizedBox(height: 8),
        Text(
          'A GridTile with only a child widget and no header or footer overlays.',
          style: TextStyle(fontSize: 13, color: Color(0xFF1565C0)),
        ),
        SizedBox(height: 12),
        _buildDemoContainer(
          'Simple colored container',
          SizedBox(
            height: 160,
            child: GridTile(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF42A5F5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'Basic GridTile',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        _buildDemoContainer(
          'Gradient background child',
          SizedBox(
            height: 160,
            child: GridTile(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF7B1FA2), Color(0xFFCE93D8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Icon(Icons.gradient, color: Colors.white, size: 48),
                ),
              ),
            ),
          ),
        ),
        _buildDemoContainer(
          'Child with centered icon and text',
          SizedBox(
            height: 160,
            child: GridTile(
              child: Container(
                color: Color(0xFF00695C),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.image, color: Colors.white70, size: 40),
                    SizedBox(height: 8),
                    Text(
                      'Image Placeholder',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildHeaderSection() {
  print('Building GridTile with header (GridTileBar)...');
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
          'GridTile - With Header',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF880E4F),
          ),
        ),
        SizedBox(height: 8),
        Text(
          'The header property accepts a widget that overlays the top of the tile.',
          style: TextStyle(fontSize: 13, color: Color(0xFFC2185B)),
        ),
        SizedBox(height: 12),
        _buildDemoContainer(
          'Header with title only',
          SizedBox(
            height: 180,
            child: GridTile(
              header: GridTileBar(
                backgroundColor: Color(0xAA000000),
                title: Text('Photo Title'),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFE91E63), Color(0xFFF06292)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                  child: Icon(Icons.photo, color: Colors.white70, size: 48),
                ),
              ),
            ),
          ),
        ),
        _buildDemoContainer(
          'Header with leading icon and title',
          SizedBox(
            height: 180,
            child: GridTile(
              header: GridTileBar(
                backgroundColor: Color(0xCC1A237E),
                leading: Icon(Icons.camera_alt, color: Colors.white),
                title: Text('Camera Shots'),
              ),
              child: Container(
                color: Color(0xFF3F51B5),
                child: Center(
                  child: Icon(Icons.camera, color: Colors.white54, size: 56),
                ),
              ),
            ),
          ),
        ),
        _buildDemoContainer(
          'Header with title, subtitle and trailing',
          SizedBox(
            height: 200,
            child: GridTile(
              header: GridTileBar(
                backgroundColor: Color(0xCC4A148C),
                title: Text(
                  'Sunset Gallery',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('24 photos'),
                trailing: Icon(Icons.more_vert, color: Colors.white70),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFFF6F00), Color(0xFFFFCA28)],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                ),
                child: Center(
                  child: Icon(Icons.wb_sunny, color: Colors.white, size: 52),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildFooterSection() {
  print('Building GridTile with footer (GridTileBar)...');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFE8F5E9),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFA5D6A7), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'GridTile - With Footer',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1B5E20),
          ),
        ),
        SizedBox(height: 8),
        Text(
          'The footer property accepts a widget that overlays the bottom of the tile.',
          style: TextStyle(fontSize: 13, color: Color(0xFF2E7D32)),
        ),
        SizedBox(height: 12),
        _buildDemoContainer(
          'Footer with title',
          SizedBox(
            height: 180,
            child: GridTile(
              footer: GridTileBar(
                backgroundColor: Color(0xAA000000),
                title: Text('Mountain View'),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF2E7D32), Color(0xFF66BB6A)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                  child: Icon(Icons.landscape, color: Colors.white70, size: 48),
                ),
              ),
            ),
          ),
        ),
        _buildDemoContainer(
          'Footer with leading, title and subtitle',
          SizedBox(
            height: 180,
            child: GridTile(
              footer: GridTileBar(
                backgroundColor: Color(0xCC006064),
                leading: Icon(Icons.water, color: Colors.white),
                title: Text('Ocean Waves'),
                subtitle: Text('Pacific coast'),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF0097A7), Color(0xFF00BCD4)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Icon(Icons.waves, color: Colors.white60, size: 52),
                ),
              ),
            ),
          ),
        ),
        _buildDemoContainer(
          'Footer with all properties',
          SizedBox(
            height: 200,
            child: GridTile(
              footer: GridTileBar(
                backgroundColor: Color(0xDD37474F),
                leading: Icon(Icons.music_note, color: Colors.amber),
                title: Text(
                  'Music Collection',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('42 tracks available'),
                trailing: Icon(Icons.play_arrow, color: Colors.white),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF263238), Color(0xFF455A64)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.headphones,
                    color: Color(0xFFFFD54F),
                    size: 56,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildHeaderFooterSection() {
  print('Building GridTile with both header and footer...');
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
          'GridTile - Header + Footer Combined',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFFE65100),
          ),
        ),
        SizedBox(height: 8),
        Text(
          'GridTile supports both header and footer simultaneously for rich overlays.',
          style: TextStyle(fontSize: 13, color: Color(0xFFEF6C00)),
        ),
        SizedBox(height: 12),
        _buildDemoContainer(
          'Full header and footer combo',
          SizedBox(
            height: 240,
            child: GridTile(
              header: GridTileBar(
                backgroundColor: Color(0xAA000000),
                leading: Icon(Icons.photo_camera, color: Colors.white),
                title: Text('Nature Photography'),
                subtitle: Text('Spring Collection'),
              ),
              footer: GridTileBar(
                backgroundColor: Color(0xAA000000),
                title: Text('By Artist Studio'),
                trailing: Icon(Icons.favorite, color: Colors.red),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF4CAF50),
                      Color(0xFF81C784),
                      Color(0xFFC8E6C9),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                  child: Icon(Icons.park, color: Colors.white, size: 60),
                ),
              ),
            ),
          ),
        ),
        _buildDemoContainer(
          'Dark-themed header and footer',
          SizedBox(
            height: 240,
            child: GridTile(
              header: GridTileBar(
                backgroundColor: Color(0xDD1A237E),
                leading: Icon(Icons.videocam, color: Colors.white),
                title: Text(
                  'Video Clip',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Icon(Icons.hd, color: Color(0xFFFFD54F)),
              ),
              footer: GridTileBar(
                backgroundColor: Color(0xDD1A237E),
                leading: Icon(Icons.timer, color: Colors.white70),
                title: Text('Duration: 3m 24s'),
                subtitle: Text('1080p quality'),
                trailing: Icon(Icons.download, color: Colors.white),
              ),
              child: Container(
                color: Color(0xFF283593),
                child: Center(
                  child: Icon(
                    Icons.play_circle_outline,
                    color: Colors.white70,
                    size: 64,
                  ),
                ),
              ),
            ),
          ),
        ),
        _buildDemoContainer(
          'Warm-toned header and footer',
          SizedBox(
            height: 220,
            child: GridTile(
              header: GridTileBar(
                backgroundColor: Color(0xCCBF360C),
                title: Text('Desert Sunset'),
                trailing: Icon(Icons.wb_sunny, color: Color(0xFFFFD54F)),
              ),
              footer: GridTileBar(
                backgroundColor: Color(0xCCBF360C),
                leading: Icon(Icons.location_on, color: Colors.white),
                title: Text('Arizona, USA'),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFFF6F00),
                      Color(0xFFFF8F00),
                      Color(0xFFFFCA28),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildGridViewSection() {
  print('Building GridView with multiple GridTiles...');
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
          'GridView with Multiple GridTiles',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A237E),
          ),
        ),
        SizedBox(height: 8),
        Text(
          'A 2-column GridView showcasing diverse GridTile configurations in context.',
          style: TextStyle(fontSize: 13, color: Color(0xFF283593)),
        ),
        SizedBox(height: 12),
        SizedBox(
          height: 560,
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 0.85,
            physics: NeverScrollableScrollPhysics(),
            children: [
              GridTile(
                footer: GridTileBar(
                  backgroundColor: Color(0xCC000000),
                  title: Text('Sunrise'),
                  subtitle: Text('Golden hour'),
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
                  child: Center(
                    child: Icon(Icons.wb_sunny, color: Colors.white, size: 36),
                  ),
                ),
              ),
              GridTile(
                header: GridTileBar(
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
                  child: Center(
                    child: Icon(Icons.waves, color: Colors.white60, size: 36),
                  ),
                ),
              ),
              GridTile(
                header: GridTileBar(
                  backgroundColor: Color(0xCC1B5E20),
                  title: Text('Forest'),
                  trailing: Icon(Icons.eco, color: Colors.lightGreen),
                ),
                footer: GridTileBar(
                  backgroundColor: Color(0xCC1B5E20),
                  title: Text('12 species'),
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
                  child: Center(
                    child: Icon(
                      Icons.brightness_3,
                      color: Colors.white38,
                      size: 36,
                    ),
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

Widget _buildDiverseContentSection() {
  print('Building GridTiles with different child content...');
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
          'GridTiles with Diverse Child Content',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4A148C),
          ),
        ),
        SizedBox(height: 8),
        Text(
          'GridTile child can be any widget: icons, text, colored boxes, and more.',
          style: TextStyle(fontSize: 13, color: Color(0xFF6A1B9A)),
        ),
        SizedBox(height: 12),
        _buildDemoContainer(
          'Large centered icon child',
          SizedBox(
            height: 180,
            child: GridTile(
              footer: GridTileBar(
                backgroundColor: Color(0xCC000000),
                title: Text('Icon Child'),
              ),
              child: Container(
                color: Color(0xFF6A1B9A),
                child: Center(
                  child: Icon(Icons.star, color: Color(0xFFFFD54F), size: 72),
                ),
              ),
            ),
          ),
        ),
        _buildDemoContainer(
          'Text-heavy child with column layout',
          SizedBox(
            height: 200,
            child: GridTile(
              header: GridTileBar(
                backgroundColor: Color(0xCC37474F),
                title: Text('Article Preview'),
              ),
              child: Container(
                color: Color(0xFFECEFF1),
                padding: EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Intro to Flutter',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF263238),
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Flutter is an open-source UI toolkit for building natively '
                      'compiled applications for mobile, web, and desktop.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF546E7A),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        _buildDemoContainer(
          'Colored box mosaic child',
          SizedBox(
            height: 200,
            child: GridTile(
              footer: GridTileBar(
                backgroundColor: Color(0xCC212121),
                title: Text('Color Palette'),
                subtitle: Text('Material Colors'),
              ),
              child: Container(
                padding: EdgeInsets.all(8),
                color: Color(0xFFF5F5F5),
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(child: Container(color: Color(0xFFE53935))),
                          SizedBox(width: 4),
                          Expanded(child: Container(color: Color(0xFF1E88E5))),
                          SizedBox(width: 4),
                          Expanded(child: Container(color: Color(0xFF43A047))),
                        ],
                      ),
                    ),
                    SizedBox(height: 4),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(child: Container(color: Color(0xFFFDD835))),
                          SizedBox(width: 4),
                          Expanded(child: Container(color: Color(0xFF8E24AA))),
                          SizedBox(width: 4),
                          Expanded(child: Container(color: Color(0xFFFF6D00))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        _buildDemoContainer(
          'Icon grid child',
          SizedBox(
            height: 200,
            child: GridTile(
              header: GridTileBar(
                backgroundColor: Color(0xCC006064),
                title: Text('App Launcher'),
              ),
              child: Container(
                color: Color(0xFFE0F7FA),
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.phone, color: Color(0xFF00695C), size: 32),
                        Icon(Icons.email, color: Color(0xFF00695C), size: 32),
                        Icon(Icons.chat, color: Color(0xFF00695C), size: 32),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.settings,
                          color: Color(0xFF00695C),
                          size: 32,
                        ),
                        Icon(Icons.camera, color: Color(0xFF00695C), size: 32),
                        Icon(Icons.map, color: Color(0xFF00695C), size: 32),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildVaryingStylesSection() {
  print('Building GridTiles with varying header/footer styles...');
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
          'Varying Header/Footer Styles',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF3E2723),
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Headers and footers can be any widget, not just GridTileBar.',
          style: TextStyle(fontSize: 13, color: Color(0xFF5D4037)),
        ),
        SizedBox(height: 12),
        _buildDemoContainer(
          'Custom Container as header',
          SizedBox(
            height: 200,
            child: GridTile(
              header: Container(
                padding: EdgeInsets.all(10),
                color: Color(0xCC3E2723),
                child: Row(
                  children: [
                    Icon(Icons.bookmark, color: Colors.amber, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Custom Header Widget',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF5D4037), Color(0xFF8D6E63)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                  child: Icon(Icons.menu_book, color: Colors.white54, size: 48),
                ),
              ),
            ),
          ),
        ),
        _buildDemoContainer(
          'Colored banner as footer',
          SizedBox(
            height: 200,
            child: GridTile(
              footer: Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xCC880E4F), Color(0xCCC2185B)],
                  ),
                ),
                child: Text(
                  'Gradient Footer Banner',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              child: Container(
                color: Color(0xFFFCE4EC),
                child: Center(
                  child: Icon(
                    Icons.favorite,
                    color: Color(0xFFE91E63),
                    size: 48,
                  ),
                ),
              ),
            ),
          ),
        ),
        _buildDemoContainer(
          'Transparent header with styled text',
          SizedBox(
            height: 200,
            child: GridTile(
              header: GridTileBar(
                backgroundColor: Colors.transparent,
                title: Text(
                  'Transparent Overlay',
                  style: TextStyle(
                    color: Color(0xFF1B5E20),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    shadows: [Shadow(color: Colors.white, blurRadius: 4)],
                  ),
                ),
              ),
              footer: GridTileBar(
                backgroundColor: Color(0xCC1B5E20),
                title: Text('Opaque footer below'),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFA5D6A7), Color(0xFFC8E6C9)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          ),
        ),
        _buildDemoContainer(
          'Footer with CircleAvatar and Row',
          SizedBox(
            height: 200,
            child: GridTile(
              footer: GridTileBar(
                backgroundColor: Color(0xDD263238),
                leading: CircleAvatar(
                  backgroundColor: Color(0xFF00BCD4),
                  radius: 16,
                  child: Text(
                    'AB',
                    style: TextStyle(color: Colors.white, fontSize: 11),
                  ),
                ),
                title: Text('Alex Brown'),
                subtitle: Text('Travel photographer'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.share, color: Colors.white60, size: 18),
                    SizedBox(width: 6),
                    Icon(
                      Icons.bookmark_border,
                      color: Colors.white60,
                      size: 18,
                    ),
                  ],
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF00796B), Color(0xFF26A69A)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Icon(Icons.flight, color: Colors.white70, size: 48),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildStandaloneSection() {
  print('Building standalone GridTile demos outside GridView...');
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
          'Standalone GridTile Demos',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF006064),
          ),
        ),
        SizedBox(height: 8),
        Text(
          'GridTile renders fine outside of a GridView, as a standalone widget.',
          style: TextStyle(fontSize: 13, color: Color(0xFF00838F)),
        ),
        SizedBox(height: 12),
        _buildDemoContainer(
          'Standalone tile - no overlay',
          SizedBox(
            height: 160,
            child: GridTile(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF0097A7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'No Header or Footer',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        _buildDemoContainer(
          'Standalone tile - footer only',
          SizedBox(
            height: 180,
            child: GridTile(
              footer: GridTileBar(
                backgroundColor: Color(0xCC000000),
                leading: Icon(Icons.info_outline, color: Colors.white),
                title: Text('Standalone Footer'),
                subtitle: Text('Works outside GridView'),
              ),
              child: Container(
                color: Color(0xFF00ACC1),
                child: Center(
                  child: Icon(
                    Icons.check_circle_outline,
                    color: Colors.white70,
                    size: 48,
                  ),
                ),
              ),
            ),
          ),
        ),
        _buildDemoContainer(
          'Standalone tile - header and footer',
          SizedBox(
            height: 220,
            child: GridTile(
              header: GridTileBar(
                backgroundColor: Color(0xCC006064),
                title: Text('Standalone Header'),
                trailing: Icon(Icons.push_pin, color: Colors.amber),
              ),
              footer: GridTileBar(
                backgroundColor: Color(0xCC006064),
                leading: Icon(
                  Icons.calendar_today,
                  color: Colors.white70,
                  size: 18,
                ),
                title: Text('March 2026'),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF00838F), Color(0xFF26C6DA)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.event, color: Colors.white, size: 40),
                      SizedBox(height: 8),
                      Text(
                        'Event Tile',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
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
          'GridTile Property Reference',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF33691E),
          ),
        ),
        SizedBox(height: 12),
        _buildPropertyRow(
          'header',
          'Widget? - Widget overlaid on top of the tile',
        ),
        _buildPropertyRow(
          'footer',
          'Widget? - Widget overlaid on bottom of the tile',
        ),
        _buildPropertyRow(
          'child',
          'Widget - The main content of the tile (required)',
        ),
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
        _buildPropertyRow('Typical use', 'Inside a GridView as a grid cell'),
        _buildPropertyRow(
          'Standalone',
          'Can also render outside of a GridView',
        ),
        _buildPropertyRow(
          'Header widget',
          'Typically a GridTileBar, but any widget works',
        ),
        _buildPropertyRow(
          'Footer widget',
          'Typically a GridTileBar, but any widget works',
        ),
        _buildPropertyRow('Child required', 'The child property is required'),
        _buildPropertyRow(
          'Overlay layout',
          'Header/footer use Stack to overlay child',
        ),
        _buildPropertyRow('Sizing', 'Sizes to fill available space in grid'),
        _buildPropertyRow(
          'Content area',
          'Child fills entire tile, header/footer overlay on top',
        ),
        SizedBox(height: 16),
        Text(
          'Common Patterns',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF33691E),
          ),
        ),
        SizedBox(height: 8),
        _buildPropertyRow('Image tile', 'Image child with GridTileBar footer'),
        _buildPropertyRow(
          'Gallery tile',
          'Image child with header title and footer actions',
        ),
        _buildPropertyRow('Info tile', 'Colored child with footer label'),
        _buildPropertyRow(
          'Action tile',
          'Child content with header containing action icons',
        ),
        _buildPropertyRow(
          'Profile tile',
          'Avatar child with footer name and subtitle',
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('GridTile test executing');
  print('========================================');
  print('Testing GridTile from material library');
  print('========================================');

  // Debug output for basic construction
  print('');
  print('--- Basic GridTile Construction ---');
  final basicTile = GridTile(child: Container(color: Colors.blue));
  print('  Basic tile created (child only)');
  print('  Type: $basicTile');

  print('');
  print('--- GridTile with Header ---');
  final headerTile = GridTile(
    header: GridTileBar(
      backgroundColor: Color(0xAA000000),
      title: Text('Header Title'),
    ),
    child: Container(color: Colors.green),
  );
  print('  Tile with header created');
  print('  Type: $headerTile');

  print('');
  print('--- GridTile with Footer ---');
  final footerTile = GridTile(
    footer: GridTileBar(
      backgroundColor: Color(0xAA000000),
      title: Text('Footer Title'),
      subtitle: Text('Subtitle text'),
    ),
    child: Container(color: Colors.orange),
  );
  print('  Tile with footer created');
  print('  Type: $footerTile');

  print('');
  print('--- GridTile with Header and Footer ---');
  final fullTile = GridTile(
    header: GridTileBar(
      backgroundColor: Color(0xCC000000),
      leading: Icon(Icons.photo),
      title: Text('Full Tile'),
    ),
    footer: GridTileBar(
      backgroundColor: Color(0xCC000000),
      title: Text('Footer Info'),
      trailing: Icon(Icons.star),
    ),
    child: Container(color: Colors.purple),
  );
  print('  Tile with header and footer created');
  print('  Type: $fullTile');

  print('');
  print('--- Testing Various Child Widgets ---');
  List<String> childTypes = [
    'Container',
    'Icon',
    'Column',
    'Colored box',
    'Gradient',
  ];
  int childIndex = 0;
  while (childIndex < childTypes.length) {
    String childType = childTypes[childIndex];
    print('  Testing child type: $childType');
    childIndex = childIndex + 1;
  }

  print('');
  print('--- GridTile in GridView Context ---');
  List<String> tileNames = [
    'Sunrise tile',
    'Ocean tile',
    'Forest tile',
    'Night tile',
  ];
  int tileIndex = 0;
  while (tileIndex < tileNames.length) {
    String tileName = tileNames[tileIndex];
    print('  Prepared: $tileName');
    tileIndex = tileIndex + 1;
  }

  print('');
  print('--- Standalone GridTile Tests ---');
  final standaloneTile = GridTile(
    child: Container(
      color: Color(0xFF0097A7),
      child: Center(
        child: Text('Standalone', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('  Standalone tile created successfully');
  print('  Type: $standaloneTile');

  final standaloneWithOverlays = GridTile(
    header: GridTileBar(
      backgroundColor: Color(0xCC000000),
      title: Text('Header'),
    ),
    footer: GridTileBar(
      backgroundColor: Color(0xCC000000),
      title: Text('Footer'),
    ),
    child: Container(color: Colors.teal),
  );
  print('  Standalone tile with overlays created');
  print('  Type: $standaloneWithOverlays');

  print('');
  print('--- Header/Footer Flexibility ---');
  final customHeaderTile = GridTile(
    header: Container(
      color: Color(0xCC000000),
      padding: EdgeInsets.all(8),
      child: Text(
        'Custom Container Header',
        style: TextStyle(color: Colors.white),
      ),
    ),
    child: Container(color: Color(0xFF8D6E63)),
  );
  print('  Custom container as header created');
  print('  Type: $customHeaderTile');

  final customFooterTile = GridTile(
    footer: Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xCC000000), Color(0x00000000)],
        ),
      ),
      child: Text('Gradient Footer', style: TextStyle(color: Colors.white)),
    ),
    child: Container(color: Color(0xFF5D4037)),
  );
  print('  Custom gradient footer created');
  print('  Type: $customFooterTile');

  print('');
  print('========================================');
  print('GridTile test completed successfully');
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
              colors: [Color(0xFF1565C0), Color(0xFF1E88E5), Color(0xFF42A5F5)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Color(0x441565C0),
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'GridTile',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'A tile in a Material Design grid list',
                style: TextStyle(fontSize: 14, color: Color(0xFFBBDEFB)),
              ),
              SizedBox(height: 4),
              Text(
                'package:flutter/material.dart',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF90CAF9),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),

        // Overview
        _buildInfoCard(
          'Overview',
          'GridTile is a material design widget representing a single tile in a '
              'GridView. It accepts a child widget as its main content, and optional '
              'header and footer widgets that overlay the child using a Stack layout.',
        ),
        _buildInfoCard(
          'Key Properties',
          'header: Widget overlaid on top of the tile\n'
              'footer: Widget overlaid on bottom of the tile\n'
              'child: The main content widget (required)',
        ),
        _buildInfoCard(
          'Typical Usage',
          'GridTile is designed to be used inside GridView. The header and footer '
              'are typically GridTileBar widgets, but can be any widget. The child fills '
              'the entire tile, with header/footer overlaid on top.',
        ),

        // Section 1: Basic child
        _buildSectionHeader('1. Basic GridTile with Child'),
        _buildBasicChildSection(),

        // Section 2: GridTile with header
        _buildSectionHeader('2. GridTile with Header'),
        _buildHeaderSection(),

        // Section 3: GridTile with footer
        _buildSectionHeader('3. GridTile with Footer'),
        _buildFooterSection(),

        // Section 4: Header and footer combined
        _buildSectionHeader('4. GridTile with Header + Footer'),
        _buildHeaderFooterSection(),

        // Section 5: GridView with multiple tiles
        _buildSectionHeader('5. GridView with Multiple GridTiles'),
        _buildGridViewSection(),

        // Section 6: Diverse child content
        _buildSectionHeader('6. Diverse Child Content'),
        _buildDiverseContentSection(),

        // Section 7: Varying header/footer styles
        _buildSectionHeader('7. Varying Header/Footer Styles'),
        _buildVaryingStylesSection(),

        // Section 8: Standalone demos
        _buildSectionHeader('8. Standalone GridTile Demos'),
        _buildStandaloneSection(),

        // Section 9: Property reference
        _buildSectionHeader('9. Property Reference'),
        _buildPropertyReferenceSection(),

        // Bottom spacing
        SizedBox(height: 32),
        Center(
          child: Text(
            'End of GridTile Demo',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF9E9E9E),
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        SizedBox(height: 16),
      ],
    ),
  );
}
