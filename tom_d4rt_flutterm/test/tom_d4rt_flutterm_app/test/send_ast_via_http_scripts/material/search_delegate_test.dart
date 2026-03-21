// D4rt test script: Tests SearchDelegate from material - delegate for showSearch() function
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

Widget buildCodeBlock(String code) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 12,
        color: Colors.greenAccent.shade400,
      ),
    ),
  );
}

Widget buildFeatureRow(IconData icon, String feature, String description) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.indigo.shade100),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.indigo.shade600, size: 24),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                feature,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.indigo.shade800,
                ),
              ),
              SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class ProductSearchDelegate extends SearchDelegate<String> {
  List<String> products;
  List<String> searchHistory;

  ProductSearchDelegate({
    List<String>? products,
    List<String>? searchHistory,
  })  : products = products ?? [],
        searchHistory = searchHistory ?? [];

  String get searchFieldLabel => 'Search products...';

  TextStyle get searchFieldStyle => TextStyle(
        fontSize: 16,
        color: Colors.grey.shade800,
      );

  ThemeData appBarTheme(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.indigo),
        titleTextStyle: TextStyle(color: Colors.black87, fontSize: 18),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.grey.shade500),
        border: InputBorder.none,
      ),
    );
  }

  Widget buildLeading(BuildContext context) {
    print('ProductSearchDelegate.buildLeading called');
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        print('Leading button pressed - closing search');
        close(context, '');
      },
    );
  }

  List<Widget> buildActions(BuildContext context) {
    print('ProductSearchDelegate.buildActions called with query: $query');
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            print('Clear button pressed');
            query = '';
            showSuggestions(context);
          },
        ),
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          print('Search button pressed with query: $query');
          showResults(context);
        },
      ),
    ];
  }

  Widget buildResults(BuildContext context) {
    print('ProductSearchDelegate.buildResults called with query: $query');
    List<String> results = products
        .where((product) => product.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (results.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: Colors.grey.shade400),
            SizedBox(height: 16),
            Text(
              'No products found for "$query"',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        String product = results[index];
        return ListTile(
          leading: Icon(Icons.shopping_bag, color: Colors.indigo),
          title: Text(product),
          subtitle: Text('Tap to select'),
          onTap: () {
            print('Selected product: $product');
            close(context, product);
          },
        );
      },
    );
  }

  Widget buildSuggestions(BuildContext context) {
    print('ProductSearchDelegate.buildSuggestions called with query: $query');
    List<String> suggestions = query.isEmpty
        ? searchHistory
        : products
            .where(
                (product) => product.toLowerCase().startsWith(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        String suggestion = suggestions[index];
        return ListTile(
          leading: Icon(
            query.isEmpty ? Icons.history : Icons.search,
            color: Colors.grey.shade600,
          ),
          title: RichText(
            text: TextSpan(
              text: suggestion.substring(0, query.length),
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: suggestion.substring(query.length),
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            print('Suggestion tapped: $suggestion');
            query = suggestion;
            showResults(context);
          },
        );
      },
    );
  }
}

class CitySearchDelegate extends SearchDelegate<String> {
  List<Map<String, dynamic>> cities;

  CitySearchDelegate({List<Map<String, dynamic>>? cities})
      : cities = cities ?? [];

  String get searchFieldLabel => 'Search cities...';

  Widget buildLeading(BuildContext context) {
    print('CitySearchDelegate.buildLeading called');
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        print('Back button pressed');
        close(context, '');
      },
    );
  }

  List<Widget> buildActions(BuildContext context) {
    print('CitySearchDelegate.buildActions called');
    return [
      IconButton(
        icon: Icon(Icons.clear),
        tooltip: 'Clear search query',
        onPressed: () {
          query = '';
        },
      ),
      IconButton(
        icon: Icon(Icons.filter_list),
        tooltip: 'Filter results',
        onPressed: () {
          print('Filter button pressed');
        },
      ),
    ];
  }

  Widget buildResults(BuildContext context) {
    print('CitySearchDelegate.buildResults for query: $query');
    List<Map<String, dynamic>> results = cities
        .where((city) => city['name']
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        Map<String, dynamic> city = results[index];
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue.shade100,
              child: Text(city['name'].toString().substring(0, 1)),
            ),
            title: Text(city['name'].toString()),
            subtitle: Text('Population: ${city['population']}'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              close(context, city['name'].toString());
            },
          ),
        );
      },
    );
  }

  Widget buildSuggestions(BuildContext context) {
    print('CitySearchDelegate.buildSuggestions for query: $query');
    if (query.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_city, size: 64, color: Colors.grey.shade300),
            SizedBox(height: 16),
            Text(
              'Start typing to search cities',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ],
        ),
      );
    }

    List<Map<String, dynamic>> suggestions = cities
        .where((city) => city['name']
            .toString()
            .toLowerCase()
            .startsWith(query.toLowerCase()))
        .take(5)
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        Map<String, dynamic> city = suggestions[index];
        return ListTile(
          leading: Icon(Icons.location_on, color: Colors.blue),
          title: Text(city['name'].toString()),
          onTap: () {
            query = city['name'].toString();
            showResults(context);
          },
        );
      },
    );
  }
}

class ContactSearchDelegate extends SearchDelegate<Map<String, String>> {
  List<Map<String, String>> contacts;
  Function(Map<String, String>)? onContactSelected;

  ContactSearchDelegate({
    List<Map<String, String>>? contacts,
    this.onContactSelected,
  }) : contacts = contacts ?? [];

  String get searchFieldLabel => 'Search contacts by name or email';

  TextStyle get searchFieldStyle => TextStyle(
        fontSize: 15,
        fontStyle: FontStyle.italic,
      );

  Widget buildLeading(BuildContext context) {
    print('ContactSearchDelegate.buildLeading');
    return BackButton(
      onPressed: () {
        close(context, {});
      },
    );
  }

  List<Widget> buildActions(BuildContext context) {
    print('ContactSearchDelegate.buildActions');
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
        ),
      PopupMenuButton<String>(
        icon: Icon(Icons.more_vert),
        onSelected: (value) {
          print('Menu selected: $value');
        },
        itemBuilder: (context) => [
          PopupMenuItem(value: 'sort', child: Text('Sort A-Z')),
          PopupMenuItem(value: 'filter', child: Text('Filter')),
        ],
      ),
    ];
  }

  Widget buildResults(BuildContext context) {
    print('ContactSearchDelegate.buildResults for: $query');
    List<Map<String, String>> results = contacts.where((contact) {
      String name = contact['name'] ?? '';
      String email = contact['email'] ?? '';
      String searchLower = query.toLowerCase();
      return name.toLowerCase().contains(searchLower) ||
          email.toLowerCase().contains(searchLower);
    }).toList();

    if (results.isEmpty) {
      return Center(
        child: Text(
          'No contacts found',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    }

    return ListView.separated(
      itemCount: results.length,
      separatorBuilder: (context, index) => Divider(height: 1),
      itemBuilder: (context, index) {
        Map<String, String> contact = results[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.teal.shade100,
            child: Text(
              (contact['name'] ?? 'U').substring(0, 1).toUpperCase(),
              style: TextStyle(color: Colors.teal.shade700),
            ),
          ),
          title: Text(contact['name'] ?? 'Unknown'),
          subtitle: Text(contact['email'] ?? ''),
          trailing: IconButton(
            icon: Icon(Icons.phone, color: Colors.green),
            onPressed: () {
              print('Calling ${contact['phone']}');
            },
          ),
          onTap: () {
            if (onContactSelected != null) {
              onContactSelected!(contact);
            }
            close(context, contact);
          },
        );
      },
    );
  }

  Widget buildSuggestions(BuildContext context) {
    print('ContactSearchDelegate.buildSuggestions for: $query');
    List<Map<String, String>> suggestions = query.isEmpty
        ? contacts.take(10).toList()
        : contacts
            .where((c) =>
                (c['name'] ?? '').toLowerCase().startsWith(query.toLowerCase()))
            .take(5)
            .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        Map<String, String> contact = suggestions[index];
        return ListTile(
          leading: Icon(Icons.person_outline),
          title: Text(contact['name'] ?? ''),
          subtitle: Text(contact['email'] ?? ''),
          onTap: () {
            query = contact['name'] ?? '';
            showResults(context);
          },
        );
      },
    );
  }
}

Widget buildSearchDelegateDemoCard(
  String title,
  String description,
  IconData icon,
  Color color,
  VoidCallback onPressed,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    child: Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      elevation: 2,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withAlpha(30),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 32),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.grey.shade400),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget buildMethodSignatureCard(
  String methodName,
  String returnType,
  String description,
  List<String> parameters,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.indigo.shade100, width: 2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.indigo.shade100,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                returnType,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  color: Colors.indigo.shade700,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 8),
            Text(
              methodName,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
        if (parameters.isNotEmpty) ...[
          SizedBox(height: 12),
          Text(
            'Parameters:',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
          SizedBox(height: 4),
          ...parameters.map((param) => Padding(
                padding: EdgeInsets.only(left: 8, top: 2),
                child: Row(
                  children: [
                    Icon(Icons.arrow_right, size: 16, color: Colors.grey),
                    SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        param,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 12,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ],
    ),
  );
}

Widget buildQueryPropertyDemo() {
  print('Building query property demo');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.amber.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.amber.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.amber.shade700),
            SizedBox(width: 8),
            Text(
              'query Property',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.amber.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Text(
          'The query property holds the current search text entered by the user. '
          'It can be read to filter results or set programmatically to change the search field content.',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '// Read current query',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: Colors.grey.shade500,
                ),
              ),
              Text(
                'String currentQuery = query;',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  color: Colors.greenAccent,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '// Set query programmatically',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: Colors.grey.shade500,
                ),
              ),
              Text(
                'query = "new search term";',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  color: Colors.greenAccent,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildSearchFieldLabelDemo() {
  print('Building searchFieldLabel demo');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.teal.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.teal.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.label_outline, color: Colors.teal.shade700),
            SizedBox(width: 8),
            Text(
              'searchFieldLabel Property',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Text(
          'The hint text displayed in the search input field when it is empty. '
          'Override this getter to customize the placeholder text.',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
        ),
        SizedBox(height: 12),
        buildCodeBlock(
          'String get searchFieldLabel => "Search products...";\n\n'
          '// Or with localization:\n'
          'String get searchFieldLabel => \n'
          '    AppLocalizations.of(context).searchHint;',
        ),
      ],
    ),
  );
}

Widget buildSearchFieldStyleDemo() {
  print('Building searchFieldStyle demo');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.purple.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.purple.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.text_format, color: Colors.purple.shade700),
            SizedBox(width: 8),
            Text(
              'searchFieldStyle Property',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.purple.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Text(
          'Defines the TextStyle for the search input text. Override to customize '
          'the font size, color, weight, and other text properties.',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
        ),
        SizedBox(height: 12),
        buildCodeBlock(
          'TextStyle get searchFieldStyle => TextStyle(\n'
          '  fontSize: 16,\n'
          '  color: Colors.grey.shade800,\n'
          '  fontWeight: FontWeight.w500,\n'
          ');',
        ),
        SizedBox(height: 12),
        Text(
          'Example Styles:',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Default Style',
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              SizedBox(height: 8),
              Text(
                'Italic Style',
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Bold Colored Style',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildShowResultsDemo() {
  print('Building showResults demo');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.blue.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.blue.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.view_list, color: Colors.blue.shade700),
            SizedBox(width: 8),
            Text(
              'showResults Method',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Text(
          'Call showResults(context) to transition from suggestions view to results view. '
          'This method triggers buildResults to be called and displays the search results.',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
        ),
        SizedBox(height: 12),
        buildCodeBlock(
          'IconButton(\n'
          '  icon: Icon(Icons.search),\n'
          '  onPressed: () {\n'
          '    showResults(context);\n'
          '  },\n'
          ')',
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Icon(Icons.info_outline, size: 16, color: Colors.blue.shade600),
            SizedBox(width: 4),
            Expanded(
              child: Text(
                'Typically called when user presses search button or selects a suggestion',
                style: TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  color: Colors.blue.shade600,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildShowSuggestionsDemo() {
  print('Building showSuggestions demo');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.orange.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.orange.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.lightbulb_outline, color: Colors.orange.shade700),
            SizedBox(width: 8),
            Text(
              'showSuggestions Method',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Text(
          'Call showSuggestions(context) to display the suggestions view. '
          'This is useful when clearing the search or when the user wants to see suggestions again.',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
        ),
        SizedBox(height: 12),
        buildCodeBlock(
          'IconButton(\n'
          '  icon: Icon(Icons.clear),\n'
          '  onPressed: () {\n'
          '    query = "";\n'
          '    showSuggestions(context);\n'
          '  },\n'
          ')',
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Icon(Icons.info_outline, size: 16, color: Colors.orange.shade600),
            SizedBox(width: 4),
            Expanded(
              child: Text(
                'Automatically called when search view opens - shows buildSuggestions widget',
                style: TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  color: Colors.orange.shade600,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildAbstractClassExplanation() {
  print('Building SearchDelegate abstract class explanation');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade100, Colors.indigo.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.indigo.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.class_, color: Colors.indigo.shade700, size: 28),
            SizedBox(width: 12),
            Text(
              'SearchDelegate<T> Abstract Class',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Text(
          'SearchDelegate is an abstract class that defines the interface for '
          'implementing custom search functionality with showSearch(). '
          'The type parameter T represents the result type returned when search completes.',
          style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Required Methods to Override:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
              SizedBox(height: 8),
              _buildRequiredMethodItem('buildLeading()', 'Widget for leading icon'),
              _buildRequiredMethodItem('buildActions()', 'List of action widgets'),
              _buildRequiredMethodItem('buildResults()', 'Search results widget'),
              _buildRequiredMethodItem('buildSuggestions()', 'Suggestions widget'),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildRequiredMethodItem(String method, String description) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Icon(Icons.check_circle, size: 16, color: Colors.green),
        SizedBox(width: 8),
        Text(
          method,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade700,
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            '- $description',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
        ),
      ],
    ),
  );
}

Widget buildDelegateComparisonTable() {
  print('Building delegate comparison table');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Delegate Type',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'Use Case',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'Result Type',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        _buildTableRow('ProductSearch', 'E-commerce product search', 'String'),
        _buildTableRow('CitySearch', 'Location/city picker', 'String'),
        _buildTableRow('ContactSearch', 'Contact selection', 'Map<String, String>'),
        _buildTableRow('DocumentSearch', 'File/document search', 'Document'),
        _buildTableRow('UserSearch', 'User lookup', 'User'),
      ],
    ),
  );
}

Widget _buildTableRow(String delegate, String useCase, String resultType) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      border: Border(top: BorderSide(color: Colors.grey.shade200)),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            delegate,
            style: TextStyle(fontSize: 13, color: Colors.indigo.shade700),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            useCase,
            style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              resultType,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: Colors.grey.shade700,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildSearchDelegateDeepDemo() {
  print('Starting SearchDelegate deep demo build');

  List<String> sampleProducts = [
    'Apple iPhone 15 Pro',
    'Samsung Galaxy S24',
    'Google Pixel 8',
    'Apple MacBook Pro',
    'Dell XPS 15',
    'Sony WH-1000XM5',
    'Apple AirPods Pro',
    'Nintendo Switch',
    'PlayStation 5',
    'Xbox Series X',
  ];

  List<String> searchHistory = [
    'iPhone',
    'MacBook',
    'headphones',
  ];

  List<Map<String, dynamic>> sampleCities = [
    {'name': 'New York', 'population': 8336817},
    {'name': 'Los Angeles', 'population': 3979576},
    {'name': 'Chicago', 'population': 2693976},
    {'name': 'Houston', 'population': 2320268},
    {'name': 'Phoenix', 'population': 1680992},
  ];

  List<Map<String, String>> sampleContacts = [
    {'name': 'Alice Johnson', 'email': 'alice@example.com', 'phone': '+1234567890'},
    {'name': 'Bob Smith', 'email': 'bob@example.com', 'phone': '+1234567891'},
    {'name': 'Carol Williams', 'email': 'carol@example.com', 'phone': '+1234567892'},
  ];

  ProductSearchDelegate productDelegate = ProductSearchDelegate(
    products: sampleProducts,
    searchHistory: searchHistory,
  );

  CitySearchDelegate cityDelegate = CitySearchDelegate(
    cities: sampleCities,
  );

  ContactSearchDelegate contactDelegate = ContactSearchDelegate(
    contacts: sampleContacts,
    onContactSelected: (contact) {
      print('Contact selected callback: ${contact['name']}');
    },
  );

  print('ProductSearchDelegate searchFieldLabel: ${productDelegate.searchFieldLabel}');
  print('CitySearchDelegate searchFieldLabel: ${cityDelegate.searchFieldLabel}');
  print('ContactSearchDelegate searchFieldLabel: ${contactDelegate.searchFieldLabel}');

  Widget result = MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.indigo,
      scaffoldBackgroundColor: Colors.grey.shade50,
    ),
    home: Scaffold(
      appBar: AppBar(
        title: Text('SearchDelegate Deep Demo'),
        backgroundColor: Colors.indigo.shade700,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              print('Search icon pressed - would call showSearch()');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionHeader('SearchDelegate Abstract Class'),
            buildAbstractClassExplanation(),

            buildInfoCard(
              'Purpose',
              'SearchDelegate is used with showSearch() to implement Material Design search interfaces',
            ),
            buildInfoCard(
              'Type Parameter',
              'SearchDelegate<T> where T is the type returned when close() is called',
            ),
            buildInfoCard(
              'showSearch Usage',
              'Future<T?> result = await showSearch(context: context, delegate: myDelegate)',
            ),

            SizedBox(height: 16),
            buildSectionHeader('buildLeading Method'),
            buildMethodSignatureCard(
              'buildLeading',
              'Widget',
              'Builds the leading widget in the app bar, typically a back button or animated menu icon.',
              ['BuildContext context'],
            ),
            buildFeatureRow(
              Icons.arrow_back,
              'Navigation Control',
              'Usually returns IconButton or BackButton to close search',
            ),
            buildFeatureRow(
              Icons.animation,
              'Animated Icons',
              'Can use AnimatedIcon with transitionAnimation for smooth transitions',
            ),
            buildCodeBlock(
              'Widget buildLeading(BuildContext context) {\n'
              '  return IconButton(\n'
              '    icon: AnimatedIcon(\n'
              '      icon: AnimatedIcons.menu_arrow,\n'
              '      progress: transitionAnimation,\n'
              '    ),\n'
              '    onPressed: () => close(context, null),\n'
              '  );\n'
              '}',
            ),

            SizedBox(height: 16),
            buildSectionHeader('buildActions Method'),
            buildMethodSignatureCard(
              'buildActions',
              'List<Widget>',
              'Builds a list of action widgets displayed at the end of the app bar.',
              ['BuildContext context'],
            ),
            buildFeatureRow(
              Icons.clear,
              'Clear Query',
              'Common action to clear the search text field',
            ),
            buildFeatureRow(
              Icons.filter_list,
              'Filter/Sort',
              'Additional actions like filtering or sorting results',
            ),
            buildFeatureRow(
              Icons.mic,
              'Voice Search',
              'Voice input button for accessibility',
            ),
            buildCodeBlock(
              'List<Widget> buildActions(BuildContext context) {\n'
              '  return [\n'
              '    if (query.isNotEmpty)\n'
              '      IconButton(\n'
              '        icon: Icon(Icons.clear),\n'
              '        onPressed: () {\n'
              '          query = "";\n'
              '          showSuggestions(context);\n'
              '        },\n'
              '      ),\n'
              '    IconButton(\n'
              '      icon: Icon(Icons.search),\n'
              '      onPressed: () => showResults(context),\n'
              '    ),\n'
              '  ];\n'
              '}',
            ),

            SizedBox(height: 16),
            buildSectionHeader('buildResults Method'),
            buildMethodSignatureCard(
              'buildResults',
              'Widget',
              'Builds the widget displayed when search results should be shown.',
              ['BuildContext context'],
            ),
            buildFeatureRow(
              Icons.list,
              'Results Display',
              'Typically returns ListView or GridView with filtered items',
            ),
            buildFeatureRow(
              Icons.search_off,
              'Empty State',
              'Handle case when no results match the query',
            ),
            buildFeatureRow(
              Icons.touch_app,
              'Selection',
              'Call close(context, result) when item is selected',
            ),
            buildCodeBlock(
              'Widget buildResults(BuildContext context) {\n'
              '  List<Item> results = items\n'
              '      .where((item) => item.name\n'
              '          .toLowerCase()\n'
              '          .contains(query.toLowerCase()))\n'
              '      .toList();\n'
              '\n'
              '  return ListView.builder(\n'
              '    itemCount: results.length,\n'
              '    itemBuilder: (context, index) {\n'
              '      return ListTile(\n'
              '        title: Text(results[index].name),\n'
              '        onTap: () => close(context, results[index]),\n'
              '      );\n'
              '    },\n'
              '  );\n'
              '}',
            ),

            SizedBox(height: 16),
            buildSectionHeader('buildSuggestions Method'),
            buildMethodSignatureCard(
              'buildSuggestions',
              'Widget',
              'Builds suggestions shown when user is typing but has not submitted search.',
              ['BuildContext context'],
            ),
            buildFeatureRow(
              Icons.history,
              'Search History',
              'Show recent searches when query is empty',
            ),
            buildFeatureRow(
              Icons.trending_up,
              'Trending',
              'Display trending or popular searches',
            ),
            buildFeatureRow(
              Icons.auto_awesome,
              'Autocomplete',
              'Show matching suggestions as user types',
            ),
            buildCodeBlock(
              'Widget buildSuggestions(BuildContext context) {\n'
              '  List<String> suggestions = query.isEmpty\n'
              '      ? recentSearches\n'
              '      : items\n'
              '          .where((s) => s.toLowerCase()\n'
              '              .startsWith(query.toLowerCase()))\n'
              '          .toList();\n'
              '\n'
              '  return ListView.builder(\n'
              '    itemCount: suggestions.length,\n'
              '    itemBuilder: (context, index) {\n'
              '      return ListTile(\n'
              '        leading: Icon(\n'
              '          query.isEmpty ? Icons.history : Icons.search,\n'
              '        ),\n'
              '        title: Text(suggestions[index]),\n'
              '        onTap: () {\n'
              '          query = suggestions[index];\n'
              '          showResults(context);\n'
              '        },\n'
              '      );\n'
              '    },\n'
              '  );\n'
              '}',
            ),

            SizedBox(height: 16),
            buildSectionHeader('showResults Method'),
            buildShowResultsDemo(),

            SizedBox(height: 16),
            buildSectionHeader('showSuggestions Method'),
            buildShowSuggestionsDemo(),

            SizedBox(height: 16),
            buildSectionHeader('searchFieldLabel Property'),
            buildSearchFieldLabelDemo(),

            SizedBox(height: 16),
            buildSectionHeader('searchFieldStyle Property'),
            buildSearchFieldStyleDemo(),

            SizedBox(height: 16),
            buildSectionHeader('query Property'),
            buildQueryPropertyDemo(),

            SizedBox(height: 16),
            buildSectionHeader('Custom Delegate Implementations'),
            buildDelegateComparisonTable(),

            SizedBox(height: 16),
            buildSectionHeader('Interactive Demo Cards'),
            buildSearchDelegateDemoCard(
              'Product Search',
              'Search through product catalog with history',
              Icons.shopping_cart,
              Colors.indigo,
              () {
                print('Product search demo tapped');
                print('Would call: showSearch(context: ctx, delegate: productDelegate)');
              },
            ),
            buildSearchDelegateDemoCard(
              'City Search',
              'Location picker with population info',
              Icons.location_city,
              Colors.blue,
              () {
                print('City search demo tapped');
                print('Would call: showSearch(context: ctx, delegate: cityDelegate)');
              },
            ),
            buildSearchDelegateDemoCard(
              'Contact Search',
              'Search contacts by name or email',
              Icons.contacts,
              Colors.teal,
              () {
                print('Contact search demo tapped');
                print('Would call: showSearch(context: ctx, delegate: contactDelegate)');
              },
            ),

            SizedBox(height: 16),
            buildSectionHeader('Additional Properties & Methods'),
            buildInfoCard('transitionAnimation', 'Animation<double> for search transition effects'),
            buildInfoCard('close(context, result)', 'Closes search and returns result to caller'),
            buildInfoCard('keyboardType', 'TextInputType for the search field keyboard'),
            buildInfoCard('textInputAction', 'TextInputAction for the search field'),
            buildInfoCard('appBarTheme(context)', 'Override to customize the search app bar theme'),

            SizedBox(height: 16),
            buildSectionHeader('Best Practices'),
            buildFeatureRow(
              Icons.speed,
              'Debounce Search',
              'Debounce rapid query changes to avoid excessive filtering',
            ),
            buildFeatureRow(
              Icons.storage,
              'Cache Results',
              'Cache search results for common queries to improve performance',
            ),
            buildFeatureRow(
              Icons.highlight,
              'Highlight Matches',
              'Use RichText to highlight matching portions of suggestions',
            ),
            buildFeatureRow(
              Icons.accessibility,
              'Accessibility',
              'Provide semantic labels and sufficient contrast for all elements',
            ),
            buildFeatureRow(
              Icons.error_outline,
              'Error Handling',
              'Show meaningful error states when search fails',
            ),

            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );

  print('SearchDelegate deep demo build completed');
  return result;
}
