// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, use_full_hex_values_for_flutter_colors
// D4rt test script: SearchBar filled style / SearchAnchor.bar filled treatments
// Deep Demo: Visual demonstration of Material 3 SearchBar in its filled
// presentation - WidgetStatePropertyAll backgroundColor with elevation 0,
// leading/trailing widget patterns, hint text variations, focused / disabled
// / error states, and comparisons against outlined SearchBar.
//
// SendTestRunner constraints respected: no StatefulWidget, no setState,
// no animations, no async, no MaterialApp/Scaffold wrapping, no Theme.of /
// Navigator.of. Container decorations use BoxDecoration only. Color blending
// uses Color.withValues(alpha: ...). Callbacks are empty closures.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SearchBar Filled Deep Demo executing');

  // ============================================================
  // PALETTE - Material 3 themed surfaces
  // ============================================================
  const Color seedPrimary = Color(0xFF6750A4);
  const Color seedSecondary = Color(0xFF625B71);
  const Color seedTertiary = Color(0xFF7D5260);
  const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  const Color surfaceContainerLow = Color(0xFFF7F2FA);
  const Color surfaceContainer = Color(0xFFF3EDF7);
  const Color surfaceContainerHigh = Color(0xFFECE6F0);
  const Color surfaceContainerHighest = Color(0xFFE6E0E9);
  const Color onSurface = Color(0xFF1D1B20);
  const Color onSurfaceVariant = Color(0xFF49454F);
  const Color outlineSoft = Color(0xFFCAC4D0);
  const Color outlineVariant = Color(0xFFE7E0EC);
  const Color errorTone = Color(0xFFB3261E);

  // ============================================================
  // SECTION 1: Title banner
  // ============================================================
  print('=== Section 1: Title banner ===');

  final titleBanner = Container(
    width: double.infinity,
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          seedPrimary,
          Color(0xFF7E5BC4),
          Color(0xFF9A75DC),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.0, 0.55, 1.0],
      ),
      borderRadius: BorderRadius.circular(24.0),
      boxShadow: [
        BoxShadow(
          color: seedPrimary.withValues(alpha: 0.45),
          blurRadius: 28.0,
          offset: Offset(0.0, 14.0),
          spreadRadius: 2.0,
        ),
        BoxShadow(
          color: Colors.white.withValues(alpha: 0.10),
          blurRadius: 6.0,
          offset: Offset(0.0, -2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.22),
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.45),
                  width: 1.5,
                ),
              ),
              child: Icon(
                Icons.search,
                color: Colors.white,
                size: 38.0,
              ),
            ),
            SizedBox(width: 18.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SearchBar - Filled',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.6,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'package:flutter/material.dart',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.white.withValues(alpha: 0.85),
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 22.0),
        Text(
          'Material 3 SearchBar rendered in its "filled" treatment - a tonal '
          'background driven by WidgetStatePropertyAll(backgroundColor) and '
          'elevation pinned to 0.0. The result is a flat, surface-anchored '
          'search affordance suitable for app shells, list filters, and '
          'inline finder patterns. This deep demo walks through anatomy, '
          'tonal variants, hint cycling, leading/trailing patterns, focus / '
          'disabled / error visualisations, and a side-by-side comparison '
          'against outlined SearchBars.',
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.white.withValues(alpha: 0.95),
            height: 1.55,
          ),
        ),
        SizedBox(height: 18.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            _buildBannerChip('SearchBar', Icons.search),
            _buildBannerChip('SearchAnchor.bar', Icons.anchor),
            _buildBannerChip('elevation 0.0', Icons.layers_clear),
            _buildBannerChip('WidgetStatePropertyAll', Icons.tune),
            _buildBannerChip('Material 3', Icons.design_services),
            _buildBannerChip('Filled tonal', Icons.format_color_fill),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Anatomy diagram (filled variant)
  // ============================================================
  print('=== Section 2: Anatomy ===');

  final anatomyDiagram = Container(
    padding: EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      color: surfaceContainerLowest,
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: outlineVariant, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: seedPrimary.withValues(alpha: 0.10),
          blurRadius: 18.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.architecture, color: seedPrimary, size: 24.0),
            SizedBox(width: 10.0),
            Text(
              'Anatomy of a Filled SearchBar',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: onSurface,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          'Each numbered callout corresponds to a SearchBar parameter. The '
          'filled tone comes from backgroundColor while elevation 0 keeps '
          'the surface flat against the container.',
          style: TextStyle(
            fontSize: 13.0,
            color: onSurfaceVariant,
            height: 1.45,
          ),
        ),
        SizedBox(height: 20.0),
        // The actual filled SearchBar exemplar
        SearchBar(
          backgroundColor: WidgetStatePropertyAll(surfaceContainerHighest),
          elevation: WidgetStatePropertyAll(0.0),
          shadowColor: WidgetStatePropertyAll(Colors.transparent),
          surfaceTintColor: WidgetStatePropertyAll(Colors.transparent),
          overlayColor: WidgetStatePropertyAll(
            seedPrimary.withValues(alpha: 0.08),
          ),
          padding: WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 16.0),
          ),
          hintText: 'Search apps, settings, and people',
          textStyle: WidgetStatePropertyAll(
            TextStyle(fontSize: 15.0, color: onSurface),
          ),
          hintStyle: WidgetStatePropertyAll(
            TextStyle(fontSize: 15.0, color: onSurfaceVariant),
          ),
          leading: Icon(Icons.search, color: onSurfaceVariant),
          trailing: <Widget>[
            IconButton(
              icon: Icon(Icons.mic, color: onSurfaceVariant),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.tune, color: onSurfaceVariant),
              onPressed: () {},
            ),
          ],
          onTap: () {},
          onChanged: (value) {},
        ),
        SizedBox(height: 20.0),
        _buildAnatomyRow(
          number: '1',
          label: 'backgroundColor',
          desc: 'WidgetStatePropertyAll<Color> producing the tonal fill.',
          color: seedPrimary,
        ),
        _buildAnatomyRow(
          number: '2',
          label: 'elevation',
          desc: 'WidgetStatePropertyAll<double>(0.0) pins the bar flat.',
          color: Color(0xFF1976D2),
        ),
        _buildAnatomyRow(
          number: '3',
          label: 'shadowColor',
          desc: 'Transparent so a flat tonal look has no implied lift.',
          color: Color(0xFF455A64),
        ),
        _buildAnatomyRow(
          number: '4',
          label: 'surfaceTintColor',
          desc: 'Disabled here - filled bars defer to backgroundColor.',
          color: Color(0xFF6A1B9A),
        ),
        _buildAnatomyRow(
          number: '5',
          label: 'leading',
          desc: 'A search glyph - typical magnifier or back arrow.',
          color: Color(0xFF00897B),
        ),
        _buildAnatomyRow(
          number: '6',
          label: 'hintText / hintStyle',
          desc: 'Placeholder copy guiding the user input.',
          color: Color(0xFFEF6C00),
        ),
        _buildAnatomyRow(
          number: '7',
          label: 'trailing',
          desc: 'List<Widget>? for trailing affordances (mic, tune, clear).',
          color: Color(0xFFD81B60),
        ),
        _buildAnatomyRow(
          number: '8',
          label: 'overlayColor',
          desc: 'Hover/focus tint - kept in seed-primary alpha 0.08.',
          color: Color(0xFF388E3C),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Tonal vs flat vs elevated comparison
  // ============================================================
  print('=== Section 3: Tonal vs Flat vs Elevated ===');

  final tonalVariants = <Widget>[
    _buildBarCase(
      title: 'Filled - tonal (M3)',
      description: 'Tonal surfaceContainerHighest + elevation 0. The '
          'canonical Material 3 search bar look.',
      accent: seedPrimary,
      code: 'SearchBar(\n'
          '  backgroundColor: WidgetStatePropertyAll(\n'
          '    Color(0xFFE6E0E9),\n'
          '  ),\n'
          '  elevation: WidgetStatePropertyAll(0.0),\n'
          ')',
      bar: SearchBar(
        backgroundColor: WidgetStatePropertyAll(surfaceContainerHighest),
        elevation: WidgetStatePropertyAll(0.0),
        shadowColor: WidgetStatePropertyAll(Colors.transparent),
        hintText: 'Search anything',
        leading: Icon(Icons.search, color: onSurfaceVariant),
        onTap: () {},
        onChanged: (value) {},
      ),
    ),
    _buildBarCase(
      title: 'Filled - tonal soft',
      description: 'A lighter surfaceContainerLow tone - useful when the '
          'parent is already a high tonal level.',
      accent: Color(0xFF7E5BC4),
      code: 'SearchBar(\n'
          '  backgroundColor: WidgetStatePropertyAll(\n'
          '    Color(0xFFF7F2FA),\n'
          '  ),\n'
          '  elevation: WidgetStatePropertyAll(0.0),\n'
          ')',
      bar: SearchBar(
        backgroundColor: WidgetStatePropertyAll(surfaceContainerLow),
        elevation: WidgetStatePropertyAll(0.0),
        shadowColor: WidgetStatePropertyAll(Colors.transparent),
        hintText: 'Soft tonal search',
        leading: Icon(Icons.search, color: onSurfaceVariant),
        onTap: () {},
        onChanged: (value) {},
      ),
    ),
    _buildBarCase(
      title: 'Filled - primary container tint',
      description: 'A primary-container backgroundColor reads as an '
          'accent-flavoured filled bar.',
      accent: Color(0xFF8E24AA),
      code: 'SearchBar(\n'
          '  backgroundColor: WidgetStatePropertyAll(\n'
          '    Color(0xFFEADDFF),\n'
          '  ),\n'
          '  elevation: WidgetStatePropertyAll(0.0),\n'
          ')',
      bar: SearchBar(
        backgroundColor: WidgetStatePropertyAll(Color(0xFFEADDFF)),
        elevation: WidgetStatePropertyAll(0.0),
        shadowColor: WidgetStatePropertyAll(Colors.transparent),
        hintText: 'Search inside primary container',
        leading: Icon(Icons.search, color: Color(0xFF21005D)),
        onTap: () {},
        onChanged: (value) {},
      ),
    ),
    _buildBarCase(
      title: 'Filled - secondary container',
      description: 'Secondary container tone - a calmer filled flavour.',
      accent: Color(0xFF625B71),
      code: 'backgroundColor: WidgetStatePropertyAll(\n'
          '  Color(0xFFE8DEF8),\n'
          ')',
      bar: SearchBar(
        backgroundColor: WidgetStatePropertyAll(Color(0xFFE8DEF8)),
        elevation: WidgetStatePropertyAll(0.0),
        shadowColor: WidgetStatePropertyAll(Colors.transparent),
        hintText: 'Search secondary content',
        leading: Icon(Icons.search, color: Color(0xFF1D192B)),
        onTap: () {},
        onChanged: (value) {},
      ),
    ),
    _buildBarCase(
      title: 'Flat (transparent)',
      description: 'A "flat" interpretation - transparent fill against an '
          'already-tinted surface, still elevation 0.',
      accent: Color(0xFF455A64),
      code: 'backgroundColor: WidgetStatePropertyAll(\n'
          '  Colors.transparent,\n'
          ')\nside: WidgetStatePropertyAll(\n'
          '  BorderSide(color: outline),\n'
          ')',
      bar: SearchBar(
        backgroundColor: WidgetStatePropertyAll(Colors.transparent),
        elevation: WidgetStatePropertyAll(0.0),
        shadowColor: WidgetStatePropertyAll(Colors.transparent),
        side: WidgetStatePropertyAll(
          BorderSide(color: outlineSoft, width: 1.0),
        ),
        hintText: 'Flat / outlined hybrid',
        leading: Icon(Icons.search, color: onSurfaceVariant),
        onTap: () {},
        onChanged: (value) {},
      ),
    ),
    _buildBarCase(
      title: 'Elevated (counter-example)',
      description: 'An elevated SearchBar uses elevation > 0 and a shadow - '
          'shown here for contrast with the filled style.',
      accent: Color(0xFF1976D2),
      code: 'elevation: WidgetStatePropertyAll(3.0)',
      bar: SearchBar(
        backgroundColor: WidgetStatePropertyAll(surfaceContainerLowest),
        elevation: WidgetStatePropertyAll(3.0),
        shadowColor: WidgetStatePropertyAll(
          Colors.black.withValues(alpha: 0.35),
        ),
        hintText: 'Elevated bar (not filled)',
        leading: Icon(Icons.search, color: onSurfaceVariant),
        onTap: () {},
        onChanged: (value) {},
      ),
    ),
  ];

  // ============================================================
  // SECTION 4: Hint text variations / placeholder cycling
  // ============================================================
  print('=== Section 4: Hint text variations ===');

  final hintVariations = <String>[
    'Search anything',
    'Search apps, files, contacts',
    'Find a setting...',
    'Try "weather in Berlin"',
    'Search inside this workspace',
    'Type a command or query',
    'Find by name, tag, or path',
    'Search e.g. "monthly report"',
  ];

  final hintGrid = Container(
    padding: EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [surfaceContainer, surfaceContainerHigh],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: outlineVariant, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.text_fields, color: seedPrimary, size: 22.0),
            SizedBox(width: 10.0),
            Text(
              'Hint Text Cycling (rendered statically)',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: onSurface,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          'SendTestRunner does not animate, so each hint is rendered as a '
          'separate filled SearchBar in a stacked sequence to convey what '
          'a placeholder cycle would look like.',
          style: TextStyle(
            fontSize: 12.5,
            color: onSurfaceVariant,
            height: 1.4,
          ),
        ),
        SizedBox(height: 16.0),
        for (int i = 0; i < hintVariations.length; i++)
          Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Row(
              children: [
                Container(
                  width: 26.0,
                  height: 26.0,
                  decoration: BoxDecoration(
                    color: seedPrimary.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: Text(
                      '${i + 1}',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: seedPrimary,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.0),
                Expanded(
                  child: SearchBar(
                    backgroundColor:
                        WidgetStatePropertyAll(surfaceContainerLowest),
                    elevation: WidgetStatePropertyAll(0.0),
                    shadowColor: WidgetStatePropertyAll(Colors.transparent),
                    hintText: hintVariations[i],
                    hintStyle: WidgetStatePropertyAll(
                      TextStyle(
                        fontSize: 14.0,
                        color: onSurfaceVariant,
                      ),
                    ),
                    leading: Icon(Icons.search,
                        color: onSurfaceVariant, size: 20.0),
                    onTap: () {},
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Leading / trailing widget patterns
  // ============================================================
  print('=== Section 5: Leading / trailing patterns ===');

  final leadingTrailingPatterns = <Widget>[
    _buildPatternCase(
      title: 'Search glyph leading',
      description: 'Magnifier as the leading widget. The most common '
          'pattern - users immediately recognise the affordance.',
      accent: seedPrimary,
      code: 'leading: Icon(Icons.search)',
      bar: SearchBar(
        backgroundColor: WidgetStatePropertyAll(surfaceContainerHighest),
        elevation: WidgetStatePropertyAll(0.0),
        shadowColor: WidgetStatePropertyAll(Colors.transparent),
        hintText: 'Search...',
        leading: Icon(Icons.search, color: onSurfaceVariant),
        onTap: () {},
        onChanged: (value) {},
      ),
    ),
    _buildPatternCase(
      title: 'Hamburger leading',
      description: 'Filled SearchBar with a navigation drawer trigger - '
          'classic Google-style application shell.',
      accent: Color(0xFF1976D2),
      code: 'leading: IconButton(\n'
          '  icon: Icon(Icons.menu),\n'
          '  onPressed: () {},\n'
          ')',
      bar: SearchBar(
        backgroundColor: WidgetStatePropertyAll(surfaceContainerHighest),
        elevation: WidgetStatePropertyAll(0.0),
        shadowColor: WidgetStatePropertyAll(Colors.transparent),
        hintText: 'Search Gmail',
        leading: IconButton(
          icon: Icon(Icons.menu, color: onSurfaceVariant),
          onPressed: () {},
        ),
        trailing: <Widget>[
          IconButton(
            icon: CircleAvatar(
              radius: 14.0,
              backgroundColor: seedPrimary,
              child: Text(
                'A',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            onPressed: () {},
          ),
        ],
        onTap: () {},
        onChanged: (value) {},
      ),
    ),
    _buildPatternCase(
      title: 'Back arrow leading',
      description: 'Used when SearchBar acts as a search-page header in a '
          'navigation flow.',
      accent: Color(0xFF388E3C),
      code: 'leading: IconButton(\n'
          '  icon: Icon(Icons.arrow_back),\n'
          '  onPressed: () {},\n'
          ')',
      bar: SearchBar(
        backgroundColor: WidgetStatePropertyAll(surfaceContainerHighest),
        elevation: WidgetStatePropertyAll(0.0),
        shadowColor: WidgetStatePropertyAll(Colors.transparent),
        hintText: 'Search results header',
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: onSurfaceVariant),
          onPressed: () {},
        ),
        trailing: <Widget>[
          IconButton(
            icon: Icon(Icons.close, color: onSurfaceVariant),
            onPressed: () {},
          ),
        ],
        onTap: () {},
        onChanged: (value) {},
      ),
    ),
    _buildPatternCase(
      title: 'Mic + tune trailing',
      description: 'Voice input plus a filter affordance - typical for '
          'media catalogues and finder UIs.',
      accent: Color(0xFFEF6C00),
      code: 'trailing: <Widget>[\n'
          '  IconButton(icon: Icon(Icons.mic), ...),\n'
          '  IconButton(icon: Icon(Icons.tune), ...),\n'
          ']',
      bar: SearchBar(
        backgroundColor: WidgetStatePropertyAll(surfaceContainerHighest),
        elevation: WidgetStatePropertyAll(0.0),
        shadowColor: WidgetStatePropertyAll(Colors.transparent),
        hintText: 'Search music or podcasts',
        leading: Icon(Icons.search, color: onSurfaceVariant),
        trailing: <Widget>[
          IconButton(
            icon: Icon(Icons.mic, color: onSurfaceVariant),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.tune, color: onSurfaceVariant),
            onPressed: () {},
          ),
        ],
        onTap: () {},
        onChanged: (value) {},
      ),
    ),
    _buildPatternCase(
      title: 'Clear button trailing',
      description: 'A single trailing IconButton with Icons.close - a '
          'clear-input affordance.',
      accent: Color(0xFFD81B60),
      code: 'trailing: <Widget>[\n'
          '  IconButton(icon: Icon(Icons.close), ...),\n'
          ']',
      bar: SearchBar(
        backgroundColor: WidgetStatePropertyAll(surfaceContainerHighest),
        elevation: WidgetStatePropertyAll(0.0),
        shadowColor: WidgetStatePropertyAll(Colors.transparent),
        hintText: 'Search inbox',
        leading: Icon(Icons.search, color: onSurfaceVariant),
        trailing: <Widget>[
          IconButton(
            icon: Icon(Icons.close, color: onSurfaceVariant),
            onPressed: () {},
          ),
        ],
        onTap: () {},
        onChanged: (value) {},
      ),
    ),
    _buildPatternCase(
      title: 'Avatar trailing',
      description: 'Trailing avatar - quick access to the active user '
          'inside the search context.',
      accent: Color(0xFF6A1B9A),
      code: 'trailing: <Widget>[\n'
          '  CircleAvatar(child: Text(\'A\')),\n'
          ']',
      bar: SearchBar(
        backgroundColor: WidgetStatePropertyAll(surfaceContainerHighest),
        elevation: WidgetStatePropertyAll(0.0),
        shadowColor: WidgetStatePropertyAll(Colors.transparent),
        hintText: 'Search workspace',
        leading: Icon(Icons.search, color: onSurfaceVariant),
        trailing: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              radius: 14.0,
              backgroundColor: seedTertiary,
              child: Text(
                'A',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
        onTap: () {},
        onChanged: (value) {},
      ),
    ),
    _buildPatternCase(
      title: 'Multiple trailing chips',
      description: 'A trailing list with three actions - history, filter, '
          'menu. Use sparingly.',
      accent: Color(0xFF00897B),
      code: 'trailing: <Widget>[\n'
          '  IconButton(icon: Icon(Icons.history)),\n'
          '  IconButton(icon: Icon(Icons.filter_list)),\n'
          '  IconButton(icon: Icon(Icons.more_vert)),\n'
          ']',
      bar: SearchBar(
        backgroundColor: WidgetStatePropertyAll(surfaceContainerHighest),
        elevation: WidgetStatePropertyAll(0.0),
        shadowColor: WidgetStatePropertyAll(Colors.transparent),
        hintText: 'Search history',
        leading: Icon(Icons.search, color: onSurfaceVariant),
        trailing: <Widget>[
          IconButton(
            icon: Icon(Icons.history, color: onSurfaceVariant),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.filter_list, color: onSurfaceVariant),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: onSurfaceVariant),
            onPressed: () {},
          ),
        ],
        onTap: () {},
        onChanged: (value) {},
      ),
    ),
    _buildPatternCase(
      title: 'No leading, only trailing',
      description: 'Some surfaces choose to omit the leading magnifier and '
          'instead rely on a trailing search icon.',
      accent: Color(0xFFC62828),
      code: 'leading: null\n'
          'trailing: <Widget>[\n'
          '  IconButton(icon: Icon(Icons.search)),\n'
          ']',
      bar: SearchBar(
        backgroundColor: WidgetStatePropertyAll(surfaceContainerHighest),
        elevation: WidgetStatePropertyAll(0.0),
        shadowColor: WidgetStatePropertyAll(Colors.transparent),
        hintText: 'Type to search',
        trailing: <Widget>[
          IconButton(
            icon: Icon(Icons.search, color: onSurfaceVariant),
            onPressed: () {},
          ),
        ],
        onTap: () {},
        onChanged: (value) {},
      ),
    ),
  ];

  // ============================================================
  // SECTION 6: Filled state visualisations - focused / disabled / error
  // ============================================================
  print('=== Section 6: State visualisations ===');

  final stateGallery = Container(
    padding: EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [surfaceContainerLow, surfaceContainerHigh],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: outlineVariant, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.toggle_on, color: seedSecondary, size: 22.0),
            SizedBox(width: 10.0),
            Text(
              'Filled state visualisations',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: onSurface,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _buildStateBlock(
          stateLabel: 'Resting',
          stateColor: Color(0xFF388E3C),
          description: 'Idle filled SearchBar with no text. The flat tonal '
              'fill is the resting state.',
          accent: seedPrimary,
          bar: SearchBar(
            backgroundColor: WidgetStatePropertyAll(surfaceContainerHighest),
            elevation: WidgetStatePropertyAll(0.0),
            shadowColor: WidgetStatePropertyAll(Colors.transparent),
            hintText: 'Search...',
            leading: Icon(Icons.search, color: onSurfaceVariant),
            onTap: () {},
            onChanged: (value) {},
          ),
        ),
        SizedBox(height: 14.0),
        _buildStateBlock(
          stateLabel: 'Focused (visualised)',
          stateColor: Color(0xFF1976D2),
          description: 'Focus is portrayed via a tinted overlay and a '
              'primary-coloured border ring. SendTestRunner cannot raise '
              'real focus, so we draw the affordance manually.',
          accent: seedPrimary,
          bar: Container(
            decoration: BoxDecoration(
              color: surfaceContainerHighest,
              borderRadius: BorderRadius.circular(28.0),
              border: Border.all(color: seedPrimary, width: 2.0),
              boxShadow: [
                BoxShadow(
                  color: seedPrimary.withValues(alpha: 0.20),
                  blurRadius: 10.0,
                  spreadRadius: 1.0,
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            height: 56.0,
            child: Row(
              children: [
                Icon(Icons.search, color: seedPrimary),
                SizedBox(width: 12.0),
                Expanded(
                  child: Text(
                    'workspace|',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: onSurface,
                    ),
                  ),
                ),
                Icon(Icons.close, color: onSurfaceVariant),
              ],
            ),
          ),
        ),
        SizedBox(height: 14.0),
        _buildStateBlock(
          stateLabel: 'Filled with text',
          stateColor: Color(0xFFEF6C00),
          description: 'Filled SearchBar showing entered query - a static '
              'visualisation of post-input state.',
          accent: seedPrimary,
          bar: Container(
            decoration: BoxDecoration(
              color: surfaceContainerHighest,
              borderRadius: BorderRadius.circular(28.0),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            height: 56.0,
            child: Row(
              children: [
                Icon(Icons.search, color: onSurfaceVariant),
                SizedBox(width: 12.0),
                Expanded(
                  child: Text(
                    'flutter material 3',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                      color: onSurface,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: onSurfaceVariant),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 14.0),
        _buildStateBlock(
          stateLabel: 'Disabled',
          stateColor: Color(0xFF757575),
          description: 'Disabled by passing onTap and onChanged to no-ops '
              'plus reduced opacity tone for the surface. (Static illusion.)',
          accent: seedPrimary,
          bar: Opacity(
            opacity: 0.55,
            child: SearchBar(
              backgroundColor:
                  WidgetStatePropertyAll(surfaceContainerHighest),
              elevation: WidgetStatePropertyAll(0.0),
              shadowColor: WidgetStatePropertyAll(Colors.transparent),
              hintText: 'Search disabled',
              leading: Icon(Icons.search,
                  color: onSurfaceVariant.withValues(alpha: 0.6)),
              onTap: () {},
              onChanged: (value) {},
            ),
          ),
        ),
        SizedBox(height: 14.0),
        _buildStateBlock(
          stateLabel: 'Error',
          stateColor: errorTone,
          description: 'Visual error treatment - error tonal background '
              'and a red border to flag invalid query syntax.',
          accent: errorTone,
          bar: Container(
            decoration: BoxDecoration(
              color: Color(0xFFFFEDEA),
              borderRadius: BorderRadius.circular(28.0),
              border: Border.all(color: errorTone, width: 1.5),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            height: 56.0,
            child: Row(
              children: [
                Icon(Icons.error_outline, color: errorTone),
                SizedBox(width: 12.0),
                Expanded(
                  child: Text(
                    'Invalid query syntax',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: errorTone,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Icon(Icons.warning_amber, color: errorTone),
              ],
            ),
          ),
        ),
        SizedBox(height: 14.0),
        _buildStateBlock(
          stateLabel: 'Loading (visualised)',
          stateColor: seedPrimary,
          description: 'A trailing progress glyph implies a search is in '
              'flight. SendTestRunner does not animate so we use a static '
              'icon.',
          accent: seedPrimary,
          bar: SearchBar(
            backgroundColor: WidgetStatePropertyAll(surfaceContainerHighest),
            elevation: WidgetStatePropertyAll(0.0),
            shadowColor: WidgetStatePropertyAll(Colors.transparent),
            hintText: 'Searching...',
            leading: Icon(Icons.search, color: onSurfaceVariant),
            trailing: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 12.0),
                child: SizedBox(
                  width: 18.0,
                  height: 18.0,
                  child: Icon(Icons.refresh, size: 18.0, color: seedPrimary),
                ),
              ),
            ],
            onTap: () {},
            onChanged: (value) {},
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Filled vs Outlined SearchBar comparison
  // ============================================================
  print('=== Section 7: Filled vs Outlined comparison ===');

  final filledVsOutlined = Container(
    padding: EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      color: surfaceContainerLowest,
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: outlineVariant, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: seedPrimary.withValues(alpha: 0.08),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.compare_arrows, color: seedPrimary, size: 22.0),
            SizedBox(width: 10.0),
            Text(
              'Filled vs Outlined SearchBar',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: onSurface,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          'Filled and outlined are the two principal SearchBar treatments. '
          'Filled emphasises a tonal fill; outlined emphasises a border.',
          style: TextStyle(
            fontSize: 13.0,
            color: onSurfaceVariant,
            height: 1.45,
          ),
        ),
        SizedBox(height: 18.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: seedPrimary.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(
                    color: seedPrimary.withValues(alpha: 0.20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.format_color_fill,
                            color: seedPrimary, size: 18.0),
                        SizedBox(width: 6.0),
                        Text(
                          'Filled',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: seedPrimary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    SearchBar(
                      backgroundColor:
                          WidgetStatePropertyAll(surfaceContainerHighest),
                      elevation: WidgetStatePropertyAll(0.0),
                      shadowColor:
                          WidgetStatePropertyAll(Colors.transparent),
                      hintText: 'Filled tone',
                      leading:
                          Icon(Icons.search, color: onSurfaceVariant),
                      onTap: () {},
                      onChanged: (value) {},
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Tonal fill,\nelevation 0,\nno border.',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: onSurfaceVariant,
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
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(color: outlineSoft),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.crop_square,
                            color: onSurface, size: 18.0),
                        SizedBox(width: 6.0),
                        Text(
                          'Outlined',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: onSurface,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    SearchBar(
                      backgroundColor:
                          WidgetStatePropertyAll(Colors.transparent),
                      elevation: WidgetStatePropertyAll(0.0),
                      shadowColor:
                          WidgetStatePropertyAll(Colors.transparent),
                      side: WidgetStatePropertyAll(
                        BorderSide(color: outlineSoft, width: 1.0),
                      ),
                      hintText: 'Outlined',
                      leading:
                          Icon(Icons.search, color: onSurfaceVariant),
                      onTap: () {},
                      onChanged: (value) {},
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Transparent fill,\nvisible border,\nelevation 0.',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: onSurfaceVariant,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 18.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: surfaceContainerLow,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: outlineVariant),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Property comparison',
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: onSurface,
                ),
              ),
              SizedBox(height: 8.0),
              _buildCompareRow('backgroundColor',
                  'tonal surface', 'transparent', seedPrimary),
              _buildCompareRow('side', '(none)',
                  'BorderSide(color: outline)', seedPrimary),
              _buildCompareRow(
                  'elevation', '0.0', '0.0', seedPrimary),
              _buildCompareRow('shadowColor', 'transparent',
                  'transparent', seedPrimary),
              _buildCompareRow('Material 3 default',
                  'preferred', 'alt look', seedPrimary),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: SearchAnchor.bar filled treatment
  // ============================================================
  print('=== Section 8: SearchAnchor.bar filled ===');

  // SearchAnchor.bar wraps a SearchBar plus a built-in SearchView controller.
  // We render the bar surface only (no view will pop in the static runner).
  final searchAnchorBar = Container(
    padding: EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [surfaceContainerLow, surfaceContainerLowest],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: outlineVariant, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.anchor, color: seedPrimary, size: 22.0),
            SizedBox(width: 10.0),
            Text(
              'SearchAnchor.bar - filled treatment',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: onSurface,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          'SearchAnchor.bar exposes the same WidgetStateProperty hooks as '
          'SearchBar (barBackgroundColor, barElevation, ...). The filled '
          'recipe is identical: tonal background plus elevation 0.',
          style: TextStyle(
            fontSize: 13.0,
            color: onSurfaceVariant,
            height: 1.45,
          ),
        ),
        SizedBox(height: 18.0),
        SearchAnchor.bar(
          barBackgroundColor:
              WidgetStatePropertyAll(surfaceContainerHighest),
          barElevation: WidgetStatePropertyAll(0.0),
          barOverlayColor: WidgetStatePropertyAll(
            seedPrimary.withValues(alpha: 0.08),
          ),
          barHintText: 'Search via SearchAnchor.bar',
          barLeading: Icon(Icons.search, color: onSurfaceVariant),
          barTrailing: <Widget>[
            IconButton(
              icon: Icon(Icons.mic, color: onSurfaceVariant),
              onPressed: () {},
            ),
          ],
          suggestionsBuilder:
              (BuildContext context, SearchController controller) {
            return <Widget>[];
          },
        ),
        SizedBox(height: 18.0),
        SearchAnchor.bar(
          barBackgroundColor:
              WidgetStatePropertyAll(Color(0xFFEADDFF)),
          barElevation: WidgetStatePropertyAll(0.0),
          barHintText: 'SearchAnchor.bar primary container',
          barLeading: Icon(Icons.search, color: Color(0xFF21005D)),
          suggestionsBuilder:
              (BuildContext context, SearchController controller) {
            return <Widget>[];
          },
        ),
        SizedBox(height: 18.0),
        SearchAnchor.bar(
          barBackgroundColor:
              WidgetStatePropertyAll(Color(0xFFE8DEF8)),
          barElevation: WidgetStatePropertyAll(0.0),
          barHintText: 'SearchAnchor.bar secondary container',
          barLeading: Icon(Icons.search, color: Color(0xFF1D192B)),
          barTrailing: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: CircleAvatar(
                radius: 14.0,
                backgroundColor: seedTertiary,
                child: Text(
                  'B',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
          suggestionsBuilder:
              (BuildContext context, SearchController controller) {
            return <Widget>[];
          },
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: WidgetStateProperty parameter map
  // ============================================================
  print('=== Section 9: WidgetStateProperty map ===');

  final propertyMap = Container(
    padding: EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF1D1B20),
          Color(0xFF2B2930),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
          blurRadius: 18.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.tune, color: Color(0xFFD0BCFF), size: 24.0),
            SizedBox(width: 10.0),
            Text(
              'SearchBar parameter map (filled-relevant)',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        _buildPropertyEntry(
          'backgroundColor',
          'WidgetStateProperty<Color?>?',
          'Tonal fill - the heart of the filled treatment.',
        ),
        _buildPropertyEntry(
          'elevation',
          'WidgetStateProperty<double?>?',
          'Pinned to 0.0 to maintain a flat tonal look.',
        ),
        _buildPropertyEntry(
          'shadowColor',
          'WidgetStateProperty<Color?>?',
          'Transparent so a flat fill has no implied lift.',
        ),
        _buildPropertyEntry(
          'surfaceTintColor',
          'WidgetStateProperty<Color?>?',
          'Defer to backgroundColor; usually transparent for filled.',
        ),
        _buildPropertyEntry(
          'overlayColor',
          'WidgetStateProperty<Color?>?',
          'Hover/focus tint; alpha 0.08 of seed-primary is idiomatic.',
        ),
        _buildPropertyEntry(
          'side',
          'WidgetStateProperty<BorderSide?>?',
          'Usually omitted in a filled bar; outlined uses BorderSide.',
        ),
        _buildPropertyEntry(
          'shape',
          'WidgetStateProperty<OutlinedBorder?>?',
          'Defaults to a stadium-like RoundedRectangleBorder.',
        ),
        _buildPropertyEntry(
          'padding',
          'WidgetStateProperty<EdgeInsetsGeometry?>?',
          'Internal padding around leading/text/trailing.',
        ),
        _buildPropertyEntry(
          'textStyle',
          'WidgetStateProperty<TextStyle?>?',
          'TextStyle for the input text.',
        ),
        _buildPropertyEntry(
          'hintStyle',
          'WidgetStateProperty<TextStyle?>?',
          'TextStyle for the placeholder copy.',
        ),
        _buildPropertyEntry(
          'leading',
          'Widget?',
          'Leading affordance - usually a magnifier or back arrow.',
        ),
        _buildPropertyEntry(
          'trailing',
          'Iterable<Widget>?',
          'Trailing affordances - mic, tune, clear, avatar, ...',
        ),
        _buildPropertyEntry(
          'hintText',
          'String?',
          'Placeholder copy guiding the user query.',
        ),
        _buildPropertyEntry(
          'controller',
          'TextEditingController?',
          'Controls the text value and selection.',
        ),
        _buildPropertyEntry(
          'focusNode',
          'FocusNode?',
          'Optional FocusNode for programmatic focus control.',
        ),
        _buildPropertyEntry(
          'onChanged',
          'ValueChanged<String>?',
          'Fires whenever the input text changes.',
        ),
        _buildPropertyEntry(
          'onTap',
          'GestureTapCallback?',
          'Fires when the bar surface is tapped.',
        ),
        _buildPropertyEntry(
          'onSubmitted',
          'ValueChanged<String>?',
          'Fires on Enter / submit action.',
        ),
        _buildPropertyEntry(
          'autoFocus',
          'bool',
          'Initial focus claim - defaults to false.',
        ),
        _buildPropertyEntry(
          'constraints',
          'BoxConstraints?',
          'Layout constraints for the bar (overrides theme defaults).',
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 10: Recap card
  // ============================================================
  print('=== Section 10: Recap ===');

  final recapCard = Container(
    padding: EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          seedPrimary,
          Color(0xFF7E5BC4),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: seedPrimary.withValues(alpha: 0.4),
          blurRadius: 22.0,
          offset: Offset(0.0, 10.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.check_circle_outline,
                color: Colors.white, size: 26.0),
            SizedBox(width: 10.0),
            Text(
              'Recap',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'A filled SearchBar pairs a tonal backgroundColor with elevation '
          'pinned to zero. The result is a flat affordance ideal for app '
          'shells, list filters, and finder patterns. The same recipe '
          'applies to SearchAnchor.bar via barBackgroundColor + '
          'barElevation. Reach for filled when the surrounding surface is '
          'low tonal (surface or surfaceContainerLow) and the bar should '
          'sit above it without visual lift.',
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.white.withValues(alpha: 0.94),
            height: 1.55,
          ),
        ),
        SizedBox(height: 16.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            _buildRecapTag('WidgetStatePropertyAll', Color(0xFFD0BCFF)),
            _buildRecapTag('elevation 0', Color(0xFFCCE4F2)),
            _buildRecapTag('tonal background', Color(0xFFFFD8E4)),
            _buildRecapTag('Material 3', Color(0xFFB6F0C5)),
            _buildRecapTag('SearchAnchor.bar', Color(0xFFFFE0B2)),
            _buildRecapTag('flat surface', Color(0xFFE6E0E9)),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.20),
            ),
          ),
          child: Text(
            'Filled recipe:\n'
            '  backgroundColor: WidgetStatePropertyAll(<tonal color>),\n'
            '  elevation: WidgetStatePropertyAll(0.0),\n'
            '  shadowColor: WidgetStatePropertyAll(Colors.transparent),\n'
            '  surfaceTintColor: WidgetStatePropertyAll(Colors.transparent),',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Colors.white,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // ASSEMBLE
  // ============================================================
  return SingleChildScrollView(
    padding: EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        titleBanner,
        SizedBox(height: 28.0),
        _buildSectionHeader(
          '2. Anatomy of SearchBar (filled variant)',
          'leading + hintText + trailing + tonal fill',
          seedPrimary,
          Icons.architecture,
        ),
        SizedBox(height: 12.0),
        anatomyDiagram,
        SizedBox(height: 28.0),
        _buildSectionHeader(
          '3. Tonal vs flat vs elevated',
          'Filled, soft tonal, primary container, secondary container, ...',
          Color(0xFF1976D2),
          Icons.layers,
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 16.0,
          runSpacing: 16.0,
          children: tonalVariants,
        ),
        SizedBox(height: 28.0),
        _buildSectionHeader(
          '4. Hint text variations',
          'Static placeholder cycling',
          Color(0xFFEF6C00),
          Icons.text_fields,
        ),
        SizedBox(height: 12.0),
        hintGrid,
        SizedBox(height: 28.0),
        _buildSectionHeader(
          '5. Leading / trailing widget patterns',
          'Magnifier, hamburger, back, mic, tune, clear, avatar, multi',
          Color(0xFFD81B60),
          Icons.tune,
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 16.0,
          runSpacing: 16.0,
          children: leadingTrailingPatterns,
        ),
        SizedBox(height: 28.0),
        _buildSectionHeader(
          '6. Filled state visualisations',
          'resting / focused / typed / disabled / error / loading',
          seedSecondary,
          Icons.toggle_on,
        ),
        SizedBox(height: 12.0),
        stateGallery,
        SizedBox(height: 28.0),
        _buildSectionHeader(
          '7. Filled vs Outlined SearchBar',
          'Side-by-side comparison + property map',
          Color(0xFF388E3C),
          Icons.compare_arrows,
        ),
        SizedBox(height: 12.0),
        filledVsOutlined,
        SizedBox(height: 28.0),
        _buildSectionHeader(
          '8. SearchAnchor.bar filled',
          'barBackgroundColor + barElevation: same recipe',
          Color(0xFF6A1B9A),
          Icons.anchor,
        ),
        SizedBox(height: 12.0),
        searchAnchorBar,
        SizedBox(height: 28.0),
        _buildSectionHeader(
          '9. WidgetStateProperty parameter map',
          'Properties used in the filled recipe',
          Color(0xFF263238),
          Icons.list_alt,
        ),
        SizedBox(height: 12.0),
        propertyMap,
        SizedBox(height: 28.0),
        _buildSectionHeader(
          '10. Recap',
          'When to reach for the filled treatment',
          seedPrimary,
          Icons.check_circle_outline,
        ),
        SizedBox(height: 12.0),
        recapCard,
        SizedBox(height: 32.0),
      ],
    ),
  );
}

// ============================================================
// HELPERS
// ============================================================

Widget _buildBannerChip(String label, IconData icon) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(
        color: Colors.white.withValues(alpha: 0.40),
        width: 1.0,
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: 14.0),
        SizedBox(width: 6.0),
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

Widget _buildSectionHeader(
  String title,
  String subtitle,
  Color color,
  IconData icon,
) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.10),
          color.withValues(alpha: 0.02),
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border(
        left: BorderSide(color: color, width: 4.0),
      ),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.08),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Icon(icon, color: color, size: 22.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12.0,
                  color: color.withValues(alpha: 0.75),
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildAnatomyRow({
  required String number,
  required String label,
  required String desc,
  required Color color,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28.0,
          height: 28.0,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.4),
                blurRadius: 6.0,
                offset: Offset(0.0, 2.0),
              ),
            ],
          ),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13.5,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                desc,
                style: TextStyle(
                  fontSize: 12.5,
                  color: Color(0xFF49454F),
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

Widget _buildBarCase({
  required String title,
  required String description,
  required Color accent,
  required String code,
  required Widget bar,
}) {
  return Container(
    width: 360.0,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(
        color: accent.withValues(alpha: 0.25),
        width: 1.5,
      ),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.15),
          blurRadius: 10.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
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
                color: accent,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: accent,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          description,
          style: TextStyle(
            fontSize: 12.0,
            color: Color(0xFF616161),
            height: 1.4,
          ),
        ),
        SizedBox(height: 14.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                accent.withValues(alpha: 0.04),
                accent.withValues(alpha: 0.10),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: accent.withValues(alpha: 0.18),
              width: 1.0,
            ),
          ),
          child: bar,
        ),
        SizedBox(height: 12.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFF1D1B20),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Color(0xFFD0BCFF),
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildPatternCase({
  required String title,
  required String description,
  required Color accent,
  required String code,
  required Widget bar,
}) {
  return Container(
    width: 380.0,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(
        color: accent.withValues(alpha: 0.25),
        width: 1.5,
      ),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.15),
          blurRadius: 10.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.label_important, color: accent, size: 16.0),
            SizedBox(width: 6.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: accent,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          description,
          style: TextStyle(
            fontSize: 12.0,
            color: Color(0xFF616161),
            height: 1.4,
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFFF7F2FA),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Color(0xFFE7E0EC), width: 1.0),
          ),
          child: bar,
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFF1D1B20),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Color(0xFFB6F0C5),
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildStateBlock({
  required String stateLabel,
  required Color stateColor,
  required String description,
  required Color accent,
  required Widget bar,
}) {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(
        color: stateColor.withValues(alpha: 0.30),
        width: 1.2,
      ),
      boxShadow: [
        BoxShadow(
          color: stateColor.withValues(alpha: 0.08),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: stateColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  color: stateColor.withValues(alpha: 0.5),
                ),
              ),
              child: Text(
                stateLabel,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.5,
                  fontWeight: FontWeight.bold,
                  color: stateColor,
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                description,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Color(0xFF616161),
                  height: 1.4,
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

Widget _buildCompareRow(
  String label,
  String filled,
  String outlined,
  Color accent,
) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        SizedBox(
          width: 140.0,
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1D1B20),
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              filled,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.5,
                color: accent,
              ),
            ),
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: Color(0xFFE7E0EC),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              outlined,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.5,
                color: Color(0xFF49454F),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildPropertyEntry(String name, String type, String description) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 6.0,
          height: 6.0,
          margin: EdgeInsets.only(top: 6.0, right: 10.0),
          decoration: BoxDecoration(
            color: Color(0xFFD0BCFF),
            shape: BoxShape.circle,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFB4AB),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.0,
                      vertical: 2.0,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFF49454F),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      type,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11.0,
                        color: Color(0xFFCCC2DC),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.0),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Color(0xFFE6E0E9),
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

Widget _buildRecapTag(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.20),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: color, width: 1.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        fontWeight: FontWeight.w600,
        color: color,
      ),
    ),
  );
}
