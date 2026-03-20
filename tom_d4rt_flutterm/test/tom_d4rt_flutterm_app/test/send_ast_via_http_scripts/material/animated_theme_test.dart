// D4rt test script: Tests AnimatedTheme from material
// Shows Theme widget with different ThemeData configurations
import 'package:flutter/material.dart';

// Helper to build a section header
Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.teal.shade700,
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

// Helper to build a themed sample card
Widget buildThemedSampleCard(
  ThemeData theme,
  String themeName,
  String description,
) {
  return Theme(
    data: theme,
    child: Builder(
      builder: (BuildContext ctx) {
        return Card(
          elevation: 4,
          margin: EdgeInsets.symmetric(vertical: 8),
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Theme.of(ctx).colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      themeName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(ctx).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                ),
                Divider(),
                Row(
                  children: [
                    ElevatedButton(onPressed: () {}, child: Text('Elevated')),
                    SizedBox(width: 8),
                    OutlinedButton(onPressed: () {}, child: Text('Outlined')),
                    SizedBox(width: 8),
                    TextButton(onPressed: () {}, child: Text('Text')),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Chip(label: Text('Chip 1')),
                    SizedBox(width: 8),
                    Chip(
                      label: Text('Chip 2'),
                      avatar: CircleAvatar(
                        backgroundColor: Theme.of(ctx).colorScheme.primary,
                        child: Text(
                          '2',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                LinearProgressIndicator(value: 0.6),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.star, color: Theme.of(ctx).colorScheme.primary),
                    Icon(Icons.star, color: Theme.of(ctx).colorScheme.primary),
                    Icon(Icons.star, color: Theme.of(ctx).colorScheme.primary),
                    Icon(
                      Icons.star_half,
                      color: Theme.of(ctx).colorScheme.primary,
                    ),
                    Icon(
                      Icons.star_border,
                      color: Theme.of(ctx).colorScheme.primary,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}

// Helper to build a color palette display
Widget buildColorPalette(String label, ColorScheme scheme) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 6),
        Row(
          children: [
            buildColorSwatch('Primary', scheme.primary, scheme.onPrimary),
            SizedBox(width: 4),
            buildColorSwatch('Secondary', scheme.secondary, scheme.onSecondary),
            SizedBox(width: 4),
            buildColorSwatch('Tertiary', scheme.tertiary, scheme.onTertiary),
            SizedBox(width: 4),
            buildColorSwatch('Error', scheme.error, scheme.onError),
          ],
        ),
        SizedBox(height: 4),
        Row(
          children: [
            buildColorSwatch('Surface', scheme.surface, scheme.onSurface),
            SizedBox(width: 4),
            buildColorSwatch(
              'PrimCont',
              scheme.primaryContainer,
              scheme.onPrimaryContainer,
            ),
            SizedBox(width: 4),
            buildColorSwatch(
              'SecCont',
              scheme.secondaryContainer,
              scheme.onSecondaryContainer,
            ),
            SizedBox(width: 4),
            buildColorSwatch(
              'TerCont',
              scheme.tertiaryContainer,
              scheme.onTertiaryContainer,
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildColorSwatch(String label, Color bg, Color fg) {
  return Expanded(
    child: Container(
      height: 48,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(fontSize: 9, color: fg, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}

// Helper to build a typography sample
Widget buildTypographySample(ThemeData theme, String themeName) {
  TextTheme textTheme = theme.textTheme;
  return Theme(
    data: theme,
    child: Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$themeName Typography',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            Divider(),
            Text(
              'Display Large',
              style: textTheme.displayLarge?.copyWith(fontSize: 28),
            ),
            Text('Headline Medium', style: textTheme.headlineMedium),
            Text('Title Large', style: textTheme.titleLarge),
            Text('Body Large - Regular body text', style: textTheme.bodyLarge),
            Text(
              'Body Medium - Default text styling',
              style: textTheme.bodyMedium,
            ),
            Text('Label Large - For buttons', style: textTheme.labelLarge),
            Text('Body Small - Fine print', style: textTheme.bodySmall),
          ],
        ),
      ),
    ),
  );
}

// Helper to build animated theme transition visualization
Widget buildTransitionVisualization(
  ThemeData fromTheme,
  ThemeData toTheme,
  String fromLabel,
  String toLabel,
) {
  Color fromColor = fromTheme.colorScheme.primary;
  Color toColor = toTheme.colorScheme.primary;

  List<double> steps = [0.0, 0.2, 0.4, 0.6, 0.8, 1.0];

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$fromLabel -> $toLabel',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: steps.map((step) {
            Color lerpedColor =
                Color.lerp(fromColor, toColor, step) ?? fromColor;
            return Column(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: lerpedColor,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: lerpedColor.withAlpha(80),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(Icons.palette, color: Colors.white, size: 20),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '${(step * 100).toInt()}%',
                  style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
                ),
              ],
            );
          }).toList(),
        ),
        SizedBox(height: 8),
        Container(
          height: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            gradient: LinearGradient(colors: [fromColor, toColor]),
          ),
        ),
      ],
    ),
  );
}

// Helper to build component showcase within theme
Widget buildComponentShowcase(ThemeData theme, String themeName) {
  return Theme(
    data: theme,
    child: Builder(
      builder: (BuildContext ctx) {
        return Card(
          elevation: 3,
          margin: EdgeInsets.symmetric(vertical: 8),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$themeName Components',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(ctx).colorScheme.primary,
                  ),
                ),
                Divider(),
                Row(
                  children: [
                    Switch(value: true, onChanged: (v) {}),
                    Switch(value: false, onChanged: (v) {}),
                    Checkbox(value: true, onChanged: (v) {}),
                    Checkbox(value: false, onChanged: (v) {}),
                    RadioGroup(
                      groupValue: 1,
                      onChanged: (int? v) {},
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [Radio(value: 1), Radio(value: 2)],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Slider(value: 0.7, onChanged: (v) {}),
                SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Sample input',
                    hintText: 'Type here...',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.edit),
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    FloatingActionButton.small(
                      onPressed: () {},
                      heroTag: '${themeName}_fab',
                      child: Icon(Icons.add),
                    ),
                    SizedBox(width: 12),
                    FloatingActionButton.extended(
                      onPressed: () {},
                      heroTag: '${themeName}_fab_ext',
                      label: Text('Extended'),
                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}

// Helper to build a mini theme preview card
Widget buildMiniPreview(ThemeData theme, String name) {
  return Container(
    width: 120,
    margin: EdgeInsets.only(right: 8),
    child: Theme(
      data: theme,
      child: Builder(
        builder: (BuildContext ctx) {
          return Card(
            elevation: 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Theme.of(ctx).colorScheme.primary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Theme.of(ctx).colorScheme.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Theme.of(ctx).colorScheme.secondary,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Theme.of(ctx).colorScheme.tertiary,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Container(
                        height: 4,
                        color: Theme.of(ctx).colorScheme.primary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ),
  );
}

dynamic build(BuildContext context) {
  debugPrint('=== AnimatedTheme Test Script ===');
  debugPrint('Testing AnimatedTheme with different ThemeData configurations');

  ThemeData blueTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
    useMaterial3: true,
  );
  debugPrint('Created blue theme');

  ThemeData greenTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
    useMaterial3: true,
  );
  debugPrint('Created green theme');

  ThemeData purpleTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
    useMaterial3: true,
  );
  debugPrint('Created purple theme');

  ThemeData orangeTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
    useMaterial3: true,
  );
  debugPrint('Created orange theme');

  ThemeData redTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
    useMaterial3: true,
  );
  debugPrint('Created red theme');

  ThemeData tealTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
    useMaterial3: true,
  );
  debugPrint('Created teal theme');

  ThemeData darkBlueTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
    brightness: Brightness.dark,
  );
  debugPrint('Created dark blue theme');

  ThemeData darkPurpleTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.purple,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
    brightness: Brightness.dark,
  );
  debugPrint('Created dark purple theme');

  debugPrint('Building AnimatedTheme demonstrations...');

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
              colors: [Colors.teal.shade700, Colors.cyan.shade600],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'AnimatedTheme Demo',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Theme transitions and ThemeData configurations',
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
            ],
          ),
        ),

        // Section 1: Mini Theme Previews
        buildSectionHeader('1. Theme Quick Previews'),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              buildMiniPreview(blueTheme, 'Blue'),
              buildMiniPreview(greenTheme, 'Green'),
              buildMiniPreview(purpleTheme, 'Purple'),
              buildMiniPreview(orangeTheme, 'Orange'),
              buildMiniPreview(redTheme, 'Red'),
              buildMiniPreview(tealTheme, 'Teal'),
            ],
          ),
        ),

        // Section 2: Full Theme Cards
        buildSectionHeader('2. Theme Sample Cards'),
        buildThemedSampleCard(
          blueTheme,
          'Blue Theme',
          'M3 theme from blue seed color',
        ),
        buildThemedSampleCard(
          greenTheme,
          'Green Theme',
          'M3 theme from green seed color',
        ),
        buildThemedSampleCard(
          purpleTheme,
          'Purple Theme',
          'M3 theme from purple seed color',
        ),
        buildThemedSampleCard(
          orangeTheme,
          'Orange Theme',
          'M3 theme from orange seed color',
        ),

        // Section 3: Color Palettes
        buildSectionHeader('3. Color Scheme Palettes'),
        buildColorPalette('Blue Theme Colors', blueTheme.colorScheme),
        buildColorPalette('Green Theme Colors', greenTheme.colorScheme),
        buildColorPalette('Purple Theme Colors', purpleTheme.colorScheme),
        buildColorPalette('Orange Theme Colors', orangeTheme.colorScheme),
        buildColorPalette('Red Theme Colors', redTheme.colorScheme),
        buildColorPalette('Teal Theme Colors', tealTheme.colorScheme),

        // Section 4: Transition Visualization
        buildSectionHeader('4. Theme Transition Steps'),
        buildTransitionVisualization(blueTheme, greenTheme, 'Blue', 'Green'),
        buildTransitionVisualization(
          purpleTheme,
          orangeTheme,
          'Purple',
          'Orange',
        ),
        buildTransitionVisualization(redTheme, tealTheme, 'Red', 'Teal'),
        buildTransitionVisualization(blueTheme, purpleTheme, 'Blue', 'Purple'),

        // Section 5: Typography Samples
        buildSectionHeader('5. Typography Per Theme'),
        buildTypographySample(blueTheme, 'Blue'),
        buildTypographySample(purpleTheme, 'Purple'),

        // Section 6: Component Showcase
        buildSectionHeader('6. Component Showcase Per Theme'),
        buildComponentShowcase(blueTheme, 'Blue'),
        buildComponentShowcase(greenTheme, 'Green'),
        buildComponentShowcase(purpleTheme, 'Purple'),

        // Section 7: Dark Themes
        buildSectionHeader('7. Dark Theme Variants'),
        buildThemedSampleCard(
          darkBlueTheme,
          'Dark Blue',
          'Dark mode with blue accent',
        ),
        buildThemedSampleCard(
          darkPurpleTheme,
          'Dark Purple',
          'Dark mode with purple accent',
        ),
        buildColorPalette('Dark Blue Colors', darkBlueTheme.colorScheme),
        buildColorPalette('Dark Purple Colors', darkPurpleTheme.colorScheme),

        // Section 8: AnimatedTheme wrapping
        buildSectionHeader('8. AnimatedTheme Widget Wrapping'),
        AnimatedTheme(
          data: blueTheme,
          duration: Duration(milliseconds: 500),
          child: Builder(
            builder: (BuildContext ctx) {
              return Container(
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(ctx).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Wrapped in AnimatedTheme (Blue)',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(ctx).colorScheme.onPrimaryContainer,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'This container uses colors from the AnimatedTheme. '
                      'When the ThemeData changes, all themed widgets animate smoothly.',
                      style: TextStyle(
                        color: Theme.of(ctx).colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        AnimatedTheme(
          data: greenTheme,
          duration: Duration(milliseconds: 500),
          child: Builder(
            builder: (BuildContext ctx) {
              return Container(
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(ctx).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Wrapped in AnimatedTheme (Green)',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(ctx).colorScheme.onPrimaryContainer,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'With a 500ms duration, theme transitions are smooth and visually pleasing.',
                      style: TextStyle(
                        color: Theme.of(ctx).colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        AnimatedTheme(
          data: purpleTheme,
          duration: Duration(milliseconds: 800),
          curve: Curves.easeInOut,
          child: Builder(
            builder: (BuildContext ctx) {
              return Container(
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(ctx).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Wrapped in AnimatedTheme (Purple, easeInOut)',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(ctx).colorScheme.onPrimaryContainer,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'This variant uses Curves.easeInOut with 800ms duration.',
                      style: TextStyle(
                        color: Theme.of(ctx).colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        SizedBox(height: 32),
        Center(
          child: Text(
            'End of AnimatedTheme Demo',
            style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
          ),
        ),
        SizedBox(height: 16),
      ],
    ),
  );
}
