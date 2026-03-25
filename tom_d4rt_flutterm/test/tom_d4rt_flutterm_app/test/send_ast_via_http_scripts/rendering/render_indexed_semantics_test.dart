// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// Deep demo: RenderIndexedSemantics - semantic index annotation for accessible lists
// IndexedSemantics assigns an index to a semantics node so screen readers
// can announce "item X of Y" when navigating scrollable collections.

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

// -- Helper: gradient header banner
Widget _buildHeader(String title, String subtitle) {
  print('[Header] $title - $subtitle');
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF1565C0), Color(0xFF0D47A1), Color(0xFF002171)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Color(0x401565C0),
          blurRadius: 16,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 14,
            color: Color(0xBBFFFFFF),
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

// -- Helper: section title with accent bar
Widget _buildSectionTitle(String title, Color accentColor) {
  print('[Section] $title');
  return Padding(
    padding: EdgeInsets.only(top: 28, bottom: 12),
    child: Row(
      children: [
        Container(
          width: 5,
          height: 28,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [accentColor, accentColor.withOpacity(0.5)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF212121),
            ),
          ),
        ),
      ],
    ),
  );
}

// -- Helper: info card with icon
Widget _buildInfoCard(IconData icon, String label, String description, Color color) {
  print('[InfoCard] $label');
  return Container(
    margin: EdgeInsets.only(bottom: 10),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: color.withOpacity(0.06),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withOpacity(0.2)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Color(0xFF212121),
                ),
              ),
              SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: Color(0xFF616161), height: 1.4),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// -- Section 1: Basic IndexedSemantics wrapping list items
Widget _buildBasicIndexedList() {
  print('[Demo] Basic IndexedSemantics wrapping list items');
  List<String> fruits = ['Apple', 'Banana', 'Cherry', 'Date', 'Elderberry', 'Fig', 'Grape'];
  List<Color> fruitColors = [
    Color(0xFFE53935),
    Color(0xFFFDD835),
    Color(0xFFC62828),
    Color(0xFF8D6E63),
    Color(0xFF7B1FA2),
    Color(0xFF4CAF50),
    Color(0xFF6A1B9A),
  ];

  List<Widget> items = [];
  for (int i = 0; i < fruits.length; i++) {
    print('[BasicList] Building item $i: ${fruits[i]}');
    items.add(
      IndexedSemantics(
        index: i,
        child: Container(
          margin: EdgeInsets.only(bottom: 8),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: fruitColors[i].withOpacity(0.3)),
            boxShadow: [
              BoxShadow(
                color: Color(0x0A000000),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: fruitColors[i].withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    '$i',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: fruitColors[i],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fruits[i],
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Semantic index: $i',
                      style: TextStyle(fontSize: 11, color: Color(0xFF9E9E9E)),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: fruitColors[i].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Index $i',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: fruitColors[i],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  return Column(children: items);
}

// -- Section 2: Semantics with sortKey for explicit ordering
Widget _buildSortKeyDemo() {
  print('[Demo] Semantics with OrdinalSortKey for ordering');
  // Items displayed visually in one order but semantically in another
  List<Map<String, dynamic>> entries = [
    {'label': 'Third visually', 'sortOrder': 3.0, 'color': Color(0xFFFF7043)},
    {'label': 'First visually', 'sortOrder': 1.0, 'color': Color(0xFF66BB6A)},
    {'label': 'Fourth visually', 'sortOrder': 4.0, 'color': Color(0xFF42A5F5)},
    {'label': 'Second visually', 'sortOrder': 2.0, 'color': Color(0xFFAB47BC)},
  ];

  List<Widget> sortItems = [];
  for (int i = 0; i < entries.length; i++) {
    Map<String, dynamic> entry = entries[i];
    double order = entry['sortOrder'];
    Color c = entry['color'];
    String label = entry['label'];
    print('[SortKey] Visual position $i -> Semantic order $order: $label');

    sortItems.add(
      Semantics(
        sortKey: OrdinalSortKey(order),
        label: '$label - semantic order $order',
        child: Container(
          margin: EdgeInsets.only(bottom: 8),
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [c.withOpacity(0.08), c.withOpacity(0.02)],
            ),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: c.withOpacity(0.25)),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: c.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${order.toInt()}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: c,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                    SizedBox(height: 3),
                    Text(
                      'Visual position: $i | Semantic order: ${order.toInt()}',
                      style: TextStyle(fontSize: 11, color: Color(0xFF757575)),
                    ),
                  ],
                ),
              ),
              Icon(Icons.swap_vert, color: c.withOpacity(0.5), size: 20),
            ],
          ),
        ),
      ),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Color(0xFFFFF8E1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xFFFFE082)),
        ),
        child: Row(
          children: [
            Icon(Icons.info_outline, color: Color(0xFFF9A825), size: 18),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'OrdinalSortKey reorders semantic traversal independently of visual layout',
                style: TextStyle(fontSize: 12, color: Color(0xFF5D4037)),
              ),
            ),
          ],
        ),
      ),
      ...sortItems,
    ],
  );
}

// -- Section 3: IndexedSemantics in a ListView.builder style
Widget _buildListViewBuilderDemo() {
  print('[Demo] IndexedSemantics in ListView.builder context');
  int itemCount = 8;
  List<IconData> icons = [
    Icons.home, Icons.star, Icons.settings, Icons.person,
    Icons.notifications, Icons.mail, Icons.bookmark, Icons.trending_up,
  ];
  List<String> labels = [
    'Home', 'Favorites', 'Settings', 'Profile',
    'Notifications', 'Messages', 'Bookmarks', 'Trending',
  ];

  List<Widget> builtItems = [];
  for (int index = 0; index < itemCount; index++) {
    print('[ListView] Building indexed item $index/${itemCount - 1}: ${labels[index]}');
    builtItems.add(
      IndexedSemantics(
        index: index,
        child: Semantics(
          label: '${labels[index]}, item ${index + 1} of $itemCount',
          child: Container(
            margin: EdgeInsets.only(bottom: 6),
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: index % 2 == 0 ? Color(0xFFF5F5F5) : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 18,
                      alignment: Alignment.center,
                      child: Text(
                        '$index',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFBDBDBD),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Icon(icons[index], color: Color(0xFF1565C0), size: 22),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        labels[index],
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Text(
                      'idx:$index',
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0xFF90A4AE),
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
    );
  }

  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          color: Color(0xFFE3F2FD),
          child: Row(
            children: [
              Icon(Icons.list, color: Color(0xFF1565C0), size: 18),
              SizedBox(width: 8),
              Text(
                'ListView.builder simulation ($itemCount items)',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1565C0),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Column(children: builtItems),
        ),
      ],
    ),
  );
}

// -- Section 4: IndexedSemantics in grid layout
Widget _buildGridLayoutDemo() {
  print('[Demo] IndexedSemantics in grid layout');
  List<Map<String, dynamic>> gridItems = [
    {'icon': Icons.photo, 'label': 'Photos', 'color': Color(0xFF43A047)},
    {'icon': Icons.video_library, 'label': 'Videos', 'color': Color(0xFFE53935)},
    {'icon': Icons.music_note, 'label': 'Music', 'color': Color(0xFF8E24AA)},
    {'icon': Icons.article, 'label': 'Documents', 'color': Color(0xFF1E88E5)},
    {'icon': Icons.download, 'label': 'Downloads', 'color': Color(0xFFFF8F00)},
    {'icon': Icons.cloud, 'label': 'Cloud', 'color': Color(0xFF00ACC1)},
  ];

  List<Widget> rows = [];
  for (int rowIdx = 0; rowIdx < gridItems.length; rowIdx += 3) {
    List<Widget> rowChildren = [];
    for (int col = 0; col < 3 && (rowIdx + col) < gridItems.length; col++) {
      int flatIndex = rowIdx + col;
      Map<String, dynamic> item = gridItems[flatIndex];
      Color c = item['color'];
      String label = item['label'];
      IconData icon = item['icon'];
      print('[Grid] Cell [$flatIndex] row=${rowIdx ~/ 3} col=$col: $label');

      rowChildren.add(
        Expanded(
          child: IndexedSemantics(
            index: flatIndex,
            child: Semantics(
              label: '$label, grid item ${flatIndex + 1} of ${gridItems.length}',
              child: Container(
                margin: EdgeInsets.all(4),
                padding: EdgeInsets.symmetric(vertical: 18, horizontal: 8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [c.withOpacity(0.12), c.withOpacity(0.04)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: c.withOpacity(0.2)),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: c.withOpacity(0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(icon, color: c, size: 26),
                    ),
                    SizedBox(height: 8),
                    Text(
                      label,
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 4),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: c.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'sem:$flatIndex',
                        style: TextStyle(
                          fontSize: 10,
                          color: c,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
    rows.add(
      Padding(
        padding: EdgeInsets.only(bottom: 4),
        child: Row(children: rowChildren),
      ),
    );
  }

  return Column(children: rows);
}

// -- Section 5: Semantic tree visualization
Widget _buildSemanticTreeVisualization() {
  print('[Demo] Semantic tree visualization with indices');
  List<Map<String, dynamic>> treeNodes = [
    {'depth': 0, 'label': 'ScrollView', 'index': -1, 'color': Color(0xFF37474F)},
    {'depth': 1, 'label': 'SliverList', 'index': -1, 'color': Color(0xFF546E7A)},
    {'depth': 2, 'label': 'ListTile "Inbox"', 'index': 0, 'color': Color(0xFF1565C0)},
    {'depth': 2, 'label': 'ListTile "Sent"', 'index': 1, 'color': Color(0xFF2E7D32)},
    {'depth': 2, 'label': 'ListTile "Drafts"', 'index': 2, 'color': Color(0xFFE65100)},
    {'depth': 2, 'label': 'ListTile "Trash"', 'index': 3, 'color': Color(0xFFC62828)},
    {'depth': 1, 'label': 'SliverGrid', 'index': -1, 'color': Color(0xFF546E7A)},
    {'depth': 2, 'label': 'GridTile "A"', 'index': 0, 'color': Color(0xFF6A1B9A)},
    {'depth': 2, 'label': 'GridTile "B"', 'index': 1, 'color': Color(0xFF00838F)},
  ];

  List<Widget> nodes = [];
  for (int i = 0; i < treeNodes.length; i++) {
    Map<String, dynamic> node = treeNodes[i];
    int depth = node['depth'];
    String label = node['label'];
    int idx = node['index'];
    Color c = node['color'];
    print('[Tree] depth=$depth label=$label index=$idx');

    nodes.add(
      Padding(
        padding: EdgeInsets.only(left: depth * 24.0, bottom: 4),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: c.withOpacity(0.08),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: c.withOpacity(0.2)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (depth > 0)
                Padding(
                  padding: EdgeInsets.only(right: 6),
                  child: Icon(
                    depth == 1 ? Icons.subdirectory_arrow_right : Icons.arrow_right,
                    size: 14,
                    color: c.withOpacity(0.5),
                  ),
                ),
              Icon(
                idx >= 0 ? Icons.tag : Icons.account_tree,
                size: 14,
                color: c,
              ),
              SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: c,
                ),
              ),
              if (idx >= 0) ...[
                SizedBox(width: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                  decoration: BoxDecoration(
                    color: c.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'index=$idx',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: c,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  return Container(
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.account_tree, size: 16, color: Color(0xFF546E7A)),
            SizedBox(width: 6),
            Text(
              'Semantic Tree Structure',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFF37474F),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        ...nodes,
      ],
    ),
  );
}

// -- Section 6: Accessible carousel pattern
Widget _buildAccessibleCarouselDemo() {
  print('[Demo] Accessible carousel with IndexedSemantics');
  List<Map<String, dynamic>> slides = [
    {'title': 'Welcome', 'desc': 'Get started with our app', 'color': Color(0xFF1565C0), 'icon': Icons.waving_hand},
    {'title': 'Discover', 'desc': 'Explore new features', 'color': Color(0xFF2E7D32), 'icon': Icons.explore},
    {'title': 'Connect', 'desc': 'Meet other users', 'color': Color(0xFFE65100), 'icon': Icons.people},
    {'title': 'Create', 'desc': 'Build something amazing', 'color': Color(0xFF6A1B9A), 'icon': Icons.create},
    {'title': 'Share', 'desc': 'Tell the world', 'color': Color(0xFFC62828), 'icon': Icons.share},
  ];

  List<Widget> slideWidgets = [];
  for (int i = 0; i < slides.length; i++) {
    Map<String, dynamic> slide = slides[i];
    Color c = slide['color'];
    String title = slide['title'];
    String desc = slide['desc'];
    IconData icon = slide['icon'];
    print('[Carousel] Slide $i: $title - $desc');

    slideWidgets.add(
      IndexedSemantics(
        index: i,
        child: Semantics(
          label: 'Slide ${i + 1} of ${slides.length}: $title. $desc',
          child: Container(
            width: 180,
            margin: EdgeInsets.only(right: 12),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [c, c.withOpacity(0.7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: c.withOpacity(0.3),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(icon, color: Colors.white, size: 28),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Color(0x33FFFFFF),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${i + 1}/${slides.length}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  desc,
                  style: TextStyle(
                    color: Color(0xCCFFFFFF),
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: Color(0x22FFFFFF),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'semantic index: $i',
                    style: TextStyle(color: Color(0xAAFFFFFF), fontSize: 10),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(children: slideWidgets),
      ),
      SizedBox(height: 12),
      // Dot indicators with semantic ordering
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(slides.length, (i) {
          print('[Carousel] Dot indicator $i');
          Color c = slides[i]['color'];
          return Semantics(
            sortKey: OrdinalSortKey(i.toDouble()),
            label: 'Page indicator ${i + 1} of ${slides.length}',
            child: Container(
              width: 10,
              height: 10,
              margin: EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: i == 0 ? c : c.withOpacity(0.3),
                border: Border.all(color: c, width: 1.5),
              ),
            ),
          );
        }),
      ),
    ],
  );
}

// -- Section 7: Practical accessible list with metadata
Widget _buildPracticalAccessibleList() {
  print('[Demo] Practical accessible list pattern');
  List<Map<String, dynamic>> emails = [
    {'sender': 'Alice', 'subject': 'Project Update', 'time': '10:30 AM', 'unread': true, 'color': Color(0xFF1565C0)},
    {'sender': 'Bob', 'subject': 'Meeting Tomorrow', 'time': '9:15 AM', 'unread': true, 'color': Color(0xFF2E7D32)},
    {'sender': 'Carol', 'subject': 'Design Review', 'time': 'Yesterday', 'unread': false, 'color': Color(0xFFE65100)},
    {'sender': 'Dave', 'subject': 'Bug Report #42', 'time': 'Yesterday', 'unread': false, 'color': Color(0xFF6A1B9A)},
    {'sender': 'Eve', 'subject': 'Sprint Retro Notes', 'time': 'Mar 20', 'unread': false, 'color': Color(0xFF00838F)},
  ];

  List<Widget> emailItems = [];
  for (int i = 0; i < emails.length; i++) {
    Map<String, dynamic> email = emails[i];
    String sender = email['sender'];
    String subject = email['subject'];
    String time = email['time'];
    bool unread = email['unread'];
    Color c = email['color'];
    print('[EmailList] Item $i: $sender - $subject (unread=$unread)');

    emailItems.add(
      IndexedSemantics(
        index: i,
        child: Semantics(
          label: '${unread ? "Unread. " : ""}From $sender: $subject. $time. Item ${i + 1} of ${emails.length}',
          child: Container(
            margin: EdgeInsets.only(bottom: 6),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: unread ? Color(0xFFE3F2FD) : Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: unread ? Color(0xFF90CAF9) : Color(0xFFEEEEEE),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: c.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      sender[0],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: c,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            sender,
                            style: TextStyle(
                              fontWeight: unread ? FontWeight.w700 : FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                          if (unread)
                            Container(
                              margin: EdgeInsets.only(left: 6),
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: Color(0xFF1565C0),
                                shape: BoxShape.circle,
                              ),
                            ),
                          Spacer(),
                          Text(
                            time,
                            style: TextStyle(fontSize: 11, color: Color(0xFF9E9E9E)),
                          ),
                        ],
                      ),
                      SizedBox(height: 3),
                      Text(
                        subject,
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF616161),
                          fontWeight: unread ? FontWeight.w500 : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '#$i',
                    style: TextStyle(fontSize: 10, color: Color(0xFFBDBDBD)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  return Column(children: emailItems);
}

// -- Section 8: Index mapping visualization
Widget _buildIndexMappingVisualization() {
  print('[Demo] List indices to semantic indices mapping');
  List<String> items = ['Header', 'ItemA', 'ItemB', 'Divider', 'ItemC', 'ItemD', 'Footer'];
  List<int> semanticIndices = [-1, 0, 1, -1, 2, 3, -1];
  List<Color> colors = [
    Color(0xFF78909C), Color(0xFF1565C0), Color(0xFF2E7D32),
    Color(0xFF78909C), Color(0xFFE65100), Color(0xFF6A1B9A), Color(0xFF78909C),
  ];

  List<Widget> mappingRows = [];
  for (int i = 0; i < items.length; i++) {
    int semIdx = semanticIndices[i];
    bool hasSemantic = semIdx >= 0;
    Color c = colors[i];
    print('[Mapping] List[$i] "${items[i]}" -> semantic ${hasSemantic ? semIdx : "none"}');

    mappingRows.add(
      Container(
        margin: EdgeInsets.only(bottom: 4),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: hasSemantic ? c.withOpacity(0.06) : Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: hasSemantic ? c.withOpacity(0.2) : Color(0xFFE0E0E0),
            width: hasSemantic ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 28,
              alignment: Alignment.center,
              child: Text(
                '$i',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF9E9E9E),
                ),
              ),
            ),
            SizedBox(width: 8),
            Icon(Icons.arrow_forward, size: 14, color: Color(0xFFBDBDBD)),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                items[i],
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: hasSemantic ? FontWeight.w600 : FontWeight.w400,
                  color: hasSemantic ? Color(0xFF212121) : Color(0xFF9E9E9E),
                  fontStyle: hasSemantic ? FontStyle.normal : FontStyle.italic,
                ),
              ),
            ),
            if (hasSemantic)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: c.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'sem:$semIdx',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: c,
                  ),
                ),
              )
            else
              Text(
                'no index',
                style: TextStyle(fontSize: 11, color: Color(0xFFBDBDBD), fontStyle: FontStyle.italic),
              ),
          ],
        ),
      ),
    );
  }

  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Not all list positions receive a semantic index:',
          style: TextStyle(fontSize: 12, color: Color(0xFF616161)),
        ),
        SizedBox(height: 10),
        ...mappingRows,
      ],
    ),
  );
}

Widget _buildIndexContinuityChecklist() {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFF3E5F5),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Color(0xFFE1BEE7)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Index Continuity Checklist',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Color(0xFF6A1B9A)),
        ),
        SizedBox(height: 8),
        Text('• Keep semantic indices stable when filtering/reordering lists.'),
        Text('• Skip decorative separators or map them explicitly to null semantics.'),
        Text('• Pair IndexedSemantics with clear labels for context-rich announcements.'),
        Text('• Validate final order with screen reader traversal, not visual order only.'),
      ],
    ),
  );
}

// -- Entry point
dynamic build(BuildContext context) {
  print('[RenderIndexedSemantics] Building deep demo');
  print('[RenderIndexedSemantics] IndexedSemantics annotates semantics nodes with indices');
  print('[RenderIndexedSemantics] Enables screen readers to announce item positions');

  return SingleChildScrollView(
    padding: EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        _buildHeader(
          'RenderIndexedSemantics',
          'Annotates a semantics node with an index so screen readers can '
          'announce "item X of Y" in scrollable lists. Widget: IndexedSemantics.',
        ),

        SizedBox(height: 16),

        // Concept cards
        _buildInfoCard(
          Icons.tag,
          'IndexedSemantics Widget',
          'Wraps a child and annotates its semantics node with an integer index. '
          'Used automatically by ListView, GridView, and other scrollables.',
          Color(0xFF1565C0),
        ),
        _buildInfoCard(
          Icons.sort,
          'OrdinalSortKey',
          'Allows explicit control of semantic traversal order independently '
          'of visual layout. Lower ordinals are visited first by screen readers.',
          Color(0xFF2E7D32),
        ),
        _buildInfoCard(
          Icons.accessibility_new,
          'Accessibility Impact',
          'Screen readers like TalkBack and VoiceOver use semantic indices to '
          'announce item positions, enabling spatial awareness in lists and grids.',
          Color(0xFFE65100),
        ),

        // Section 1
        _buildSectionTitle('1. Basic IndexedSemantics List', Color(0xFF1565C0)),
        _buildBasicIndexedList(),

        // Section 2
        _buildSectionTitle('2. OrdinalSortKey Reordering', Color(0xFF2E7D32)),
        _buildSortKeyDemo(),

        // Section 3
        _buildSectionTitle('3. ListView.builder with Indices', Color(0xFFE65100)),
        _buildListViewBuilderDemo(),

        // Section 4
        _buildSectionTitle('4. Grid Layout with Indices', Color(0xFF6A1B9A)),
        _buildGridLayoutDemo(),

        // Section 5
        _buildSectionTitle('5. Semantic Tree Visualization', Color(0xFF37474F)),
        _buildSemanticTreeVisualization(),

        // Section 6
        _buildSectionTitle('6. Accessible Carousel Pattern', Color(0xFFC62828)),
        _buildAccessibleCarouselDemo(),

        // Section 7
        _buildSectionTitle('7. Practical Accessible Email List', Color(0xFF00838F)),
        _buildPracticalAccessibleList(),

        // Section 8
        _buildSectionTitle('8. Index Mapping Visualization', Color(0xFF795548)),
        _buildIndexMappingVisualization(),

        // Section 9
        _buildSectionTitle('9. Index Continuity Checklist', Color(0xFF6A1B9A)),
        _buildIndexContinuityChecklist(),

        SizedBox(height: 32),

        // Footer
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Color(0xFFE0E0E0)),
          ),
          child: Column(
            children: [
              Icon(Icons.accessibility, color: Color(0xFF1565C0), size: 28),
              SizedBox(height: 8),
              Text(
                'IndexedSemantics + OrdinalSortKey = Fully Accessible Collections',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: Color(0xFF424242),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4),
              Text(
                'Every scrollable item should have a semantic index for assistive technology',
                style: TextStyle(fontSize: 11, color: Color(0xFF9E9E9E)),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),

        SizedBox(height: 20),
      ],
    ),
  );
}
