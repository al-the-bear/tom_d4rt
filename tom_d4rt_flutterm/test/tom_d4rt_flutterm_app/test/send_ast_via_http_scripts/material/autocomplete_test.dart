// D4rt test script: Tests Autocomplete widget concepts from material
// Demonstrates autocomplete with different data sources and suggestion rendering
import 'package:flutter/material.dart';

// Helper to build a section header
Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.purple.shade700,
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

// Helper to build a suggestion list item
Widget buildSuggestionListItem(
  String primary,
  String secondary,
  IconData icon,
  Color color, {
  bool isHighlighted = false,
  String? badge,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      color: isHighlighted ? color.withAlpha(15) : Colors.white,
      border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
    ),
    child: Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withAlpha(25),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(icon, color: color, size: 22),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                primary,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              if (secondary.isNotEmpty)
                Text(
                  secondary,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
            ],
          ),
        ),
        if (badge != null)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: color.withAlpha(25),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              badge,
              style: TextStyle(
                fontSize: 11,
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    ),
  );
}

// Helper to build an autocomplete with dropdown shown
Widget buildAutocompleteWithDropdown(
  String label,
  String inputText,
  String hintText,
  List<Widget> suggestions,
  Color accentColor, {
  IconData? prefixIcon,
  bool showClear = true,
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(20),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                    bottomLeft: Radius.circular(suggestions.isEmpty ? 8 : 0),
                    bottomRight: Radius.circular(suggestions.isEmpty ? 8 : 0),
                  ),
                  border: Border.all(color: accentColor, width: 2),
                ),
                child: Row(
                  children: [
                    if (prefixIcon != null) ...[
                      SizedBox(width: 12),
                      Icon(prefixIcon, color: accentColor, size: 22),
                    ],
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                        child: Text(
                          inputText.isEmpty ? hintText : inputText,
                          style: TextStyle(
                            fontSize: 16,
                            color: inputText.isEmpty
                                ? Colors.grey.shade400
                                : Colors.black87,
                          ),
                        ),
                      ),
                    ),
                    if (showClear && inputText.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: Icon(
                          Icons.close,
                          color: Colors.grey.shade400,
                          size: 20,
                        ),
                      ),
                  ],
                ),
              ),
              if (suggestions.isNotEmpty)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                    border: Border(
                      left: BorderSide(color: accentColor, width: 2),
                      right: BorderSide(color: accentColor, width: 2),
                      bottom: BorderSide(color: accentColor, width: 2),
                    ),
                  ),
                  child: Column(children: suggestions),
                ),
            ],
          ),
        ),
      ],
    ),
  );
}

// Helper to build a tag/chip input field
Widget buildChipInputField(
  String label,
  List<String> chips,
  String inputText,
  Color color,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 4),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: color, width: 2),
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: Wrap(
            spacing: 6,
            runSpacing: 4,
            children: [
              ...chips.map(
                (chip) => Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: color.withAlpha(20),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: color.withAlpha(60)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(chip, style: TextStyle(fontSize: 13, color: color)),
                      SizedBox(width: 4),
                      Icon(Icons.close, size: 14, color: color),
                    ],
                  ),
                ),
              ),
              if (inputText.isNotEmpty)
                Text(
                  inputText,
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
            ],
          ),
        ),
      ],
    ),
  );
}

// Helper to build a category filter
Widget buildCategoryFilter(String label, Color color, bool isActive) {
  return Container(
    margin: EdgeInsets.only(right: 8, bottom: 4),
    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 7),
    decoration: BoxDecoration(
      color: isActive ? color : Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: isActive ? color : Colors.grey.shade300),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 13,
        color: isActive ? Colors.white : Colors.grey.shade600,
        fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
      ),
    ),
  );
}

// Helper to build a typed character highlight
Widget buildHighlightedText(String text, String query, Color highlightColor) {
  if (query.isEmpty) {
    return Text(text, style: TextStyle(fontSize: 15));
  }
  int index = text.toLowerCase().indexOf(query.toLowerCase());
  if (index == -1) {
    return Text(text, style: TextStyle(fontSize: 15));
  }
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      if (index > 0)
        Text(text.substring(0, index), style: TextStyle(fontSize: 15)),
      Container(
        color: highlightColor.withAlpha(50),
        child: Text(
          text.substring(index, index + query.length),
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: highlightColor,
          ),
        ),
      ),
      if (index + query.length < text.length)
        Text(
          text.substring(index + query.length),
          style: TextStyle(fontSize: 15),
        ),
    ],
  );
}

// Helper to build search result count
Widget buildResultCount(int count, String query, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: color.withAlpha(10),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.info_outline, size: 16, color: color),
        SizedBox(width: 6),
        Text(
          '$count results for "$query"',
          style: TextStyle(fontSize: 13, color: color),
        ),
      ],
    ),
  );
}

// Helper to build a "no results" state
Widget buildNoResults(String query, Color color) {
  return Container(
    padding: EdgeInsets.all(24),
    child: Column(
      children: [
        Icon(Icons.search_off, size: 48, color: Colors.grey.shade400),
        SizedBox(height: 8),
        Text(
          'No results for "$query"',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade600,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Try different keywords',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
        ),
      ],
    ),
  );
}

// Helper to build recent/history item
Widget buildRecentItem(String text, Color color, {String? time}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
    ),
    child: Row(
      children: [
        Icon(Icons.history, size: 18, color: Colors.grey.shade400),
        SizedBox(width: 12),
        Expanded(child: Text(text, style: TextStyle(fontSize: 14))),
        if (time != null)
          Text(
            time,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
          ),
        SizedBox(width: 8),
        Icon(Icons.north_west, size: 14, color: Colors.grey.shade400),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  debugPrint('=== Autocomplete Test Script ===');
  debugPrint('Testing autocomplete widget patterns with various data sources');
  debugPrint('Demonstrates suggestion lists, text field states, and typed inputs');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple.shade700, Colors.deepPurple.shade500],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Autocomplete Demo',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Text fields with suggestions, filtering, and selection',
                style: TextStyle(fontSize: 15, color: Colors.white70),
              ),
            ],
          ),
        ),

        // Section 1: Basic Autocomplete
        buildSectionHeader('1. Basic String Autocomplete'),
        buildAutocompleteWithDropdown(
          'Country Search',
          'Ger',
          'Type a country name...',
          [
            buildSuggestionListItem(
              'Germany',
              'Europe',
              Icons.flag,
              Colors.purple.shade700,
              isHighlighted: true,
              badge: '83M',
            ),
            buildSuggestionListItem(
              'Georgia',
              'Asia / Europe',
              Icons.flag,
              Colors.purple.shade700,
              badge: '3.7M',
            ),
            buildSuggestionListItem(
              'Grenada',
              'Caribbean',
              Icons.flag,
              Colors.purple.shade700,
              badge: '113K',
            ),
          ],
          Colors.purple.shade700,
          prefixIcon: Icons.search,
        ),

        // Section 2: Object Autocomplete
        buildSectionHeader('2. Object-Based Autocomplete'),
        buildAutocompleteWithDropdown(
          'User Search',
          'John',
          'Search for a user...',
          [
            buildSuggestionListItem(
              'John Doe',
              'john.doe@example.com',
              Icons.person,
              Colors.blue.shade700,
              isHighlighted: true,
              badge: 'Admin',
            ),
            buildSuggestionListItem(
              'John Smith',
              'john.smith@example.com',
              Icons.person,
              Colors.blue.shade700,
              badge: 'User',
            ),
            buildSuggestionListItem(
              'Johnny Walker',
              'johnny.w@example.com',
              Icons.person,
              Colors.blue.shade700,
              badge: 'Mod',
            ),
          ],
          Colors.blue.shade700,
          prefixIcon: Icons.people,
        ),

        // Section 3: Category Search
        buildSectionHeader('3. Category-Filtered Autocomplete'),
        Wrap(
          children: [
            buildCategoryFilter('All', Colors.purple.shade700, true),
            buildCategoryFilter('Contacts', Colors.blue.shade700, false),
            buildCategoryFilter('Files', Colors.green.shade700, false),
            buildCategoryFilter('Messages', Colors.orange.shade700, false),
            buildCategoryFilter('Calendar', Colors.teal.shade700, false),
          ],
        ),
        SizedBox(height: 4),
        buildAutocompleteWithDropdown(
          'Category Search',
          'project',
          'Search across categories...',
          [
            buildSuggestionListItem(
              'Project Alpha',
              'Documents / Shared',
              Icons.folder,
              Colors.green.shade700,
              badge: 'File',
            ),
            buildSuggestionListItem(
              'Project meeting notes',
              'Messages / Team Chat',
              Icons.chat,
              Colors.orange.shade700,
              badge: 'Msg',
            ),
            buildSuggestionListItem(
              'Project review',
              'Calendar / Jan 20',
              Icons.event,
              Colors.teal.shade700,
              badge: 'Event',
            ),
            buildSuggestionListItem(
              'Project Manager - Lisa',
              'Contacts',
              Icons.person,
              Colors.blue.shade700,
              badge: 'Contact',
            ),
          ],
          Colors.purple.shade700,
          prefixIcon: Icons.search,
        ),
        SizedBox(height: 4),
        buildResultCount(4, 'project', Colors.purple.shade700),

        // Section 4: Tag Input
        buildSectionHeader('4. Tag/Chip Input Autocomplete'),
        buildChipInputField(
          'Tags',
          ['Flutter', 'Dart', 'Material'],
          'Wid',
          Colors.teal.shade700,
        ),
        Container(
          margin: EdgeInsets.only(top: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.teal.shade300),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              buildSuggestionListItem(
                'Widget',
                '245 items',
                Icons.widgets,
                Colors.teal.shade700,
                isHighlighted: true,
              ),
              buildSuggestionListItem(
                'WidgetBuilder',
                '34 items',
                Icons.build,
                Colors.teal.shade700,
              ),
              buildSuggestionListItem(
                'WidgetSpan',
                '12 items',
                Icons.text_fields,
                Colors.teal.shade700,
              ),
            ],
          ),
        ),

        // Section 5: Highlighted Text Matching
        buildSectionHeader('5. Text Highlight Matching'),
        Card(
          elevation: 2,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Query: "flu"',
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.purple.shade50,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: buildHighlightedText(
                    'Flutter',
                    'flu',
                    Colors.purple.shade700,
                  ),
                ),
                SizedBox(height: 4),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: buildHighlightedText(
                    'Influencer',
                    'flu',
                    Colors.purple.shade700,
                  ),
                ),
                SizedBox(height: 4),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: buildHighlightedText(
                    'Fluid dynamics',
                    'flu',
                    Colors.purple.shade700,
                  ),
                ),
                SizedBox(height: 4),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: buildHighlightedText(
                    'Confluence',
                    'flu',
                    Colors.purple.shade700,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Section 6: Recent/History Suggestions
        buildSectionHeader('6. Recent Search History'),
        Card(
          elevation: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(12),
                child: Row(
                  children: [
                    Icon(Icons.history, size: 18, color: Colors.grey.shade600),
                    SizedBox(width: 8),
                    Text(
                      'Recent searches',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Text(
                      'Clear all',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.purple.shade700,
                      ),
                    ),
                  ],
                ),
              ),
              buildRecentItem(
                'Flutter widgets',
                Colors.purple.shade700,
                time: '2 min ago',
              ),
              buildRecentItem(
                'Dart streams tutorial',
                Colors.purple.shade700,
                time: '1 hour ago',
              ),
              buildRecentItem(
                'Material design 3',
                Colors.purple.shade700,
                time: '3 hours ago',
              ),
              buildRecentItem(
                'State management patterns',
                Colors.purple.shade700,
                time: 'Yesterday',
              ),
              buildRecentItem(
                'Custom painter examples',
                Colors.purple.shade700,
                time: '2 days ago',
              ),
            ],
          ),
        ),

        // Section 7: No Results State
        buildSectionHeader('7. No Results State'),
        buildAutocompleteWithDropdown(
          'Search',
          'xyzabc123',
          'Search...',
          [],
          Colors.grey.shade500,
          prefixIcon: Icons.search,
        ),
        buildNoResults('xyzabc123', Colors.grey.shade600),

        // Section 8: Empty State / Placeholder
        buildSectionHeader('8. Input States'),
        buildAutocompleteWithDropdown(
          'Empty / Ready',
          '',
          'Start typing to search...',
          [],
          Colors.grey.shade400,
          prefixIcon: Icons.search,
          showClear: false,
        ),
        SizedBox(height: 4),
        buildAutocompleteWithDropdown(
          'Typing in progress',
          'fl',
          'Search...',
          [
            buildSuggestionListItem(
              'Flutter',
              'UI framework',
              Icons.flutter_dash,
              Colors.blue.shade700,
              isHighlighted: true,
            ),
            buildSuggestionListItem(
              'Flame',
              'Game engine',
              Icons.local_fire_department,
              Colors.orange.shade700,
            ),
            buildSuggestionListItem(
              'Floor',
              'Database ORM',
              Icons.storage,
              Colors.green.shade700,
            ),
          ],
          Colors.blue.shade700,
          prefixIcon: Icons.search,
        ),
        SizedBox(height: 4),
        buildAutocompleteWithDropdown(
          'Selection made',
          'Flutter',
          'Search...',
          [],
          Colors.grey.shade400,
          prefixIcon: Icons.check_circle,
        ),

        SizedBox(height: 32),
        Center(
          child: Text(
            'End of Autocomplete Demo',
            style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
          ),
        ),
        SizedBox(height: 16),
      ],
    ),
  );
}
