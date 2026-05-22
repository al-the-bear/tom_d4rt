// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Theme, ThemeData, ColorScheme, TextTheme from material
// Deep Demo: Visual demonstration of Material 3 theming primitives.

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Theme Deep Demo executing');

  // ============================================================
  // SECTION 1: ColorScheme.fromSeed - Multi seed comparison
  // ============================================================
  print('=== Section 1: ColorScheme.fromSeed swatches ===');

  final seedDefinitions = <Map<String, dynamic>>[
    {'name': 'Indigo', 'seed': Colors.indigo, 'icon': Icons.water_drop},
    {'name': 'Teal', 'seed': Colors.teal, 'icon': Icons.eco},
    {'name': 'Deep Orange', 'seed': Colors.deepOrange, 'icon': Icons.local_fire_department},
    {'name': 'Pink', 'seed': Colors.pink, 'icon': Icons.favorite},
    {'name': 'Green', 'seed': Colors.green, 'icon': Icons.park},
  ];

  final seedSchemeRows = <Widget>[];
  for (final def in seedDefinitions) {
    final seed = def['seed'] as MaterialColor;
    final name = def['name'] as String;
    final icon = def['icon'] as IconData;

    final lightScheme = ColorScheme.fromSeed(
      seedColor: seed,
      brightness: Brightness.light,
    );
    final darkScheme = ColorScheme.fromSeed(
      seedColor: seed,
      brightness: Brightness.dark,
    );

    print('Seed: $name -> light.primary=${lightScheme.primary}');
    print('Seed: $name -> dark.primary=${darkScheme.primary}');

    seedSchemeRows.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: seed.shade300, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: seed.withValues(alpha: 0.18),
              blurRadius: 10.0,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36.0,
                  height: 36.0,
                  decoration: BoxDecoration(
                    color: seed,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: Colors.white, size: 20.0),
                ),
                SizedBox(width: 12.0),
                Text(
                  'fromSeed(${name.toLowerCase()})',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: seed.shade900,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.0),
            Text(
              'Light scheme',
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
            SizedBox(height: 6.0),
            _buildSchemeSwatchRow(lightScheme),
            SizedBox(height: 10.0),
            Text(
              'Dark scheme',
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
            SizedBox(height: 6.0),
            _buildSchemeSwatchRow(darkScheme),
          ],
        ),
      ),
    );
  }
  print('Created ${seedSchemeRows.length} seed scheme cards');

  // ============================================================
  // SECTION 2: ThemeData constructors - light / dark / custom
  // ============================================================
  print('=== Section 2: ThemeData constructor variants ===');

  final lightThemeData = ThemeData.light(useMaterial3: true);
  print('ThemeData.light created: brightness=${lightThemeData.brightness}');

  final darkThemeData = ThemeData.dark(useMaterial3: true);
  print('ThemeData.dark created: brightness=${darkThemeData.brightness}');

  final customBrandTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.light,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.deepPurple,
      foregroundColor: Colors.white,
      elevation: 2.0,
      centerTitle: true,
    ),
    cardTheme: CardThemeData(
      color: Colors.deepPurple.shade50,
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.0),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: Colors.deepPurple.shade100,
      labelStyle: TextStyle(color: Colors.deepPurple.shade900),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.deepPurple,
      foregroundColor: Colors.white,
    ),
  );
  print('Custom branded ThemeData created');

  final highContrastTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.highContrastLight(),
  );
  print('High contrast ThemeData created');

  final themeVariantData = <Map<String, dynamic>>[
    {
      'name': 'ThemeData.light()',
      'desc': 'Material 3 default light palette',
      'theme': lightThemeData,
      'icon': Icons.light_mode,
      'accent': Colors.amber,
    },
    {
      'name': 'ThemeData.dark()',
      'desc': 'Material 3 default dark palette',
      'theme': darkThemeData,
      'icon': Icons.dark_mode,
      'accent': Colors.indigo,
    },
    {
      'name': 'Custom Branded',
      'desc': 'Deep purple seed + AppBar/Card/Chip overrides',
      'theme': customBrandTheme,
      'icon': Icons.brush,
      'accent': Colors.deepPurple,
    },
    {
      'name': 'High Contrast',
      'desc': 'Accessibility-tuned light scheme',
      'theme': highContrastTheme,
      'icon': Icons.contrast,
      'accent': Colors.black,
    },
  ];

  final themeVariantCards = <Widget>[];
  for (final v in themeVariantData) {
    final theme = v['theme'] as ThemeData;
    final accent = v['accent'] as Color;
    themeVariantCards.add(
      Container(
        width: 240.0,
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: accent.withValues(alpha: 0.6), width: 2.0),
          boxShadow: [
            BoxShadow(
              color: accent.withValues(alpha: 0.2),
              blurRadius: 8.0,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Icon(v['icon'] as IconData, color: accent, size: 22.0),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    v['name'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Text(
              v['desc'] as String,
              style: TextStyle(
                fontSize: 11.0,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: 12.0),
            Row(
              children: [
                _buildMiniSwatch(theme.colorScheme.primary, 'P'),
                SizedBox(width: 4.0),
                _buildMiniSwatch(theme.colorScheme.secondary, 'S'),
                SizedBox(width: 4.0),
                _buildMiniSwatch(theme.colorScheme.tertiary, 'T'),
                SizedBox(width: 4.0),
                _buildMiniSwatch(theme.colorScheme.error, 'E'),
              ],
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                'brightness: ${theme.brightness.name}',
                style: TextStyle(
                  fontSize: 10.0,
                  fontFamily: 'monospace',
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${themeVariantCards.length} theme variant cards');

  // ============================================================
  // SECTION 3: TextTheme - displayLarge..labelSmall samples
  // ============================================================
  print('=== Section 3: TextTheme samples ===');

  final demoTextTheme = TextTheme(
    displayLarge: TextStyle(fontSize: 38.0, fontWeight: FontWeight.w300, color: Colors.indigo.shade900),
    displayMedium: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w300, color: Colors.indigo.shade800),
    displaySmall: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w400, color: Colors.indigo.shade700),
    headlineLarge: TextStyle(fontSize: 26.0, fontWeight: FontWeight.w500, color: Colors.deepPurple.shade800),
    headlineMedium: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w500, color: Colors.deepPurple.shade700),
    headlineSmall: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500, color: Colors.deepPurple.shade600),
    titleLarge: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.teal.shade800),
    titleMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.teal.shade700, letterSpacing: 0.15),
    titleSmall: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.teal.shade600, letterSpacing: 0.1),
    bodyLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.grey.shade800, letterSpacing: 0.5),
    bodyMedium: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, color: Colors.grey.shade700, letterSpacing: 0.25),
    bodySmall: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400, color: Colors.grey.shade600, letterSpacing: 0.4),
    labelLarge: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.orange.shade900, letterSpacing: 0.1),
    labelMedium: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500, color: Colors.orange.shade800, letterSpacing: 0.5),
    labelSmall: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w500, color: Colors.orange.shade700, letterSpacing: 0.5),
  );

  print('Demo TextTheme displayLarge size = ${demoTextTheme.displayLarge?.fontSize}');
  print('Demo TextTheme labelSmall size = ${demoTextTheme.labelSmall?.fontSize}');

  final textThemeRows = <Map<String, dynamic>>[
    {'name': 'displayLarge', 'style': demoTextTheme.displayLarge, 'group': 'Display'},
    {'name': 'displayMedium', 'style': demoTextTheme.displayMedium, 'group': 'Display'},
    {'name': 'displaySmall', 'style': demoTextTheme.displaySmall, 'group': 'Display'},
    {'name': 'headlineLarge', 'style': demoTextTheme.headlineLarge, 'group': 'Headline'},
    {'name': 'headlineMedium', 'style': demoTextTheme.headlineMedium, 'group': 'Headline'},
    {'name': 'headlineSmall', 'style': demoTextTheme.headlineSmall, 'group': 'Headline'},
    {'name': 'titleLarge', 'style': demoTextTheme.titleLarge, 'group': 'Title'},
    {'name': 'titleMedium', 'style': demoTextTheme.titleMedium, 'group': 'Title'},
    {'name': 'titleSmall', 'style': demoTextTheme.titleSmall, 'group': 'Title'},
    {'name': 'bodyLarge', 'style': demoTextTheme.bodyLarge, 'group': 'Body'},
    {'name': 'bodyMedium', 'style': demoTextTheme.bodyMedium, 'group': 'Body'},
    {'name': 'bodySmall', 'style': demoTextTheme.bodySmall, 'group': 'Body'},
    {'name': 'labelLarge', 'style': demoTextTheme.labelLarge, 'group': 'Label'},
    {'name': 'labelMedium', 'style': demoTextTheme.labelMedium, 'group': 'Label'},
    {'name': 'labelSmall', 'style': demoTextTheme.labelSmall, 'group': 'Label'},
  ];

  final textThemeWidgets = <Widget>[];
  for (final row in textThemeRows) {
    final style = row['style'] as TextStyle?;
    final group = row['group'] as String;
    Color tagColor;
    if (group == 'Display') {
      tagColor = Colors.indigo;
    } else if (group == 'Headline') {
      tagColor = Colors.deepPurple;
    } else if (group == 'Title') {
      tagColor = Colors.teal;
    } else if (group == 'Body') {
      tagColor = Colors.grey.shade700;
    } else {
      tagColor = Colors.orange;
    }
    textThemeWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: tagColor.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: tagColor.withValues(alpha: 0.25), width: 1.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 84.0,
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: tagColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                group,
                style: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                  color: tagColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Text(
                row['name'] as String,
                style: style,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: 8.0),
            Text(
              '${style?.fontSize?.toStringAsFixed(0)}',
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: 'monospace',
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${textThemeWidgets.length} text theme widgets');

  // ============================================================
  // SECTION 4: Nested Theme overrides via copyWith
  // ============================================================
  print('=== Section 4: Nested Theme overrides ===');

  final parentTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
  );
  print('Parent theme primary = ${parentTheme.colorScheme.primary}');

  final overrideScopes = <Map<String, dynamic>>[
    {
      'label': 'Parent (blueGrey)',
      'theme': parentTheme,
      'tag': 'root',
      'color': Colors.blueGrey,
    },
    {
      'label': 'copyWith primary = red',
      'theme': parentTheme.copyWith(
        colorScheme: parentTheme.colorScheme.copyWith(primary: Colors.red.shade700),
      ),
      'tag': 'override-1',
      'color': Colors.red,
    },
    {
      'label': 'copyWith primary = amber',
      'theme': parentTheme.copyWith(
        colorScheme: parentTheme.colorScheme.copyWith(primary: Colors.amber.shade800),
      ),
      'tag': 'override-2',
      'color': Colors.amber.shade800,
    },
    {
      'label': 'copyWith primary = green',
      'theme': parentTheme.copyWith(
        colorScheme: parentTheme.colorScheme.copyWith(primary: Colors.green.shade700),
      ),
      'tag': 'override-3',
      'color': Colors.green,
    },
  ];

  final overrideWidgets = <Widget>[];
  for (int i = 0; i < overrideScopes.length; i++) {
    final scope = overrideScopes[i];
    final theme = scope['theme'] as ThemeData;
    final accent = scope['color'] as Color;
    final isLast = i == overrideScopes.length - 1;

    overrideWidgets.add(
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 36.0,
                height: 36.0,
                decoration: BoxDecoration(
                  color: accent,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2.0),
                  boxShadow: [
                    BoxShadow(
                      color: accent.withValues(alpha: 0.5),
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    '${i + 1}',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              if (!isLast)
                Container(
                  width: 3.0,
                  height: 30.0,
                  color: accent.withValues(alpha: 0.4),
                ),
            ],
          ),
          SizedBox(width: 14.0),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: isLast ? 0.0 : 12.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: accent.withValues(alpha: 0.35),
                  width: 1.0,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.0,
                          vertical: 2.0,
                        ),
                        decoration: BoxDecoration(
                          color: accent.withValues(alpha: 0.25),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          scope['tag'] as String,
                          style: TextStyle(
                            fontSize: 10.0,
                            fontFamily: 'monospace',
                            color: accent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: Text(
                          scope['label'] as String,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Theme(
                    data: theme,
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: theme.colorScheme.outlineVariant,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 28.0,
                            height: 28.0,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Expanded(
                            child: Text(
                              'primary: ${theme.colorScheme.primary}',
                              style: TextStyle(
                                fontSize: 11.0,
                                fontFamily: 'monospace',
                                color: theme.colorScheme.onSurface,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
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
  print('Created ${overrideWidgets.length} override widgets');

  // ============================================================
  // SECTION 5: Themed UI fragment - real-world usage
  // ============================================================
  print('=== Section 5: Themed UI fragment ===');

  final brandedFragment = Theme(
    data: customBrandTheme,
    child: Builder(
      builder: (BuildContext ctx) {
        final theme = Theme.of(ctx);
        print('Branded fragment context primary: ${theme.colorScheme.primary}');
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: theme.colorScheme.outlineVariant),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.primary.withValues(alpha: 0.18),
                blurRadius: 12.0,
                offset: Offset(0, 6),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Branded AppBar replica
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                color: theme.appBarTheme.backgroundColor,
                child: Row(
                  children: [
                    Icon(Icons.menu, color: theme.appBarTheme.foregroundColor),
                    SizedBox(width: 14.0),
                    Expanded(
                      child: Text(
                        'Branded AppBar',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: theme.appBarTheme.foregroundColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.notifications,
                      color: theme.appBarTheme.foregroundColor,
                    ),
                  ],
                ),
              ),
              // Themed Card
              Padding(
                padding: EdgeInsets.all(14.0),
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Theme-driven Card',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        SizedBox(height: 6.0),
                        Text(
                          'Background and corner radius come from cardTheme',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Themed ListTile
              Container(
                color: theme.colorScheme.surfaceContainerHighest,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: theme.colorScheme.primary,
                    child: Icon(
                      Icons.person,
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                  title: Text(
                    'Themed ListTile',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  subtitle: Text(
                    'Inherits typography from ThemeData',
                    style: TextStyle(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
              // Themed chips
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 14.0,
                  vertical: 10.0,
                ),
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: [
                    Chip(label: Text('Design')),
                    Chip(label: Text('System')),
                    Chip(label: Text('Branding')),
                    Chip(label: Text('Material 3')),
                  ],
                ),
              ),
              // Themed buttons
              Padding(
                padding: EdgeInsets.fromLTRB(14.0, 4.0, 14.0, 14.0),
                child: Row(
                  children: [
                    Expanded(
                      child: FilledButton(
                        onPressed: () {},
                        child: Text('Primary Action'),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        child: Text('Secondary'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
  print('Branded fragment widget created');

  // ============================================================
  // SECTION 6: Comparison table light / dark / branded
  // ============================================================
  print('=== Section 6: Comparison table ===');

  final comparisonRoles = <Map<String, dynamic>>[
    {'role': 'primary', 'icon': Icons.star},
    {'role': 'onPrimary', 'icon': Icons.star_border},
    {'role': 'secondary', 'icon': Icons.bubble_chart},
    {'role': 'tertiary', 'icon': Icons.scatter_plot},
    {'role': 'error', 'icon': Icons.error_outline},
    {'role': 'surface', 'icon': Icons.layers},
    {'role': 'onSurface', 'icon': Icons.text_fields},
    {'role': 'outline', 'icon': Icons.crop_square},
  ];

  Color schemeRole(ColorScheme s, String role) {
    switch (role) {
      case 'primary':
        return s.primary;
      case 'onPrimary':
        return s.onPrimary;
      case 'secondary':
        return s.secondary;
      case 'tertiary':
        return s.tertiary;
      case 'error':
        return s.error;
      case 'surface':
        return s.surface;
      case 'onSurface':
        return s.onSurface;
      case 'outline':
        return s.outline;
    }
    return Colors.transparent;
  }

  final comparisonRows = <Widget>[];
  // Header row
  comparisonRows.add(
    Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: 28.0),
          Expanded(
            flex: 3,
            child: Text(
              'Role',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
                color: Colors.grey.shade800,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Light',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
                color: Colors.grey.shade800,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              'Dark',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
                color: Colors.grey.shade800,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              'Branded',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
                color: Colors.grey.shade800,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ),
  );

  for (int i = 0; i < comparisonRoles.length; i++) {
    final r = comparisonRoles[i];
    final role = r['role'] as String;
    final icon = r['icon'] as IconData;
    final isAlt = i.isOdd;
    comparisonRows.add(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        color: isAlt ? Colors.grey.shade50 : Colors.white,
        child: Row(
          children: [
            Icon(icon, size: 18.0, color: Colors.grey.shade700),
            SizedBox(width: 10.0),
            Expanded(
              flex: 3,
              child: Text(
                role,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: _buildSwatchCell(
                  schemeRole(lightThemeData.colorScheme, role),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: _buildSwatchCell(
                  schemeRole(darkThemeData.colorScheme, role),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: _buildSwatchCell(
                  schemeRole(customBrandTheme.colorScheme, role),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${comparisonRows.length} comparison rows');

  final comparisonTable = Container(
    margin: EdgeInsets.symmetric(horizontal: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.grey.shade300, width: 1.0),
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(children: comparisonRows),
  );

  // ============================================================
  // SECTION 7: Code panels
  // ============================================================
  print('=== Section 7: Code panels ===');

  final codePanels = Column(
    children: [
      _buildCodePanel(
        'ColorScheme.fromSeed',
        Icons.colorize,
        Colors.cyan.shade400,
        '// Generate a full Material 3 scheme from a seed color\n'
            'final scheme = ColorScheme.fromSeed(\n'
            '  seedColor: Colors.indigo,\n'
            '  brightness: Brightness.light,\n'
            ');\n'
            '\n'
            '// Access roles\n'
            'scheme.primary;\n'
            'scheme.onPrimary;\n'
            'scheme.primaryContainer;\n'
            'scheme.tertiaryContainer;',
      ),
      _buildCodePanel(
        'ThemeData constructors',
        Icons.palette,
        Colors.amber.shade300,
        '// Built-in light / dark\n'
            'ThemeData.light(useMaterial3: true);\n'
            'ThemeData.dark(useMaterial3: true);\n'
            '\n'
            '// Custom branded theme\n'
            'ThemeData(\n'
            '  useMaterial3: true,\n'
            '  colorScheme: ColorScheme.fromSeed(\n'
            '    seedColor: Colors.deepPurple,\n'
            '  ),\n'
            '  appBarTheme: AppBarTheme(/* ... */),\n'
            '  cardTheme: CardThemeData(/* ... */),\n'
            ');',
      ),
      _buildCodePanel(
        'TextTheme',
        Icons.text_fields,
        Colors.pink.shade300,
        '// 13 typography roles\n'
            'TextTheme(\n'
            '  displayLarge: TextStyle(fontSize: 57),\n'
            '  headlineMedium: TextStyle(fontSize: 28),\n'
            '  titleLarge: TextStyle(fontSize: 22),\n'
            '  bodyMedium: TextStyle(fontSize: 14),\n'
            '  labelSmall: TextStyle(fontSize: 11),\n'
            ');\n'
            '\n'
            '// Bulk recolor via apply()\n'
            'textTheme.apply(bodyColor: Colors.black87);',
      ),
      _buildCodePanel(
        'Nested Theme overrides',
        Icons.layers,
        Colors.greenAccent.shade400,
        '// Override a subtree without rebuilding the whole tree\n'
            'Theme(\n'
            '  data: Theme.of(context).copyWith(\n'
            '    colorScheme: Theme.of(context)\n'
            '        .colorScheme\n'
            '        .copyWith(primary: Colors.red),\n'
            '  ),\n'
            '  child: childWidget,\n'
            ');',
      ),
    ],
  );
  print('Code panels widget created');

  // ============================================================
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryPanel = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade100, Colors.deepPurple.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.deepPurple.shade300, width: 2.0),
    ),
    child: Column(
      children: [
        Text(
          'Key Takeaways',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple.shade900,
          ),
        ),
        SizedBox(height: 16.0),
        _buildSummaryItem(
          Icons.colorize,
          'Seed-driven palettes',
          'ColorScheme.fromSeed generates an entire role set',
          Colors.indigo,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.light_mode,
          'Light & Dark parity',
          'Each scheme has light/dark variants with matching roles',
          Colors.amber.shade800,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.text_fields,
          'TextTheme tiers',
          'display / headline / title / body / label scales',
          Colors.pink,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.layers,
          'Scoped overrides',
          'Theme(data: copyWith(...)) themes only a subtree',
          Colors.green,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.brush,
          'Component themes',
          'AppBar / Card / Chip / Button themes flow from ThemeData',
          Colors.deepPurple,
        ),
      ],
    ),
  );
  print('Summary panel created');

  print('Theme Deep Demo completed successfully');

  // ============================================================
  // Return complete visual layout
  // ============================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
    ),
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
                  colors: [Colors.indigo, Colors.deepPurple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.indigo.withValues(alpha: 0.4),
                    blurRadius: 16.0,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(Icons.palette, size: 56.0, color: Colors.white),
                  SizedBox(height: 8.0),
                  Text(
                    'Material 3 Theming',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'ColorScheme · ThemeData · TextTheme',
                    style: TextStyle(fontSize: 14.0, color: Colors.white70),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.0),

            // Section 1
            Text(
              '1. ColorScheme.fromSeed Swatches',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            ...seedSchemeRows,
            SizedBox(height: 32.0),

            // Section 2
            Text(
              '2. ThemeData Constructor Variants',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            Wrap(
              alignment: WrapAlignment.center,
              children: themeVariantCards,
            ),
            SizedBox(height: 32.0),

            // Section 3
            Text(
              '3. TextTheme Samples',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            ...textThemeWidgets,
            SizedBox(height: 32.0),

            // Section 4
            Text(
              '4. Nested Theme Overrides (copyWith)',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(children: overrideWidgets),
            ),
            SizedBox(height: 32.0),

            // Section 5
            Text(
              '5. Themed UI Fragment',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            brandedFragment,
            SizedBox(height: 32.0),

            // Section 6
            Text(
              '6. Role Comparison Table',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            comparisonTable,
            SizedBox(height: 32.0),

            // Section 7
            Text(
              '7. Code Patterns',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            codePanels,
            SizedBox(height: 32.0),

            // Section 8
            Text(
              '8. Summary',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            summaryPanel,
          ],
        ),
      ),
    ),
  );
}

// ============================================================
// Helper Widgets
// ============================================================

Widget _buildSchemeSwatchRow(ColorScheme scheme) {
  final pairs = <Map<String, dynamic>>[
    {'fill': scheme.primary, 'on': scheme.onPrimary, 'label': 'P'},
    {
      'fill': scheme.primaryContainer,
      'on': scheme.onPrimaryContainer,
      'label': 'PC',
    },
    {'fill': scheme.secondary, 'on': scheme.onSecondary, 'label': 'S'},
    {
      'fill': scheme.secondaryContainer,
      'on': scheme.onSecondaryContainer,
      'label': 'SC',
    },
    {'fill': scheme.tertiary, 'on': scheme.onTertiary, 'label': 'T'},
    {
      'fill': scheme.tertiaryContainer,
      'on': scheme.onTertiaryContainer,
      'label': 'TC',
    },
    {'fill': scheme.error, 'on': scheme.onError, 'label': 'E'},
    {
      'fill': scheme.errorContainer,
      'on': scheme.onErrorContainer,
      'label': 'EC',
    },
  ];

  return Row(
    children: pairs.map((p) {
      return Expanded(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 2.0),
          height: 40.0,
          decoration: BoxDecoration(
            color: p['fill'] as Color,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Center(
            child: Text(
              p['label'] as String,
              style: TextStyle(
                color: p['on'] as Color,
                fontWeight: FontWeight.bold,
                fontSize: 11.0,
              ),
            ),
          ),
        ),
      );
    }).toList(),
  );
}

Widget _buildMiniSwatch(Color fill, String label) {
  return Container(
    width: 36.0,
    height: 36.0,
    decoration: BoxDecoration(
      color: fill,
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: Colors.black12, width: 1.0),
    ),
    child: Center(
      child: Text(
        label,
        style: TextStyle(
          color: ThemeData.estimateBrightnessForColor(fill) == Brightness.dark
              ? Colors.white
              : Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 11.0,
        ),
      ),
    ),
  );
}

Widget _buildSwatchCell(Color color) {
  return Container(
    width: 28.0,
    height: 22.0,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(4.0),
      border: Border.all(color: Colors.black26, width: 1.0),
    ),
  );
}

Widget _buildCodePanel(
  String title,
  IconData icon,
  Color accent,
  String code,
) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
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
            Icon(icon, color: accent, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              title,
              style: TextStyle(
                color: accent,
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.green.shade300,
            ),
          ),
        ),
      ],
    ),
  );
}

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
