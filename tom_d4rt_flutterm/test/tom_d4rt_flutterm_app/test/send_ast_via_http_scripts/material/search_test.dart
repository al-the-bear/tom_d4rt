// D4rt test script: Tests SearchBar and SearchAnchor from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Search widgets test executing');

  // ========== SEARCHBAR ==========
  print('--- SearchBar Tests ---');

  // Test basic SearchBar
  final basicSearchBar = SearchBar(hintText: 'Search');
  print('Basic SearchBar created');

  // Test SearchBar with leading
  final leadingSearchBar = SearchBar(
    hintText: 'Search',
    leading: Icon(Icons.search),
  );
  print('SearchBar with leading created');

  // Test SearchBar with trailing
  final trailingSearchBar = SearchBar(
    hintText: 'Search',
    trailing: [
      IconButton(
        icon: Icon(Icons.mic),
        onPressed: () {
          print('Mic pressed');
        },
      ),
    ],
  );
  print('SearchBar with trailing created');

  // Test SearchBar with onTap
  final tapSearchBar = SearchBar(
    hintText: 'Tap to search',
    onTap: () {
      print('SearchBar tapped');
    },
  );
  print('SearchBar with onTap created');

  // Test SearchBar with onChanged
  final changedSearchBar = SearchBar(
    hintText: 'Type to search',
    onChanged: (String value) {
      print('Search changed: $value');
    },
  );
  print('SearchBar with onChanged created');

  // Test SearchBar with onSubmitted
  final submittedSearchBar = SearchBar(
    hintText: 'Press enter to submit',
    onSubmitted: (String value) {
      print('Search submitted: $value');
    },
  );
  print('SearchBar with onSubmitted created');

  // Test SearchBar with controller
  final controller = TextEditingController(text: 'Initial text');
  final controllerSearchBar = SearchBar(
    hintText: 'With controller',
    controller: controller,
  );
  print('SearchBar with controller created');

  // Test SearchBar with backgroundColor
  final bgSearchBar = SearchBar(
    hintText: 'Colored background',
    backgroundColor: MaterialStateProperty.all(Colors.blue.shade50),
  );
  print('SearchBar with backgroundColor created');

  // Test SearchBar with overlayColor
  final overlaySearchBar = SearchBar(
    hintText: 'Overlay color',
    overlayColor: MaterialStateProperty.all(Colors.purple.shade100),
  );
  print('SearchBar with overlayColor created');

  // Test SearchBar with shadowColor
  final shadowSearchBar = SearchBar(
    hintText: 'Shadow color',
    shadowColor: MaterialStateProperty.all(Colors.red),
    elevation: MaterialStateProperty.all(8.0),
  );
  print('SearchBar with shadowColor created');

  // Test SearchBar with elevation
  final elevatedSearchBar = SearchBar(
    hintText: 'Elevated',
    elevation: MaterialStateProperty.all(12.0),
  );
  print('SearchBar with elevation created');

  // Test SearchBar with side
  final borderedSearchBar = SearchBar(
    hintText: 'Bordered',
    side: MaterialStateProperty.all(BorderSide(color: Colors.blue, width: 2.0)),
  );
  print('SearchBar with side created');

  // Test SearchBar with shape
  final shapedSearchBar = SearchBar(
    hintText: 'Custom shape',
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    ),
  );
  print('SearchBar with shape created');

  // Test SearchBar with padding
  final paddedSearchBar = SearchBar(
    hintText: 'Padded',
    padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 24.0)),
  );
  print('SearchBar with padding created');

  // Test SearchBar with textStyle
  final styledTextSearchBar = SearchBar(
    hintText: 'Styled text',
    textStyle: MaterialStateProperty.all(
      TextStyle(color: Colors.purple, fontSize: 18.0),
    ),
  );
  print('SearchBar with textStyle created');

  // Test SearchBar with hintStyle
  final styledHintSearchBar = SearchBar(
    hintText: 'Styled hint',
    hintStyle: MaterialStateProperty.all(
      TextStyle(color: Colors.grey.shade400, fontStyle: FontStyle.italic),
    ),
  );
  print('SearchBar with hintStyle created');

  // Test SearchBar with constraints
  final constrainedSearchBar = SearchBar(
    hintText: 'Constrained',
    constraints: BoxConstraints(maxWidth: 300, minHeight: 56),
  );
  print('SearchBar with constraints created');

  // Test SearchBar with autoFocus
  final autoFocusSearchBar = SearchBar(
    hintText: 'Auto focus (disabled for demo)',
    autoFocus: false,
  );
  print('SearchBar with autoFocus created');

  // ========== SEARCHANCHOR ==========
  print('--- SearchAnchor Tests ---');

  // Test basic SearchAnchor
  final basicSearchAnchor = SearchAnchor(
    builder: (BuildContext context, SearchController controller) {
      return IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          controller.openView();
        },
      );
    },
    suggestionsBuilder: (BuildContext context, SearchController controller) {
      return List<Widget>.generate(5, (int index) {
        final item = 'Item $index';
        return ListTile(
          title: Text(item),
          onTap: () {
            controller.closeView(item);
            print('Selected: $item');
          },
        );
      });
    },
  );
  print('Basic SearchAnchor created');

  // Test SearchAnchor with isFullScreen
  final fullScreenSearchAnchor = SearchAnchor(
    isFullScreen: true,
    builder: (context, controller) {
      return IconButton(
        icon: Icon(Icons.search),
        onPressed: () => controller.openView(),
      );
    },
    suggestionsBuilder: (context, controller) {
      return [
        ListTile(title: Text('Fullscreen suggestion 1')),
        ListTile(title: Text('Fullscreen suggestion 2')),
      ];
    },
  );
  print('SearchAnchor with isFullScreen created');

  // Test SearchAnchor with searchController
  final searchController = SearchController();
  final controllerSearchAnchor = SearchAnchor(
    searchController: searchController,
    builder: (context, controller) {
      return IconButton(
        icon: Icon(Icons.search),
        onPressed: () => controller.openView(),
      );
    },
    suggestionsBuilder: (context, controller) {
      final text = controller.text;
      return [ListTile(title: Text('Searching for: $text'))];
    },
  );
  print('SearchAnchor with searchController created');

  // Test SearchAnchor with viewHintText
  final hintSearchAnchor = SearchAnchor(
    viewHintText: 'Search items...',
    builder: (context, controller) {
      return FilledButton.icon(
        icon: Icon(Icons.search),
        label: Text('Search'),
        onPressed: () => controller.openView(),
      );
    },
    suggestionsBuilder: (context, controller) {
      return [ListTile(title: Text('Hint visible in view'))];
    },
  );
  print('SearchAnchor with viewHintText created');

  // Test SearchAnchor with viewLeading
  final leadingSearchAnchor = SearchAnchor(
    viewLeading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {}),
    builder: (context, controller) {
      return IconButton(
        icon: Icon(Icons.search),
        onPressed: () => controller.openView(),
      );
    },
    suggestionsBuilder: (context, controller) {
      return [ListTile(title: Text('Custom leading icon'))];
    },
  );
  print('SearchAnchor with viewLeading created');

  // Test SearchAnchor with viewTrailing
  final trailingSearchAnchor = SearchAnchor(
    viewTrailing: [
      IconButton(icon: Icon(Icons.mic), onPressed: () {}),
      IconButton(icon: Icon(Icons.clear), onPressed: () {}),
    ],
    builder: (context, controller) {
      return IconButton(
        icon: Icon(Icons.search),
        onPressed: () => controller.openView(),
      );
    },
    suggestionsBuilder: (context, controller) {
      return [ListTile(title: Text('Custom trailing icons'))];
    },
  );
  print('SearchAnchor with viewTrailing created');

  // Test SearchAnchor with viewBackgroundColor
  final bgSearchAnchor = SearchAnchor(
    viewBackgroundColor: Colors.blue.shade50,
    builder: (context, controller) {
      return IconButton(
        icon: Icon(Icons.search),
        onPressed: () => controller.openView(),
      );
    },
    suggestionsBuilder: (context, controller) {
      return [ListTile(title: Text('Colored background view'))];
    },
  );
  print('SearchAnchor with viewBackgroundColor created');

  // Test SearchAnchor with viewElevation
  final elevationSearchAnchor = SearchAnchor(
    viewElevation: 16.0,
    builder: (context, controller) {
      return IconButton(
        icon: Icon(Icons.search),
        onPressed: () => controller.openView(),
      );
    },
    suggestionsBuilder: (context, controller) {
      return [ListTile(title: Text('Elevated view'))];
    },
  );
  print('SearchAnchor with viewElevation created');

  // Test SearchAnchor with viewSide
  final sideSearchAnchor = SearchAnchor(
    viewSide: BorderSide(color: Colors.purple, width: 2.0),
    builder: (context, controller) {
      return IconButton(
        icon: Icon(Icons.search),
        onPressed: () => controller.openView(),
      );
    },
    suggestionsBuilder: (context, controller) {
      return [ListTile(title: Text('Bordered view'))];
    },
  );
  print('SearchAnchor with viewSide created');

  // Test SearchAnchor with viewShape
  final shapeSearchAnchor = SearchAnchor(
    viewShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
    ),
    builder: (context, controller) {
      return IconButton(
        icon: Icon(Icons.search),
        onPressed: () => controller.openView(),
      );
    },
    suggestionsBuilder: (context, controller) {
      return [ListTile(title: Text('Rounded view'))];
    },
  );
  print('SearchAnchor with viewShape created');

  // Test SearchAnchor with dividerColor
  final dividerSearchAnchor = SearchAnchor(
    dividerColor: Colors.orange,
    builder: (context, controller) {
      return IconButton(
        icon: Icon(Icons.search),
        onPressed: () => controller.openView(),
      );
    },
    suggestionsBuilder: (context, controller) {
      return [
        ListTile(title: Text('Orange divider')),
        Divider(),
        ListTile(title: Text('Second item')),
      ];
    },
  );
  print('SearchAnchor with dividerColor created');

  // Test SearchAnchor.bar
  final barSearchAnchor = SearchAnchor.bar(
    barHintText: 'Search bar',
    suggestionsBuilder: (context, controller) {
      return List<Widget>.generate(3, (index) {
        return ListTile(
          title: Text('Bar suggestion $index'),
          onTap: () {
            controller.closeView('Bar suggestion $index');
          },
        );
      });
    },
  );
  print('SearchAnchor.bar created');

  print('Search widgets test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Search Widgets Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),

        Text(
          'SearchBar Examples:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),

        basicSearchBar,
        SizedBox(height: 12.0),

        leadingSearchBar,
        SizedBox(height: 12.0),

        trailingSearchBar,
        SizedBox(height: 12.0),

        bgSearchBar,
        SizedBox(height: 12.0),

        borderedSearchBar,
        SizedBox(height: 12.0),

        shapedSearchBar,
        SizedBox(height: 12.0),

        elevatedSearchBar,
        SizedBox(height: 12.0),

        styledHintSearchBar,

        SizedBox(height: 24.0),
        Text(
          'SearchAnchor Examples:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          '(Tap icons to open search views)',
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
        SizedBox(height: 8.0),

        Row(
          children: [
            Column(
              children: [
                basicSearchAnchor,
                Text('Basic', style: TextStyle(fontSize: 10)),
              ],
            ),
            SizedBox(width: 16),
            Column(
              children: [
                fullScreenSearchAnchor,
                Text('Fullscreen', style: TextStyle(fontSize: 10)),
              ],
            ),
            SizedBox(width: 16),
            Column(children: [hintSearchAnchor]),
          ],
        ),
        SizedBox(height: 16.0),

        Row(
          children: [
            Column(
              children: [
                leadingSearchAnchor,
                Text('Custom Lead', style: TextStyle(fontSize: 10)),
              ],
            ),
            SizedBox(width: 16),
            Column(
              children: [
                trailingSearchAnchor,
                Text('Custom Trail', style: TextStyle(fontSize: 10)),
              ],
            ),
            SizedBox(width: 16),
            Column(
              children: [
                bgSearchAnchor,
                Text('BG Color', style: TextStyle(fontSize: 10)),
              ],
            ),
          ],
        ),

        SizedBox(height: 24.0),
        Text(
          'SearchAnchor.bar:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        barSearchAnchor,
      ],
    ),
  );
}
