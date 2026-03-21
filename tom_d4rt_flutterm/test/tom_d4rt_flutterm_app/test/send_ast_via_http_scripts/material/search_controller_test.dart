// D4rt test script: Tests SearchController - controls SearchAnchor/SearchBar interactions
import 'package:flutter/material.dart';

Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.indigo.shade700,
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

Widget buildCreatingSearchController() {
  print('Building Creating SearchController demo');
  SearchController controller1 = SearchController();
  SearchController controller2 = SearchController();
  SearchController controller3 = SearchController();

  List<String> fruits = ['Apple', 'Banana', 'Cherry', 'Date', 'Elderberry'];

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
          'Creating SearchController Instances',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'SearchController is instantiated with no arguments. Each controller manages one SearchAnchor.',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Code Example:',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade700,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'SearchController controller = SearchController();',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'monospace',
                  color: Colors.indigo.shade900,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Basic Search with Controller',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        SearchAnchor(
          searchController: controller1,
          builder: (BuildContext context, SearchController ctrl) {
            return SearchBar(
              controller: ctrl,
              padding: WidgetStatePropertyAll(
                EdgeInsets.symmetric(horizontal: 16),
              ),
              onTap: () {
                ctrl.openView();
              },
              leading: Icon(Icons.search, color: Colors.indigo),
              hintText: 'Search fruits...',
            );
          },
          suggestionsBuilder: (BuildContext context, SearchController ctrl) {
            String query = ctrl.text.toLowerCase();
            List<Widget> suggestions = [];
            int i = 0;
            for (i = 0; i < fruits.length; i = i + 1) {
              if (fruits[i].toLowerCase().contains(query)) {
                String item = fruits[i];
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
            }
            return suggestions;
          },
        ),
        SizedBox(height: 16),
        Text(
          'Multiple Controllers (Independent)',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: SearchAnchor(
                searchController: controller2,
                builder: (BuildContext context, SearchController ctrl) {
                  return FilledButton.tonalIcon(
                    onPressed: () {
                      ctrl.openView();
                    },
                    icon: Icon(Icons.person_search),
                    label: Text('Users'),
                  );
                },
                suggestionsBuilder: (
                  BuildContext context,
                  SearchController ctrl,
                ) {
                  return [
                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text('Alice'),
                      onTap: () {
                        ctrl.closeView('Alice');
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text('Bob'),
                      onTap: () {
                        ctrl.closeView('Bob');
                      },
                    ),
                  ];
                },
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: SearchAnchor(
                searchController: controller3,
                builder: (BuildContext context, SearchController ctrl) {
                  return FilledButton.tonalIcon(
                    onPressed: () {
                      ctrl.openView();
                    },
                    icon: Icon(Icons.tag),
                    label: Text('Tags'),
                  );
                },
                suggestionsBuilder: (
                  BuildContext context,
                  SearchController ctrl,
                ) {
                  return [
                    ListTile(
                      leading: Icon(Icons.label),
                      title: Text('Flutter'),
                      onTap: () {
                        ctrl.closeView('Flutter');
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.label),
                      title: Text('Dart'),
                      onTap: () {
                        ctrl.closeView('Dart');
                      },
                    ),
                  ];
                },
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildTextPropertyDemo() {
  print('Building text property demo');
  SearchController controller = SearchController();

  List<String> countries = [
    'United States',
    'United Kingdom',
    'Canada',
    'Australia',
    'Germany',
    'France',
    'Japan',
    'Brazil',
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
          'text Property',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'The text property gets/sets the current search query. Use in suggestionsBuilder to filter results.',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.teal.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Usage:',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade700,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'String query = controller.text;',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'monospace',
                  color: Colors.teal.shade900,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'controller.text = "new search";',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'monospace',
                  color: Colors.teal.shade900,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
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
              onChanged: (String value) {
                print('Current text: ${ctrl.text}');
              },
              leading: Icon(Icons.public, color: Colors.teal),
              hintText: 'Search countries...',
            );
          },
          suggestionsBuilder: (BuildContext context, SearchController ctrl) {
            String query = ctrl.text.toLowerCase();
            print('Filtering with text: "$query"');
            List<Widget> suggestions = [];
            int i = 0;
            for (i = 0; i < countries.length; i = i + 1) {
              if (countries[i].toLowerCase().contains(query)) {
                String country = countries[i];
                suggestions.add(
                  ListTile(
                    leading: Icon(Icons.flag, color: Colors.teal),
                    title: Text(country),
                    subtitle: Text('Match for: "${ctrl.text}"'),
                    onTap: () {
                      ctrl.closeView(country);
                    },
                  ),
                );
              }
            }
            if (suggestions.isEmpty) {
              suggestions.add(
                ListTile(
                  leading: Icon(Icons.search_off, color: Colors.grey),
                  title: Text('No results for "${ctrl.text}"'),
                ),
              );
            }
            return suggestions;
          },
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.amber.shade300),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.amber.shade700, size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'The text property is read from TextEditingController internally and reflects current input.',
                  style: TextStyle(fontSize: 12, color: Colors.amber.shade900),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildOpenViewDemo() {
  print('Building openView demo');
  SearchController controller1 = SearchController();
  SearchController controller2 = SearchController();

  List<String> tasks = [
    'Complete documentation',
    'Review pull request',
    'Fix login bug',
    'Update dependencies',
    'Write unit tests',
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
          'openView() Method',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Opens the search view programmatically. Call this to show the suggestions overlay.',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Method Signature:',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade700,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'void openView()',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'monospace',
                  color: Colors.blue.shade900,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Open on Tap',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        SearchAnchor(
          searchController: controller1,
          builder: (BuildContext context, SearchController ctrl) {
            return SearchBar(
              controller: ctrl,
              padding: WidgetStatePropertyAll(
                EdgeInsets.symmetric(horizontal: 16),
              ),
              onTap: () {
                print('onTap called - opening view');
                ctrl.openView();
              },
              leading: Icon(Icons.task_alt, color: Colors.blue),
              hintText: 'Tap to open search view...',
            );
          },
          suggestionsBuilder: (BuildContext context, SearchController ctrl) {
            String query = ctrl.text.toLowerCase();
            List<Widget> suggestions = [];
            int i = 0;
            for (i = 0; i < tasks.length; i = i + 1) {
              if (tasks[i].toLowerCase().contains(query)) {
                String task = tasks[i];
                suggestions.add(
                  ListTile(
                    leading: Icon(Icons.check_circle_outline, color: Colors.blue),
                    title: Text(task),
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
        SizedBox(height: 16),
        Text(
          'Open on Text Change',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        SearchAnchor(
          searchController: controller2,
          builder: (BuildContext context, SearchController ctrl) {
            return SearchBar(
              controller: ctrl,
              padding: WidgetStatePropertyAll(
                EdgeInsets.symmetric(horizontal: 16),
              ),
              onChanged: (String text) {
                print('Text changed to: $text - opening view');
                ctrl.openView();
              },
              leading: Icon(Icons.edit, color: Colors.purple),
              hintText: 'Type to trigger openView...',
            );
          },
          suggestionsBuilder: (BuildContext context, SearchController ctrl) {
            return [
              ListTile(
                leading: Icon(Icons.info, color: Colors.purple),
                title: Text('View opened via onChanged'),
                subtitle: Text('Current input: "${ctrl.text}"'),
              ),
            ];
          },
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.green.shade300),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb, color: Colors.green.shade700, size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Use openView() in onTap or onChanged to show suggestions when user interacts with search bar.',
                  style: TextStyle(fontSize: 12, color: Colors.green.shade900),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildCloseViewDemo() {
  print('Building closeView demo');
  SearchController controller1 = SearchController();
  SearchController controller2 = SearchController();

  List<String> colors = [
    'Red',
    'Blue',
    'Green',
    'Yellow',
    'Purple',
    'Orange',
    'Pink',
    'Cyan',
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
          'closeView() Method',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Closes the search view and optionally sets the selected text value.',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Method Signature:',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange.shade700,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'void closeView(String? selectedText)',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'monospace',
                  color: Colors.orange.shade900,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Close with Selected Value',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        SearchAnchor(
          searchController: controller1,
          builder: (BuildContext context, SearchController ctrl) {
            return SearchBar(
              controller: ctrl,
              padding: WidgetStatePropertyAll(
                EdgeInsets.symmetric(horizontal: 16),
              ),
              onTap: () {
                ctrl.openView();
              },
              leading: Icon(Icons.palette, color: Colors.orange),
              hintText: 'Select a color...',
            );
          },
          suggestionsBuilder: (BuildContext context, SearchController ctrl) {
            String query = ctrl.text.toLowerCase();
            List<Widget> suggestions = [];
            int i = 0;
            for (i = 0; i < colors.length; i = i + 1) {
              if (colors[i].toLowerCase().contains(query)) {
                String color = colors[i];
                suggestions.add(
                  ListTile(
                    leading: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: _getColorFromName(color),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    title: Text(color),
                    subtitle: Text('Tap to select'),
                    onTap: () {
                      print('closeView called with: $color');
                      ctrl.closeView(color);
                    },
                  ),
                );
              }
            }
            return suggestions;
          },
        ),
        SizedBox(height: 16),
        Text(
          'Close without Value (null)',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        SearchAnchor(
          searchController: controller2,
          viewLeading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  print('closeView called with null');
                  controller2.closeView(null);
                },
              );
            },
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
              leading: Icon(Icons.cancel, color: Colors.red),
              hintText: 'Use back to close without selecting...',
            );
          },
          suggestionsBuilder: (BuildContext context, SearchController ctrl) {
            return [
              ListTile(
                leading: Icon(Icons.info, color: Colors.grey),
                title: Text('Press back arrow to close'),
                subtitle: Text('No value will be set'),
              ),
              ListTile(
                leading: Icon(Icons.check_circle, color: Colors.green),
                title: Text('Option A'),
                onTap: () {
                  ctrl.closeView('Option A');
                },
              ),
              ListTile(
                leading: Icon(Icons.check_circle, color: Colors.green),
                title: Text('Option B'),
                onTap: () {
                  ctrl.closeView('Option B');
                },
              ),
            ];
          },
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.purple.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.purple.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.compare_arrows, color: Colors.purple.shade700, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'closeView Behavior:',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple.shade900,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6),
              Text(
                'closeView("value") - closes and sets text to "value"',
                style: TextStyle(fontSize: 11, color: Colors.purple.shade800),
              ),
              Text(
                'closeView(null) - closes without changing text',
                style: TextStyle(fontSize: 11, color: Colors.purple.shade800),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Color _getColorFromName(String name) {
  if (name == 'Red') return Colors.red;
  if (name == 'Blue') return Colors.blue;
  if (name == 'Green') return Colors.green;
  if (name == 'Yellow') return Colors.yellow;
  if (name == 'Purple') return Colors.purple;
  if (name == 'Orange') return Colors.orange;
  if (name == 'Pink') return Colors.pink;
  if (name == 'Cyan') return Colors.cyan;
  return Colors.grey;
}

Widget buildIsOpenDemo() {
  print('Building isOpen demo');
  SearchController controller = SearchController();

  List<String> items = ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5'];

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
          'isOpen Property',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Read-only boolean indicating if the search view is currently open.',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.cyan.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Property:',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyan.shade700,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'bool get isOpen',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'monospace',
                  color: Colors.cyan.shade900,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        SearchAnchor(
          searchController: controller,
          builder: (BuildContext context, SearchController ctrl) {
            return SearchBar(
              controller: ctrl,
              padding: WidgetStatePropertyAll(
                EdgeInsets.symmetric(horizontal: 16),
              ),
              onTap: () {
                print('Before openView - isOpen: ${ctrl.isOpen}');
                ctrl.openView();
                print('After openView - isOpen: ${ctrl.isOpen}');
              },
              leading: Icon(Icons.visibility, color: Colors.cyan),
              hintText: 'Check isOpen in console...',
            );
          },
          suggestionsBuilder: (BuildContext context, SearchController ctrl) {
            print('In suggestionsBuilder - isOpen: ${ctrl.isOpen}');
            List<Widget> suggestions = [];
            int i = 0;
            for (i = 0; i < items.length; i = i + 1) {
              String item = items[i];
              suggestions.add(
                ListTile(
                  leading: Icon(Icons.circle, color: Colors.cyan),
                  title: Text(item),
                  subtitle: Text('isOpen: ${ctrl.isOpen}'),
                  onTap: () {
                    print('Before closeView - isOpen: ${ctrl.isOpen}');
                    ctrl.closeView(item);
                  },
                ),
              );
            }
            return suggestions;
          },
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Usage Scenarios:',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              _buildUsageRow(
                'Conditional UI',
                'Show/hide elements based on search state',
              ),
              _buildUsageRow(
                'Analytics',
                'Track when users open/close search',
              ),
              _buildUsageRow(
                'State Management',
                'Sync search state with app state',
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildUsageRow(String title, String description) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.arrow_right, color: Colors.cyan, size: 18),
        SizedBox(width: 4),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              Text(
                description,
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildValuePropertyDemo() {
  print('Building value property demo');
  SearchController controller = SearchController();

  List<String> emails = [
    'john@example.com',
    'jane@example.com',
    'bob@example.com',
    'alice@example.com',
    'charlie@example.com',
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
          'value Property',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'The value property provides access to the TextEditingValue, containing text and selection info.',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Property:',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple.shade700,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'TextEditingValue get value',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'monospace',
                  color: Colors.deepPurple.shade900,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'set value(TextEditingValue newValue)',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'monospace',
                  color: Colors.deepPurple.shade900,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
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
                TextEditingValue val = ctrl.value;
                print('value.text: ${val.text}');
                print('value.selection: ${val.selection}');
                print('value.composing: ${val.composing}');
              },
              leading: Icon(Icons.email, color: Colors.deepPurple),
              hintText: 'Type to see value details...',
            );
          },
          suggestionsBuilder: (BuildContext context, SearchController ctrl) {
            String query = ctrl.text.toLowerCase();
            List<Widget> suggestions = [];
            int i = 0;
            for (i = 0; i < emails.length; i = i + 1) {
              if (emails[i].toLowerCase().contains(query)) {
                String email = emails[i];
                suggestions.add(
                  ListTile(
                    leading: Icon(Icons.mail_outline, color: Colors.deepPurple),
                    title: Text(email),
                    onTap: () {
                      ctrl.closeView(email);
                    },
                  ),
                );
              }
            }
            return suggestions;
          },
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TextEditingValue Contains:',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              _buildValuePropertyRow('text', 'String', 'The current text content'),
              _buildValuePropertyRow(
                'selection',
                'TextSelection',
                'Start/end of text selection',
              ),
              _buildValuePropertyRow(
                'composing',
                'TextRange',
                'Range being composed (IME)',
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildValuePropertyRow(String name, String type, String desc) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3),
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Row(
      children: [
        Container(
          width: 80,
          child: Text(
            name,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
        ),
        Container(
          width: 90,
          child: Text(
            type,
            style: TextStyle(
              fontSize: 11,
              fontStyle: FontStyle.italic,
              color: Colors.grey.shade600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            desc,
            style: TextStyle(fontSize: 11, color: Colors.grey.shade700),
          ),
        ),
      ],
    ),
  );
}

Widget buildSelectionPropertyDemo() {
  print('Building selection property demo');
  SearchController controller = SearchController();

  List<String> snippets = [
    'Hello World',
    'Flutter is awesome',
    'Dart programming',
    'Material Design',
    'Cross platform',
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
          'selection Property',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Access and modify the text selection (cursor position and selected range).',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.pink.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Property:',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink.shade700,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'TextSelection get selection',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'monospace',
                  color: Colors.pink.shade900,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'set selection(TextSelection newSelection)',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'monospace',
                  color: Colors.pink.shade900,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
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
              leading: Icon(Icons.text_fields, color: Colors.pink),
              hintText: 'Select a snippet...',
            );
          },
          suggestionsBuilder: (BuildContext context, SearchController ctrl) {
            List<Widget> suggestions = [];
            int i = 0;
            for (i = 0; i < snippets.length; i = i + 1) {
              String snippet = snippets[i];
              suggestions.add(
                ListTile(
                  leading: Icon(Icons.code, color: Colors.pink),
                  title: Text(snippet),
                  subtitle: Text('Length: ${snippet.length} chars'),
                  onTap: () {
                    ctrl.closeView(snippet);
                    TextSelection selection = ctrl.selection;
                    print('Selection base: ${selection.baseOffset}');
                    print('Selection extent: ${selection.extentOffset}');
                    print('Selection isCollapsed: ${selection.isCollapsed}');
                  },
                ),
              );
            }
            return suggestions;
          },
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TextSelection Properties:',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              _buildSelectionPropertyRow(
                'baseOffset',
                'Start position of selection',
              ),
              _buildSelectionPropertyRow(
                'extentOffset',
                'End position of selection',
              ),
              _buildSelectionPropertyRow(
                'isCollapsed',
                'True if base == extent (cursor only)',
              ),
              _buildSelectionPropertyRow(
                'isValid',
                'True if offsets are within text bounds',
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildSelectionPropertyRow(String name, String desc) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 110,
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
          decoration: BoxDecoration(
            color: Colors.pink.shade100,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            name,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Colors.pink.shade800,
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            desc,
            style: TextStyle(fontSize: 11, color: Colors.grey.shade700),
          ),
        ),
      ],
    ),
  );
}

Widget buildAddRemoveListenerDemo() {
  print('Building addListener/removeListener demo');
  SearchController controller = SearchController();

  List<String> notifications = [
    'New message received',
    'Friend request pending',
    'Update available',
    'Payment successful',
    'Order shipped',
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
          'addListener() / removeListener()',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Listen to changes in the SearchController. Inherited from ChangeNotifier via TextEditingController.',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Methods:',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber.shade700,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'void addListener(VoidCallback listener)',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'monospace',
                  color: Colors.amber.shade900,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'void removeListener(VoidCallback listener)',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'monospace',
                  color: Colors.amber.shade900,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Builder(
          builder: (BuildContext context) {
            void onControllerChange() {
              print('Controller changed! Text: ${controller.text}');
            }

            controller.addListener(onControllerChange);
            print('Listener added to controller');

            return SearchAnchor(
              searchController: controller,
              builder: (BuildContext ctx, SearchController ctrl) {
                return SearchBar(
                  controller: ctrl,
                  padding: WidgetStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 16),
                  ),
                  onTap: () {
                    ctrl.openView();
                  },
                  leading: Icon(Icons.notifications, color: Colors.amber.shade700),
                  hintText: 'Type to trigger listener...',
                );
              },
              suggestionsBuilder: (BuildContext ctx, SearchController ctrl) {
                String query = ctrl.text.toLowerCase();
                List<Widget> suggestions = [];
                int i = 0;
                for (i = 0; i < notifications.length; i = i + 1) {
                  if (notifications[i].toLowerCase().contains(query)) {
                    String notification = notifications[i];
                    suggestions.add(
                      ListTile(
                        leading: Icon(
                          Icons.notification_important,
                          color: Colors.amber.shade700,
                        ),
                        title: Text(notification),
                        onTap: () {
                          ctrl.closeView(notification);
                        },
                      ),
                    );
                  }
                }
                return suggestions;
              },
            );
          },
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Listener Use Cases:',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              _buildListenerUseCase(
                Icons.sync,
                'State Synchronization',
                'Keep external state in sync with search text',
              ),
              _buildListenerUseCase(
                Icons.analytics,
                'Analytics Tracking',
                'Log search queries for analytics',
              ),
              _buildListenerUseCase(
                Icons.check_circle,
                'Input Validation',
                'Validate input as user types',
              ),
              _buildListenerUseCase(
                Icons.auto_fix_high,
                'Auto-suggestions',
                'Trigger API calls for suggestions',
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.red.shade300),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.warning, color: Colors.red.shade700, size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Important: Always call removeListener when disposing to prevent memory leaks. In StatefulWidget, do this in dispose().',
                  style: TextStyle(fontSize: 12, color: Colors.red.shade900),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildListenerUseCase(IconData icon, String title, String desc) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.amber.shade700, size: 20),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              Text(
                desc,
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildSearchControllerPropertiesTable() {
  print('Building SearchController properties table');
  List<String> propNames = [
    'text',
    'value',
    'selection',
    'isOpen',
  ];
  List<String> propTypes = [
    'String',
    'TextEditingValue',
    'TextSelection',
    'bool',
  ];
  List<String> propDescriptions = [
    'Current text in the search input',
    'Complete text editing value with selection',
    'Current text selection range',
    'Whether search view is currently open',
  ];

  List<Widget> rows = [];
  int p = 0;
  for (p = 0; p < propNames.length; p = p + 1) {
    Color bg = (p % 2 == 0) ? Colors.indigo.shade50 : Colors.white;
    rows.add(
      Container(
        padding: EdgeInsets.all(10),
        color: bg,
        child: Row(
          children: [
            Container(
              width: 100,
              child: Text(
                propNames[p],
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade800,
                ),
              ),
            ),
            Container(
              width: 120,
              child: Text(
                propTypes[p],
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade600,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Expanded(
              child: Text(
                propDescriptions[p],
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
            color: Colors.indigo.shade100,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Text(
            'SearchController Properties',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Column(children: rows),
      ],
    ),
  );
}

Widget buildSearchControllerMethodsTable() {
  print('Building SearchController methods table');
  List<String> methodNames = [
    'openView()',
    'closeView(String?)',
    'addListener()',
    'removeListener()',
    'clear()',
    'dispose()',
  ];
  List<String> methodDescriptions = [
    'Opens the search view overlay',
    'Closes search view, optionally setting text',
    'Register callback for controller changes',
    'Unregister previously added callback',
    'Clears the current text content',
    'Releases resources used by controller',
  ];

  List<Widget> rows = [];
  int m = 0;
  for (m = 0; m < methodNames.length; m = m + 1) {
    Color bg = (m % 2 == 0) ? Colors.teal.shade50 : Colors.white;
    rows.add(
      Container(
        padding: EdgeInsets.all(10),
        color: bg,
        child: Row(
          children: [
            Container(
              width: 150,
              child: Text(
                methodNames[m],
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                  color: Colors.teal.shade800,
                ),
              ),
            ),
            Expanded(
              child: Text(
                methodDescriptions[m],
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
            color: Colors.teal.shade100,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Text(
            'SearchController Methods',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Column(children: rows),
      ],
    ),
  );
}

Widget buildBestPracticesSection() {
  print('Building best practices section');
  List<String> practices = [
    'Create controllers early, ideally in initState or as member variables',
    'Dispose controllers in dispose() to prevent memory leaks',
    'Use one controller per SearchAnchor - do not share controllers',
    'Check isOpen before calling openView() to avoid redundant calls',
    'Pass selected value to closeView() for proper text population',
    'Add listeners only when needed and always remove them on dispose',
    'Use text property for filtering in suggestionsBuilder',
    'Handle null in closeView() for dismissal without selection',
  ];

  List<Widget> practiceItems = [];
  int p = 0;
  for (p = 0; p < practices.length; p = p + 1) {
    practiceItems.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${p + 1}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                practices[p],
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
            Icon(Icons.recommend, color: Colors.green.shade700),
            SizedBox(width: 8),
            Text(
              'Best Practices',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade700,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Column(children: practiceItems),
      ],
    ),
  );
}

Widget buildCommonPatternsSection() {
  print('Building common patterns section');

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
          'Common Usage Patterns',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        _buildPatternCard(
          'Filter Pattern',
          'Use controller.text.toLowerCase() in suggestionsBuilder to filter items',
          Icons.filter_list,
          Colors.blue,
        ),
        _buildPatternCard(
          'Selection Pattern',
          'Call closeView(selectedItem) in suggestion onTap to set the selection',
          Icons.touch_app,
          Colors.orange,
        ),
        _buildPatternCard(
          'Auto-open Pattern',
          'Call openView() in onTap and onChanged to auto-show suggestions',
          Icons.open_in_new,
          Colors.purple,
        ),
        _buildPatternCard(
          'Clear Pattern',
          'Add a trailing icon that calls controller.clear() then openView()',
          Icons.clear,
          Colors.red,
        ),
        _buildPatternCard(
          'Debounce Pattern',
          'Use Timer with addListener to debounce API calls on text change',
          Icons.timer,
          Colors.teal,
        ),
      ],
    ),
  );
}

Widget _buildPatternCard(
  String title,
  String description,
  IconData icon,
  Color color,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(20),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(80)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.white, size: 22),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget main() {
  print('Starting SearchController deep demo');

  Widget result = MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: Text('SearchController Demo'),
        backgroundColor: Colors.indigo.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionHeader('1. Overview'),
            buildInfoCard('Class', 'SearchController'),
            buildInfoCard(
              'Extends',
              'TextEditingController',
            ),
            buildInfoCard('Package', 'flutter/material.dart'),
            buildInfoCard(
              'Purpose',
              'Controls SearchAnchor and SearchBar search state',
            ),
            buildInfoCard(
              'Key Feature',
              'Manages open/close state and text value of search view',
            ),

            buildSectionHeader('2. Creating SearchController'),
            buildCreatingSearchController(),

            buildSectionHeader('3. text Property'),
            buildTextPropertyDemo(),

            buildSectionHeader('4. openView() Method'),
            buildOpenViewDemo(),

            buildSectionHeader('5. closeView() Method'),
            buildCloseViewDemo(),

            buildSectionHeader('6. isOpen Property'),
            buildIsOpenDemo(),

            buildSectionHeader('7. value Property'),
            buildValuePropertyDemo(),

            buildSectionHeader('8. selection Property'),
            buildSelectionPropertyDemo(),

            buildSectionHeader('9. addListener/removeListener'),
            buildAddRemoveListenerDemo(),

            buildSectionHeader('10. Properties Reference'),
            buildSearchControllerPropertiesTable(),

            buildSectionHeader('11. Methods Reference'),
            buildSearchControllerMethodsTable(),

            buildSectionHeader('12. Common Patterns'),
            buildCommonPatternsSection(),

            buildSectionHeader('13. Best Practices'),
            buildBestPracticesSection(),

            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );

  print('SearchController deep demo completed');
  return result;
}
