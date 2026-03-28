// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Typography from material
// Deep Demo: Visual demonstration of Material Design typography system
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Typography Deep Demo executing');

  // Get the current theme's text theme for demonstrations
  final textTheme = Theme.of(context).textTheme;
  print('TextTheme retrieved from context');

  // ============================================================
  // SECTION 1: Typography Overview
  // ============================================================
  print('=== Section 1: Typography Overview ===');

  final overviewCard = Container(
    margin: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withValues(alpha: 0.15),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple.shade400, Colors.deepPurple.shade600],
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.text_fields, color: Colors.white, size: 28.0),
              SizedBox(width: 12.0),
              Text(
                'Material Typography System',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Typography in Material Design provides a hierarchy of text styles '
                'that work together for readability and visual harmony. The Typography '
                'class defines text styles for different platforms and size categories.',
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.grey.shade700,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.deepPurple.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Typography Categories:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple.shade700,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    _buildCategoryRow('Display', 'Large, dramatic headers'),
                    _buildCategoryRow('Headline', 'Section headers'),
                    _buildCategoryRow('Title', 'Card and dialog titles'),
                    _buildCategoryRow('Body', 'Main content text'),
                    _buildCategoryRow('Label', 'Buttons, captions, overlines'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created overview card');

  // ============================================================
  // SECTION 2: Display Styles
  // ============================================================
  print('=== Section 2: Display Styles ===');

  final displayStyles = Container(
    margin: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withValues(alpha: 0.15),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.format_size, color: Colors.blue, size: 24.0),
              SizedBox(width: 12.0),
              Text(
                'Display Styles',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Display styles are the largest text styles, typically used for '
                'hero sections and dramatic visual statements.',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade600,
                ),
              ),
              SizedBox(height: 20.0),

              // Display Large
              _buildTextStyleDemo(
                label: 'displayLarge',
                sampleText: 'Display',
                style: textTheme.displayLarge,
                description: '57sp, for hero text and landing pages',
              ),
              Divider(height: 32.0),

              // Display Medium
              _buildTextStyleDemo(
                label: 'displayMedium',
                sampleText: 'Display Medium',
                style: textTheme.displayMedium,
                description: '45sp, prominent headers',
              ),
              Divider(height: 32.0),

              // Display Small
              _buildTextStyleDemo(
                label: 'displaySmall',
                sampleText: 'Display Small Style',
                style: textTheme.displaySmall,
                description: '36sp, smaller display text',
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created display styles card');

  // ============================================================
  // SECTION 3: Headline Styles
  // ============================================================
  print('=== Section 3: Headline Styles ===');

  final headlineStyles = Container(
    margin: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withValues(alpha: 0.15),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.title, color: Colors.green, size: 24.0),
              SizedBox(width: 12.0),
              Text(
                'Headline Styles',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade900,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Headline styles are used for section headers and prominent titles. '
                'They create visual hierarchy in content-heavy screens.',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade600,
                ),
              ),
              SizedBox(height: 20.0),

              // Headline Large
              _buildTextStyleDemo(
                label: 'headlineLarge',
                sampleText: 'Headline Large',
                style: textTheme.headlineLarge,
                description: '32sp, page titles',
              ),
              Divider(height: 32.0),

              // Headline Medium
              _buildTextStyleDemo(
                label: 'headlineMedium',
                sampleText: 'Headline Medium',
                style: textTheme.headlineMedium,
                description: '28sp, section headers',
              ),
              Divider(height: 32.0),

              // Headline Small
              _buildTextStyleDemo(
                label: 'headlineSmall',
                sampleText: 'Headline Small',
                style: textTheme.headlineSmall,
                description: '24sp, subsection headers',
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created headline styles card');

  // ============================================================
  // SECTION 4: Title Styles
  // ============================================================
  print('=== Section 4: Title Styles ===');

  final titleStyles = Container(
    margin: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withValues(alpha: 0.15),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.subtitles, color: Colors.orange, size: 24.0),
              SizedBox(width: 12.0),
              Text(
                'Title Styles',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange.shade900,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Title styles are used for card titles, dialog titles, and AppBar '
                'titles. They provide medium emphasis in the visual hierarchy.',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade600,
                ),
              ),
              SizedBox(height: 20.0),

              // Title Large
              _buildTextStyleDemo(
                label: 'titleLarge',
                sampleText: 'Title Large Style',
                style: textTheme.titleLarge,
                description: '22sp, AppBar titles, dialog headers',
              ),
              Divider(height: 32.0),

              // Title Medium
              _buildTextStyleDemo(
                label: 'titleMedium',
                sampleText: 'Title Medium Style',
                style: textTheme.titleMedium,
                description: '16sp, card titles, list tile titles',
              ),
              Divider(height: 32.0),

              // Title Small
              _buildTextStyleDemo(
                label: 'titleSmall',
                sampleText: 'Title Small Style',
                style: textTheme.titleSmall,
                description: '14sp, tab labels, navigation rail',
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created title styles card');

  // ============================================================
  // SECTION 5: Body Styles
  // ============================================================
  print('=== Section 5: Body Styles ===');

  final bodyStyles = Container(
    margin: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withValues(alpha: 0.15),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.teal.shade50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.article, color: Colors.teal, size: 24.0),
              SizedBox(width: 12.0),
              Text(
                'Body Styles',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade900,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Body styles are used for main content text, long-form reading, '
                'and descriptions. Optimized for readability at smaller sizes.',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade600,
                ),
              ),
              SizedBox(height: 20.0),

              // Body Large
              _buildTextStyleDemo(
                label: 'bodyLarge',
                sampleText: 'Body Large text for longer paragraphs and main content that requires comfortable reading at desktop sizes.',
                style: textTheme.bodyLarge,
                description: '16sp, primary paragraph text',
              ),
              Divider(height: 32.0),

              // Body Medium
              _buildTextStyleDemo(
                label: 'bodyMedium',
                sampleText: 'Body Medium is the default body style used throughout most Material components and general content.',
                style: textTheme.bodyMedium,
                description: '14sp, default body text',
              ),
              Divider(height: 32.0),

              // Body Small
              _buildTextStyleDemo(
                label: 'bodySmall',
                sampleText: 'Body Small is used for annotations, footnotes, timestamps, and secondary information that supports the main content.',
                style: textTheme.bodySmall,
                description: '12sp, captions, timestamps',
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created body styles card');

  // ============================================================
  // SECTION 6: Label Styles
  // ============================================================
  print('=== Section 6: Label Styles ===');

  final labelStyles = Container(
    margin: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withValues(alpha: 0.15),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.pink.shade50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.label, color: Colors.pink, size: 24.0),
              SizedBox(width: 12.0),
              Text(
                'Label Styles',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink.shade900,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Label styles are used for buttons, chips, form labels, and navigation. '
                'They are designed to be legible at very small sizes.',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade600,
                ),
              ),
              SizedBox(height: 20.0),

              // Label Large
              _buildTextStyleDemo(
                label: 'labelLarge',
                sampleText: 'LABEL LARGE',
                style: textTheme.labelLarge,
                description: '14sp, button text, prominent labels',
              ),
              Divider(height: 32.0),

              // Label Medium
              _buildTextStyleDemo(
                label: 'labelMedium',
                sampleText: 'LABEL MEDIUM',
                style: textTheme.labelMedium,
                description: '12sp, navigation labels, chip text',
              ),
              Divider(height: 32.0),

              // Label Small
              _buildTextStyleDemo(
                label: 'labelSmall',
                sampleText: 'LABEL SMALL',
                style: textTheme.labelSmall,
                description: '11sp, tiny labels, badges',
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created label styles card');

  // ============================================================
  // SECTION 7: Typography in Context
  // ============================================================
  print('=== Section 7: Typography in Context ===');

  final articleCard = Container(
    margin: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withValues(alpha: 0.2),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Article image placeholder
        Container(
          width: double.infinity,
          height: 160.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo.shade300, Colors.purple.shade300],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Center(
            child: Icon(Icons.image, color: Colors.white54, size: 48.0),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category label
              Text(
                'TECHNOLOGY',
                style: textTheme.labelSmall?.copyWith(
                  color: Colors.indigo,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: 8.0),

              // Article title
              Text(
                'The Future of Mobile Development',
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),

              // Subtitle
              Text(
                'How Flutter is changing the way we build apps',
                style: textTheme.titleMedium?.copyWith(
                  color: Colors.grey.shade600,
                ),
              ),
              SizedBox(height: 16.0),

              // Body text
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
                'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.',
                style: textTheme.bodyMedium?.copyWith(
                  height: 1.5,
                ),
              ),
              SizedBox(height: 16.0),

              // Author and date
              Row(
                children: [
                  CircleAvatar(
                    radius: 16.0,
                    backgroundColor: Colors.indigo.shade100,
                    child: Icon(Icons.person, color: Colors.indigo, size: 18.0),
                  ),
                  SizedBox(width: 8.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'John Developer',
                        style: textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Mar 28, 2025 • 5 min read',
                        style: textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // Profile card example
  final profileCard = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withValues(alpha: 0.15),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Row(
      children: [
        CircleAvatar(
          radius: 32.0,
          backgroundColor: Colors.amber.shade100,
          child: Icon(Icons.person, color: Colors.amber.shade700, size: 32.0),
        ),
        SizedBox(width: 16.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sarah Johnson',
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                'Senior Flutter Developer',
                style: textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade600,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                '@sarahj • San Francisco, CA',
                style: textTheme.bodySmall?.copyWith(
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Text(
            'Follow',
            style: textTheme.labelMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
  print('Created context examples');

  // ============================================================
  // SECTION 8: Typography Scale Reference
  // ============================================================
  print('=== Section 8: Typography Scale Reference ===');

  final scaleItems = [
    {'name': 'displayLarge', 'size': 57.0, 'weight': 'Regular', 'tracking': -0.25},
    {'name': 'displayMedium', 'size': 45.0, 'weight': 'Regular', 'tracking': 0.0},
    {'name': 'displaySmall', 'size': 36.0, 'weight': 'Regular', 'tracking': 0.0},
    {'name': 'headlineLarge', 'size': 32.0, 'weight': 'Regular', 'tracking': 0.0},
    {'name': 'headlineMedium', 'size': 28.0, 'weight': 'Regular', 'tracking': 0.0},
    {'name': 'headlineSmall', 'size': 24.0, 'weight': 'Regular', 'tracking': 0.0},
    {'name': 'titleLarge', 'size': 22.0, 'weight': 'Regular', 'tracking': 0.0},
    {'name': 'titleMedium', 'size': 16.0, 'weight': 'Medium', 'tracking': 0.15},
    {'name': 'titleSmall', 'size': 14.0, 'weight': 'Medium', 'tracking': 0.1},
    {'name': 'bodyLarge', 'size': 16.0, 'weight': 'Regular', 'tracking': 0.5},
    {'name': 'bodyMedium', 'size': 14.0, 'weight': 'Regular', 'tracking': 0.25},
    {'name': 'bodySmall', 'size': 12.0, 'weight': 'Regular', 'tracking': 0.4},
    {'name': 'labelLarge', 'size': 14.0, 'weight': 'Medium', 'tracking': 0.1},
    {'name': 'labelMedium', 'size': 12.0, 'weight': 'Medium', 'tracking': 0.5},
    {'name': 'labelSmall', 'size': 11.0, 'weight': 'Medium', 'tracking': 0.5},
  ];

  final scaleRows = <Widget>[];
  for (final item in scaleItems) {
    scaleRows.add(
      Container(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade200),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                item['name'] as String,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey.shade800,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                '${(item['size'] as double).toStringAsFixed(0)}sp',
                style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                item['weight'] as String,
                style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                '${item['tracking']}',
                style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final scaleCard = Container(
    margin: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withValues(alpha: 0.15),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.straighten, color: Colors.blueGrey, size: 24.0),
              SizedBox(width: 12.0),
              Text(
                'Typography Scale Reference',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey.shade900,
                ),
              ),
            ],
          ),
        ),
        // Header row
        Container(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          color: Colors.grey.shade100,
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  'Style',
                  style: TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'Size',
                  style: TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'Weight',
                  style: TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'Track',
                  style: TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ],
          ),
        ),
        ...scaleRows,
      ],
    ),
  );

  // Platform options
  final platformCard = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.cyan.shade50,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.cyan.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.devices, color: Colors.cyan.shade700, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Platform Typography',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.cyan.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'Typography class provides platform-specific factory constructors:',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            _buildPlatformChip('Typography.material2014()'),
            _buildPlatformChip('Typography.material2018()'),
            _buildPlatformChip('Typography.material2021()'),
            _buildPlatformChip('Typography.englishLike2014'),
            _buildPlatformChip('Typography.englishLike2018'),
            _buildPlatformChip('Typography.englishLike2021'),
          ],
        ),
      ],
    ),
  );
  print('Created scale card');

  // ============================================================
  // Final Layout Assembly
  // ============================================================
  print('Typography Deep Demo completed successfully');

  return SingleChildScrollView(
    child: Column(
      children: <Widget>[
        // Header
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.indigo],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              Icon(Icons.text_fields, color: Colors.white, size: 48.0),
              SizedBox(height: 16.0),
              Text(
                'Typography Deep Demo',
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [Shadow(color: Colors.black38, blurRadius: 4.0)],
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Material Design text style system',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),

        // Section 1: Overview
        SizedBox(height: 24.0),
        _buildSectionHeader('Section 1: Overview', Icons.info_outline),
        overviewCard,

        // Section 2: Display
        SizedBox(height: 24.0),
        _buildSectionHeader('Section 2: Display Styles', Icons.format_size),
        displayStyles,

        // Section 3: Headline
        SizedBox(height: 24.0),
        _buildSectionHeader('Section 3: Headline Styles', Icons.title),
        headlineStyles,

        // Section 4: Title
        SizedBox(height: 24.0),
        _buildSectionHeader('Section 4: Title Styles', Icons.subtitles),
        titleStyles,

        // Section 5: Body
        SizedBox(height: 24.0),
        _buildSectionHeader('Section 5: Body Styles', Icons.article),
        bodyStyles,

        // Section 6: Label
        SizedBox(height: 24.0),
        _buildSectionHeader('Section 6: Label Styles', Icons.label),
        labelStyles,

        // Section 7: Context
        SizedBox(height: 24.0),
        _buildSectionHeader('Section 7: Real-World Examples', Icons.preview),
        articleCard,
        profileCard,

        // Section 8: Scale Reference
        SizedBox(height: 24.0),
        _buildSectionHeader('Section 8: Scale Reference', Icons.straighten),
        platformCard,
        scaleCard,

        SizedBox(height: 32.0),
      ],
    ),
  );
}

// Helper: Build section header
Widget _buildSectionHeader(String title, IconData icon) {
  print('Section: $title');
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    child: Row(
      children: [
        Icon(icon, color: Colors.grey.shade700),
        SizedBox(width: 8.0),
        Text(
          title,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
      ],
    ),
  );
}

// Helper: Build category row
Widget _buildCategoryRow(String name, String description) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.chevron_right, size: 16.0, color: Colors.deepPurple.shade400),
        SizedBox(width: 4.0),
        Text(
          '$name: ',
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple.shade700,
          ),
        ),
        Expanded(
          child: Text(
            description,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.grey.shade600,
            ),
          ),
        ),
      ],
    ),
  );
}

// Helper: Build text style demo
Widget _buildTextStyleDemo({
  required String label,
  required String sampleText,
  required TextStyle? style,
  required String description,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: Text(
              description,
              style: TextStyle(
                fontSize: 11.0,
                color: Colors.grey.shade500,
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 8.0),
      Text(sampleText, style: style),
    ],
  );
}

// Helper: Build platform chip
Widget _buildPlatformChip(String label) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: Colors.cyan.shade100,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.cyan.shade300),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 10.0,
        fontWeight: FontWeight.w500,
        color: Colors.cyan.shade900,
      ),
    ),
  );
}
