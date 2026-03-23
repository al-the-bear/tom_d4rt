// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SearchAnchor - Material 3 search widget with suggestions
import 'package:flutter/material.dart';

Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.blue.shade700,
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

Widget buildInfoCard(String label, String value) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
          ),
        ),
      ],
    ),
  );
}

Widget buildBasicSearchAnchor(String label, SearchController controller) {
  print('Building basic SearchAnchor: $label');
  List<String> sampleItems = [
    'Apple',
    'Banana',
    'Cherry',
    'Date',
    'Elderberry',
    'Fig',
    'Grape',
    'Honeydew',
  ];

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Tap to search for fruits',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        SearchAnchor(
          searchController: controller,
          builder: (BuildContext context, SearchController ctrl) {
            return SearchBar(
              controller: ctrl,
              padding: WidgetStatePropertyAll(
                EdgeInsets.symmetric(horizontal: 16),
              ),
              onTap: () {
                ctrl.openView();
              },
              onChanged: (String text) {
                ctrl.openView();
              },
              leading: Icon(Icons.search),
              hintText: 'Search fruits...',
            );
          },
          suggestionsBuilder: (
            BuildContext context,
            SearchController ctrl,
          ) {
            String query = ctrl.text.toLowerCase();
            List<String> filtered = [];
            int i = 0;
            for (i = 0; i < sampleItems.length; i = i + 1) {
              if (sampleItems[i].toLowerCase().contains(query)) {
                filtered.add(sampleItems[i]);
              }
            }
            List<Widget> suggestions = [];
            int j = 0;
            for (j = 0; j < filtered.length; j = j + 1) {
              String item = filtered[j];
              suggestions.add(
                ListTile(
                  leading: Icon(Icons.local_florist, color: Colors.green),
                  title: Text(item),
                  onTap: () {
                    ctrl.closeView(item);
                  },
                ),
              );
            }
            return suggestions;
          },
        ),
      ],
    ),
  );
}

Widget buildSearchAnchorWithViewLeading(SearchController controller) {
  print('Building SearchAnchor with viewLeading');
  List<String> cities = [
    'New York',
    'Los Angeles',
    'Chicago',
    'Houston',
    'Phoenix',
    'Philadelphia',
    'San Antonio',
    'San Diego',
  ];

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Custom viewLeading',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'viewLeading provides custom leading widget in search view',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        SearchAnchor(
          searchController: controller,
          viewLeading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.blue),
            onPressed: () {},
          ),
          builder: (BuildContext context, SearchController ctrl) {
            return SearchBar(
              controller: ctrl,
              padding: WidgetStatePropertyAll(
                EdgeInsets.symmetric(horizontal: 16),
              ),
              onTap: () {
                ctrl.openView();
              },
              leading: Icon(Icons.location_city, color: Colors.blue),
              hintText: 'Search cities...',
            );
          },
          suggestionsBuilder: (
            BuildContext context,
            SearchController ctrl,
          ) {
            String query = ctrl.text.toLowerCase();
            List<Widget> suggestions = [];
            int i = 0;
            for (i = 0; i < cities.length; i = i + 1) {
              if (cities[i].toLowerCase().contains(query)) {
                String city = cities[i];
                suggestions.add(
                  ListTile(
                    leading: Icon(Icons.place, color: Colors.blue),
                    title: Text(city),
                    subtitle: Text('United States'),
                    onTap: () {
                      ctrl.closeView(city);
                    },
                  ),
                );
              }
            }
            return suggestions;
          },
        ),
      ],
    ),
  );
}

Widget buildSearchAnchorWithViewTrailing(SearchController controller) {
  print('Building SearchAnchor with viewTrailing');
  List<String> contacts = [
    'Alice Johnson',
    'Bob Smith',
    'Carol White',
    'David Brown',
    'Emma Davis',
    'Frank Wilson',
  ];

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Custom viewTrailing',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'viewTrailing provides action buttons in search view',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        SearchAnchor(
          searchController: controller,
          viewTrailing: [
            IconButton(
              icon: Icon(Icons.mic, color: Colors.deepPurple),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.clear, color: Colors.red),
              onPressed: () {},
            ),
          ],
          builder: (BuildContext context, SearchController ctrl) {
            return SearchBar(
              controller: ctrl,
              padding: WidgetStatePropertyAll(
                EdgeInsets.symmetric(horizontal: 16),
              ),
              onTap: () {
                ctrl.openView();
              },
              leading: Icon(Icons.person_search, color: Colors.deepPurple),
              hintText: 'Search contacts...',
            );
          },
          suggestionsBuilder: (
            BuildContext context,
            SearchController ctrl,
          ) {
            String query = ctrl.text.toLowerCase();
            List<Widget> suggestions = [];
            int i = 0;
            for (i = 0; i < contacts.length; i = i + 1) {
              if (contacts[i].toLowerCase().contains(query)) {
                String contact = contacts[i];
                suggestions.add(
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.deepPurple.shade100,
                      child: Text(
                        contact.substring(0, 1),
                        style: TextStyle(color: Colors.deepPurple),
                      ),
                    ),
                    title: Text(contact),
                    trailing: Icon(Icons.call, color: Colors.green),
                    onTap: () {
                      ctrl.closeView(contact);
                    },
                  ),
                );
              }
            }
            return suggestions;
          },
        ),
      ],
    ),
  );
}

Widget buildSearchAnchorWithHintText(SearchController controller) {
  print('Building SearchAnchor with custom hint text');
  List<String> products = [
    'Laptop',
    'Smartphone',
    'Tablet',
    'Headphones',
    'Smartwatch',
    'Camera',
    'Speaker',
    'Monitor',
  ];

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Custom Hint Text',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'viewHintText sets placeholder in the search view input',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        SearchAnchor(
          searchController: controller,
          viewHintText: 'Type product name here...',
          builder: (BuildContext context, SearchController ctrl) {
            return SearchBar(
              controller: ctrl,
              padding: WidgetStatePropertyAll(
                EdgeInsets.symmetric(horizontal: 16),
              ),
              onTap: () {
                ctrl.openView();
              },
              leading: Icon(Icons.shopping_bag, color: Colors.orange),
              hintText: 'Search products...',
            );
          },
          suggestionsBuilder: (
            BuildContext context,
            SearchController ctrl,
          ) {
            String query = ctrl.text.toLowerCase();
            List<Widget> suggestions = [];
            int i = 0;
            for (i = 0; i < products.length; i = i + 1) {
              if (products[i].toLowerCase().contains(query)) {
                String product = products[i];
                suggestions.add(
                  ListTile(
                    leading: Icon(Icons.devices, color: Colors.orange),
                    title: Text(product),
                    subtitle: Text('Electronics'),
                    trailing: Text(
                      '\$${(i + 1) * 100}',
                      style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      ctrl.closeView(product);
                    },
                  ),
                );
              }
            }
            return suggestions;
          },
        ),
      ],
    ),
  );
}

Widget buildSearchAnchorWithCustomBuilder(SearchController controller) {
  print('Building SearchAnchor with custom builder');
  List<String> movies = [
    'The Shawshank Redemption',
    'The Godfather',
    'The Dark Knight',
    'Pulp Fiction',
    'Forrest Gump',
    'Inception',
    'The Matrix',
    'Interstellar',
  ];

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Custom Builder Widget',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'The builder property allows fully custom anchor widget',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        SearchAnchor(
          searchController: controller,
          builder: (BuildContext context, SearchController ctrl) {
            return FilledButton.tonalIcon(
              onPressed: () {
                ctrl.openView();
              },
              icon: Icon(Icons.movie_filter),
              label: Text('Search Movies'),
            );
          },
          suggestionsBuilder: (
            BuildContext context,
            SearchController ctrl,
          ) {
            String query = ctrl.text.toLowerCase();
            List<Widget> suggestions = [];
            int i = 0;
            for (i = 0; i < movies.length; i = i + 1) {
              if (movies[i].toLowerCase().contains(query)) {
                String movie = movies[i];
                suggestions.add(
                  ListTile(
                    leading: Icon(Icons.movie, color: Colors.red),
                    title: Text(movie),
                    subtitle: Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        SizedBox(width: 4),
                        Text('${8.0 + (i * 0.1)}'),
                      ],
                    ),
                    onTap: () {
                      ctrl.closeView(movie);
                    },
                  ),
                );
              }
            }
            return suggestions;
          },
        ),
      ],
    ),
  );
}

Widget buildSearchAnchorWithIconBuilder(SearchController controller) {
  print('Building SearchAnchor with icon as builder');
  List<String> tasks = [
    'Complete project documentation',
    'Review pull requests',
    'Fix bug in login module',
    'Update dependencies',
    'Write unit tests',
    'Deploy to staging',
  ];

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Icon Button as Builder',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Using IconButton as the search anchor trigger',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Center(
          child: SearchAnchor(
            searchController: controller,
            builder: (BuildContext context, SearchController ctrl) {
              return IconButton.filledTonal(
                icon: Icon(Icons.search, size: 28),
                onPressed: () {
                  ctrl.openView();
                },
              );
            },
            suggestionsBuilder: (
              BuildContext context,
              SearchController ctrl,
            ) {
              String query = ctrl.text.toLowerCase();
              List<Widget> suggestions = [];
              int i = 0;
              for (i = 0; i < tasks.length; i = i + 1) {
                if (tasks[i].toLowerCase().contains(query)) {
                  String task = tasks[i];
                  suggestions.add(
                    ListTile(
                      leading: Icon(Icons.task_alt, color: Colors.teal),
                      title: Text(task),
                      trailing: Chip(
                        label: Text('Active'),
                        backgroundColor: Colors.teal.shade100,
                      ),
                      onTap: () {
                        ctrl.closeView(task);
                      },
                    ),
                  );
                }
              }
              return suggestions;
            },
          ),
        ),
      ],
    ),
  );
}

Widget buildSearchAnchorFullScreen(SearchController controller) {
  print('Building SearchAnchor with isFullScreen');
  List<String> recipes = [
    'Spaghetti Carbonara',
    'Chicken Tikka Masala',
    'Beef Tacos',
    'Caesar Salad',
    'Vegetable Stir Fry',
    'Mushroom Risotto',
    'Grilled Salmon',
    'Pad Thai',
  ];

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Full Screen Mode (isFullScreen)',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'isFullScreen: true makes search view cover entire screen',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        SearchAnchor(
          searchController: controller,
          isFullScreen: true,
          builder: (BuildContext context, SearchController ctrl) {
            return SearchBar(
              controller: ctrl,
              padding: WidgetStatePropertyAll(
                EdgeInsets.symmetric(horizontal: 16),
              ),
              onTap: () {
                ctrl.openView();
              },
              leading: Icon(Icons.restaurant_menu, color: Colors.pink),
              hintText: 'Search recipes...',
            );
          },
          suggestionsBuilder: (
            BuildContext context,
            SearchController ctrl,
          ) {
            String query = ctrl.text.toLowerCase();
            List<Widget> suggestions = [];
            int i = 0;
            for (i = 0; i < recipes.length; i = i + 1) {
              if (recipes[i].toLowerCase().contains(query)) {
                String recipe = recipes[i];
                suggestions.add(
                  ListTile(
                    leading: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.pink.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.fastfood, color: Colors.pink),
                    ),
                    title: Text(recipe),
                    subtitle: Text('${15 + i * 5} min prep'),
                    trailing: Icon(Icons.favorite_border),
                    onTap: () {
                      ctrl.closeView(recipe);
                    },
                  ),
                );
              }
            }
            return suggestions;
          },
        ),
      ],
    ),
  );
}

Widget buildSearchAnchorWithBackgroundColor(SearchController controller) {
  print('Building SearchAnchor with viewBackgroundColor');
  List<String> playlists = [
    'Chill Vibes',
    'Workout Mix',
    'Focus Music',
    'Road Trip',
    'Party Hits',
    'Study Session',
    'Morning Coffee',
    'Late Night',
  ];

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Custom viewBackgroundColor',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'viewBackgroundColor changes the search view background',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        SearchAnchor(
          searchController: controller,
          viewBackgroundColor: Colors.indigo.shade50,
          builder: (BuildContext context, SearchController ctrl) {
            return SearchBar(
              controller: ctrl,
              padding: WidgetStatePropertyAll(
                EdgeInsets.symmetric(horizontal: 16),
              ),
              onTap: () {
                ctrl.openView();
              },
              leading: Icon(Icons.library_music, color: Colors.indigo),
              hintText: 'Search playlists...',
            );
          },
          suggestionsBuilder: (
            BuildContext context,
            SearchController ctrl,
          ) {
            String query = ctrl.text.toLowerCase();
            List<Widget> suggestions = [];
            int i = 0;
            for (i = 0; i < playlists.length; i = i + 1) {
              if (playlists[i].toLowerCase().contains(query)) {
                String playlist = playlists[i];
                suggestions.add(
                  ListTile(
                    leading: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.indigo, Colors.purple],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.playlist_play, color: Colors.white),
                    ),
                    title: Text(playlist),
                    subtitle: Text('${(i + 1) * 12} songs'),
                    onTap: () {
                      ctrl.closeView(playlist);
                    },
                  ),
                );
              }
            }
            return suggestions;
          },
        ),
      ],
    ),
  );
}

Widget buildSearchAnchorWithElevation(SearchController controller) {
  print('Building SearchAnchor with viewElevation');
  List<String> files = [
    'document.pdf',
    'spreadsheet.xlsx',
    'presentation.pptx',
    'image.png',
    'video.mp4',
    'archive.zip',
    'code.dart',
    'config.yaml',
  ];

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Custom viewElevation',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'viewElevation controls shadow depth of search view',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        SearchAnchor(
          searchController: controller,
          viewElevation: 16.0,
          builder: (BuildContext context, SearchController ctrl) {
            return SearchBar(
              controller: ctrl,
              padding: WidgetStatePropertyAll(
                EdgeInsets.symmetric(horizontal: 16),
              ),
              onTap: () {
                ctrl.openView();
              },
              leading: Icon(Icons.folder_open, color: Colors.amber.shade700),
              hintText: 'Search files...',
            );
          },
          suggestionsBuilder: (
            BuildContext context,
            SearchController ctrl,
          ) {
            String query = ctrl.text.toLowerCase();
            List<Widget> suggestions = [];
            int i = 0;
            for (i = 0; i < files.length; i = i + 1) {
              if (files[i].toLowerCase().contains(query)) {
                String file = files[i];
                IconData fileIcon = Icons.insert_drive_file;
                Color iconColor = Colors.grey;
                if (file.endsWith('.pdf')) {
                  fileIcon = Icons.picture_as_pdf;
                  iconColor = Colors.red;
                } else if (file.endsWith('.xlsx')) {
                  fileIcon = Icons.table_chart;
                  iconColor = Colors.green;
                } else if (file.endsWith('.pptx')) {
                  fileIcon = Icons.slideshow;
                  iconColor = Colors.orange;
                } else if (file.endsWith('.png')) {
                  fileIcon = Icons.image;
                  iconColor = Colors.blue;
                } else if (file.endsWith('.mp4')) {
                  fileIcon = Icons.video_file;
                  iconColor = Colors.purple;
                } else if (file.endsWith('.zip')) {
                  fileIcon = Icons.archive;
                  iconColor = Colors.brown;
                } else if (file.endsWith('.dart')) {
                  fileIcon = Icons.code;
                  iconColor = Colors.teal;
                } else if (file.endsWith('.yaml')) {
                  fileIcon = Icons.settings;
                  iconColor = Colors.pink;
                }
                suggestions.add(
                  ListTile(
                    leading: Icon(fileIcon, color: iconColor, size: 28),
                    title: Text(file),
                    subtitle: Text('${(i + 1) * 100} KB'),
                    onTap: () {
                      ctrl.closeView(file);
                    },
                  ),
                );
              }
            }
            return suggestions;
          },
        ),
      ],
    ),
  );
}

Widget buildSearchAnchorPropertiesTable() {
  print('Building SearchAnchor properties table');
  List<String> propNames = [
    'searchController',
    'builder',
    'suggestionsBuilder',
    'viewLeading',
    'viewTrailing',
    'viewHintText',
    'isFullScreen',
    'viewBackgroundColor',
    'viewElevation',
    'viewSurfaceTintColor',
  ];
  List<String> propTypes = [
    'SearchController?',
    'Widget Function(BuildContext, SearchController)',
    'Iterable<Widget> Function(BuildContext, SearchController)',
    'Widget?',
    'Iterable<Widget>?',
    'String?',
    'bool?',
    'Color?',
    'double?',
    'Color?',
  ];
  List<String> propDescriptions = [
    'Controller for managing search state',
    'Builds the anchor widget that triggers search',
    'Builds suggestion list based on search query',
    'Leading widget in the search view app bar',
    'Trailing widgets in the search view app bar',
    'Placeholder text in search input field',
    'Whether search view covers full screen',
    'Background color of the search view',
    'Elevation shadow of the search view',
    'Surface tint color for Material 3 styling',
  ];

  List<Widget> rows = [];
  int p = 0;
  for (p = 0; p < propNames.length; p = p + 1) {
    Color bg = (p % 2 == 0) ? Colors.blue.shade50 : Colors.white;
    rows.add(
      Container(
        padding: EdgeInsets.all(10),
        color: bg,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  propNames[p],
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  propTypes[p],
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade600,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            Text(
              propDescriptions[p],
              style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Text(
            'SearchAnchor Properties Reference',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Column(children: rows),
      ],
    ),
  );
}

Widget buildSearchControllerInfo() {
  print('Building SearchController info');
  List<String> methods = [
    'openView()',
    'closeView(String? text)',
    'text',
    'dispose()',
  ];
  List<String> descriptions = [
    'Opens the search view programmatically',
    'Closes search view, optionally setting selected text',
    'Current text in search input (getter)',
    'Disposes the controller when no longer needed',
  ];

  List<Widget> items = [];
  int m = 0;
  for (m = 0; m < methods.length; m = m + 1) {
    items.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.teal.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.teal.shade200),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                methods[m],
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                descriptions[m],
                style: TextStyle(fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SearchController Methods',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Essential methods for controlling search behavior',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: items),
      ],
    ),
  );
}

Widget buildMaterialDesignGuidelines() {
  print('Building Material Design guidelines');
  List<String> guidelines = [
    'SearchAnchor is a Material 3 component for contextual search',
    'Use with SearchController for programmatic control',
    'suggestionsBuilder should return filtered results based on query',
    'Consider using SearchAnchor.bar for a simpler search bar variant',
    'viewLeading typically contains a back or close button',
    'viewTrailing can include voice search or clear buttons',
    'Use isFullScreen: true for mobile-optimized experience',
    'Match viewBackgroundColor with your app theme',
  ];

  List<Widget> guidelineWidgets = [];
  int g = 0;
  for (g = 0; g < guidelines.length; g = g + 1) {
    guidelineWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 3),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 18),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                guidelines[g],
                style: TextStyle(fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.green.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.green.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.design_services, color: Colors.green.shade700),
            SizedBox(width: 8),
            Text(
              'Material Design Guidelines',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade700,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Column(children: guidelineWidgets),
      ],
    ),
  );
}

Widget buildSearchAnchorBarVariant(SearchController controller) {
  print('Building SearchAnchor.bar variant');
  List<String> books = [
    'The Great Gatsby',
    'To Kill a Mockingbird',
    'Pride and Prejudice',
    '1984',
    'The Catcher in the Rye',
    'Lord of the Flies',
    'Animal Farm',
    'Brave New World',
  ];

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SearchAnchor.bar Variant',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Simplified search bar with default Material 3 styling',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        SearchAnchor.bar(
          searchController: controller,
          barHintText: 'Search books...',
          barLeading: Icon(Icons.menu_book, color: Colors.brown),
          suggestionsBuilder: (
            BuildContext context,
            SearchController ctrl,
          ) {
            String query = ctrl.text.toLowerCase();
            List<Widget> suggestions = [];
            int i = 0;
            for (i = 0; i < books.length; i = i + 1) {
              if (books[i].toLowerCase().contains(query)) {
                String book = books[i];
                suggestions.add(
                  ListTile(
                    leading: Icon(Icons.book, color: Colors.brown),
                    title: Text(book),
                    subtitle: Text('Classic Literature'),
                    onTap: () {
                      ctrl.closeView(book);
                    },
                  ),
                );
              }
            }
            return suggestions;
          },
        ),
      ],
    ),
  );
}

Widget buildSuggestionBuildingPatterns() {
  print('Building suggestion patterns');
  List<String> patterns = [
    'Filter Suggestions',
    'Highlight Matches',
    'Category Headers',
    'Recent Searches',
    'Trending Items',
    'Empty State',
  ];
  List<String> patternDescriptions = [
    'Filter items based on query text using contains or startsWith',
    'Bold or highlight the matching portion in suggestion text',
    'Group suggestions under category headers using dividers',
    'Show recently searched terms when query is empty',
    'Display popular items before showing search results',
    'Show helpful message when no suggestions match query',
  ];
  List<IconData> patternIcons = [
    Icons.filter_list,
    Icons.highlight,
    Icons.category,
    Icons.history,
    Icons.trending_up,
    Icons.inbox,
  ];

  List<Widget> patternCards = [];
  int p = 0;
  for (p = 0; p < patterns.length; p = p + 1) {
    patternCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.purple.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.purple.shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(patternIcons[p], color: Colors.white, size: 20),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    patterns[p],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    patternDescriptions[p],
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Suggestion Building Patterns',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Common approaches for building suggestion lists',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: patternCards),
      ],
    ),
  );
}

Widget buildSearchBarStylingOptions() {
  print('Building SearchBar styling options');
  List<String> styleNames = [
    'padding',
    'elevation',
    'backgroundColor',
    'shadowColor',
    'overlayColor',
    'surfaceTintColor',
    'shape',
    'side',
    'textStyle',
    'hintStyle',
  ];
  List<String> styleDescriptions = [
    'Internal padding of the search bar',
    'Elevation shadow depth',
    'Background fill color',
    'Color of the shadow',
    'Color when hovered or focused',
    'Material 3 surface tint',
    'Overall shape and border radius',
    'Border styling',
    'Style for search text',
    'Style for hint text',
  ];

  List<Widget> styleRows = [];
  int s = 0;
  for (s = 0; s < styleNames.length; s = s + 1) {
    styleRows.add(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: (s % 2 == 0) ? Colors.orange.shade50 : Colors.white,
        ),
        child: Row(
          children: [
            SizedBox(
              width: 120,
              child: Text(
                styleNames[s],
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange.shade800,
                ),
              ),
            ),
            Expanded(
              child: Text(
                styleDescriptions[s],
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.orange.shade100,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Text(
            'SearchBar Styling Properties',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Column(children: styleRows),
      ],
    ),
  );
}

Widget buildAccessibilityFeatures() {
  print('Building accessibility features');
  List<String> features = [
    'SearchAnchor supports screen readers via semantics',
    'Focus management is handled automatically',
    'Keyboard navigation works within suggestions',
    'viewHintText provides accessibility label for input',
    'Use proper contrast ratios for text colors',
    'Ensure touch targets meet minimum size guidelines',
  ];

  List<Widget> featureItems = [];
  int f = 0;
  for (f = 0; f < features.length; f = f + 1) {
    featureItems.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 3),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.accessibility_new, color: Colors.blue, size: 18),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                features[f],
                style: TextStyle(fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.blue.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.blue.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.accessibility, color: Colors.blue.shade700),
            SizedBox(width: 8),
            Text(
              'Accessibility Features',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade700,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Column(children: featureItems),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('SearchAnchor deep demo test executing');

  SearchController controller1 = SearchController();
  SearchController controller2 = SearchController();
  SearchController controller3 = SearchController();
  SearchController controller4 = SearchController();
  SearchController controller5 = SearchController();
  SearchController controller6 = SearchController();
  SearchController controller7 = SearchController();
  SearchController controller8 = SearchController();
  SearchController controller9 = SearchController();
  SearchController controller10 = SearchController();

  Widget result = MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: Text('SearchAnchor Demo'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionHeader('1. Overview'),
            buildInfoCard('Class', 'SearchAnchor'),
            buildInfoCard(
              'Purpose',
              'Material 3 search widget with suggestions support',
            ),
            buildInfoCard('Package', 'flutter/material.dart'),
            buildInfoCard(
              'Key Feature',
              'Manages search view with customizable suggestions',
            ),

            buildSectionHeader('2. Basic SearchAnchor'),
            buildBasicSearchAnchor('Fruit Search', controller1),

            buildSectionHeader('3. Custom viewLeading'),
            buildSearchAnchorWithViewLeading(controller2),

            buildSectionHeader('4. Custom viewTrailing'),
            buildSearchAnchorWithViewTrailing(controller3),

            buildSectionHeader('5. Hint Text'),
            buildSearchAnchorWithHintText(controller4),

            buildSectionHeader('6. Builder Customization'),
            buildSearchAnchorWithCustomBuilder(controller5),
            buildSearchAnchorWithIconBuilder(controller6),

            buildSectionHeader('7. Full Screen Mode'),
            buildSearchAnchorFullScreen(controller7),

            buildSectionHeader('8. View Background Color'),
            buildSearchAnchorWithBackgroundColor(controller8),

            buildSectionHeader('9. View Elevation'),
            buildSearchAnchorWithElevation(controller9),

            buildSectionHeader('10. SearchAnchor.bar Variant'),
            buildSearchAnchorBarVariant(controller10),

            buildSectionHeader('11. Properties Reference'),
            buildSearchAnchorPropertiesTable(),

            buildSectionHeader('12. SearchController'),
            buildSearchControllerInfo(),

            buildSectionHeader('13. SearchBar Styling'),
            buildSearchBarStylingOptions(),

            buildSectionHeader('14. Suggestion Patterns'),
            buildSuggestionBuildingPatterns(),

            buildSectionHeader('15. Design Guidelines'),
            buildMaterialDesignGuidelines(),

            buildSectionHeader('16. Accessibility'),
            buildAccessibilityFeatures(),

            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );

  print('SearchAnchor deep demo completed');
  return result;
}
