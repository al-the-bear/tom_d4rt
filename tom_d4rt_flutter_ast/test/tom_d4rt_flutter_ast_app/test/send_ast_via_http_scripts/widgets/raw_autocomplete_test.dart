// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — RawAutocomplete
// Demonstrates RawAutocomplete<T>: the headless autocomplete widget that gives
// full control over the text field and options display, unlike Autocomplete
// which uses Material-styled defaults.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RawAutocomplete Deep Demo executing');

  // ============================================================
  // SECTION 1: What RawAutocomplete Is — Concept
  // ============================================================
  print('=== Section 1: RawAutocomplete Concept ===');

  // RawAutocomplete<T> is a widget that provides autocomplete functionality
  // WITHOUT any predefined Material or Cupertino styling. You supply:
  //
  //   1. optionsBuilder — a callback that takes a TextEditingValue and returns
  //      an Iterable<T> of matching options
  //   2. fieldViewBuilder — builds the actual text input field
  //   3. optionsViewBuilder — builds the dropdown/overlay of matching options
  //   4. displayStringForOption — converts T to a display string
  //   5. onSelected — called when an option is chosen
  //
  // This makes RawAutocomplete ideal for custom-designed autocomplete UIs,
  // while Autocomplete wraps it with Material defaults.

  final conceptCard = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF00695C), Color(0xFF004D40)],
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.teal.withValues(alpha: 0.3),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          children: [
            Icon(Icons.search, color: Colors.white, size: 30.0),
            SizedBox(width: 12.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'RawAutocomplete<T>',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Headless autocomplete — you style everything',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 20.0),
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Why RawAutocomplete?',
                style: TextStyle(
                  color: Colors.tealAccent,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Autocomplete uses Material styling. RawAutocomplete gives you '
                'complete control: build your own text field, design your own '
                'options overlay, handle selection your own way. The framework '
                'manages the lifecycle — showing/hiding options, keyboard '
                'navigation, option highlighting — while you control the visuals.',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 13.0,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildConceptChip('Headless', Icons.visibility_off),
            _buildConceptChip('Typed <T>', Icons.code),
            _buildConceptChip('Builder-based', Icons.build),
          ],
        ),
      ],
    ),
  );

  print('  conceptCard built');

  // ============================================================
  // SECTION 2: Basic Usage — Fruit Search
  // ============================================================
  print('=== Section 2: Basic Usage — Fruit Search ===');

  // A straightforward RawAutocomplete searching a list of fruits.
  // The fieldViewBuilder creates a styled text field.
  // The optionsBuilder filters fruits case-insensitively.
  // The optionsViewBuilder creates a custom dropdown.

  final fruitOptions = <String>[
    'Apple', 'Apricot', 'Avocado', 'Banana', 'Blackberry', 'Blueberry',
    'Cherry', 'Coconut', 'Cranberry', 'Dragon Fruit', 'Fig', 'Grape',
    'Grapefruit', 'Guava', 'Kiwi', 'Lemon', 'Lime', 'Lychee', 'Mango',
    'Melon', 'Nectarine', 'Orange', 'Papaya', 'Passion Fruit', 'Peach',
    'Pear', 'Pineapple', 'Plum', 'Pomegranate', 'Raspberry', 'Strawberry',
    'Tangerine', 'Watermelon',
  ];

  final fruitSearch = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.teal.shade200),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withValues(alpha: 0.15),
          blurRadius: 8.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 2: Basic Fruit Search',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.teal.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'A RawAutocomplete with a list of 33 fruits. Type to filter.',
          style: TextStyle(fontSize: 13.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16.0),
        RawAutocomplete<String>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return const Iterable<String>.empty();
            }
            return fruitOptions.where((String option) {
              return option.toLowerCase().contains(
                textEditingValue.text.toLowerCase(),
              );
            });
          },
          fieldViewBuilder: (
            BuildContext context,
            TextEditingController textEditingController,
            FocusNode focusNode,
            VoidCallback onFieldSubmitted,
          ) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.teal.shade300),
              ),
              child: TextField(
                controller: textEditingController,
                focusNode: focusNode,
                decoration: InputDecoration(
                  hintText: 'Search fruits...',
                  prefixIcon: Icon(Icons.search, color: Colors.teal),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 14.0,
                  ),
                ),
                onSubmitted: (String value) {
                  onFieldSubmitted();
                },
              ),
            );
          },
          optionsViewBuilder: (
            BuildContext context,
            AutocompleteOnSelected<String> onSelected,
            Iterable<String> options,
          ) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                elevation: 4.0,
                borderRadius: BorderRadius.circular(8.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 200.0, maxWidth: 300.0),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: options.length,
                    itemBuilder: (BuildContext context, int index) {
                      final option = options.elementAt(index);
                      return InkWell(
                        onTap: () => onSelected(option),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 12.0,
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey.shade200,
                                width: 0.5,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Text('🍎', style: TextStyle(fontSize: 18.0)),
                              SizedBox(width: 12.0),
                              Text(
                                option,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.teal.shade900,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
          onSelected: (String selection) {
            print('  Selected fruit: $selection');
          },
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.teal.shade50,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.teal, size: 18.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'optionsBuilder returns Iterable<String>.empty() when text '
                  'is empty, preventing the full list from showing on focus.',
                  style: TextStyle(fontSize: 12.0, color: Colors.teal.shade700),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  print('  fruitSearch built with ${fruitOptions.length} options');

  // ============================================================
  // SECTION 3: Three-Part Architecture — Visual Diagram
  // ============================================================
  print('=== Section 3: Architecture Diagram ===');

  // RawAutocomplete has three essential builder parts:
  //   1. fieldViewBuilder  — creates the input control
  //   2. optionsBuilder    — filters options from raw text
  //   3. optionsViewBuilder — creates the suggestion overlay

  final architectureDiagram = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.blueGrey.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 3: Three-Part Architecture',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'How RawAutocomplete connects the field, filter, and overlay.',
          style: TextStyle(fontSize: 13.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 20.0),
        // The user types input
        _buildArchitectureStep(
          'User Types Input',
          'Text entered into the field built by fieldViewBuilder',
          Icons.keyboard,
          Colors.blue,
          1,
        ),
        _buildArchitectureArrow(),
        // optionsBuilder filters
        _buildArchitectureStep(
          'optionsBuilder Filters',
          'Receives TextEditingValue, returns matching Iterable<T>',
          Icons.filter_list,
          Colors.orange,
          2,
        ),
        _buildArchitectureArrow(),
        // optionsViewBuilder displays
        _buildArchitectureStep(
          'optionsViewBuilder Displays',
          'Receives filtered options, builds overlay widget',
          Icons.view_list,
          Colors.green,
          3,
        ),
        _buildArchitectureArrow(),
        // User selects
        _buildArchitectureStep(
          'onSelected Callback',
          'Called with the chosen T value when user taps an option',
          Icons.check_circle,
          Colors.purple,
          4,
        ),
        SizedBox(height: 16.0),
        // Summary row
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade50,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.blueGrey.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb_outline,
                  color: Colors.amber.shade700, size: 20.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'RawAutocomplete orchestrates these steps automatically. '
                  'You only define the builders — the framework coordinates '
                  'showing/hiding the overlay and keyboard navigation.',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.blueGrey.shade700,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  print('  architectureDiagram built');

  // ============================================================
  // SECTION 4: Custom Options Display — Styled Results
  // ============================================================
  print('=== Section 4: Custom Options Display ===');

  // Because optionsViewBuilder gives full control, we can create
  // richly styled option presentations. Here we show what different
  // optionsViewBuilder implementations could look like.

  final customOptionsDisplay = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.deepPurple.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 4: Custom Options Displays',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'The optionsViewBuilder can render options any way you want.',
          style: TextStyle(fontSize: 13.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 20.0),

        // Style A: Card-based options
        Text(
          'Style A: Card-Based Options',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            color: Colors.deepPurple.shade700,
          ),
        ),
        SizedBox(height: 8.0),
        _buildMockOptionCard('United States', 'North America', Icons.flag,
            Colors.blue.shade50, Colors.blue.shade700),
        SizedBox(height: 4.0),
        _buildMockOptionCard('United Kingdom', 'Europe', Icons.flag,
            Colors.red.shade50, Colors.red.shade700),
        SizedBox(height: 4.0),
        _buildMockOptionCard('United Arab Emirates', 'Asia', Icons.flag,
            Colors.green.shade50, Colors.green.shade700),

        SizedBox(height: 24.0),

        // Style B: Chip-based options
        Text(
          'Style B: Chip-Based Options',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            color: Colors.deepPurple.shade700,
          ),
        ),
        SizedBox(height: 8.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            _buildMockOptionChip('Python', Colors.blue),
            _buildMockOptionChip('JavaScript', Colors.yellow.shade700),
            _buildMockOptionChip('Dart', Colors.cyan),
            _buildMockOptionChip('TypeScript', Colors.indigo),
            _buildMockOptionChip('Rust', Colors.orange),
            _buildMockOptionChip('Swift', Colors.red),
          ],
        ),

        SizedBox(height: 24.0),

        // Style C: Grouped sections
        Text(
          'Style C: Grouped Sections',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            color: Colors.deepPurple.shade700,
          ),
        ),
        SizedBox(height: 8.0),
        _buildMockGroupHeader('Recent Searches'),
        _buildMockGroupItem('Flutter widgets', Icons.history),
        _buildMockGroupItem('Dart generics', Icons.history),
        SizedBox(height: 8.0),
        _buildMockGroupHeader('Suggestions'),
        _buildMockGroupItem('RawAutocomplete', Icons.star),
        _buildMockGroupItem('Autocomplete', Icons.star_border),
        _buildMockGroupItem('RawAutocomplete.optionsBuilder', Icons.star_border),

        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade50,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'All three styles above are possible because optionsViewBuilder '
            'receives the filtered options and returns any widget tree. '
            'The framework calls your builder whenever options change.',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.deepPurple.shade700,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );

  print('  customOptionsDisplay built with 3 styles');

  // ============================================================
  // SECTION 5: displayStringForOption and Initial Value
  // ============================================================
  print('=== Section 5: displayStringForOption and Initial Value ===');

  // When T is not String, displayStringForOption converts the typed
  // object to a string for the text field. This is essential for
  // custom models. initialValue sets the starting text.

  final displayStringSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.indigo.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 5: displayStringForOption & initialValue',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade800,
          ),
        ),
        SizedBox(height: 16.0),

        // displayStringForOption explanation
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo.shade50, Colors.indigo.shade100],
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.text_fields, color: Colors.indigo, size: 22.0),
                  SizedBox(width: 8.0),
                  Text(
                    'displayStringForOption',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.indigo.shade800,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Text(
                'When your options are objects (not strings), this callback '
                'extracts the display text. For example, a User object might '
                'display as "user.name" in the text field after selection.',
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.indigo.shade700,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 12.0),
              // Visual example of object-to-string mapping
              Row(
                children: [
                  _buildMappingBox(
                    'User(id: 42, name: "Alice")',
                    Colors.indigo.shade100,
                    Colors.indigo.shade800,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(Icons.arrow_forward,
                        color: Colors.indigo, size: 20.0),
                  ),
                  _buildMappingBox(
                    '"Alice"',
                    Colors.green.shade100,
                    Colors.green.shade800,
                  ),
                ],
              ),
            ],
          ),
        ),

        SizedBox(height: 16.0),

        // initialValue explanation
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.amber.shade50, Colors.amber.shade100],
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.play_arrow, color: Colors.amber.shade800,
                      size: 22.0),
                  SizedBox(width: 8.0),
                  Text(
                    'initialValue',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.amber.shade900,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Text(
                'Sets the text field initial content via TextEditingValue. '
                'Useful when editing an existing record — the field starts '
                'pre-populated with the current value.',
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.amber.shade900,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 12.0),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 12.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.0),
                  border: Border.all(color: Colors.amber.shade300),
                ),
                child: Row(
                  children: [
                    Icon(Icons.edit, color: Colors.amber.shade700, size: 16.0),
                    SizedBox(width: 8.0),
                    Text(
                      'initialValue: TextEditingValue(text: "Banana")',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontFamily: 'monospace',
                        color: Colors.amber.shade900,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 16.0),

        // Live demo with initialValue
        RawAutocomplete<String>(
          initialValue: TextEditingValue(text: 'Cherry'),
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return const Iterable<String>.empty();
            }
            return fruitOptions.where((String option) {
              return option.toLowerCase().contains(
                textEditingValue.text.toLowerCase(),
              );
            });
          },
          fieldViewBuilder: (
            BuildContext context,
            TextEditingController textEditingController,
            FocusNode focusNode,
            VoidCallback onFieldSubmitted,
          ) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.indigo.shade50,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.indigo.shade300),
              ),
              child: TextField(
                controller: textEditingController,
                focusNode: focusNode,
                decoration: InputDecoration(
                  hintText: 'Pre-filled with "Cherry"',
                  prefixIcon: Icon(Icons.edit, color: Colors.indigo),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 14.0,
                  ),
                ),
                onSubmitted: (String value) {
                  onFieldSubmitted();
                },
              ),
            );
          },
          optionsViewBuilder: (
            BuildContext context,
            AutocompleteOnSelected<String> onSelected,
            Iterable<String> options,
          ) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                elevation: 4.0,
                borderRadius: BorderRadius.circular(8.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 180.0,
                    maxWidth: 280.0,
                  ),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    children: options.map((String option) {
                      return ListTile(
                        dense: true,
                        title: Text(option),
                        leading: Icon(Icons.local_florist,
                            color: Colors.indigo, size: 18.0),
                        onTap: () => onSelected(option),
                      );
                    }).toList(),
                  ),
                ),
              ),
            );
          },
          onSelected: (String selection) {
            print('  initialValue demo selected: $selection');
          },
        ),
      ],
    ),
  );

  print('  displayStringSection built');

  // ============================================================
  // SECTION 6: Multiple Instances — Different Data Sources
  // ============================================================
  print('=== Section 6: Multiple Instances ===');

  // Two RawAutocomplete widgets side-by-side, each with different
  // data types and visual styles, showing independence.

  final countryOptions = <String>[
    'Argentina', 'Australia', 'Austria', 'Belgium', 'Brazil', 'Canada',
    'Chile', 'China', 'Colombia', 'Denmark', 'Egypt', 'Finland',
    'France', 'Germany', 'Greece', 'India', 'Indonesia', 'Ireland',
    'Israel', 'Italy', 'Japan', 'Kenya', 'Mexico', 'Netherlands',
    'New Zealand', 'Norway', 'Peru', 'Philippines', 'Poland', 'Portugal',
    'South Korea', 'Spain', 'Sweden', 'Switzerland', 'Thailand',
    'Turkey', 'United Kingdom', 'United States', 'Vietnam',
  ];

  final languageOptions = <String>[
    'C', 'C++', 'C#', 'Clojure', 'CoffeeScript', 'Dart', 'Elixir',
    'Erlang', 'F#', 'Go', 'Groovy', 'Haskell', 'Java', 'JavaScript',
    'Julia', 'Kotlin', 'Lua', 'Nim', 'Objective-C', 'OCaml', 'Perl',
    'PHP', 'Python', 'R', 'Ruby', 'Rust', 'Scala', 'Shell', 'SQL',
    'Swift', 'TypeScript', 'V', 'Zig',
  ];

  final multipleInstances = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.brown.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 6: Multiple Instances',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.brown.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Each RawAutocomplete manages its own state independently.',
          style: TextStyle(fontSize: 13.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16.0),

        // Country search
        Text(
          'Country Search (${countryOptions.length} countries)',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            color: Colors.blue.shade800,
          ),
        ),
        SizedBox(height: 8.0),
        RawAutocomplete<String>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return const Iterable<String>.empty();
            }
            return countryOptions.where((String option) {
              return option.toLowerCase().contains(
                textEditingValue.text.toLowerCase(),
              );
            });
          },
          fieldViewBuilder: (
            BuildContext context,
            TextEditingController controller,
            FocusNode focusNode,
            VoidCallback onFieldSubmitted,
          ) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.blue.shade300),
              ),
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                decoration: InputDecoration(
                  hintText: 'Search countries...',
                  prefixIcon: Icon(Icons.public, color: Colors.blue),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 14.0,
                  ),
                ),
                onSubmitted: (String value) {
                  onFieldSubmitted();
                },
              ),
            );
          },
          optionsViewBuilder: (
            BuildContext context,
            AutocompleteOnSelected<String> onSelected,
            Iterable<String> options,
          ) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                elevation: 4.0,
                borderRadius: BorderRadius.circular(8.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 160.0,
                    maxWidth: 280.0,
                  ),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    children: options.map((String option) {
                      return ListTile(
                        dense: true,
                        title: Text(option),
                        leading: Icon(Icons.location_on,
                            color: Colors.blue, size: 18.0),
                        onTap: () => onSelected(option),
                      );
                    }).toList(),
                  ),
                ),
              ),
            );
          },
          onSelected: (String selection) {
            print('  Country selected: $selection');
          },
        ),
        SizedBox(height: 24.0),

        // Language search
        Text(
          'Programming Language Search (${languageOptions.length} languages)',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            color: Colors.deepOrange.shade800,
          ),
        ),
        SizedBox(height: 8.0),
        RawAutocomplete<String>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return const Iterable<String>.empty();
            }
            return languageOptions.where((String option) {
              return option.toLowerCase().startsWith(
                textEditingValue.text.toLowerCase(),
              );
            });
          },
          fieldViewBuilder: (
            BuildContext context,
            TextEditingController controller,
            FocusNode focusNode,
            VoidCallback onFieldSubmitted,
          ) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.deepOrange.shade50,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.deepOrange.shade300),
              ),
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                decoration: InputDecoration(
                  hintText: 'Search languages (prefix match)...',
                  prefixIcon: Icon(Icons.code, color: Colors.deepOrange),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 14.0,
                  ),
                ),
                onSubmitted: (String value) {
                  onFieldSubmitted();
                },
              ),
            );
          },
          optionsViewBuilder: (
            BuildContext context,
            AutocompleteOnSelected<String> onSelected,
            Iterable<String> options,
          ) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                elevation: 4.0,
                borderRadius: BorderRadius.circular(8.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 160.0,
                    maxWidth: 280.0,
                  ),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    children: options.map((String option) {
                      return ListTile(
                        dense: true,
                        title: Text(option),
                        leading: Icon(Icons.terminal,
                            color: Colors.deepOrange, size: 18.0),
                        onTap: () => onSelected(option),
                      );
                    }).toList(),
                  ),
                ),
              ),
            );
          },
          onSelected: (String selection) {
            print('  Language selected: $selection');
          },
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.brown.shade50,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'Note: The country search uses .contains() (substring match) while '
            'the language search uses .startsWith() (prefix match). Each '
            'RawAutocomplete manages its own TextEditingController and FocusNode.',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.brown.shade700,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );

  print('  multipleInstances built with countries + languages');

  // ============================================================
  // SECTION 7: API Property Reference
  // ============================================================
  print('=== Section 7: API Property Reference ===');

  final apiReference = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.cyan.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 7: API Property Reference',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.cyan.shade800,
          ),
        ),
        SizedBox(height: 16.0),
        _buildApiProperty(
          'optionsBuilder',
          'AutocompleteOptionsBuilder<T>',
          'Required. Takes TextEditingValue, returns Iterable<T>. Called every '
          'time the input changes. Return empty iterable to hide the overlay.',
          Colors.cyan,
        ),
        SizedBox(height: 12.0),
        _buildApiProperty(
          'fieldViewBuilder',
          'AutocompleteFieldViewBuilder?',
          'Builds the text input widget. Receives a TextEditingController, '
          'FocusNode, and onFieldSubmitted callback. If null, you must provide '
          'a focusNode and textEditingController externally.',
          Colors.blue,
        ),
        SizedBox(height: 12.0),
        _buildApiProperty(
          'optionsViewBuilder',
          'AutocompleteOptionsViewBuilder<T>?',
          'Builds the suggestion overlay. Receives onSelected callback and '
          'the filtered Iterable<T>. Defaults to a simple Material list if '
          'not provided.',
          Colors.green,
        ),
        SizedBox(height: 12.0),
        _buildApiProperty(
          'optionsViewOpenDirection',
          'OptionsViewOpenDirection',
          'Controls whether the options overlay opens above (.up) or below '
          '(.down) the field. Defaults to .down.',
          Colors.orange,
        ),
        SizedBox(height: 12.0),
        _buildApiProperty(
          'displayStringForOption',
          'AutocompleteOptionToString<T>',
          'Converts an option of type T to a String for the text field. '
          'Defaults to calling .toString(). Essential when T is a custom class.',
          Colors.purple,
        ),
        SizedBox(height: 12.0),
        _buildApiProperty(
          'onSelected',
          'AutocompleteOnSelected<T>?',
          'Called when the user selects an option. Receives the selected T '
          'value. The text field is automatically updated via '
          'displayStringForOption.',
          Colors.red,
        ),
        SizedBox(height: 12.0),
        _buildApiProperty(
          'initialValue',
          'TextEditingValue?',
          'Sets the initial text in the field. Cannot be used together with '
          'textEditingController. Useful for edit-mode forms.',
          Colors.amber,
        ),
      ],
    ),
  );

  print('  apiReference built with 7 properties');

  // ============================================================
  // SECTION 8: RawAutocomplete vs Autocomplete — Comparison
  // ============================================================
  print('=== Section 8: RawAutocomplete vs Autocomplete ===');

  final comparisonSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.pink.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 8: RawAutocomplete vs Autocomplete',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.pink.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Autocomplete wraps RawAutocomplete with Material defaults.',
          style: TextStyle(fontSize: 13.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16.0),

        // Header row
        Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
          decoration: BoxDecoration(
            color: Colors.pink.shade50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.0),
              topRight: Radius.circular(8.0),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Feature',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                    color: Colors.pink.shade900,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'RawAutocomplete',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                    color: Colors.teal.shade700,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'Autocomplete',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                    color: Colors.blue.shade700,
                  ),
                ),
              ),
            ],
          ),
        ),

        _buildComparisonRow(
          'Styling',
          'Fully custom — you build everything',
          'Material defaults out of the box',
        ),
        _buildComparisonRow(
          'Field Widget',
          'Any widget via fieldViewBuilder',
          'Uses TextFormField with InputDecoration',
        ),
        _buildComparisonRow(
          'Options Widget',
          'Any widget via optionsViewBuilder',
          'Material-styled ListView with InkWells',
        ),
        _buildComparisonRow(
          'Library',
          'widgets library (framework-level)',
          'material library (Material Design)',
        ),
        _buildComparisonRow(
          'Use Case',
          'Custom design systems, Cupertino apps',
          'Quick Material autocomplete fields',
        ),
        _buildComparisonRow(
          'Complexity',
          'More code but total control',
          'Less code with sensible defaults',
        ),

        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.pink.shade50, Colors.purple.shade50],
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Icon(Icons.tips_and_updates,
                  color: Colors.pink.shade600, size: 20.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Choose RawAutocomplete when you need pixel-perfect control '
                  'over both the input field and the suggestions overlay. '
                  'Choose Autocomplete when Material defaults suffice.',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.pink.shade800,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  print('  comparisonSection built');

  // ============================================================
  // SECTION 9: Keyboard Navigation & optionsViewOpenDirection
  // ============================================================
  print('=== Section 9: Keyboard Navigation & Direction ===');

  final keyboardNavSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.lime.shade400),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 9: Keyboard Navigation & Open Direction',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.lime.shade900,
          ),
        ),
        SizedBox(height: 16.0),

        // Keyboard navigation visual
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.lime.shade50,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.lime.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Built-in Keyboard Navigation',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.lime.shade900,
                ),
              ),
              SizedBox(height: 12.0),
              _buildKeyboardShortcut(
                'Arrow Down / Arrow Up',
                'Navigate between options in the list',
                Icons.swap_vert,
              ),
              SizedBox(height: 8.0),
              _buildKeyboardShortcut(
                'Enter',
                'Select the currently highlighted option',
                Icons.keyboard_return,
              ),
              SizedBox(height: 8.0),
              _buildKeyboardShortcut(
                'Escape',
                'Close the options overlay',
                Icons.close,
              ),
              SizedBox(height: 12.0),
              Text(
                'This keyboard navigation is built into RawAutocomplete '
                'automatically — no additional code needed.',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.lime.shade800,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.0),

        // Open direction visual
        Text(
          'optionsViewOpenDirection',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w600,
            color: Colors.lime.shade900,
          ),
        ),
        SizedBox(height: 12.0),
        Row(
          children: [
            // Down direction
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.green.shade300),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 36.0,
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(color: Colors.green.shade400),
                      ),
                      child: Center(
                        child: Text(
                          'Text Field',
                          style: TextStyle(
                            fontSize: 11.0,
                            color: Colors.green.shade800,
                          ),
                        ),
                      ),
                    ),
                    Icon(Icons.arrow_downward,
                        color: Colors.green, size: 20.0),
                    Container(
                      height: 60.0,
                      decoration: BoxDecoration(
                        color: Colors.green.shade200,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Center(
                        child: Text(
                          'Options\n(below)',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.green.shade900,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 6.0),
                    Text(
                      '.down (default)',
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.green.shade800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12.0),
            // Up direction
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.blue.shade300),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 60.0,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade200,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Center(
                        child: Text(
                          'Options\n(above)',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.blue.shade900,
                          ),
                        ),
                      ),
                    ),
                    Icon(Icons.arrow_upward,
                        color: Colors.blue, size: 20.0),
                    Container(
                      height: 36.0,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(color: Colors.blue.shade400),
                      ),
                      child: Center(
                        child: Text(
                          'Text Field',
                          style: TextStyle(
                            fontSize: 11.0,
                            color: Colors.blue.shade800,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 6.0),
                    Text(
                      '.up',
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue.shade800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'Use .up when the field is near the bottom of the screen and '
          'options would be clipped by the viewport edge.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.lime.shade800,
            height: 1.4,
          ),
        ),
      ],
    ),
  );

  print('  keyboardNavSection built');

  // ============================================================
  // SECTION 10: External Controller Pattern
  // ============================================================
  print('=== Section 10: External Controller Pattern ===');

  // When fieldViewBuilder is null, you provide your own
  // TextEditingController and FocusNode. This is useful for
  // integrating RawAutocomplete into existing form systems.

  final externalControllerNote = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 10: External Controller Pattern',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'When fieldViewBuilder is null, you manage the controller yourself.',
          style: TextStyle(fontSize: 13.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16.0),

        // Pattern visual
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Why use an external controller?',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade800,
                ),
              ),
              SizedBox(height: 8.0),
              _buildUseCaseItem(
                'Form integration',
                'Share the controller with a Form widget for validation',
                Icons.description,
                Colors.blue,
              ),
              SizedBox(height: 6.0),
              _buildUseCaseItem(
                'Programmatic text changes',
                'Set text from external events (e.g., barcode scanner)',
                Icons.qr_code_scanner,
                Colors.green,
              ),
              SizedBox(height: 6.0),
              _buildUseCaseItem(
                'Focus management',
                'Coordinate focus with other fields in a multi-field form',
                Icons.center_focus_strong,
                Colors.orange,
              ),
              SizedBox(height: 6.0),
              _buildUseCaseItem(
                'Text decoration',
                'Apply custom input formatting or masking',
                Icons.text_format,
                Colors.purple,
              ),
            ],
          ),
        ),
        SizedBox(height: 16.0),

        // Code pattern diagram
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Color(0xFF263238),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pattern: fieldViewBuilder = null',
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.cyanAccent,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'final controller = TextEditingController();\n'
                'final focusNode = FocusNode();\n\n'
                'RawAutocomplete<String>(\n'
                '  textEditingController: controller,\n'
                '  focusNode: focusNode,\n'
                '  // fieldViewBuilder is omitted\n'
                '  optionsBuilder: ...,\n'
                '  optionsViewBuilder: ...,\n'
                ')\n\n'
                '// Your custom field, placed elsewhere:\n'
                'TextField(\n'
                '  controller: controller,\n'
                '  focusNode: focusNode,\n'
                ')',
                style: TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'monospace',
                  color: Colors.white.withValues(alpha: 0.85),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.amber.shade300),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.warning_amber, color: Colors.amber.shade700,
                  size: 20.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Important: When using external controllers, you must not '
                  'also provide initialValue — they are mutually exclusive. '
                  'Also, you are responsible for disposing the controller '
                  'and focus node.',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.amber.shade900,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  print('  externalControllerNote built');

  // ============================================================
  // Assemble all sections
  // ============================================================
  print('=== Assembling final layout ===');

  final result = SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        conceptCard,
        fruitSearch,
        architectureDiagram,
        customOptionsDisplay,
        displayStringSection,
        multipleInstances,
        apiReference,
        comparisonSection,
        keyboardNavSection,
        externalControllerNote,
        SizedBox(height: 32.0),
      ],
    ),
  );

  print('RawAutocomplete Deep Demo complete — 10 sections');
  return result;
}

// ============================================================
// Helper functions
// ============================================================

Widget _buildConceptChip(String label, IconData icon) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.2),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: Colors.tealAccent.withValues(alpha: 0.5)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.tealAccent, size: 14.0),
        SizedBox(width: 4.0),
        Text(
          label,
          style: TextStyle(
            color: Colors.tealAccent,
            fontSize: 11.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

Widget _buildArchitectureStep(
  String title,
  String description,
  IconData icon,
  MaterialColor color,
  int stepNumber,
) {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.shade300),
    ),
    child: Row(
      children: [
        Container(
          width: 32.0,
          height: 32.0,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '$stepNumber',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ),
        ),
        SizedBox(width: 12.0),
        Icon(icon, color: color.shade700, size: 24.0),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13.0,
                  color: color.shade900,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                description,
                style: TextStyle(fontSize: 11.0, color: color.shade700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildArchitectureArrow() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Center(
      child: Icon(Icons.arrow_downward, color: Colors.grey.shade400, size: 20.0),
    ),
  );
}

Widget _buildMockOptionCard(
  String title,
  String subtitle,
  IconData icon,
  Color bgColor,
  Color textColor,
) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: textColor.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: [
        Icon(icon, color: textColor, size: 20.0),
        SizedBox(width: 10.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(fontSize: 11.0, color: textColor.withValues(alpha: 0.7)),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildMockOptionChip(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: color.withValues(alpha: 0.5)),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.w500,
        color: color,
      ),
    ),
  );
}

Widget _buildMockGroupHeader(String title) {
  return Padding(
    padding: EdgeInsets.only(bottom: 4.0),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.bold,
        color: Colors.deepPurple.shade600,
        letterSpacing: 0.5,
      ),
    ),
  );
}

Widget _buildMockGroupItem(String text, IconData icon) {
  return Padding(
    padding: EdgeInsets.only(left: 8.0, bottom: 2.0),
    child: Row(
      children: [
        Icon(icon, size: 14.0, color: Colors.deepPurple.shade400),
        SizedBox(width: 8.0),
        Text(
          text,
          style: TextStyle(fontSize: 13.0, color: Colors.deepPurple.shade700),
        ),
      ],
    ),
  );
}

Widget _buildMappingBox(String text, Color bgColor, Color textColor) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10.0,
          fontFamily: 'monospace',
          color: textColor,
        ),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

Widget _buildApiProperty(
  String name,
  String type,
  String description,
  MaterialColor color,
) {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 8.0,
              height: 8.0,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 8.0),
            Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
                color: color.shade900,
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 16.0, top: 2.0),
          child: Text(
            type,
            style: TextStyle(
              fontSize: 11.0,
              fontFamily: 'monospace',
              color: color.shade600,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16.0, top: 6.0),
          child: Text(
            description,
            style: TextStyle(
              fontSize: 12.0,
              color: color.shade800,
              height: 1.3,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildComparisonRow(
  String feature,
  String rawValue,
  String autoValue,
) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: Colors.pink.shade100, width: 0.5),
      ),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            feature,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12.0,
              color: Colors.pink.shade900,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            rawValue,
            style: TextStyle(fontSize: 11.0, color: Colors.teal.shade700),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            autoValue,
            style: TextStyle(fontSize: 11.0, color: Colors.blue.shade700),
          ),
        ),
      ],
    ),
  );
}

Widget _buildKeyboardShortcut(String keys, String action, IconData icon) {
  return Row(
    children: [
      Icon(icon, color: Colors.lime.shade700, size: 18.0),
      SizedBox(width: 8.0),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: Colors.lime.shade100,
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(color: Colors.lime.shade400),
        ),
        child: Text(
          keys,
          style: TextStyle(
            fontSize: 11.0,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w600,
            color: Colors.lime.shade900,
          ),
        ),
      ),
      SizedBox(width: 8.0),
      Expanded(
        child: Text(
          action,
          style: TextStyle(fontSize: 12.0, color: Colors.lime.shade800),
        ),
      ),
    ],
  );
}

Widget _buildUseCaseItem(
  String title,
  String description,
  IconData icon,
  MaterialColor color,
) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: color.shade100,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Icon(icon, color: color.shade700, size: 16.0),
      ),
      SizedBox(width: 8.0),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade800,
              ),
            ),
            Text(
              description,
              style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    ],
  );
}
