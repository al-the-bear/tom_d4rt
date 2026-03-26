// ignore_for_file: avoid_print
// ============================================================================
// ListTileTitleAlignment Deep Demo
// ============================================================================
//
// This demo comprehensively demonstrates the ListTileTitleAlignment enum,
// which controls how the title and leading/trailing widgets are vertically
// aligned within a ListTile.
//
// ListTileTitleAlignment has three values:
//
// 1. **threeLine** - Positions title at the top, designed for ListTiles with
//    isThreeLine: true. The title, subtitle, and leading/trailing align to top.
//
// 2. **titleHeight** - The default alignment. Title is centered relative to
//    the first line of the subtitle height. Leading/trailing are centered
//    relative to the entire tile height.
//
// 3. **top** - Forces all content (title, leading, trailing) to align to
//    the very top of the ListTile, regardless of content height.
//
// Understanding these alignments is crucial for creating visually balanced
// list interfaces, especially when mixing tiles with varying content lengths.
//
// ============================================================================

import 'package:flutter/material.dart';

/// Main build function that creates the ListTileTitleAlignment demonstration
dynamic build(BuildContext context) {
  print('═══════════════════════════════════════════════════════════════════');
  print('  ListTileTitleAlignment Deep Demo');
  print('═══════════════════════════════════════════════════════════════════');
  print('');
  print('This demo shows how ListTileTitleAlignment affects vertical');
  print('positioning of title, subtitle, leading, and trailing widgets.');
  print('');

  return MaterialApp(
    title: 'ListTileTitleAlignment Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      useMaterial3: true,
    ),
    home: const ListTileTitleAlignmentShowcase(),
  );
}

/// Main showcase widget containing all demo sections
class ListTileTitleAlignmentShowcase extends StatelessWidget {
  const ListTileTitleAlignmentShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ListTileTitleAlignment'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Introduction section
            _buildIntroductionSection(context),
            const SizedBox(height: 24),

            // The three alignment values comparison
            _buildAlignmentComparisonSection(context),
            const SizedBox(height: 24),

            // Single-line tile alignment demo
            _buildSingleLineTileSection(context),
            const SizedBox(height: 24),

            // Two-line tile alignment demo
            _buildTwoLineTileSection(context),
            const SizedBox(height: 24),

            // Three-line tile alignment demo
            _buildThreeLineTileSection(context),
            const SizedBox(height: 24),

            // Leading widget alignment visualization
            _buildLeadingWidgetSection(context),
            const SizedBox(height: 24),

            // Trailing widget alignment visualization
            _buildTrailingWidgetSection(context),
            const SizedBox(height: 24),

            // Mixed content height scenarios
            _buildMixedContentSection(context),
            const SizedBox(height: 24),

            // Contact list real-world example
            _buildContactListExample(context),
            const SizedBox(height: 24),

            // Settings page real-world example
            _buildSettingsPageExample(context),
            const SizedBox(height: 24),

            // File browser real-world example
            _buildFileBrowserExample(context),
            const SizedBox(height: 24),

            // Interactive comparison section
            _buildInteractiveComparison(context),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  /// Builds the introduction section explaining ListTileTitleAlignment
  Widget _buildIntroductionSection(BuildContext context) {
    print('Building Introduction Section...');

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: Theme.of(context).colorScheme.primary,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Text(
                  'What is ListTileTitleAlignment?',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ListTileTitleAlignment is an enum that controls the vertical '
                    'alignment of a ListTile\'s title, leading widget, and trailing '
                    'widget relative to the overall tile height.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'This becomes especially important when:',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildBulletPoint(context, 'Tiles have multi-line subtitles'),
                  _buildBulletPoint(
                    context,
                    'Leading icons need specific positioning',
                  ),
                  _buildBulletPoint(context, 'Trailing widgets vary in height'),
                  _buildBulletPoint(
                    context,
                    'Creating visually consistent lists',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Visual representation of enum values
            Row(
              children: [
                Expanded(
                  child: _buildEnumValueCard(
                    context,
                    'threeLine',
                    'Top-aligned for 3-line tiles',
                    Icons.vertical_align_top,
                    Colors.orange,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildEnumValueCard(
                    context,
                    'titleHeight',
                    'Default centered alignment',
                    Icons.vertical_align_center,
                    Colors.blue,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildEnumValueCard(
                    context,
                    'top',
                    'Force top alignment',
                    Icons.align_vertical_top,
                    Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Helper to build bullet points
  Widget _buildBulletPoint(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  /// Helper to build enum value cards
  Widget _buildEnumValueCard(
    BuildContext context,
    String value,
    String description,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10, color: color.withValues(alpha: 0.8)),
          ),
        ],
      ),
    );
  }

  /// Builds the alignment comparison section showing all three values side by side
  Widget _buildAlignmentComparisonSection(BuildContext context) {
    print('Building Alignment Comparison Section...');

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(context, 'Alignment Comparison', Icons.compare),
            const SizedBox(height: 16),
            Text(
              'Compare how each alignment value affects a ListTile with the same '
              'content but different titleAlignment settings:',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),

            // threeLine alignment
            _buildAlignmentDemo(
              context,
              'ListTileTitleAlignment.threeLine',
              ListTileTitleAlignment.threeLine,
              Colors.orange,
              'Title and leading/trailing align to the top. '
                  'Designed for isThreeLine: true ListTiles.',
            ),
            const SizedBox(height: 12),

            // titleHeight alignment (default)
            _buildAlignmentDemo(
              context,
              'ListTileTitleAlignment.titleHeight (Default)',
              ListTileTitleAlignment.titleHeight,
              Colors.blue,
              'Title centered to first subtitle line height. '
                  'Leading/trailing centered to full tile.',
            ),
            const SizedBox(height: 12),

            // top alignment
            _buildAlignmentDemo(
              context,
              'ListTileTitleAlignment.top',
              ListTileTitleAlignment.top,
              Colors.green,
              'All content forced to top alignment. '
                  'Useful for consistent top positioning.',
            ),
          ],
        ),
      ),
    );
  }

  /// Helper to build individual alignment demos
  Widget _buildAlignmentDemo(
    BuildContext context,
    String label,
    ListTileTitleAlignment alignment,
    Color accentColor,
    String description,
  ) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: accentColor.withValues(alpha: 0.5), width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.15),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10),
              ),
            ),
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: accentColor,
                fontFamily: 'monospace',
              ),
            ),
          ),
          ListTile(
            titleAlignment: alignment,
            leading: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: accentColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.person, color: accentColor),
            ),
            title: const Text('John Doe'),
            subtitle: const Text(
              'Software Engineer\n'
              'San Francisco, CA\n'
              'Available for projects',
            ),
            isThreeLine: true,
            trailing: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.star, color: accentColor, size: 20),
                Text(
                  '4.9',
                  style: TextStyle(
                    fontSize: 12,
                    color: accentColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(10),
              ),
            ),
            child: Text(
              description,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the single-line tile alignment section
  Widget _buildSingleLineTileSection(BuildContext context) {
    print('Building Single-Line Tile Section...');

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(context, 'Single-Line Tiles', Icons.short_text),
            const SizedBox(height: 8),
            Text(
              'With single-line ListTiles, alignment differences are minimal '
              'since there is no subtitle. However, leading/trailing positions '
              'may still vary.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),

            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _buildLabeledListTile(
                    context,
                    'threeLine',
                    ListTileTitleAlignment.threeLine,
                    hasSubtitle: false,
                  ),
                  const Divider(height: 1),
                  _buildLabeledListTile(
                    context,
                    'titleHeight',
                    ListTileTitleAlignment.titleHeight,
                    hasSubtitle: false,
                  ),
                  const Divider(height: 1),
                  _buildLabeledListTile(
                    context,
                    'top',
                    ListTileTitleAlignment.top,
                    hasSubtitle: false,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.amber.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.amber.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.lightbulb_outline, color: Colors.amber),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'For single-line tiles, the default titleHeight is usually '
                      'the best choice as it centers content naturally.',
                      style: Theme.of(context).textTheme.bodySmall,
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

  /// Helper to build labeled ListTiles for comparison
  Widget _buildLabeledListTile(
    BuildContext context,
    String alignmentName,
    ListTileTitleAlignment alignment, {
    bool hasSubtitle = true,
    int subtitleLines = 2,
  }) {
    final subtitleText = subtitleLines == 1
        ? 'Single line subtitle text'
        : subtitleLines == 2
        ? 'Two line subtitle text\nwith additional information'
        : 'Three line subtitle text\nwith more details\nand extra information';

    return ListTile(
      titleAlignment: alignment,
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        child: Icon(
          Icons.account_circle,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      title: Text('Title ($alignmentName)'),
      subtitle: hasSubtitle ? Text(subtitleText) : null,
      isThreeLine: subtitleLines >= 3,
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    );
  }

  /// Builds the two-line tile alignment section
  Widget _buildTwoLineTileSection(BuildContext context) {
    print('Building Two-Line Tile Section...');

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(context, 'Two-Line Tiles', Icons.notes),
            const SizedBox(height: 8),
            Text(
              'Two-line ListTiles show more pronounced alignment differences. '
              'The titleHeight alignment centers title to the first subtitle line.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildCompactAlignmentCard(
                    context,
                    'threeLine',
                    ListTileTitleAlignment.threeLine,
                    Colors.orange,
                    subtitleLines: 1,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildCompactAlignmentCard(
                    context,
                    'titleHeight',
                    ListTileTitleAlignment.titleHeight,
                    Colors.blue,
                    subtitleLines: 1,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildCompactAlignmentCard(
                    context,
                    'top',
                    ListTileTitleAlignment.top,
                    Colors.green,
                    subtitleLines: 1,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Helper to build compact alignment cards
  Widget _buildCompactAlignmentCard(
    BuildContext context,
    String alignmentName,
    ListTileTitleAlignment alignment,
    Color color, {
    int subtitleLines = 2,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: color.withValues(alpha: 0.4)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(7),
              ),
            ),
            child: Center(
              child: Text(
                alignmentName,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
          ),
          ListTile(
            dense: true,
            titleAlignment: alignment,
            leading: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.folder, color: color, size: 20),
            ),
            title: const Text('Document', style: TextStyle(fontSize: 13)),
            subtitle: Text(
              subtitleLines == 1
                  ? 'Modified recently'
                  : 'Modified recently\n2.4 MB',
              style: const TextStyle(fontSize: 11),
            ),
            isThreeLine: subtitleLines > 2,
          ),
        ],
      ),
    );
  }

  /// Builds the three-line tile alignment section
  Widget _buildThreeLineTileSection(BuildContext context) {
    print('Building Three-Line Tile Section...');

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(context, 'Three-Line Tiles', Icons.subject),
            const SizedBox(height: 8),
            Text(
              'Three-line ListTiles (isThreeLine: true) show the most significant '
              'alignment differences. The threeLine alignment is specifically '
              'designed for these cases.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),

            // Show detailed three-line comparisons
            ...[
              (
                'threeLine (Recommended)',
                ListTileTitleAlignment.threeLine,
                Colors.orange,
              ),
              ('titleHeight', ListTileTitleAlignment.titleHeight, Colors.blue),
              ('top', ListTileTitleAlignment.top, Colors.green),
            ].map((entry) {
              return Column(
                children: [
                  _buildThreeLineDemo(context, entry.$1, entry.$2, entry.$3),
                  const SizedBox(height: 8),
                ],
              );
            }),

            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle_outline, color: Colors.green),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'For isThreeLine: true ListTiles, use ListTileTitleAlignment.threeLine '
                      'for optimal visual balance.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
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

  /// Helper to build three-line demos
  Widget _buildThreeLineDemo(
    BuildContext context,
    String label,
    ListTileTitleAlignment alignment,
    Color color,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: ListTile(
        titleAlignment: alignment,
        leading: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color, color.withValues(alpha: 0.6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.article, color: Colors.white),
        ),
        title: Text(
          'News Article ($label)',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: const Text(
          'This is an important news article with a longer '
          'description that spans multiple lines to demonstrate '
          'how the alignment affects the overall appearance.',
        ),
        isThreeLine: true,
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.bookmark_border, color: color),
            const SizedBox(height: 4),
            Text('5 min', style: TextStyle(fontSize: 10, color: color)),
          ],
        ),
      ),
    );
  }

  /// Builds the leading widget alignment visualization section
  Widget _buildLeadingWidgetSection(BuildContext context) {
    print('Building Leading Widget Section...');

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(
              context,
              'Leading Widget Alignment',
              Icons.arrow_back,
            ),
            const SizedBox(height: 8),
            Text(
              'The leading widget position is affected by titleAlignment. '
              'Notice how the icon position changes relative to the tile content.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),

            // Visual diagram showing leading positions
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _buildLeadingPositionVisual(
                    context,
                    'threeLine',
                    ListTileTitleAlignment.threeLine,
                    'Leading aligns to TOP of tile',
                    Colors.orange,
                  ),
                  const SizedBox(height: 12),
                  _buildLeadingPositionVisual(
                    context,
                    'titleHeight',
                    ListTileTitleAlignment.titleHeight,
                    'Leading CENTERS to tile height',
                    Colors.blue,
                  ),
                  const SizedBox(height: 12),
                  _buildLeadingPositionVisual(
                    context,
                    'top',
                    ListTileTitleAlignment.top,
                    'Leading aligns to TOP of tile',
                    Colors.green,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Helper to visualize leading positions
  Widget _buildLeadingPositionVisual(
    BuildContext context,
    String alignmentName,
    ListTileTitleAlignment alignment,
    String description,
    Color color,
  ) {
    return Row(
      children: [
        // Left indicator
        Container(
          width: 4,
          height: 80,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: color.withValues(alpha: 0.3)),
            ),
            child: ListTile(
              titleAlignment: alignment,
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: color, width: 2),
                ),
                child: Center(child: Icon(Icons.star, color: color, size: 20)),
              ),
              title: Text(
                alignmentName,
                style: TextStyle(color: color, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(description, style: const TextStyle(fontSize: 11)),
            ),
          ),
        ),
      ],
    );
  }

  /// Builds the trailing widget alignment visualization section
  Widget _buildTrailingWidgetSection(BuildContext context) {
    print('Building Trailing Widget Section...');

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(
              context,
              'Trailing Widget Alignment',
              Icons.arrow_forward,
            ),
            const SizedBox(height: 8),
            Text(
              'Trailing widgets also respond to titleAlignment. Large trailing '
              'widgets make alignment differences more visible.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),

            // Tiles with various trailing widgets
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _buildTrailingDemo(
                    context,
                    ListTileTitleAlignment.threeLine,
                    'threeLine',
                    Colors.orange,
                  ),
                  const Divider(height: 1),
                  _buildTrailingDemo(
                    context,
                    ListTileTitleAlignment.titleHeight,
                    'titleHeight',
                    Colors.blue,
                  ),
                  const Divider(height: 1),
                  _buildTrailingDemo(
                    context,
                    ListTileTitleAlignment.top,
                    'top',
                    Colors.green,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Helper to build trailing demos
  Widget _buildTrailingDemo(
    BuildContext context,
    ListTileTitleAlignment alignment,
    String label,
    Color color,
  ) {
    return ListTile(
      titleAlignment: alignment,
      leading: CircleAvatar(
        backgroundColor: color.withValues(alpha: 0.2),
        child: Icon(Icons.music_note, color: color),
      ),
      title: Text('Audio Track ($label)'),
      subtitle: const Text('Artist Name - Album Title\nDuration: 3:45'),
      isThreeLine: true,
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.play_circle_fill, color: color, size: 24),
            Text(
              'PLAY',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the mixed content section
  Widget _buildMixedContentSection(BuildContext context) {
    print('Building Mixed Content Section...');

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(context, 'Mixed Content Heights', Icons.height),
            const SizedBox(height: 8),
            Text(
              'When combining tiles with different content heights in a list, '
              'consistent titleAlignment helps maintain visual harmony.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),

            // Using threeLine for all
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      'Using threeLine alignment:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.orange.shade700,
                      ),
                    ),
                  ),
                  _buildMixedTile(
                    context,
                    ListTileTitleAlignment.threeLine,
                    1,
                    Colors.orange,
                  ),
                  _buildMixedTile(
                    context,
                    ListTileTitleAlignment.threeLine,
                    2,
                    Colors.orange,
                  ),
                  _buildMixedTile(
                    context,
                    ListTileTitleAlignment.threeLine,
                    3,
                    Colors.orange,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Using titleHeight for all
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      'Using titleHeight alignment:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ),
                  _buildMixedTile(
                    context,
                    ListTileTitleAlignment.titleHeight,
                    1,
                    Colors.blue,
                  ),
                  _buildMixedTile(
                    context,
                    ListTileTitleAlignment.titleHeight,
                    2,
                    Colors.blue,
                  ),
                  _buildMixedTile(
                    context,
                    ListTileTitleAlignment.titleHeight,
                    3,
                    Colors.blue,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Helper to build mixed tiles with varying content
  Widget _buildMixedTile(
    BuildContext context,
    ListTileTitleAlignment alignment,
    int lines,
    Color color,
  ) {
    final subtitles = [
      'Single line',
      'Two lines of\nsubtitle text',
      'Three lines of\nlonger subtitle\nwith more info',
    ];

    return ListTile(
      titleAlignment: alignment,
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            '$lines',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      ),
      title: Text('Item with $lines-line subtitle'),
      subtitle: Text(subtitles[lines - 1]),
      isThreeLine: lines >= 3,
      trailing: Icon(Icons.chevron_right, color: color),
    );
  }

  /// Builds the contact list real-world example
  Widget _buildContactListExample(BuildContext context) {
    print('Building Contact List Example...');

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(
              context,
              'Example: Contact List',
              Icons.contacts,
            ),
            const SizedBox(height: 8),
            Text(
              'A contact list application using titleHeight alignment for balanced '
              'appearance with profile photos and action buttons.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),

            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildContactTile(
                    context,
                    'Alice Johnson',
                    '+1 (555) 123-4567',
                    Colors.purple,
                    true,
                  ),
                  const Divider(height: 1),
                  _buildContactTile(
                    context,
                    'Bob Smith',
                    '+1 (555) 987-6543',
                    Colors.teal,
                    false,
                  ),
                  const Divider(height: 1),
                  _buildContactTile(
                    context,
                    'Carol Williams',
                    '+1 (555) 456-7890',
                    Colors.amber,
                    true,
                  ),
                  const Divider(height: 1),
                  _buildContactTile(
                    context,
                    'David Brown',
                    '+1 (555) 321-0987',
                    Colors.red,
                    false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Helper to build contact tiles
  Widget _buildContactTile(
    BuildContext context,
    String name,
    String phone,
    Color avatarColor,
    bool isFavorite,
  ) {
    return ListTile(
      titleAlignment: ListTileTitleAlignment.titleHeight,
      leading: CircleAvatar(
        backgroundColor: avatarColor.withValues(alpha: 0.2),
        child: Text(
          name[0],
          style: TextStyle(fontWeight: FontWeight.bold, color: avatarColor),
        ),
      ),
      title: Text(name),
      subtitle: Text(phone),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.star : Icons.star_border,
              color: isFavorite ? Colors.amber : Colors.grey,
            ),
            onPressed: () {
              print('Toggle favorite for $name');
            },
          ),
          IconButton(
            icon: const Icon(Icons.phone, color: Colors.green),
            onPressed: () {
              print('Call $name');
            },
          ),
        ],
      ),
    );
  }

  /// Builds the settings page real-world example
  Widget _buildSettingsPageExample(BuildContext context) {
    print('Building Settings Page Example...');

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(
              context,
              'Example: Settings Page',
              Icons.settings,
            ),
            const SizedBox(height: 8),
            Text(
              'A settings page demonstrating threeLine alignment for tiles '
              'with detailed descriptions that span multiple lines.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),

            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildSettingsTile(
                    context,
                    'Notifications',
                    'Enable push notifications for messages, '
                        'updates, and important alerts from the app.',
                    Icons.notifications_outlined,
                    true,
                  ),
                  const Divider(height: 1),
                  _buildSettingsTile(
                    context,
                    'Dark Mode',
                    'Switch to dark theme to reduce eye strain '
                        'and save battery on OLED screens.',
                    Icons.dark_mode_outlined,
                    false,
                  ),
                  const Divider(height: 1),
                  _buildSettingsTile(
                    context,
                    'Auto-Sync',
                    'Automatically sync data in the background '
                        'when connected to WiFi networks.',
                    Icons.sync_outlined,
                    true,
                  ),
                  const Divider(height: 1),
                  _buildSettingsTile(
                    context,
                    'Location Services',
                    'Allow the app to access your location for '
                        'personalized content and nearby suggestions.',
                    Icons.location_on_outlined,
                    false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Helper to build settings tiles
  Widget _buildSettingsTile(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    bool isEnabled,
  ) {
    return ListTile(
      titleAlignment: ListTileTitleAlignment.threeLine,
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: Theme.of(context).colorScheme.primary),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(description),
      isThreeLine: true,
      trailing: Switch(
        value: isEnabled,
        onChanged: (value) {
          print('$title switched to: $value');
        },
      ),
    );
  }

  /// Builds the file browser real-world example
  Widget _buildFileBrowserExample(BuildContext context) {
    print('Building File Browser Example...');

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(
              context,
              'Example: File Browser',
              Icons.folder_open,
            ),
            const SizedBox(height: 8),
            Text(
              'A file browser interface using top alignment for consistent '
              'icon positioning regardless of file name length.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),

            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildFileTile(
                    context,
                    'Documents',
                    'Folder • 24 items',
                    Icons.folder,
                    Colors.amber,
                    isFolder: true,
                  ),
                  const Divider(height: 1),
                  _buildFileTile(
                    context,
                    'Annual Report 2025.pdf',
                    '2.4 MB • Modified Mar 15',
                    Icons.picture_as_pdf,
                    Colors.red,
                  ),
                  const Divider(height: 1),
                  _buildFileTile(
                    context,
                    'Project Presentation Slides for Q1 Review Meeting.pptx',
                    '8.7 MB • Modified Mar 20',
                    Icons.slideshow,
                    Colors.orange,
                  ),
                  const Divider(height: 1),
                  _buildFileTile(
                    context,
                    'Budget.xlsx',
                    '156 KB • Modified Mar 22',
                    Icons.table_chart,
                    Colors.green,
                  ),
                  const Divider(height: 1),
                  _buildFileTile(
                    context,
                    'Meeting Notes - A Comprehensive Summary of All Discussion Points and Action Items.docx',
                    '89 KB • Modified Mar 25',
                    Icons.description,
                    Colors.blue,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Helper to build file tiles
  Widget _buildFileTile(
    BuildContext context,
    String name,
    String details,
    IconData icon,
    Color color, {
    bool isFolder = false,
  }) {
    return ListTile(
      titleAlignment: ListTileTitleAlignment.top,
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: color),
      ),
      title: Text(name, maxLines: 2, overflow: TextOverflow.ellipsis),
      subtitle: Text(details),
      trailing: PopupMenuButton<String>(
        icon: const Icon(Icons.more_vert),
        itemBuilder: (context) => [
          const PopupMenuItem(value: 'open', child: Text('Open')),
          const PopupMenuItem(value: 'share', child: Text('Share')),
          const PopupMenuItem(value: 'delete', child: Text('Delete')),
        ],
        onSelected: (value) {
          print('$value selected for $name');
        },
      ),
    );
  }

  /// Builds the interactive comparison section
  Widget _buildInteractiveComparison(BuildContext context) {
    print('Building Interactive Comparison Section...');

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(context, 'Quick Reference', Icons.bookmark),
            const SizedBox(height: 16),

            // Summary table
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  // Header row
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(7),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 2,
                          child: Text(
                            'Alignment',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Expanded(
                          flex: 3,
                          child: Text(
                            'Best For',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Expanded(
                          flex: 2,
                          child: Text(
                            'Position',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildTableRow(
                    'threeLine',
                    'isThreeLine: true tiles',
                    'Top',
                    Colors.orange,
                  ),
                  _buildTableRow(
                    'titleHeight',
                    'General purpose (default)',
                    'Centered',
                    Colors.blue,
                  ),
                  _buildTableRow(
                    'top',
                    'Consistent top alignment',
                    'Top',
                    Colors.green,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Code example
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.code, color: Colors.grey.shade400, size: 16),
                      const SizedBox(width: 8),
                      Text(
                        'Usage Example',
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'ListTile(\n'
                    '  titleAlignment: ListTileTitleAlignment.threeLine,\n'
                    '  leading: const CircleAvatar(child: Icon(Icons.person)),\n'
                    '  title: const Text(\'John Doe\'),\n'
                    '  subtitle: const Text(\n'
                    '    \'Software Engineer\\n\'\n'
                    '    \'Available for hire\',\n'
                    '  ),\n'
                    '  isThreeLine: true,\n'
                    '  trailing: const Icon(Icons.arrow_forward_ios),\n'
                    ')',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      color: Colors.lightGreenAccent,
                      fontSize: 12,
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

  /// Helper to build table rows
  Widget _buildTableRow(
    String alignment,
    String bestFor,
    String position,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                alignment,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(bestFor, style: const TextStyle(fontSize: 12)),
          ),
          Expanded(
            flex: 2,
            child: Text(position, style: const TextStyle(fontSize: 12)),
          ),
        ],
      ),
    );
  }

  /// Helper to build section headers
  Widget _buildSectionHeader(
    BuildContext context,
    String title,
    IconData icon,
  ) {
    return Row(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
