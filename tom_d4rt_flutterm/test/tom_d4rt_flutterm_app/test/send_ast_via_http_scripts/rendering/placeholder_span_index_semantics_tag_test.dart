// D4rt test script: Deep demo for PlaceholderSpanIndexSemanticsTag from rendering
//
// PlaceholderSpanIndexSemanticsTag is a SemanticsTag that:
//   - Associates placeholder indices with semantic nodes
//   - Enables screen readers to understand inline widget positions
//   - Works with Text.rich and WidgetSpan for rich text accessibility
//   - Provides index property for placeholder identification
//
// This demo covers:
//   1. SemanticsTag concept and purpose
//   2. PlaceholderSpanIndexSemanticsTag usage with Text.rich and WidgetSpan
//   3. Index property visualization and multiple placeholders
//   4. Semantic tree structure with inline widgets
//
// ═══════════════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// ═══════════════════════════════════════════════════════════════════════════
// COLOR PALETTE
// ═══════════════════════════════════════════════════════════════════════════

Color _kIndigo50 = Color(0xFFE8EAF6);
Color _kIndigo100 = Color(0xFFC5CAE9);
Color _kIndigo200 = Color(0xFF9FA8DA);
Color _kIndigo300 = Color(0xFF7986CB);
Color _kIndigo400 = Color(0xFF5C6BC0);
Color _kIndigo500 = Color(0xFF3F51B5);
Color _kIndigo600 = Color(0xFF3949AB);
Color _kIndigo700 = Color(0xFF303F9F);
Color _kIndigo800 = Color(0xFF283593);
Color _kIndigo900 = Color(0xFF1A237E);

Color _kAmber500 = Color(0xFFFFC107);
Color _kAmber600 = Color(0xFFFFB300);

Color _kTeal400 = Color(0xFF26A69A);
Color _kTeal500 = Color(0xFF009688);
Color _kTeal600 = Color(0xFF00897B);

Color _kOrange500 = Color(0xFFFF9800);

Color _kPink500 = Color(0xFFE91E63);

// ═══════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════

// Builds a styled section header with icon
Widget _buildSectionHeader(String title, IconData icon) {
  return Padding(
    padding: EdgeInsets.only(bottom: 16, top: 8),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _kIndigo100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: _kIndigo800, size: 24),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: _kIndigo900,
            ),
          ),
        ),
      ],
    ),
  );
}

// Builds an info card with description
Widget _buildInfoCard(String title, String description, IconData icon) {
  return Container(
    margin: EdgeInsets.only(bottom: 12),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _kIndigo50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kIndigo200),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: _kIndigo600, size: 24),
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
                  color: _kIndigo900,
                ),
              ),
              SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: _kIndigo700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// Builds a property display row
Widget _buildPropertyRow(String name, String value, IconData icon) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Icon(icon, size: 16, color: _kIndigo500),
        SizedBox(width: 8),
        Text(
          '$name:',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: _kIndigo800,
            fontSize: 13,
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(color: _kIndigo600, fontSize: 13),
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 1: SEMANTICS TAG CONCEPT
// ═══════════════════════════════════════════════════════════════════════════

Widget _buildSemanticsTagConceptSection() {
  return Container(
    margin: EdgeInsets.only(bottom: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: _kIndigo200),
      boxShadow: [
        BoxShadow(
          color: _kIndigo100.withValues(alpha: 0.5),
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('SemanticsTag Concept', Icons.label_important),
        Text(
          'SemanticsTag is a marker class for semantics classification',
          style: TextStyle(
            fontSize: 14,
            color: _kIndigo700,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 16),
        _buildInfoCard(
          'Purpose of SemanticsTag',
          'Tags allow categorization of semantic nodes for filtering and '
          'identification without affecting the semantic information itself.',
          Icons.category,
        ),
        _buildInfoCard(
          'How Tags Work',
          'Tags are attached to SemanticsNode via SemanticsConfiguration.tagsForChildren '
          'and can be queried to filter specific semantic entities.',
          Icons.hub,
        ),
        _buildInfoCard(
          'PlaceholderSpanIndexSemanticsTag',
          'A specialized tag that associates an index with inline widget placeholders, '
          'helping screen readers navigate between embedded widgets in rich text.',
          Icons.pin_drop,
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kTeal400.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _kTeal500.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb_outline, color: _kTeal600, size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Tags enable assistive technologies to understand widget relationships',
                  style: TextStyle(fontSize: 12, color: _kTeal600),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        _buildTagHierarchyVisualization(),
      ],
    ),
  );
}

Widget _buildTagHierarchyVisualization() {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _kIndigo50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kIndigo200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SemanticsTag Class Hierarchy',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kIndigo800,
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            _buildHierarchyBox('SemanticsTag', _kIndigo400, true),
            SizedBox(width: 8),
            Icon(Icons.arrow_forward, color: _kIndigo400, size: 20),
            SizedBox(width: 8),
            _buildHierarchyBox('PlaceholderSpanIndex\nSemanticsTag', _kIndigo600, false),
          ],
        ),
        SizedBox(height: 12),
        Row(
          children: [
            SizedBox(width: 40),
            Icon(Icons.subdirectory_arrow_right, color: _kIndigo300, size: 20),
            SizedBox(width: 8),
            Text(
              'Stores: int index (placeholder position)',
              style: TextStyle(fontSize: 11, color: _kIndigo600),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildHierarchyBox(String label, Color color, bool isBase) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.2),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color, width: isBase ? 2 : 1),
    ),
    child: Text(
      label,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: color,
      ),
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 2: USAGE WITH TEXT.RICH AND WIDGETSPAN
// ═══════════════════════════════════════════════════════════════════════════

Widget _buildUsageWithTextRichSection() {
  return Container(
    margin: EdgeInsets.only(bottom: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: _kIndigo200),
      boxShadow: [
        BoxShadow(
          color: _kIndigo100.withValues(alpha: 0.5),
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Usage with Text.rich & WidgetSpan', Icons.text_fields),
        Text(
          'PlaceholderSpanIndexSemanticsTag tracks inline widget positions',
          style: TextStyle(
            fontSize: 14,
            color: _kIndigo700,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 16),
        _buildRichTextExample1(),
        SizedBox(height: 16),
        _buildRichTextExample2(),
        SizedBox(height: 16),
        _buildRichTextExample3(),
        SizedBox(height: 16),
        _buildCodeExplanation(),
      ],
    ),
  );
}

Widget _buildRichTextExample1() {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _kIndigo50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kIndigo200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _kAmber500,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Example 1',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            SizedBox(width: 8),
            Text(
              'Single Inline Widget',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: _kIndigo800,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _kIndigo300),
          ),
          child: RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 16, color: Colors.black87),
              children: [
                TextSpan(text: 'Rate this article '),
                WidgetSpan(
                  child: Icon(Icons.star, color: _kAmber500, size: 20),
                  alignment: PlaceholderAlignment.middle,
                ),
                TextSpan(text: ' by clicking the star'),
              ],
            ),
          ),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.info_outline, size: 14, color: _kIndigo500),
            SizedBox(width: 4),
            Text(
              'PlaceholderSpanIndexSemanticsTag(index: 0) for star icon',
              style: TextStyle(fontSize: 11, color: _kIndigo600),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildRichTextExample2() {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _kIndigo50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kIndigo200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _kTeal500,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Example 2',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 8),
            Text(
              'Multiple Inline Widgets',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: _kIndigo800,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _kIndigo300),
          ),
          child: RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 16, color: Colors.black87),
              children: [
                TextSpan(text: 'Actions: '),
                WidgetSpan(
                  child: _buildActionChip(Icons.thumb_up, 'Like', _kTeal500),
                  alignment: PlaceholderAlignment.middle,
                ),
                TextSpan(text: ' '),
                WidgetSpan(
                  child: _buildActionChip(Icons.share, 'Share', _kOrange500),
                  alignment: PlaceholderAlignment.middle,
                ),
                TextSpan(text: ' '),
                WidgetSpan(
                  child: _buildActionChip(Icons.bookmark, 'Save', _kPink500),
                  alignment: PlaceholderAlignment.middle,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 8),
        _buildIndexLegend([
          IndexLegendItem(0, 'Like button', _kTeal500),
          IndexLegendItem(1, 'Share button', _kOrange500),
          IndexLegendItem(2, 'Save button', _kPink500),
        ]),
      ],
    ),
  );
}

Widget _buildActionChip(IconData icon, String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: color),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w500),
        ),
      ],
    ),
  );
}

class IndexLegendItem {
  int index;
  String description;
  Color color;
  IndexLegendItem(this.index, this.description, this.color);
}

Widget _buildIndexLegend(List<IndexLegendItem> items) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: items.map((item) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 2),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: item.color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: item.color),
              ),
              child: Center(
                child: Text(
                  '${item.index}',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: item.color,
                  ),
                ),
              ),
            ),
            SizedBox(width: 8),
            Text(
              'PlaceholderSpanIndexSemanticsTag(index: ${item.index}) - ${item.description}',
              style: TextStyle(fontSize: 11, color: _kIndigo600),
            ),
          ],
        ),
      );
    }).toList(),
  );
}

Widget _buildRichTextExample3() {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _kIndigo50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kIndigo200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _kPink500,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Example 3',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 8),
            Text(
              'Complex Mixed Content',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: _kIndigo800,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _kIndigo300),
          ),
          child: RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 15, color: Colors.black87),
              children: [
                TextSpan(text: 'User '),
                WidgetSpan(
                  child: _buildUserAvatar(),
                  alignment: PlaceholderAlignment.middle,
                ),
                TextSpan(text: ' posted '),
                WidgetSpan(
                  child: Icon(Icons.photo, color: _kIndigo500, size: 18),
                  alignment: PlaceholderAlignment.middle,
                ),
                TextSpan(text: ' photos and tagged '),
                WidgetSpan(
                  child: _buildTagBadge('@friend', _kTeal500),
                  alignment: PlaceholderAlignment.middle,
                ),
                TextSpan(text: ' with '),
                WidgetSpan(
                  child: _buildEmojiWidget('😀'),
                  alignment: PlaceholderAlignment.middle,
                ),
                TextSpan(text: ' reaction'),
              ],
            ),
          ),
        ),
        SizedBox(height: 8),
        _buildIndexLegend([
          IndexLegendItem(0, 'User avatar', _kIndigo500),
          IndexLegendItem(1, 'Photo icon', _kIndigo500),
          IndexLegendItem(2, 'Tag badge', _kTeal500),
          IndexLegendItem(3, 'Emoji reaction', _kAmber500),
        ]),
      ],
    ),
  );
}

Widget _buildUserAvatar() {
  return Container(
    width: 22,
    height: 22,
    decoration: BoxDecoration(
      color: _kIndigo400,
      shape: BoxShape.circle,
    ),
    child: Icon(Icons.person, size: 14, color: Colors.white),
  );
}

Widget _buildTagBadge(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text(
      text,
      style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w500),
    ),
  );
}

Widget _buildEmojiWidget(String emoji) {
  return Container(
    padding: EdgeInsets.all(2),
    child: Text(emoji, style: TextStyle(fontSize: 16)),
  );
}

Widget _buildCodeExplanation() {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFF1E1E1E),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '// Creating a tag for placeholder tracking',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11,
            color: Color(0xFF6A9955),
          ),
        ),
        SizedBox(height: 4),
        RichText(
          text: TextSpan(
            style: TextStyle(fontFamily: 'monospace', fontSize: 11),
            children: [
              TextSpan(text: 'var ', style: TextStyle(color: Color(0xFF569CD6))),
              TextSpan(text: 'tag = ', style: TextStyle(color: Color(0xFFD4D4D4))),
              TextSpan(text: 'PlaceholderSpanIndexSemanticsTag', style: TextStyle(color: Color(0xFF4EC9B0))),
              TextSpan(text: '(', style: TextStyle(color: Color(0xFFD4D4D4))),
              TextSpan(text: '0', style: TextStyle(color: Color(0xFFB5CEA8))),
              TextSpan(text: ');', style: TextStyle(color: Color(0xFFD4D4D4))),
            ],
          ),
        ),
        SizedBox(height: 4),
        RichText(
          text: TextSpan(
            style: TextStyle(fontFamily: 'monospace', fontSize: 11),
            children: [
              TextSpan(text: 'print', style: TextStyle(color: Color(0xFFDCDCAA))),
              TextSpan(text: '(tag.', style: TextStyle(color: Color(0xFFD4D4D4))),
              TextSpan(text: 'index', style: TextStyle(color: Color(0xFF9CDCFE))),
              TextSpan(text: '); ', style: TextStyle(color: Color(0xFFD4D4D4))),
              TextSpan(text: '// Outputs: 0', style: TextStyle(color: Color(0xFF6A9955))),
            ],
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 3: INDEX PROPERTY VISUALIZATION
// ═══════════════════════════════════════════════════════════════════════════

Widget _buildIndexPropertySection() {
  return Container(
    margin: EdgeInsets.only(bottom: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: _kIndigo200),
      boxShadow: [
        BoxShadow(
          color: _kIndigo100.withValues(alpha: 0.5),
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Index Property Visualization', Icons.format_list_numbered),
        Text(
          'The index property identifies each placeholder\'s position',
          style: TextStyle(
            fontSize: 14,
            color: _kIndigo700,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 16),
        _buildIndexVisualization(),
        SizedBox(height: 16),
        _buildIndexPropertyDetails(),
        SizedBox(height: 16),
        _buildIndexComparisonTable(),
      ],
    ),
  );
}

Widget _buildIndexVisualization() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _kIndigo50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kIndigo200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Placeholder Index Assignment',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kIndigo800,
          ),
        ),
        SizedBox(height: 16),
        SizedBox(
          height: 100,
          child: Row(
            children: [
              Expanded(child: _buildIndexedPlaceholder(0, Icons.image, 'Image')),
              _buildIndexArrow(),
              Expanded(child: _buildIndexedPlaceholder(1, Icons.videocam, 'Video')),
              _buildIndexArrow(),
              Expanded(child: _buildIndexedPlaceholder(2, Icons.link, 'Link')),
              _buildIndexArrow(),
              Expanded(child: _buildIndexedPlaceholder(3, Icons.attachment, 'File')),
            ],
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _kAmber500.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _kAmber500.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              Icon(Icons.arrow_forward, color: _kAmber600, size: 16),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Indices are assigned sequentially (0, 1, 2, 3...) as placeholders appear in text flow',
                  style: TextStyle(fontSize: 11, color: _kAmber600),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildIndexedPlaceholder(int index, IconData icon, String label) {
  List<Color> colors = [_kIndigo500, _kTeal500, _kOrange500, _kPink500];
  Color color = colors[index % colors.length];
  
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: color, width: 2),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          Positioned(
            top: -8,
            right: -8,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '$index',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 6),
      Text(
        label,
        style: TextStyle(fontSize: 10, color: _kIndigo700),
      ),
    ],
  );
}

Widget _buildIndexArrow() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 4),
    child: Icon(Icons.arrow_forward_ios, size: 12, color: _kIndigo300),
  );
}

Widget _buildIndexPropertyDetails() {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _kIndigo50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kIndigo200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Index Property Characteristics',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kIndigo800,
          ),
        ),
        SizedBox(height: 12),
        _buildPropertyRow('Type', 'int (non-negative integer)', Icons.code),
        _buildPropertyRow('Range', '0 to (placeholder_count - 1)', Icons.timeline),
        _buildPropertyRow('Assignment', 'Automatic by text rendering system', Icons.auto_fix_high),
        _buildPropertyRow('Stability', 'Changes when placeholders are added/removed', Icons.sync),
      ],
    ),
  );
}

Widget _buildIndexComparisonTable() {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _kIndigo50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kIndigo200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Index Values for Different Scenarios',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kIndigo800,
          ),
        ),
        SizedBox(height: 12),
        Table(
          border: TableBorder.all(color: _kIndigo300, width: 1),
          columnWidths: {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(1),
          },
          children: [
            TableRow(
              decoration: BoxDecoration(color: _kIndigo200),
              children: [
                _buildTableCell('Scenario', true),
                _buildTableCell('Index', true),
              ],
            ),
            TableRow(
              children: [
                _buildTableCell('First placeholder in text', false),
                _buildTableCell('0', false),
              ],
            ),
            TableRow(
              children: [
                _buildTableCell('Second placeholder in text', false),
                _buildTableCell('1', false),
              ],
            ),
            TableRow(
              children: [
                _buildTableCell('After removing first placeholder', false),
                _buildTableCell('Reindexed', false),
              ],
            ),
            TableRow(
              children: [
                _buildTableCell('Nested WidgetSpan', false),
                _buildTableCell('Same rules', false),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildTableCell(String text, bool isHeader) {
  return Container(
    padding: EdgeInsets.all(8),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 12,
        fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
        color: isHeader ? _kIndigo900 : _kIndigo700,
      ),
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 4: SEMANTIC TREE STRUCTURE
// ═══════════════════════════════════════════════════════════════════════════

Widget _buildSemanticTreeSection() {
  return Container(
    margin: EdgeInsets.only(bottom: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: _kIndigo200),
      boxShadow: [
        BoxShadow(
          color: _kIndigo100.withValues(alpha: 0.5),
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Semantic Tree Structure', Icons.account_tree),
        Text(
          'How PlaceholderSpanIndexSemanticsTag integrates with semantics',
          style: TextStyle(
            fontSize: 14,
            color: _kIndigo700,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 16),
        _buildTreeVisualization(),
        SizedBox(height: 16),
        _buildAccessibilityFlow(),
        SizedBox(height: 16),
        _buildScreenReaderExample(),
      ],
    ),
  );
}

Widget _buildTreeVisualization() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _kIndigo50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kIndigo200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Semantic Tree with Inline Widgets',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kIndigo800,
          ),
        ),
        SizedBox(height: 16),
        _buildTreeNode('RichText Semantics', Icons.text_snippet, _kIndigo500, 0, [
          _buildTreeNode('TextSpan: "Click "', Icons.text_format, _kIndigo400, 1, []),
          _buildTreeNode('WidgetSpan [index: 0]', Icons.widgets, _kTeal500, 1, [
            _buildTreeNode('Icon Semantics', Icons.accessibility, _kTeal400, 2, []),
          ]),
          _buildTreeNode('TextSpan: " to continue"', Icons.text_format, _kIndigo400, 1, []),
        ]),
      ],
    ),
  );
}

Widget _buildTreeNode(String label, IconData icon, Color color, int depth, List<Widget> children) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.only(left: depth * 20.0),
        child: Row(
          children: [
            if (depth > 0) ...[
              Container(
                width: 16,
                height: 2,
                color: color.withValues(alpha: 0.5),
              ),
              SizedBox(width: 4),
            ],
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: color),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, size: 14, color: color),
                  SizedBox(width: 6),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      if (children.isNotEmpty) ...[
        SizedBox(height: 8),
        ...children,
        SizedBox(height: 4),
      ],
    ],
  );
}

Widget _buildAccessibilityFlow() {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _kTeal400.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kTeal500.withValues(alpha: 0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.accessibility_new, color: _kTeal600, size: 20),
            SizedBox(width: 8),
            Text(
              'Accessibility Navigation Flow',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: _kTeal600,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        _buildFlowStep(1, 'Screen reader encounters RichText', _kTeal500),
        _buildFlowStep(2, 'Reads text spans in order', _kTeal500),
        _buildFlowStep(3, 'Identifies placeholder via index tag', _kTeal600),
        _buildFlowStep(4, 'Announces inline widget semantics', _kTeal600),
        _buildFlowStep(5, 'Continues to next text span', _kTeal500),
      ],
    ),
  );
}

Widget _buildFlowStep(int step, String description, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '$step',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            description,
            style: TextStyle(fontSize: 12, color: _kTeal600),
          ),
        ),
      ],
    ),
  );
}

Widget _buildScreenReaderExample() {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _kIndigo50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kIndigo200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.volume_up, color: _kIndigo600, size: 20),
            SizedBox(width: 8),
            Text(
              'Screen Reader Announcement Example',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: _kIndigo800,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _kIndigo300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Original Text:',
                style: TextStyle(fontSize: 11, color: _kIndigo500),
              ),
              SizedBox(height: 4),
              RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                  children: [
                    TextSpan(text: 'Press '),
                    WidgetSpan(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: _kIndigo500,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Enter',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ),
                      alignment: PlaceholderAlignment.middle,
                    ),
                    TextSpan(text: ' to submit'),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _kAmber500.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _kAmber500.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              Icon(Icons.record_voice_over, color: _kAmber600, size: 18),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  '"Press Enter button to submit"',
                  style: TextStyle(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                    color: _kAmber600,
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

// ═══════════════════════════════════════════════════════════════════════════
// MAIN BUILD FUNCTION
// ═══════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  print('═══════════════════════════════════════════════════════════════════');
  print('║       PlaceholderSpanIndexSemanticsTag Deep Demo                ║');
  print('═══════════════════════════════════════════════════════════════════');
  print('');
  print('PlaceholderSpanIndexSemanticsTag deep demo executing...');
  print('');
  
  // Create and demonstrate tag instances
  var tag0 = PlaceholderSpanIndexSemanticsTag(0);
  var tag1 = PlaceholderSpanIndexSemanticsTag(1);
  var tag2 = PlaceholderSpanIndexSemanticsTag(2);
  
  print('Section 1: SemanticsTag Concept');
  print('  - PlaceholderSpanIndexSemanticsTag extends SemanticsTag');
  print('  - Purpose: Associate index with inline widget placeholders');
  print('');
  
  print('Section 2: Tag Creation');
  print('  - tag0 = PlaceholderSpanIndexSemanticsTag(0)');
  print('  - tag0.index = ${tag0.index}');
  print('  - tag1 = PlaceholderSpanIndexSemanticsTag(1)');
  print('  - tag1.index = ${tag1.index}');
  print('  - tag2 = PlaceholderSpanIndexSemanticsTag(2)');
  print('  - tag2.index = ${tag2.index}');
  print('');
  
  print('Section 3: Index Property Characteristics');
  print('  - Type: int');
  print('  - Range: 0 to (placeholder_count - 1)');
  print('  - Assignment: Sequential based on appearance order');
  print('');
  
  print('Section 4: Semantic Tree Integration');
  print('  - Tags attach to SemanticsNode for each placeholder');
  print('  - Screen readers use indices for navigation');
  print('  - Enables accessible inline widget identification');
  print('');
  
  print('PlaceholderSpanIndexSemanticsTag deep demo completed');
  print('═══════════════════════════════════════════════════════════════════');
  
  return Scaffold(
    appBar: AppBar(
      title: Text('PlaceholderSpanIndexSemanticsTag Demo'),
      backgroundColor: _kIndigo500,
      foregroundColor: Colors.white,
    ),
    body: Container(
      color: _kIndigo50.withValues(alpha: 0.5),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Demo header
            Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [_kIndigo600, _kIndigo800],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: _kIndigo500.withValues(alpha: 0.4),
                    blurRadius: 12,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(Icons.pin_drop, color: Colors.white, size: 28),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'PlaceholderSpanIndex',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'SemanticsTag',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Semantic identification for inline widget placeholders in rich text',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
            ),
            
            // Section 1: SemanticsTag Concept
            _buildSemanticsTagConceptSection(),
            
            // Section 2: Usage with Text.rich and WidgetSpan
            _buildUsageWithTextRichSection(),
            
            // Section 3: Index Property Visualization
            _buildIndexPropertySection(),
            
            // Section 4: Semantic Tree Structure
            _buildSemanticTreeSection(),
            
            // Demo completion indicator
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _kTeal500.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _kTeal500.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: _kTeal500, size: 24),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Demo Complete',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: _kTeal600,
                          ),
                        ),
                        Text(
                          'PlaceholderSpanIndexSemanticsTag enables accessible inline widget navigation',
                          style: TextStyle(fontSize: 12, color: _kTeal600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );
}
