// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Material 3 search components
// Deep Demo: Visual demonstration of SearchBar, SearchAnchor, SearchController,
// SearchBarTheme and SearchViewThemeData. Includes real-world examples and a
// comparison of the Material 2 SearchDelegate API vs the Material 3 anchor API.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Material 3 Search Deep Demo executing');

  // ============================================================
  // SECTION 1: Search Component Overview
  // ============================================================
  print('=== Section 1: Search Component Overview ===');

  final conceptCards = <Widget>[];

  // Concept 1: SearchBar
  conceptCards.add(
    Container(
      width: 220.0,
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo.shade50, Colors.blue.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.indigo.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.search, size: 44.0, color: Colors.indigo),
          SizedBox(height: 12.0),
          Text(
            'SearchBar',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.indigo.shade900,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Material 3 input field\nwith optional leading\nand trailing widgets',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.0, color: Colors.indigo.shade700),
          ),
        ],
      ),
    ),
  );

  // Concept 2: SearchAnchor
  conceptCards.add(
    Container(
      width: 220.0,
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.teal.shade50, Colors.cyan.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.teal.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.manage_search, size: 44.0, color: Colors.teal),
          SizedBox(height: 12.0),
          Text(
            'SearchAnchor',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.teal.shade900,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Opens a search view\nwith dynamic suggestion\nbuilders and routing',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.0, color: Colors.teal.shade700),
          ),
        ],
      ),
    ),
  );

  // Concept 3: SearchController
  conceptCards.add(
    Container(
      width: 220.0,
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple.shade50, Colors.pink.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.purple.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.tune, size: 44.0, color: Colors.purple),
          SizedBox(height: 12.0),
          Text(
            'SearchController',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.purple.shade900,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Reads text, opens and\ncloses the view, exposes\nthe selected value',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.0, color: Colors.purple.shade700),
          ),
        ],
      ),
    ),
  );

  print('Created ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: SearchBar Variant Gallery
  // ============================================================
  print('=== Section 2: SearchBar Variant Gallery ===');

  // 2.1 Basic SearchBar
  final basicSearchBar = SearchBar(hintText: 'Search products');
  print('Basic SearchBar created');

  // 2.2 SearchBar with leading icon
  final leadingSearchBar = SearchBar(
    hintText: 'Search with leading icon',
    leading: Padding(
      padding: EdgeInsets.only(left: 12.0),
      child: Icon(Icons.search, color: Colors.indigo),
    ),
  );
  print('Leading SearchBar created');

  // 2.3 SearchBar with trailing actions
  final trailingSearchBar = SearchBar(
    hintText: 'Search with mic and filter',
    leading: Padding(
      padding: EdgeInsets.only(left: 12.0),
      child: Icon(Icons.search),
    ),
    trailing: [
      IconButton(
        icon: Icon(Icons.mic),
        onPressed: () {
          print('Mic pressed');
        },
      ),
      IconButton(
        icon: Icon(Icons.filter_list),
        onPressed: () {
          print('Filter pressed');
        },
      ),
    ],
  );
  print('Trailing SearchBar created');

  // 2.4 Colored / themed SearchBar
  final coloredSearchBar = SearchBar(
    hintText: 'Themed background',
    backgroundColor: MaterialStateProperty.all(Colors.indigo.shade50),
    overlayColor: MaterialStateProperty.all(Colors.indigo.shade100),
    leading: Padding(
      padding: EdgeInsets.only(left: 12.0),
      child: Icon(Icons.search, color: Colors.indigo),
    ),
  );
  print('Themed SearchBar created');

  // 2.5 Elevated SearchBar with shadow
  final elevatedSearchBar = SearchBar(
    hintText: 'High elevation',
    elevation: MaterialStateProperty.all(12.0),
    shadowColor: MaterialStateProperty.all(Colors.indigo.shade200),
    backgroundColor: MaterialStateProperty.all(Colors.white),
    leading: Padding(
      padding: EdgeInsets.only(left: 12.0),
      child: Icon(Icons.search),
    ),
  );
  print('Elevated SearchBar created');

  // 2.6 SearchBar with custom shape and border
  final shapedSearchBar = SearchBar(
    hintText: 'Custom shape + border',
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    ),
    side: MaterialStateProperty.all(
      BorderSide(color: Colors.teal, width: 2.0),
    ),
    backgroundColor: MaterialStateProperty.all(Colors.teal.shade50),
    leading: Padding(
      padding: EdgeInsets.only(left: 12.0),
      child: Icon(Icons.search, color: Colors.teal),
    ),
  );
  print('Shaped SearchBar created');

  // 2.7 SearchBar with styled text and hint
  final styledTextSearchBar = SearchBar(
    hintText: 'Styled hint text',
    textStyle: MaterialStateProperty.all(
      TextStyle(color: Colors.purple, fontSize: 16.0),
    ),
    hintStyle: MaterialStateProperty.all(
      TextStyle(
        color: Colors.purple.shade300,
        fontStyle: FontStyle.italic,
      ),
    ),
    leading: Padding(
      padding: EdgeInsets.only(left: 12.0),
      child: Icon(Icons.search, color: Colors.purple),
    ),
  );
  print('Styled text SearchBar created');

  // 2.8 Constrained SearchBar (narrow)
  final constrainedSearchBar = SearchBar(
    hintText: 'Constrained',
    constraints: BoxConstraints(maxWidth: 280.0, minHeight: 48.0),
    leading: Padding(
      padding: EdgeInsets.only(left: 12.0),
      child: Icon(Icons.search),
    ),
  );
  print('Constrained SearchBar created');

  // Variant cards bundle each SearchBar with a label and a description.
  Widget variantCard(String title, String desc, Widget bar, Color tint) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: tint.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: tint.withValues(alpha: 0.4), width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  color: tint.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: tint,
                    fontSize: 12.0,
                  ),
                ),
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  desc,
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          bar,
        ],
      ),
    );
  }

  final searchBarVariants = <Widget>[
    variantCard(
      'BASIC',
      'Default SearchBar, no decorations.',
      basicSearchBar,
      Colors.indigo,
    ),
    variantCard(
      'LEADING',
      'Leading search icon for affordance.',
      leadingSearchBar,
      Colors.indigo,
    ),
    variantCard(
      'TRAILING',
      'Mic + filter actions on the right.',
      trailingSearchBar,
      Colors.teal,
    ),
    variantCard(
      'COLORED',
      'Themed background and overlay color.',
      coloredSearchBar,
      Colors.indigo,
    ),
    variantCard(
      'ELEVATED',
      'Elevation 12 with colored shadow.',
      elevatedSearchBar,
      Colors.deepPurple,
    ),
    variantCard(
      'SHAPED',
      'Rectangular shape with 2px teal border.',
      shapedSearchBar,
      Colors.teal,
    ),
    variantCard(
      'STYLED TEXT',
      'Custom text and italic hint styles.',
      styledTextSearchBar,
      Colors.purple,
    ),
    variantCard(
      'CONSTRAINED',
      'maxWidth 280, minHeight 48.',
      constrainedSearchBar,
      Colors.blueGrey,
    ),
  ];

  // Code panel for SearchBar variants
  final searchBarCodePanel = Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.cyan.shade400, size: 18.0),
            SizedBox(width: 8.0),
            Text(
              'SearchBar variants',
              style: TextStyle(
                color: Colors.cyan.shade400,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          '// Basic\n'
          'SearchBar(hintText: "Search products");\n\n'
          '// Leading + trailing actions\n'
          'SearchBar(\n'
          '  leading: Icon(Icons.search),\n'
          '  trailing: [\n'
          '    IconButton(icon: Icon(Icons.mic), onPressed: ...),\n'
          '    IconButton(icon: Icon(Icons.filter_list), onPressed: ...),\n'
          '  ],\n'
          ');\n\n'
          '// Themed (MaterialStateProperty)\n'
          'SearchBar(\n'
          '  backgroundColor: MaterialStateProperty.all(...),\n'
          '  elevation: MaterialStateProperty.all(12.0),\n'
          '  shape: MaterialStateProperty.all(\n'
          '    RoundedRectangleBorder(\n'
          '      borderRadius: BorderRadius.circular(8.0),\n'
          '    ),\n'
          '  ),\n'
          ');',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Colors.green.shade300,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: SearchAnchor.bar Static Previews
  // ============================================================
  print('=== Section 3: SearchAnchor.bar Static Previews ===');

  // Real SearchAnchor.bar widgets - these would normally open a full view.
  final defaultAnchorBar = SearchAnchor.bar(
    barHintText: 'Search articles',
    suggestionsBuilder: (BuildContext context, SearchController controller) {
      return List<Widget>.generate(3, (int index) {
        final item = 'Article $index';
        return ListTile(
          title: Text(item),
          onTap: () => controller.closeView(item),
        );
      });
    },
  );
  print('Default SearchAnchor.bar created');

  final scopedAnchorBar = SearchAnchor.bar(
    barHintText: 'Filter contacts',
    barLeading: Icon(Icons.contacts, color: Colors.indigo),
    barTrailing: [
      Icon(Icons.tune, color: Colors.indigo),
    ],
    suggestionsBuilder: (BuildContext context, SearchController controller) {
      final query = controller.text;
      return [
        ListTile(
          leading: Icon(Icons.person),
          title: Text('Match for "$query"'),
          onTap: () => controller.closeView(query),
        ),
      ];
    },
  );
  print('Scoped SearchAnchor.bar created');

  final viewThemedAnchorBar = SearchAnchor.bar(
    barHintText: 'Themed view',
    viewHintText: 'Type to refine results...',
    viewBackgroundColor: Colors.purple.shade50,
    viewElevation: 6.0,
    viewShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
    ),
    suggestionsBuilder: (BuildContext context, SearchController controller) {
      return [
        ListTile(title: Text('Themed suggestion')),
      ];
    },
  );
  print('Themed SearchAnchor.bar created');

  Widget anchorPreviewCard(String title, String description, Widget anchor, Color tint) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [tint.withValues(alpha: 0.05), tint.withValues(alpha: 0.12)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: tint.withValues(alpha: 0.4), width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(Icons.flash_on, size: 16.0, color: tint),
              SizedBox(width: 6.0),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: tint,
                  fontSize: 13.0,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.0),
          Text(
            description,
            style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
          ),
          SizedBox(height: 10.0),
          anchor,
        ],
      ),
    );
  }

  final anchorBarPreviews = <Widget>[
    anchorPreviewCard(
      'Default anchor bar',
      'SearchAnchor.bar with default styling.',
      defaultAnchorBar,
      Colors.indigo,
    ),
    anchorPreviewCard(
      'Scoped anchor bar',
      'Custom leading icon and trailing tune.',
      scopedAnchorBar,
      Colors.teal,
    ),
    anchorPreviewCard(
      'Themed view',
      'viewBackgroundColor, viewElevation, viewShape.',
      viewThemedAnchorBar,
      Colors.purple,
    ),
  ];

  final anchorCodePanel = Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.cyan.shade400, size: 18.0),
            SizedBox(width: 8.0),
            Text(
              'SearchAnchor.bar',
              style: TextStyle(
                color: Colors.cyan.shade400,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'SearchAnchor.bar(\n'
          '  barHintText: "Search articles",\n'
          '  barLeading: Icon(Icons.contacts),\n'
          '  barTrailing: [ Icon(Icons.tune) ],\n'
          '  viewHintText: "Type to refine results...",\n'
          '  viewBackgroundColor: Colors.purple.shade50,\n'
          '  viewElevation: 6.0,\n'
          '  viewShape: RoundedRectangleBorder(\n'
          '    borderRadius: BorderRadius.circular(16.0),\n'
          '  ),\n'
          '  suggestionsBuilder: (context, controller) {\n'
          '    return List<Widget>.generate(\n'
          '      3,\n'
          '      (i) => ListTile(\n'
          '        title: Text("Item \$i"),\n'
          '        onTap: () => controller.closeView("Item \$i"),\n'
          '      ),\n'
          '    );\n'
          '  },\n'
          ');',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Colors.amber.shade200,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: Real-World Search Examples
  // ============================================================
  print('=== Section 4: Real-World Search Examples ===');

  // 4.1 App-bar style search
  final appBarSearchExample = Container(
    margin: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.indigo.shade200, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.indigo,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.menu, color: Colors.white),
              SizedBox(width: 12.0),
              Expanded(
                child: SearchBar(
                  hintText: 'Search your mailbox',
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  leading: Padding(
                    padding: EdgeInsets.only(left: 12.0),
                    child: Icon(Icons.search, color: Colors.indigo),
                  ),
                  trailing: [
                    Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.indigo.shade100,
                        child: Text(
                          'TA',
                          style: TextStyle(
                            color: Colors.indigo,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'App-bar search',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade900,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'A SearchBar embedded in an app-bar style header, '
                'with a menu icon and an avatar trailing widget.',
                style: TextStyle(
                  fontSize: 11.0,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // 4.2 Settings search
  final settingsSearchExample = Container(
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Settings',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 10.0),
        SearchBar(
          hintText: 'Search settings',
          backgroundColor: MaterialStateProperty.all(Colors.white),
          elevation: MaterialStateProperty.all(2.0),
          leading: Padding(
            padding: EdgeInsets.only(left: 12.0),
            child: Icon(Icons.search, color: Colors.grey.shade700),
          ),
        ),
        SizedBox(height: 12.0),
        _settingsRow(Icons.wifi, 'Wi-Fi', 'TomNet · Connected'),
        _settingsRow(Icons.bluetooth, 'Bluetooth', 'On'),
        _settingsRow(Icons.notifications, 'Notifications', '12 apps'),
        _settingsRow(Icons.dark_mode, 'Display', 'Dark, Adaptive'),
      ],
    ),
  );

  // 4.3 Contact-list search
  final contactSearchExample = Container(
    margin: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.teal.shade200, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.all(12.0),
          child: SearchBar(
            hintText: 'Search contacts',
            backgroundColor: MaterialStateProperty.all(Colors.teal.shade50),
            leading: Padding(
              padding: EdgeInsets.only(left: 12.0),
              child: Icon(Icons.search, color: Colors.teal),
            ),
            trailing: [
              IconButton(
                icon: Icon(Icons.person_add, color: Colors.teal),
                onPressed: () {},
              ),
            ],
          ),
        ),
        Divider(height: 1.0),
        _contactTile('AK', 'Alexis K.', Colors.indigo),
        _contactTile('BM', 'Bea M.', Colors.purple),
        _contactTile('CR', 'Carl R.', Colors.teal),
        _contactTile('DS', 'Dora S.', Colors.orange),
        _contactTile('EW', 'Erin W.', Colors.pink),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Material 2 vs Material 3 Comparison
  // ============================================================
  print('=== Section 5: M2 vs M3 Search Comparison ===');

  final comparisonRows = <Map<String, String>>[
    {
      'aspect': 'Entry point',
      'm2': 'showSearch(context: ..., delegate: ...)',
      'm3': 'SearchAnchor / SearchAnchor.bar',
    },
    {
      'aspect': 'Suggestions',
      'm2': 'SearchDelegate.buildSuggestions(context)',
      'm3': 'suggestionsBuilder callback',
    },
    {
      'aspect': 'Results',
      'm2': 'SearchDelegate.buildResults(context)',
      'm3': 'closeView(value) + caller routing',
    },
    {
      'aspect': 'Theme hook',
      'm2': 'SearchDelegate.appBarTheme',
      'm3': 'SearchBarTheme / SearchViewThemeData',
    },
    {
      'aspect': 'Controller',
      'm2': 'query getter/setter',
      'm3': 'SearchController (extends TextEditingController)',
    },
    {
      'aspect': 'Surface',
      'm2': 'Pushes a full-screen route',
      'm3': 'Anchored or full-screen view',
    },
  ];

  final comparisonTable = Container(
    margin: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.blueGrey.shade300, width: 1.0),
    ),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade100,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Aspect',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'Material 2 (SearchDelegate)',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'Material 3 (SearchAnchor)',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
              ),
            ],
          ),
        ),
        for (int i = 0; i < comparisonRows.length; i++)
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
            decoration: BoxDecoration(
              color: i.isEven ? Colors.white : Colors.blueGrey.shade50,
              borderRadius: i == comparisonRows.length - 1
                  ? BorderRadius.only(
                      bottomLeft: Radius.circular(12.0),
                      bottomRight: Radius.circular(12.0),
                    )
                  : null,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    comparisonRows[i]['aspect']!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey.shade800,
                      fontSize: 12.0,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    comparisonRows[i]['m2']!,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.0,
                      color: Colors.deepOrange.shade800,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    comparisonRows[i]['m3']!,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.0,
                      color: Colors.teal.shade800,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );

  // SearchDelegate legacy code panel (cannot render directly without showSearch)
  final legacyDelegateCodePanel = Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.history, color: Colors.deepOrange.shade300, size: 18.0),
            SizedBox(width: 8.0),
            Text(
              'Legacy: SearchDelegate (Material 2)',
              style: TextStyle(
                color: Colors.deepOrange.shade300,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'class _MySearchDelegate extends SearchDelegate<String> {\n'
          '  @override\n'
          '  Widget buildLeading(BuildContext context) =>\n'
          '    IconButton(\n'
          '      icon: Icon(Icons.arrow_back),\n'
          '      onPressed: () => close(context, ""),\n'
          '    );\n\n'
          '  @override\n'
          '  Widget buildSuggestions(BuildContext context) =>\n'
          '    ListView(children: [ ListTile(title: Text(query)) ]);\n\n'
          '  @override\n'
          '  Widget buildResults(BuildContext context) =>\n'
          '    Center(child: Text("Results for \$query"));\n\n'
          '  @override\n'
          '  List<Widget> buildActions(BuildContext context) => [];\n'
          '}\n\n'
          '// Invocation\n'
          'showSearch(context: ctx, delegate: _MySearchDelegate());',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Colors.orange.shade200,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: SearchController Lifecycle and Property Reference
  // ============================================================
  print('=== Section 6: SearchController lifecycle ===');

  final lifecycleSteps = <Map<String, dynamic>>[
    {
      'step': 'Instantiate',
      'desc': 'final controller = SearchController();',
      'icon': Icons.fiber_new,
      'color': Colors.blue,
    },
    {
      'step': 'Attach',
      'desc': 'Pass into SearchAnchor.searchController or SearchAnchor.bar.',
      'icon': Icons.link,
      'color': Colors.indigo,
    },
    {
      'step': 'Open view',
      'desc': 'controller.openView() expands the search view.',
      'icon': Icons.open_in_browser,
      'color': Colors.teal,
    },
    {
      'step': 'Read text',
      'desc': 'controller.text drives the suggestionsBuilder result.',
      'icon': Icons.text_fields,
      'color': Colors.orange,
    },
    {
      'step': 'Close view',
      'desc': 'controller.closeView(value) returns the chosen value.',
      'icon': Icons.close_fullscreen,
      'color': Colors.deepPurple,
    },
    {
      'step': 'Dispose',
      'desc': 'controller.dispose() releases listeners.',
      'icon': Icons.delete_outline,
      'color': Colors.red,
    },
  ];

  final lifecycleWidgets = <Widget>[];
  for (int i = 0; i < lifecycleSteps.length; i++) {
    final step = lifecycleSteps[i];
    final color = step['color'] as Color;
    final isLast = i == lifecycleSteps.length - 1;
    lifecycleWidgets.add(
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: color.withValues(alpha: 0.4),
                      blurRadius: 6.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  step['icon'] as IconData,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              if (!isLast)
                Container(
                  width: 3.0,
                  height: 30.0,
                  color: color.withValues(alpha: 0.5),
                ),
            ],
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: isLast ? 0 : 12.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: color.withValues(alpha: 0.3),
                  width: 1.0,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step['step'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    step['desc'] as String,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey.shade700,
                      fontFamily: step['desc'].toString().contains('controller')
                          ? 'monospace'
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Property reference grid for SearchBar, SearchAnchor and SearchBarTheme
  final propertyGroups = <Map<String, dynamic>>[
    {
      'title': 'SearchBar',
      'color': Colors.indigo,
      'icon': Icons.search,
      'props': [
        'hintText',
        'leading',
        'trailing',
        'onTap / onChanged / onSubmitted',
        'controller',
        'backgroundColor (MSP)',
        'overlayColor (MSP)',
        'shadowColor (MSP)',
        'elevation (MSP)',
        'shape (MSP)',
        'side (MSP)',
        'textStyle (MSP)',
        'hintStyle (MSP)',
        'padding (MSP)',
        'constraints',
        'autoFocus',
      ],
    },
    {
      'title': 'SearchAnchor',
      'color': Colors.teal,
      'icon': Icons.manage_search,
      'props': [
        'builder',
        'suggestionsBuilder',
        'searchController',
        'isFullScreen',
        'viewHintText',
        'viewLeading',
        'viewTrailing',
        'viewBackgroundColor',
        'viewElevation',
        'viewSide',
        'viewShape',
        'dividerColor',
        'headerHintStyle',
        'headerTextStyle',
      ],
    },
    {
      'title': 'SearchBarTheme / SearchViewThemeData',
      'color': Colors.purple,
      'icon': Icons.palette,
      'props': [
        'SearchBarTheme.of(context)',
        'SearchBarThemeData.backgroundColor',
        'SearchBarThemeData.elevation',
        'SearchBarThemeData.shape',
        'SearchBarThemeData.textStyle',
        'SearchViewThemeData.backgroundColor',
        'SearchViewThemeData.elevation',
        'SearchViewThemeData.shape',
        'SearchViewThemeData.dividerColor',
        'SearchViewThemeData.headerHintStyle',
      ],
    },
  ];

  final propertyCards = <Widget>[];
  for (final group in propertyGroups) {
    final color = group['color'] as Color;
    final props = group['props'] as List<String>;
    propertyCards.add(
      Container(
        width: 280.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: color.withValues(alpha: 0.4), width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(group['icon'] as IconData, color: color, size: 20.0),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    group['title'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: color,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            for (final p in props)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.chevron_right,
                      color: color.withValues(alpha: 0.7),
                      size: 14.0,
                    ),
                    SizedBox(width: 4.0),
                    Expanded(
                      child: Text(
                        p,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 11.0,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 7: Summary Panel
  // ============================================================
  print('=== Section 7: Summary ===');

  final summaryPanel = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade100, Colors.teal.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade300, width: 2.0),
    ),
    child: Column(
      children: [
        Text(
          'Key Takeaways',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade900,
          ),
        ),
        SizedBox(height: 16.0),
        _buildSummaryItem(
          Icons.search,
          'SearchBar is composable',
          'A standalone Material 3 input you can drop into any layout.',
          Colors.indigo,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.manage_search,
          'SearchAnchor owns the view',
          'Wraps a launcher and a search view together via callbacks.',
          Colors.teal,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.tune,
          'SearchController is shared state',
          'Drives text, openView, closeView and listeners across both.',
          Colors.purple,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.palette,
          'Theming via SearchBarTheme',
          'Use SearchBarTheme and SearchViewThemeData to centralize styling.',
          Colors.deepPurple,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.history,
          'SearchDelegate is legacy',
          'showSearch + SearchDelegate still works but is M2-style.',
          Colors.deepOrange,
        ),
      ],
    ),
  );
  print('Created summary panel');

  print('Material 3 Search Deep Demo completed successfully');

  // ============================================================
  // Return complete visual layout
  // ============================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header banner
            Container(
              padding: EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.indigo, Colors.teal],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.indigo.withValues(alpha: 0.3),
                    blurRadius: 12.0,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(Icons.search, size: 56.0, color: Colors.white),
                  SizedBox(height: 8.0),
                  Text(
                    'Material 3 Search Components',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'SearchBar  ·  SearchAnchor  ·  SearchController',
                    style: TextStyle(fontSize: 14.0, color: Colors.white70),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.0),

            // Section 1
            Text(
              '1. Search Component Overview',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            Wrap(
              alignment: WrapAlignment.center,
              children: conceptCards,
            ),
            SizedBox(height: 32.0),

            // Section 2
            Text(
              '2. SearchBar Variant Gallery',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            ...searchBarVariants,
            SizedBox(height: 8.0),
            searchBarCodePanel,
            SizedBox(height: 32.0),

            // Section 3
            Text(
              '3. SearchAnchor.bar Configurations',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            ...anchorBarPreviews,
            SizedBox(height: 8.0),
            anchorCodePanel,
            SizedBox(height: 32.0),

            // Section 4
            Text(
              '4. Real-World Search Examples',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            appBarSearchExample,
            settingsSearchExample,
            contactSearchExample,
            SizedBox(height: 32.0),

            // Section 5
            Text(
              '5. Material 2 vs Material 3',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            comparisonTable,
            legacyDelegateCodePanel,
            SizedBox(height: 32.0),

            // Section 6
            Text(
              '6. SearchController Lifecycle and Properties',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(children: lifecycleWidgets),
            ),
            SizedBox(height: 16.0),
            Wrap(
              alignment: WrapAlignment.center,
              children: propertyCards,
            ),
            SizedBox(height: 32.0),

            // Section 7
            Text(
              '7. Summary',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            summaryPanel,
          ],
        ),
      ),
    ),
  );
}

// Helper: Settings row used by section 4 settings example.
Widget _settingsRow(IconData icon, String title, String subtitle) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.grey.shade300, width: 1.0),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.indigo, size: 18.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade900,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 11.0,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
        Icon(Icons.chevron_right, color: Colors.grey.shade400),
      ],
    ),
  );
}

// Helper: Contact tile for the contact-list example in section 4.
Widget _contactTile(String initials, String name, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: Colors.grey.shade200, width: 1.0),
      ),
    ),
    child: Row(
      children: [
        CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.2),
          child: Text(
            initials,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
        ),
        Icon(Icons.phone, color: color, size: 18.0),
        SizedBox(width: 12.0),
        Icon(Icons.message, color: color, size: 18.0),
      ],
    ),
  );
}

// Helper: Build summary item used by the final summary panel.
Widget _buildSummaryItem(
  IconData icon,
  String title,
  String desc,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.3), width: 1.0),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, color: color),
              ),
              Text(
                desc,
                style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
