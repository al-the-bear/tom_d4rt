// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Visual - Autocomplete<T> & the Chip Family
// Tag library / dewey-decimal card catalog aesthetic
// Kraft paper, typewriter black, ink red, forest green, rubber-stamp accents
import 'package:flutter/material.dart';

// =============================================================================
// PALETTE - Tag Library / Dewey Decimal Card Catalog
// =============================================================================

const Color kKraft = Color(0xFFE8D9B5);
const Color kKraftDark = Color(0xFFCBB07F);
const Color kKraftDeep = Color(0xFFA98B5C);
const Color kCardCream = Color(0xFFF6ECD2);
const Color kInkBlack = Color(0xFF1B1814);
const Color kInkSoft = Color(0xFF3D352B);
const Color kInkFaint = Color(0xFF7A6A55);
const Color kInkRed = Color(0xFFA62E2A);
const Color kStampRed = Color(0xFFC53B36);
const Color kForest = Color(0xFF31594A);
const Color kForestDeep = Color(0xFF1F3D31);
const Color kLeaf = Color(0xFF74A48F);
const Color kRule = Color(0xFFB8A077);
const Color kPaperShadow = Color(0x33000000);

// =============================================================================
// LOCAL DOMAIN TYPES
// =============================================================================

class Author {
  final String name;
  final int booksWritten;
  const Author(this.name, this.booksWritten);
  @override
  String toString() => name;
}

class Tag {
  final String label;
  final IconData icon;
  final Color color;
  const Tag(this.label, this.icon, this.color);
}

// =============================================================================
// BUILD ENTRY
// =============================================================================

dynamic build(BuildContext context) {
  print('Deep Visual: Autocomplete<T> & the Chip family');

  // ---------------------------------------------------------------------------
  // Local data: authors, tags, suggestion strings
  // ---------------------------------------------------------------------------
  final List<String> fruitOptions = <String>[
    'apple', 'apricot', 'avocado', 'banana', 'blueberry',
    'cherry', 'clementine', 'date', 'elderberry', 'fig',
    'grape', 'grapefruit', 'honeydew', 'kiwi', 'lemon',
    'lime', 'mango', 'nectarine', 'orange', 'peach',
  ];

  final List<Author> authorOptions = <Author>[
    Author('Ada Lovelace', 3),
    Author('Alan Turing', 7),
    Author('Barbara Liskov', 11),
    Author('Donald Knuth', 14),
    Author('Edsger Dijkstra', 9),
    Author('Grace Hopper', 5),
    Author('Linus Torvalds', 2),
    Author('Margaret Hamilton', 4),
  ];

  final List<Tag> preselectedTags = <Tag>[
    Tag('architecture', Icons.account_balance, kForest),
    Tag('history', Icons.menu_book, kInkRed),
    Tag('philosophy', Icons.psychology, kKraftDeep),
    Tag('cartography', Icons.public, kForestDeep),
  ];

  // ---------------------------------------------------------------------------
  // Autocomplete typedef instances - present, but bodies are no-ops
  // ---------------------------------------------------------------------------

  // AutocompleteOptionsBuilder<String>
  Iterable<String> stringOptionsBuilder(TextEditingValue v) {
    if (v.text.isEmpty) return fruitOptions;
    return fruitOptions.where(
      (String o) => o.toLowerCase().contains(v.text.toLowerCase()),
    );
  }

  // AutocompleteOptionsBuilder<Author>
  Iterable<Author> authorOptionsBuilder(TextEditingValue v) {
    if (v.text.isEmpty) return authorOptions;
    return authorOptions.where(
      (Author a) => a.name.toLowerCase().contains(v.text.toLowerCase()),
    );
  }

  // displayStringForOption<Author>
  String authorDisplayString(Author a) => a.name;

  // AutocompletePredicate<Author> - referenced via predicate-style filter
  bool isProlificAuthor(Author a) => a.booksWritten >= 5;
  final int prolificCount = authorOptions.where(isProlificAuthor).length;

  // AutocompleteFieldViewBuilder
  Widget basicFieldViewBuilder(
    BuildContext ctx,
    TextEditingController controller,
    FocusNode focusNode,
    VoidCallback onFieldSubmitted,
  ) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        hintText: 'type to search...',
        hintStyle: TextStyle(
          color: kInkFaint,
          fontFamily: 'monospace',
          fontSize: 13.0,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: kInkBlack, width: 1.2),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      ),
      style: TextStyle(
        color: kInkBlack,
        fontFamily: 'monospace',
        fontSize: 14.0,
      ),
      onSubmitted: (String _) {},
    );
  }

  // AutocompleteOptionsViewBuilder<String> (basic)
  Widget basicOptionsViewBuilder(
    BuildContext ctx,
    AutocompleteOnSelected<String> onSelected,
    Iterable<String> options,
  ) {
    return Material(
      elevation: 4.0,
      child: ListView(
        shrinkWrap: true,
        children: options
            .map<Widget>(
              (String o) => ListTile(
                title: Text(o),
                onTap: () => onSelected(o),
              ),
            )
            .toList(),
      ),
    );
  }

  // AutocompleteOptionsViewBuilder<Author> (rich)
  Widget richAuthorOptionsViewBuilder(
    BuildContext ctx,
    AutocompleteOnSelected<Author> onSelected,
    Iterable<Author> options,
  ) {
    return Material(
      elevation: 6.0,
      color: kCardCream,
      child: ListView(
        shrinkWrap: true,
        children: options.map<Widget>((Author a) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: kForest,
              child: Text(
                a.name.substring(0, 1),
                style: TextStyle(color: Color(0xFFFFFFFF)),
              ),
            ),
            title: Text(a.name),
            trailing: Text('${a.booksWritten} books'),
            onTap: () => onSelected(a),
          );
        }).toList(),
      ),
    );
  }

  // AutocompleteOnSelected<String>
  void onStringSelected(String s) {}
  // AutocompleteOnSelected<Author>
  void onAuthorSelected(Author a) {}

  // Construct actual Autocomplete<T> widgets (kept off-screen-rendered;
  // their fieldViewBuilder/optionsViewBuilder lambdas are wired through).
  final Autocomplete<String> basicStringAutocomplete = Autocomplete<String>(
    optionsBuilder: stringOptionsBuilder,
    onSelected: onStringSelected,
    fieldViewBuilder: basicFieldViewBuilder,
    optionsViewBuilder: basicOptionsViewBuilder,
    optionsMaxHeight: 200.0,
  );

  final Autocomplete<Author> typedAuthorAutocomplete = Autocomplete<Author>(
    optionsBuilder: authorOptionsBuilder,
    displayStringForOption: authorDisplayString,
    onSelected: onAuthorSelected,
    fieldViewBuilder: basicFieldViewBuilder,
    optionsViewBuilder: richAuthorOptionsViewBuilder,
  );

  final RawAutocomplete<String> rawStringAutocomplete = RawAutocomplete<String>(
    optionsBuilder: stringOptionsBuilder,
    onSelected: onStringSelected,
    fieldViewBuilder: basicFieldViewBuilder,
    optionsViewBuilder: basicOptionsViewBuilder,
  );

  print('Autocomplete<String> instance: ${basicStringAutocomplete.runtimeType}');
  print('Autocomplete<Author> instance: ${typedAuthorAutocomplete.runtimeType}');
  print('RawAutocomplete<String> instance: ${rawStringAutocomplete.runtimeType}');
  print('Prolific authors (predicate count): $prolificCount');

  // ---------------------------------------------------------------------------
  // ASSEMBLE PAGE
  // ---------------------------------------------------------------------------

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      scaffoldBackgroundColor: kKraft,
      fontFamily: 'monospace',
      colorScheme: ColorScheme.light(
        primary: kInkBlack,
        secondary: kInkRed,
        surface: kCardCream,
      ),
    ),
    home: Scaffold(
      backgroundColor: kKraft,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildHeroHeader(),
              _verticalGap(28.0),
              _buildConceptOverview(),
              _verticalGap(24.0),
              _buildAutocompleteAnatomyCard(),
              _verticalGap(20.0),
              _buildRawAutocompleteAnatomyCard(),
              _verticalGap(28.0),
              _buildSectionDivider('Live Autocomplete Specimens'),
              _verticalGap(16.0),
              _buildAutocompleteSpecimen1(basicStringAutocomplete),
              _verticalGap(20.0),
              _buildAutocompleteSpecimen2(typedAuthorAutocomplete, authorOptions),
              _verticalGap(20.0),
              _buildAutocompleteSpecimen3(authorOptions),
              _verticalGap(28.0),
              _buildSectionDivider('Chip Variants Gallery'),
              _verticalGap(16.0),
              _buildChipVariantsGallery(),
              _verticalGap(24.0),
              _buildChipAnatomyCard(),
              _verticalGap(24.0),
              _buildChipThemeSpecimen(),
              _verticalGap(24.0),
              _buildFilterChipDemo(),
              _verticalGap(20.0),
              _buildChoiceChipDemo(),
              _verticalGap(20.0),
              _buildActionChipShowcase(),
              _verticalGap(20.0),
              _buildInputChipDeleteShowcase(),
              _verticalGap(28.0),
              _buildCompositeTagInputMockup(preselectedTags),
              _verticalGap(28.0),
              _buildSectionDivider('Recipe Cards'),
              _verticalGap(16.0),
              _buildRecipeCards(),
              _verticalGap(28.0),
              _buildComparisonTable(),
              _verticalGap(24.0),
              _buildPitfallsSection(),
              _verticalGap(24.0),
              _buildGlossary(),
              _verticalGap(24.0),
              _buildEpilogue(),
              _verticalGap(24.0),
              _buildFooter(),
            ],
          ),
        ),
      ),
    ),
  );
}

// =============================================================================
// HELPERS - small reusable widgets
// =============================================================================

Widget _verticalGap(double h) => SizedBox(height: h);

Widget _stamp(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(
      border: Border.all(color: color, width: 2.0),
      borderRadius: BorderRadius.circular(2.0),
    ),
    child: Text(
      text.toUpperCase(),
      style: TextStyle(
        color: color,
        fontFamily: 'monospace',
        fontWeight: FontWeight.bold,
        fontSize: 11.0,
        letterSpacing: 2.0,
      ),
    ),
  );
}

Widget _catalogCard({
  required String shelf,
  required String title,
  required Widget body,
  Color tint = kCardCream,
}) {
  return Container(
    decoration: BoxDecoration(
      color: tint,
      border: Border.all(color: kInkBlack, width: 1.2),
      boxShadow: [
        BoxShadow(color: kPaperShadow, offset: Offset(2.0, 2.0), blurRadius: 0.0),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: kInkBlack,
          ),
          child: Row(
            children: <Widget>[
              Text(
                shelf,
                style: TextStyle(
                  color: kKraft,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  fontSize: 11.0,
                  letterSpacing: 1.4,
                ),
              ),
              SizedBox(width: 12.0),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: kCardCream,
                    fontFamily: 'monospace',
                    fontSize: 12.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 1.0,
          color: kInkBlack,
        ),
        Padding(
          padding: EdgeInsets.all(14.0),
          child: body,
        ),
      ],
    ),
  );
}

Widget _labelRow(String label, String value, {Color? valueColor}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 168.0,
          child: Text(
            label,
            style: TextStyle(
              color: kInkSoft,
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: valueColor ?? kInkBlack,
              fontFamily: 'monospace',
              fontSize: 12.0,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _bullet(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '> ',
          style: TextStyle(
            color: kInkRed,
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
            fontSize: 12.0,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: kInkBlack,
              fontFamily: 'monospace',
              fontSize: 12.0,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _kvPair(String k, String v) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
        color: kInkBlack,
        child: Text(
          k,
          style: TextStyle(
            color: kKraft,
            fontFamily: 'monospace',
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      SizedBox(width: 8.0),
      Expanded(
        child: Text(
          v,
          style: TextStyle(
            color: kInkSoft,
            fontFamily: 'monospace',
            fontSize: 12.0,
          ),
        ),
      ),
    ],
  );
}

// =============================================================================
// SECTION 1 - HERO HEADER
// =============================================================================

Widget _buildHeroHeader() {
  return Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: kInkBlack,
      border: Border.all(color: kInkRed, width: 3.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: kInkRed,
              ),
              child: Icon(Icons.local_library, color: kCardCream, size: 28.0),
            ),
            SizedBox(width: 14.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'TAG LIBRARY · CARD CATALOG',
                    style: TextStyle(
                      color: kKraftDark,
                      fontFamily: 'monospace',
                      fontSize: 11.0,
                      letterSpacing: 3.0,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Autocomplete<T> & the Chip family',
                    style: TextStyle(
                      color: kCardCream,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                    ),
                  ),
                ],
              ),
            ),
            _stamp('CATALOGUED', kStampRed),
          ],
        ),
        SizedBox(height: 14.0),
        Container(height: 1.0, color: kKraftDark),
        SizedBox(height: 12.0),
        Text(
          'A deep-dive into the search-then-token pattern in Material:',
          style: TextStyle(
            color: kKraft,
            fontFamily: 'monospace',
            fontSize: 13.0,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          '  Autocomplete<T>, RawAutocomplete<T>, and Chip / InputChip /',
          style: TextStyle(
            color: kKraftDark,
            fontFamily: 'monospace',
            fontSize: 12.0,
          ),
        ),
        Text(
          '  FilterChip / ChoiceChip / ActionChip / RawChip + ChipTheme.',
          style: TextStyle(
            color: kKraftDark,
            fontFamily: 'monospace',
            fontSize: 12.0,
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 2 - CONCEPT OVERVIEW
// =============================================================================

Widget _buildConceptOverview() {
  return _catalogCard(
    shelf: '§2',
    title: 'Concept overview · input → token',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Two Material vocabularies, one workflow:',
          style: TextStyle(
            color: kInkBlack,
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
            fontSize: 13.0,
          ),
        ),
        SizedBox(height: 10.0),
        _bullet('Autocomplete<T> turns a TextField into a typed picker. '
            'You give it an optionsBuilder; it gives you back the chosen T.'),
        _bullet('Chips are the visible tokens. A finished selection lives '
            'in a Wrap of InputChips with deleteIcons.'),
        _bullet('Glue: when Autocomplete.onSelected fires, append a chip to '
            'the chip list and clear the controller.'),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: kKraft,
            border: Border.all(color: kInkBlack, width: 1.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _miniPill('TextField', kInkBlack, kKraft),
              _arrow(),
              _miniPill('options', kForest, kCardCream),
              _arrow(),
              _miniPill('onSelected', kInkRed, kCardCream),
              _arrow(),
              _miniPill('InputChip', kKraftDeep, kInkBlack),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _miniPill(String label, Color bg, Color fg) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(2.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: fg,
        fontFamily: 'monospace',
        fontSize: 11.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _arrow() => Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.0),
      child: Text(
        '→',
        style: TextStyle(
          color: kInkBlack,
          fontFamily: 'monospace',
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

// =============================================================================
// SECTION 3 - AUTOCOMPLETE<T> ANATOMY
// =============================================================================

Widget _buildAutocompleteAnatomyCard() {
  return _catalogCard(
    shelf: '§3',
    title: 'Autocomplete<T> · constructor params',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _labelRow('optionsBuilder', 'Iterable<T> Function(TextEditingValue)'),
        _labelRow('displayStringForOption', 'String Function(T)  // default toString'),
        _labelRow('fieldViewBuilder', 'Widget Function(ctx, ctrl, focus, submit)'),
        _labelRow('optionsViewBuilder', 'Widget Function(ctx, onSelected, options)'),
        _labelRow('onSelected', 'void Function(T)'),
        _labelRow('initialValue', 'TextEditingValue?'),
        _labelRow('optionsMaxHeight', 'double  // default 200.0'),
        _labelRow('focusNode', 'FocusNode?'),
        _labelRow('textEditingController', 'TextEditingController?'),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: kKraft,
            border: Border.all(color: kInkBlack, width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'NOTE',
                style: TextStyle(
                  color: kInkRed,
                  fontFamily: 'monospace',
                  fontSize: 10.0,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'Autocomplete supplies sensible defaults for the field and options '
                'views. RawAutocomplete does not.',
                style: TextStyle(
                  color: kInkSoft,
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 4 - RAWAUTOCOMPLETE<T> ANATOMY
// =============================================================================

Widget _buildRawAutocompleteAnatomyCard() {
  return _catalogCard(
    shelf: '§4',
    title: 'RawAutocomplete<T> · no defaults',
    tint: kKraft,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _bullet('Same parameter surface as Autocomplete<T>, but every builder '
            'must be supplied explicitly.'),
        _bullet('Use the raw form when you need an alternate overlay (no '
            'Material elevation, custom positioning) or a custom field decoration '
            'system.'),
        _bullet('RawAutocomplete returns whatever fieldViewBuilder returns; '
            'it does not impose Material chrome.'),
        SizedBox(height: 10.0),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: kCardCream,
                  border: Border.all(color: kInkBlack, width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _stamp('PICK Autocomplete', kForest),
                    SizedBox(height: 6.0),
                    Text(
                      '• Material default field\n'
                      '• Material default options list\n'
                      '• 95% of use cases',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11.0,
                        color: kInkBlack,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: kCardCream,
                  border: Border.all(color: kInkBlack, width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _stamp('PICK RawAutocomplete', kInkRed),
                    SizedBox(height: 6.0),
                    Text(
                      '• Custom field decoration\n'
                      '• Custom overlay/portal\n'
                      '• Power-user controls',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11.0,
                        color: kInkBlack,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION DIVIDER
// =============================================================================

Widget _buildSectionDivider(String title) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Expanded(child: Container(height: 1.5, color: kInkBlack)),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.0),
        child: Text(
          title.toUpperCase(),
          style: TextStyle(
            color: kInkBlack,
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
            letterSpacing: 3.0,
          ),
        ),
      ),
      Expanded(child: Container(height: 1.5, color: kInkBlack)),
    ],
  );
}

// =============================================================================
// SECTION 5 - LIVE SPECIMEN 1: BASIC AUTOCOMPLETE<STRING>
// =============================================================================

Widget _buildAutocompleteSpecimen1(Autocomplete<String> ac) {
  return _catalogCard(
    shelf: '§5',
    title: 'Specimen 1 · Autocomplete<String> · 20 fruits',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _kvPair('TYPE', '${ac.runtimeType}'),
        _kvPair('OPTIONS COUNT', '20'),
        _kvPair('OPTIONS MAX HEIGHT', '${ac.optionsMaxHeight}'),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: kKraft,
            border: Border.all(color: kInkBlack, width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'rendered field (no overlay - cannot run live):',
                style: TextStyle(
                  color: kInkFaint,
                  fontFamily: 'monospace',
                  fontSize: 10.5,
                ),
              ),
              SizedBox(height: 6.0),
              TextField(
                decoration: InputDecoration(
                  hintText: 'type to search 20 fruits...',
                  hintStyle: TextStyle(
                    color: kInkFaint,
                    fontFamily: 'monospace',
                    fontSize: 13.0,
                  ),
                  prefixIcon: Icon(Icons.search, color: kInkBlack, size: 18.0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: kInkBlack, width: 1.2),
                  ),
                  filled: true,
                  fillColor: kCardCream,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                ),
                style: TextStyle(
                  color: kInkBlack,
                  fontFamily: 'monospace',
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 6 - LIVE SPECIMEN 2: AUTOCOMPLETE<AUTHOR>
// =============================================================================

Widget _buildAutocompleteSpecimen2(
  Autocomplete<Author> ac,
  List<Author> authors,
) {
  return _catalogCard(
    shelf: '§6',
    title: 'Specimen 2 · Autocomplete<Author> · typed model',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _kvPair('TYPE', '${ac.runtimeType}'),
        _kvPair('DISPLAY STRING', 'authorDisplayString → Author.name'),
        _kvPair('REQUIRED', 'displayStringForOption (T ≠ String)'),
        SizedBox(height: 12.0),
        Text(
          'options preview:',
          style: TextStyle(
            color: kInkFaint,
            fontFamily: 'monospace',
            fontSize: 10.5,
          ),
        ),
        SizedBox(height: 6.0),
        Container(
          decoration: BoxDecoration(
            color: kCardCream,
            border: Border.all(color: kInkBlack, width: 1.0),
          ),
          child: Column(
            children: <Widget>[
              for (final Author a in authors.take(4))
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: kRule, width: 0.5)),
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 26.0,
                        height: 26.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: kForest,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          a.name.substring(0, 1),
                          style: TextStyle(
                            color: kCardCream,
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: Text(
                          a.name,
                          style: TextStyle(
                            color: kInkBlack,
                            fontFamily: 'monospace',
                            fontSize: 12.5,
                          ),
                        ),
                      ),
                      Text(
                        '${a.booksWritten} books',
                        style: TextStyle(
                          color: kInkFaint,
                          fontFamily: 'monospace',
                          fontSize: 11.0,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 7 - LIVE SPECIMEN 3: RICH OPTIONSVIEWBUILDER
// =============================================================================

Widget _buildAutocompleteSpecimen3(List<Author> authors) {
  return _catalogCard(
    shelf: '§7',
    title: 'Specimen 3 · custom optionsViewBuilder · icon + name + count',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Custom options can render anything — here, a labelled list with icons:',
          style: TextStyle(
            color: kInkSoft,
            fontFamily: 'monospace',
            fontSize: 12.0,
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          decoration: BoxDecoration(
            color: kKraft,
            border: Border.all(color: kInkBlack, width: 1.0),
          ),
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              for (int i = 0; i < authors.length && i < 6; i++)
                Container(
                  margin: EdgeInsets.only(bottom: 4.0),
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: i.isEven ? kCardCream : Color(0xFFEDDFB8),
                    border: Border.all(color: kRule, width: 0.6),
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.menu_book, size: 18.0, color: kInkRed),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: Text(
                          authors[i].name,
                          style: TextStyle(
                            color: kInkBlack,
                            fontFamily: 'monospace',
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 6.0, vertical: 2.0),
                        decoration: BoxDecoration(
                          color: kForest,
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                        child: Text(
                          'x${authors[i].booksWritten}',
                          style: TextStyle(
                            color: kCardCream,
                            fontFamily: 'monospace',
                            fontSize: 11.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 8 - CHIP VARIANTS GALLERY
// =============================================================================

Widget _buildChipVariantsGallery() {
  final List<_ChipVariantSpec> specs = <_ChipVariantSpec>[
    _ChipVariantSpec(
      shelf: '8A',
      name: 'Chip',
      summary: 'Base material chip — label, optional avatar, optional delete.',
      chip: Chip(
        avatar: CircleAvatar(
          backgroundColor: kForest,
          child: Text('C',
              style: TextStyle(color: kCardCream, fontSize: 12.0)),
        ),
        label: Text('plain chip'),
        backgroundColor: kCardCream,
      ),
    ),
    _ChipVariantSpec(
      shelf: '8B',
      name: 'InputChip',
      summary: 'User-generated token. Often deletable; supports selected.',
      chip: InputChip(
        avatar: Icon(Icons.tag, size: 16.0, color: kInkBlack),
        label: Text('input chip'),
        onDeleted: () {},
        backgroundColor: kKraft,
      ),
    ),
    _ChipVariantSpec(
      shelf: '8C',
      name: 'FilterChip',
      summary: 'Multi-select. Toggled state; shows check when selected.',
      chip: FilterChip(
        label: Text('filter on'),
        selected: true,
        onSelected: (bool v) {},
        selectedColor: kForest,
        checkmarkColor: kCardCream,
        labelStyle: TextStyle(color: kCardCream, fontFamily: 'monospace'),
      ),
    ),
    _ChipVariantSpec(
      shelf: '8D',
      name: 'ChoiceChip',
      summary: 'Single-select within a set. Like a stylish radio button.',
      chip: ChoiceChip(
        label: Text('choice'),
        selected: true,
        onSelected: (bool v) {},
        selectedColor: kInkRed,
        labelStyle: TextStyle(color: kCardCream, fontFamily: 'monospace'),
      ),
    ),
    _ChipVariantSpec(
      shelf: '8E',
      name: 'ActionChip',
      summary: 'Triggers an action when tapped. Always tappable, never selected.',
      chip: ActionChip(
        avatar: Icon(Icons.flash_on, size: 16.0, color: kInkRed),
        label: Text('act now'),
        onPressed: () {},
      ),
    ),
    _ChipVariantSpec(
      shelf: '8F',
      name: 'RawChip',
      summary: 'Low-level chip; all behaviour explicitly configured.',
      chip: RawChip(
        label: Text('raw chip'),
        onPressed: () {},
        backgroundColor: kKraftDark,
      ),
    ),
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      for (final _ChipVariantSpec s in specs) ...<Widget>[
        _catalogCard(
          shelf: s.shelf,
          title: '${s.name} · variant',
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                s.summary,
                style: TextStyle(
                  color: kInkSoft,
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 12.0),
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: kKraft,
                  border: Border.all(color: kInkBlack, width: 1.0),
                ),
                child: Row(
                  children: <Widget>[
                    s.chip,
                    SizedBox(width: 12.0),
                    Text(
                      '← live ${s.name}',
                      style: TextStyle(
                        color: kInkFaint,
                        fontFamily: 'monospace',
                        fontSize: 11.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 14.0),
      ],
    ],
  );
}

class _ChipVariantSpec {
  final String shelf;
  final String name;
  final String summary;
  final Widget chip;
  const _ChipVariantSpec({
    required this.shelf,
    required this.name,
    required this.summary,
    required this.chip,
  });
}

// =============================================================================
// SECTION 9 - CHIP ANATOMY
// =============================================================================

Widget _buildChipAnatomyCard() {
  return _catalogCard(
    shelf: '§9',
    title: 'Chip anatomy · slot map',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: kKraft,
            border: Border.all(color: kInkBlack, width: 1.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Chip(
                avatar: CircleAvatar(
                  backgroundColor: kInkRed,
                  child: Text(
                    'A',
                    style: TextStyle(color: kCardCream, fontSize: 12.0),
                  ),
                ),
                label: Text('annotated'),
                deleteIcon: Icon(Icons.close, size: 18.0),
                onDeleted: () {},
                backgroundColor: kCardCream,
                side: BorderSide(color: kInkBlack, width: 1.0),
                elevation: 1.5,
                padding:
                    EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                labelPadding: EdgeInsets.symmetric(horizontal: 4.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 14.0),
        _labelRow('avatar', 'Widget? — circular leading slot'),
        _labelRow('label', 'Widget — required text or content'),
        _labelRow('deleteIcon', 'Widget? — defaults to Icons.cancel'),
        _labelRow('onDeleted', 'VoidCallback? — required to show delete'),
        _labelRow('side', 'BorderSide? — outline'),
        _labelRow('shape', 'OutlinedBorder? — defaults to StadiumBorder'),
        _labelRow('padding', 'EdgeInsetsGeometry? — outer padding'),
        _labelRow('labelPadding', 'EdgeInsetsGeometry? — around label widget'),
        _labelRow('backgroundColor', 'Color? — surface tint'),
        _labelRow('elevation', 'double? — Material shadow depth'),
        _labelRow('pressElevation', 'double? — elevation while pressed'),
      ],
    ),
  );
}

// =============================================================================
// SECTION 10 - CHIPTHEME / CHIPTHEMEDATA
// =============================================================================

Widget _buildChipThemeSpecimen() {
  return _catalogCard(
    shelf: '§10',
    title: 'ChipTheme / ChipThemeData · three brands',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Same Chip widget, three ChipTheme overrides:',
          style: TextStyle(
            color: kInkSoft,
            fontFamily: 'monospace',
            fontSize: 12.0,
          ),
        ),
        SizedBox(height: 12.0),
        _chipThemeRow(
          'DEFAULT',
          ChipThemeData(
            backgroundColor: kCardCream,
            labelStyle: TextStyle(color: kInkBlack, fontFamily: 'monospace'),
            side: BorderSide(color: kInkBlack),
          ),
        ),
        SizedBox(height: 10.0),
        _chipThemeRow(
          'DARK',
          ChipThemeData(
            backgroundColor: kInkBlack,
            labelStyle: TextStyle(color: kCardCream, fontFamily: 'monospace'),
            side: BorderSide(color: kKraftDark),
          ),
        ),
        SizedBox(height: 10.0),
        _chipThemeRow(
          'BRANDED',
          ChipThemeData(
            backgroundColor: kInkRed,
            labelStyle: TextStyle(
              color: kCardCream,
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
            ),
            side: BorderSide(color: kInkBlack, width: 1.4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2.0),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _chipThemeRow(String label, ChipThemeData data) {
  return Row(
    children: <Widget>[
      SizedBox(
        width: 96.0,
        child: Text(
          label,
          style: TextStyle(
            color: kInkBlack,
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
            fontSize: 11.0,
            letterSpacing: 2.0,
          ),
        ),
      ),
      Expanded(
        child: ChipTheme(
          data: data,
          child: Wrap(
            spacing: 8.0,
            children: <Widget>[
              Chip(label: Text('alpha')),
              Chip(label: Text('beta')),
              Chip(label: Text('gamma')),
            ],
          ),
        ),
      ),
    ],
  );
}

// =============================================================================
// SECTION 11 - FILTERCHIP MULTI-SELECT
// =============================================================================

Widget _buildFilterChipDemo() {
  final List<_ChipState> states = <_ChipState>[
    _ChipState('fiction', true),
    _ChipState('non-fiction', false),
    _ChipState('history', true),
    _ChipState('science', false),
    _ChipState('poetry', true),
    _ChipState('drama', false),
  ];

  return _catalogCard(
    shelf: '§11',
    title: 'FilterChip · multi-select (static)',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Note: rendered statically. selected booleans are baked in; '
          'onSelected is a no-op.',
          style: TextStyle(
            color: kInkFaint,
            fontFamily: 'monospace',
            fontSize: 11.5,
          ),
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            for (final _ChipState s in states)
              FilterChip(
                label: Text(s.label),
                selected: s.selected,
                onSelected: (bool v) {},
                selectedColor: kForest,
                backgroundColor: kCardCream,
                checkmarkColor: kCardCream,
                labelStyle: TextStyle(
                  color: s.selected ? kCardCream : kInkBlack,
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                ),
              ),
          ],
        ),
      ],
    ),
  );
}

class _ChipState {
  final String label;
  final bool selected;
  const _ChipState(this.label, this.selected);
}

// =============================================================================
// SECTION 12 - CHOICECHIP SINGLE-SELECT
// =============================================================================

Widget _buildChoiceChipDemo() {
  const List<String> choices = <String>['small', 'medium', 'large', 'extra'];
  const int selectedIndex = 1;

  return _catalogCard(
    shelf: '§12',
    title: 'ChoiceChip · single-select (radio-like)',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Exactly one selected at a time. The chip itself does not enforce '
          'this — the caller does.',
          style: TextStyle(
            color: kInkSoft,
            fontFamily: 'monospace',
            fontSize: 12.0,
            height: 1.4,
          ),
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 8.0,
          children: <Widget>[
            for (int i = 0; i < choices.length; i++)
              ChoiceChip(
                label: Text(choices[i]),
                selected: i == selectedIndex,
                onSelected: (bool v) {},
                selectedColor: kInkRed,
                backgroundColor: kCardCream,
                labelStyle: TextStyle(
                  color: i == selectedIndex ? kCardCream : kInkBlack,
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  fontWeight: i == selectedIndex
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
          ],
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 13 - ACTIONCHIP SHOWCASE
// =============================================================================

Widget _buildActionChipShowcase() {
  return _catalogCard(
    shelf: '§13',
    title: 'ActionChip · three actions',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'ActionChip is always tappable, never selected. Use for verbs.',
          style: TextStyle(
            color: kInkSoft,
            fontFamily: 'monospace',
            fontSize: 12.0,
          ),
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 8.0,
          children: <Widget>[
            ActionChip(
              avatar: Icon(Icons.refresh, size: 16.0, color: kInkBlack),
              label: Text('reload',
                  style: TextStyle(fontFamily: 'monospace')),
              onPressed: () {},
              backgroundColor: kCardCream,
            ),
            ActionChip(
              avatar: Icon(Icons.save, size: 16.0, color: kForest),
              label: Text('save',
                  style: TextStyle(fontFamily: 'monospace')),
              onPressed: () {},
              backgroundColor: kCardCream,
            ),
            ActionChip(
              avatar: Icon(Icons.delete_forever, size: 16.0, color: kInkRed),
              label: Text('purge',
                  style: TextStyle(fontFamily: 'monospace')),
              onPressed: () {},
              backgroundColor: kCardCream,
            ),
          ],
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 14 - INPUTCHIP WITH DELETE
// =============================================================================

Widget _buildInputChipDeleteShowcase() {
  const List<String> tags = <String>[
    'architecture',
    'history',
    'philosophy',
    'cartography',
    'mythology',
  ];
  return _catalogCard(
    shelf: '§14',
    title: 'InputChip · five chips with deleteIcon',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Each InputChip below renders a deleteIcon; tapping it calls '
          'onDeleted (no-op here).',
          style: TextStyle(
            color: kInkSoft,
            fontFamily: 'monospace',
            fontSize: 12.0,
            height: 1.4,
          ),
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            for (final String t in tags)
              InputChip(
                avatar: Icon(Icons.tag, size: 14.0, color: kInkRed),
                label: Text(t,
                    style: TextStyle(fontFamily: 'monospace', fontSize: 12.0)),
                onDeleted: () {},
                deleteIcon: Icon(Icons.close, size: 16.0),
                backgroundColor: kCardCream,
                side: BorderSide(color: kInkBlack, width: 0.8),
              ),
          ],
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 15 - COMPOSITE: TAG INPUT MOCKUP
// =============================================================================

Widget _buildCompositeTagInputMockup(List<Tag> preselected) {
  return _catalogCard(
    shelf: '§15',
    title: 'Composite · Autocomplete-driven tag input (mockup)',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'A static mockup of the canonical pattern: pre-selected tags in a '
          'Wrap above the autocomplete TextField.',
          style: TextStyle(
            color: kInkSoft,
            fontFamily: 'monospace',
            fontSize: 12.0,
            height: 1.4,
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: kKraft,
            border: Border.all(color: kInkBlack, width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Wrap(
                spacing: 6.0,
                runSpacing: 6.0,
                children: <Widget>[
                  for (final Tag tag in preselected)
                    InputChip(
                      avatar: Icon(tag.icon, size: 14.0, color: tag.color),
                      label: Text(
                        tag.label,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 12.0,
                          color: kInkBlack,
                        ),
                      ),
                      onDeleted: () {},
                      deleteIcon: Icon(Icons.close, size: 14.0),
                      backgroundColor: kCardCream,
                      side: BorderSide(color: tag.color, width: 1.0),
                    ),
                ],
              ),
              SizedBox(height: 10.0),
              Container(height: 1.0, color: kRule),
              SizedBox(height: 10.0),
              TextField(
                decoration: InputDecoration(
                  hintText: 'add a tag and press enter...',
                  hintStyle: TextStyle(
                    color: kInkFaint,
                    fontFamily: 'monospace',
                    fontSize: 13.0,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: kInkBlack, width: 1.0),
                  ),
                  prefixIcon: Icon(Icons.add, color: kInkBlack, size: 18.0),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                  filled: true,
                  fillColor: kCardCream,
                ),
                style: TextStyle(
                  color: kInkBlack,
                  fontFamily: 'monospace',
                  fontSize: 13.0,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: kCardCream,
            border: Border.all(color: kInkRed, width: 1.0),
          ),
          child: Text(
            'Wiring: Autocomplete<String>.onSelected → append to tag list → '
            'clear controller → setState. Statically rendered above.',
            style: TextStyle(
              color: kInkRed,
              fontFamily: 'monospace',
              fontSize: 11.0,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 16 - RECIPE CARDS (6)
// =============================================================================

Widget _buildRecipeCards() {
  final List<_Recipe> recipes = <_Recipe>[
    _Recipe(
      number: '01',
      title: 'basic string autocomplete',
      lines: <String>[
        'Autocomplete<String>(',
        '  optionsBuilder: (v) => list.where(...),',
        '  onSelected: (s) => setState(...),',
        ')',
      ],
      stamp: 'simple',
      stampColor: kForest,
    ),
    _Recipe(
      number: '02',
      title: 'typed model autocomplete',
      lines: <String>[
        'Autocomplete<Author>(',
        '  optionsBuilder: (v) => authors.where(...),',
        '  displayStringForOption: (a) => a.name,',
        '  onSelected: pick,',
        ')',
      ],
      stamp: 'typed',
      stampColor: kInkRed,
    ),
    _Recipe(
      number: '03',
      title: 'tag input · Autocomplete + InputChip Wrap',
      lines: <String>[
        'Column(children: [',
        '  Wrap(children: tags.map(InputChip.new)...),',
        '  Autocomplete<String>(...onSelected: addTag),',
        '])',
      ],
      stamp: 'composite',
      stampColor: kKraftDeep,
    ),
    _Recipe(
      number: '04',
      title: 'filter row with FilterChip',
      lines: <String>[
        'Wrap(children: filters.map((f) =>',
        '  FilterChip(',
        '    selected: selected.contains(f),',
        '    onSelected: (v) => toggle(f),',
        '  )',
        '))',
      ],
      stamp: 'multi',
      stampColor: kForest,
    ),
    _Recipe(
      number: '05',
      title: 'ChoiceChip radio group',
      lines: <String>[
        'Wrap(children: sizes.asMap().entries.map((e) =>',
        '  ChoiceChip(',
        '    selected: pick == e.key,',
        '    onSelected: (_) => setState(() => pick = e.key),',
        '  )',
        '))',
      ],
      stamp: 'single',
      stampColor: kInkRed,
    ),
    _Recipe(
      number: '06',
      title: 'ChipTheme branded look',
      lines: <String>[
        'ChipTheme(',
        '  data: ChipThemeData(backgroundColor: brand, ...),',
        '  child: child,',
        ')',
      ],
      stamp: 'styling',
      stampColor: kKraftDeep,
    ),
  ];

  return Column(
    children: <Widget>[
      for (int i = 0; i < recipes.length; i++) ...<Widget>[
        _recipeCard(recipes[i]),
        if (i != recipes.length - 1) SizedBox(height: 12.0),
      ],
    ],
  );
}

Widget _recipeCard(_Recipe r) {
  return Container(
    decoration: BoxDecoration(
      color: kCardCream,
      border: Border.all(color: kInkBlack, width: 1.2),
      boxShadow: [
        BoxShadow(color: kPaperShadow, offset: Offset(2.0, 2.0)),
      ],
    ),
    padding: EdgeInsets.all(14.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              color: kInkBlack,
              child: Text(
                'RECIPE ${r.number}',
                style: TextStyle(
                  color: kKraft,
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.6,
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                r.title,
                style: TextStyle(
                  color: kInkBlack,
                  fontFamily: 'monospace',
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _stamp(r.stamp, r.stampColor),
          ],
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: kInkBlack,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              for (final String l in r.lines)
                Text(
                  l,
                  style: TextStyle(
                    color: kKraft,
                    fontFamily: 'monospace',
                    fontSize: 11.5,
                    height: 1.4,
                  ),
                ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _Recipe {
  final String number;
  final String title;
  final List<String> lines;
  final String stamp;
  final Color stampColor;
  const _Recipe({
    required this.number,
    required this.title,
    required this.lines,
    required this.stamp,
    required this.stampColor,
  });
}

// =============================================================================
// SECTION 17 - COMPARISON TABLE
// =============================================================================

Widget _buildComparisonTable() {
  final List<List<String>> rows = <List<String>>[
    <String>['variant', 'selection', 'tap', 'delete', 'typical use'],
    <String>['Chip', 'none', '—', 'opt', 'static info / token'],
    <String>['InputChip', 'optional', 'opt', 'opt', 'user-generated tag'],
    <String>['FilterChip', 'multi', 'yes', 'no', 'multi-select filter set'],
    <String>['ChoiceChip', 'single', 'yes', 'no', 'radio-like picker'],
    <String>['ActionChip', 'none', 'yes', 'no', 'inline action verb'],
    <String>['RawChip', 'optional', 'opt', 'opt', 'custom underlying widget'],
  ];

  return _catalogCard(
    shelf: '§17',
    title: 'Chip variant comparison · selection × interactivity',
    body: Container(
      decoration: BoxDecoration(
        border: Border.all(color: kInkBlack, width: 1.0),
      ),
      child: Column(
        children: <Widget>[
          for (int i = 0; i < rows.length; i++)
            Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: i == 0 ? kInkBlack : (i.isEven ? kKraft : kCardCream),
                border: Border(
                  bottom: BorderSide(
                    color: kInkBlack,
                    width: i == rows.length - 1 ? 0.0 : 0.5,
                  ),
                ),
              ),
              child: Row(
                children: <Widget>[
                  for (int c = 0; c < rows[i].length; c++)
                    Expanded(
                      flex: c == 0 ? 2 : (c == rows[i].length - 1 ? 3 : 2),
                      child: Text(
                        rows[i][c],
                        style: TextStyle(
                          color: i == 0 ? kKraft : kInkBlack,
                          fontFamily: 'monospace',
                          fontSize: 11.5,
                          fontWeight:
                              i == 0 ? FontWeight.bold : FontWeight.normal,
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

// =============================================================================
// SECTION 18 - PITFALLS
// =============================================================================

Widget _buildPitfallsSection() {
  return _catalogCard(
    shelf: '§18',
    title: 'Pitfalls · the ankle-biters',
    tint: kKraft,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _pitfall(
          'PERF',
          'optionsBuilder runs on every keystroke. If your option list is '
          'large or expensive to filter, debounce or precompute an index.',
        ),
        _pitfall(
          'REQUIRED',
          'displayStringForOption is required (effectively) whenever T is '
          'not String — without it, you get T.toString() in the field.',
        ),
        _pitfall(
          'SEMANTICS',
          'FilterChip is multi-select; ChoiceChip is single-select. Don\'t '
          'use FilterChip for radio behaviour or ChoiceChip for checklists.',
        ),
        _pitfall(
          'SIZING',
          'deleteIcon size is fixed by the chip; if you supply an oversized '
          'Icon, the chip will not grow gracefully.',
        ),
        _pitfall(
          'AVATAR',
          'Avatars are constrained to a square slot. Use a CircleAvatar or '
          'a small Icon — large widgets get clipped.',
        ),
        _pitfall(
          'FOCUS',
          'If you pass your own focusNode/textEditingController to '
          'Autocomplete, you own its lifecycle. dispose them in your widget.',
        ),
      ],
    ),
  );
}

Widget _pitfall(String tag, String body) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 64.0,
          padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
          color: kInkRed,
          alignment: Alignment.center,
          child: Text(
            tag,
            style: TextStyle(
              color: kCardCream,
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              fontSize: 10.5,
              letterSpacing: 1.5,
            ),
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Text(
            body,
            style: TextStyle(
              color: kInkBlack,
              fontFamily: 'monospace',
              fontSize: 12.0,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 19 - GLOSSARY (17 TERMS)
// =============================================================================

Widget _buildGlossary() {
  final List<List<String>> terms = <List<String>>[
    <String>['Autocomplete<T>', 'Typed Material widget combining a TextField '
        'with an overlay of options.'],
    <String>['RawAutocomplete<T>', 'Same surface as Autocomplete but without '
        'Material defaults — all builders explicit.'],
    <String>['AutocompletePredicate<T>',
        'bool Function(T) — filter callback used to test individual options.'],
    <String>['AutocompleteFieldViewBuilder',
        'Widget Function(ctx, ctrl, focus, submit) — builds the text input.'],
    <String>['AutocompleteOptionsViewBuilder<T>',
        'Widget Function(ctx, onSelected, options) — builds the overlay list.'],
    <String>['AutocompleteOnSelected<T>',
        'void Function(T) — called when the user picks an option.'],
    <String>['Chip',
        'Material base chip with label, optional avatar, optional delete.'],
    <String>['InputChip',
        'Chip representing a user-supplied token; supports selected + delete.'],
    <String>['FilterChip',
        'Multi-select chip; selected reflects a boolean filter state.'],
    <String>['ChoiceChip',
        'Single-select chip; one of a small set is selected.'],
    <String>['ActionChip',
        'Tappable verb chip that triggers an action; never selected.'],
    <String>['RawChip',
        'Low-level chip; all behaviours configured by the caller.'],
    <String>['ChipTheme',
        'InheritedWidget that propagates ChipThemeData to descendants.'],
    <String>['ChipThemeData',
        'The bag of defaults: colors, label style, shape, side, padding.'],
    <String>['ChipAttributes',
        'Mixin of common slots (label, avatar, padding, shape, etc.).'],
    <String>['DeletableChipAttributes',
        'Mixin of delete-related slots (deleteIcon, onDeleted, tooltips).'],
    <String>['SelectableChipAttributes',
        'Mixin of selection-related slots (selected, onSelected, '
        'selectedColor).'],
  ];

  return _catalogCard(
    shelf: '§19',
    title: 'Glossary · 17 terms',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (final List<String> t in terms)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 170.0,
                  child: Text(
                    t[0],
                    style: TextStyle(
                      color: kInkRed,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.bold,
                      fontSize: 11.5,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    t[1],
                    style: TextStyle(
                      color: kInkBlack,
                      fontFamily: 'monospace',
                      fontSize: 11.5,
                      height: 1.5,
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

// =============================================================================
// SECTION 20 - EPILOGUE
// =============================================================================

Widget _buildEpilogue() {
  return Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: kForestDeep,
      border: Border.all(color: kKraftDark, width: 2.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.bookmark, color: kKraft, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'EPILOGUE',
              style: TextStyle(
                color: kKraft,
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                letterSpacing: 3.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'Autocomplete<T> and the Chip family form Material\'s vocabulary for '
          'the tag-input pattern. The card catalog metaphor lines up well:',
          style: TextStyle(
            color: kCardCream,
            fontFamily: 'monospace',
            fontSize: 13.0,
            height: 1.55,
          ),
        ),
        SizedBox(height: 10.0),
        _epilogueLine('Autocomplete<T>', 'the typewriter and search drawer'),
        _epilogueLine('displayStringForOption', 'the librarian\'s shorthand'),
        _epilogueLine('FilterChip', 'the genre filter row at the front desk'),
        _epilogueLine('ChoiceChip', 'the single-stamp on a borrow slip'),
        _epilogueLine('InputChip', 'each finished, deletable tag card'),
        _epilogueLine('ChipTheme', 'the house style of the entire library'),
        SizedBox(height: 12.0),
        Container(
          height: 1.0,
          color: kKraftDark,
        ),
        SizedBox(height: 10.0),
        Text(
          'Pick Autocomplete unless you have a reason to drop to '
          'RawAutocomplete. Pick the right Chip variant by selection model — '
          'and let ChipTheme keep the brand consistent.',
          style: TextStyle(
            color: kKraft,
            fontFamily: 'monospace',
            fontSize: 12.0,
            height: 1.55,
          ),
        ),
      ],
    ),
  );
}

Widget _epilogueLine(String a, String b) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 200.0,
          child: Text(
            a,
            style: TextStyle(
              color: kLeaf,
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
            ),
          ),
        ),
        Expanded(
          child: Text(
            b,
            style: TextStyle(
              color: kCardCream,
              fontFamily: 'monospace',
              fontSize: 12.0,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// FOOTER
// =============================================================================

Widget _buildFooter() {
  return Column(
    children: <Widget>[
      Container(height: 1.0, color: kInkBlack),
      SizedBox(height: 10.0),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'D4RT · DEEP VISUAL',
            style: TextStyle(
              color: kInkBlack,
              fontFamily: 'monospace',
              fontSize: 10.5,
              letterSpacing: 2.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'autocomplete + chips · catalog card stack',
            style: TextStyle(
              color: kInkSoft,
              fontFamily: 'monospace',
              fontSize: 10.5,
            ),
          ),
          _stamp('FILED', kForest),
        ],
      ),
    ],
  );
}
