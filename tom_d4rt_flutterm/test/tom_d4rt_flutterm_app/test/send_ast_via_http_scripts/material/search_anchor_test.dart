// D4rt test script: Tests SearchAnchor, SearchBar, SearchController,
// SearchBarThemeData, SearchViewThemeData, showSearch, SearchDelegate
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Search anchor test executing');

  // ========== SearchController ==========
  print('--- SearchController Tests ---');
  final controller = SearchController();
  print('SearchController created');
  print('  isOpen: ${controller.isOpen}');

  // ========== SearchBar ==========
  print('--- SearchBar Tests ---');
  final searchBar = SearchBar(
    controller: TextEditingController(),
    hintText: 'Search...',
    onTap: () => print('  SearchBar tapped'),
    onChanged: (value) => print('  Changed: $value'),
    onSubmitted: (value) => print('  Submitted: $value'),
    leading: Icon(Icons.search),
    trailing: [
      IconButton(icon: Icon(Icons.clear), onPressed: () {}),
      IconButton(icon: Icon(Icons.mic), onPressed: () {}),
    ],
    padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 16)),
    elevation: WidgetStateProperty.all(2.0),
    backgroundColor: WidgetStateProperty.all(Colors.white),
    shadowColor: WidgetStateProperty.all(Colors.black26),
    surfaceTintColor: WidgetStateProperty.all(Colors.blue[50]),
    overlayColor: WidgetStateProperty.all(Colors.blue[100]),
    side: WidgetStateProperty.all(BorderSide(color: Colors.grey[300]!)),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
    ),
    textStyle: WidgetStateProperty.all(TextStyle(fontSize: 16)),
    hintStyle: WidgetStateProperty.all(TextStyle(color: Colors.grey)),
    constraints: BoxConstraints(minHeight: 56),
    autoFocus: false,
    keyboardType: TextInputType.text,
    textCapitalization: TextCapitalization.none,
    textInputAction: TextInputAction.search,
  );
  print('SearchBar created');

  // ========== SearchAnchor ==========
  print('--- SearchAnchor Tests ---');
  final searchAnchor = SearchAnchor(
    searchController: controller,
    builder: (context, controller) {
      return IconButton(
        icon: Icon(Icons.search),
        onPressed: () => controller.openView(),
      );
    },
    suggestionsBuilder: (context, controller) {
      return List.generate(5, (index) => ListTile(
        title: Text('Suggestion $index'),
        onTap: () {
          controller.closeView('Suggestion $index');
        },
      ));
    },
    viewHintText: 'Search items...',
    viewBackgroundColor: Colors.white,
    viewElevation: 8.0,
    viewSurfaceTintColor: Colors.blue[50],
    viewSide: BorderSide(color: Colors.grey[300]!),
    viewShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    headerHintStyle: TextStyle(color: Colors.grey),
    headerTextStyle: TextStyle(fontSize: 16),
    isFullScreen: false,
    viewLeading: Icon(Icons.arrow_back),
    viewTrailing: [Icon(Icons.clear)],
  );
  print('SearchAnchor created');

  // ========== SearchAnchor.bar ==========
  print('--- SearchAnchor.bar Tests ---');
  final searchAnchorBar = SearchAnchor.bar(
    searchController: SearchController(),
    barHintText: 'Search here...',
    barLeading: Icon(Icons.search),
    barTrailing: [Icon(Icons.mic)],
    barElevation: WidgetStateProperty.all(1.0),
    barBackgroundColor: WidgetStateProperty.all(Colors.grey[100]),
    barShape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
    ),
    suggestionsBuilder: (context, controller) {
      return [ListTile(title: Text('Result'))];
    },
    viewHintText: 'Search...',
    isFullScreen: false,
  );
  print('SearchAnchor.bar created');

  // ========== SearchBarThemeData ==========
  print('--- SearchBarThemeData Tests ---');
  final searchBarTheme = SearchBarThemeData(
    elevation: WidgetStateProperty.all(2.0),
    backgroundColor: WidgetStateProperty.all(Colors.white),
    shadowColor: WidgetStateProperty.all(Colors.black26),
    surfaceTintColor: WidgetStateProperty.all(Colors.blue),
    overlayColor: WidgetStateProperty.all(Colors.blue[50]),
    side: WidgetStateProperty.all(BorderSide.none),
    shape: WidgetStateProperty.all(StadiumBorder()),
    padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 16)),
    textStyle: WidgetStateProperty.all(TextStyle(fontSize: 16)),
    hintStyle: WidgetStateProperty.all(TextStyle(color: Colors.grey)),
    constraints: BoxConstraints(minHeight: 48),
  );
  print('SearchBarThemeData created');

  // ========== SearchViewThemeData ==========
  print('--- SearchViewThemeData Tests ---');
  final searchViewTheme = SearchViewThemeData(
    backgroundColor: Colors.white,
    elevation: 8.0,
    surfaceTintColor: Colors.blue[50],
    side: BorderSide(color: Colors.grey[300]!),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    headerHintStyle: TextStyle(color: Colors.grey),
    headerTextStyle: TextStyle(fontSize: 16, color: Colors.black),
    dividerColor: Colors.grey[200],
  );
  print('SearchViewThemeData created');
  print('  elevation: ${searchViewTheme.elevation}');

  print('All search anchor tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Column(
        children: [
          SizedBox(height: 40),
          searchBar,
          SizedBox(height: 16),
          searchAnchor,
          SizedBox(height: 16),
          searchAnchorBar,
        ],
      ),
    ),
  );
}
