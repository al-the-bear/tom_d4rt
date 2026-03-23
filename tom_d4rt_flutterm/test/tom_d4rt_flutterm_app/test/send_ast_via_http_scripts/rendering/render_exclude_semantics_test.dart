// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// Deep demo: RenderExcludeSemantics
// ExcludeSemantics removes subtree from accessibility/semantics tree
// When excluding=true, screen readers ignore the content entirely

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== RenderExcludeSemantics Deep Demo ===');
  print('ExcludeSemantics controls what screen readers see');
  print('excluding=true -> hidden from accessibility tree');
  print('excluding=false -> visible to accessibility tree');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildHeader(),
        SizedBox(height: 16),
        _buildSectionTitle('1. Basic ExcludeSemantics (excluding: true)'),
        _buildExcludedDecorativeContent(),
        SizedBox(height: 16),
        _buildSectionTitle('2. ExcludeSemantics (excluding: false) - Included'),
        _buildIncludedImportantContent(),
        SizedBox(height: 16),
        _buildSectionTitle('3. Semantics Widget Comparison'),
        _buildSemanticsComparison(),
        SizedBox(height: 16),
        _buildSectionTitle('4. MergeSemantics Grouping'),
        _buildMergeSemanticsDemo(),
        SizedBox(height: 16),
        _buildSectionTitle('5. Decorative vs Meaningful Patterns'),
        _buildDecorativeVsMeaningful(),
        SizedBox(height: 16),
        _buildSectionTitle('6. Visual Comparison: Green=Visible, Red=Excluded'),
        _buildColorCodedComparison(),
        SizedBox(height: 16),
        _buildSectionTitle('7. Accessibility Tree Visualization'),
        _buildAccessibilityTreeVisualization(),
        SizedBox(height: 16),
        _buildSectionTitle('8. ExcludeSemantics in List Items'),
        _buildListItemsDemo(),
        SizedBox(height: 16),
        _buildSectionTitle('9. ExcludeSemantics in Cards'),
        _buildCardsDemo(),
        SizedBox(height: 16),
        _buildSectionTitle('10. ExcludeSemantics in Form Layouts'),
        _buildFormLayoutDemo(),
        SizedBox(height: 24),
        _buildFooter(),
      ],
    ),
  );
}

// Header with gradient styling
Widget _buildHeader() {
  print('[Header] Building gradient header');
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF6A1B9A), Color(0xFF8E24AA), Color(0xFFAB47BC)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'RenderExcludeSemantics',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Control what the accessibility tree sees',
          style: TextStyle(fontSize: 16, color: Color(0xFFE1BEE7)),
        ),
        SizedBox(height: 4),
        Text(
          'ExcludeSemantics hides decorative content from screen readers',
          style: TextStyle(fontSize: 13, color: Color(0xFFCE93D8)),
        ),
      ],
    ),
  );
}

// Section title helper with gradient underline
Widget _buildSectionTitle(String title) {
  print('[Section] $title');
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4A148C),
          ),
        ),
        SizedBox(height: 4),
        Container(
          height: 3,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF6A1B9A),
                Color(0xFFCE93D8),
                Colors.transparent,
              ],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    ),
  );
}

// Section 1: Excluded decorative content
Widget _buildExcludedDecorativeContent() {
  print('[Section 1] ExcludeSemantics excluding=true for decorative content');
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFFCE4EC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFE53935), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'These decorative elements are EXCLUDED from semantics:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFFB71C1C),
            ),
          ),
          SizedBox(height: 12),
          ExcludeSemantics(
            excluding: true,
            child: Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 32),
                SizedBox(width: 8),
                Icon(Icons.star, color: Colors.amber, size: 32),
                SizedBox(width: 8),
                Icon(Icons.star, color: Colors.amber, size: 32),
                SizedBox(width: 12),
                Text(
                  'Decorative stars (hidden from screen reader)',
                  style: TextStyle(color: Color(0xFF757575), fontSize: 12),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          ExcludeSemantics(
            excluding: true,
            child: Divider(color: Color(0xFFE0E0E0), thickness: 2),
          ),
          SizedBox(height: 8),
          ExcludeSemantics(
            excluding: true,
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFE1BEE7), Color(0xFFF3E5F5)],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  'Decorative banner (excluded)',
                  style: TextStyle(color: Color(0xFF9E9E9E)),
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Screen readers will NOT announce any of the above elements.',
            style: TextStyle(fontSize: 12, color: Color(0xFF616161)),
          ),
        ],
      ),
    ),
  );
}

// Section 2: Included important content
Widget _buildIncludedImportantContent() {
  print('[Section 2] ExcludeSemantics excluding=false for important content');
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFF43A047), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'These elements remain VISIBLE to semantics:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF1B5E20),
            ),
          ),
          SizedBox(height: 12),
          ExcludeSemantics(
            excluding: false,
            child: Row(
              children: [
                Icon(Icons.check_circle, color: Color(0xFF43A047), size: 28),
                SizedBox(width: 8),
                Text(
                  'Important action button label',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          ExcludeSemantics(
            excluding: false,
            child: Text(
              'This text is critical: "Order confirmed, arriving Tuesday"',
              style: TextStyle(fontSize: 15, color: Color(0xFF2E7D32)),
            ),
          ),
          SizedBox(height: 8),
          ExcludeSemantics(
            excluding: false,
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0xFFC8E6C9),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Error message: Please enter a valid email address',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1B5E20),
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Screen readers WILL announce all of the above elements.',
            style: TextStyle(fontSize: 12, color: Color(0xFF616161)),
          ),
        ],
      ),
    ),
  );
}

// Section 3: Semantics widget comparison
Widget _buildSemanticsComparison() {
  print('[Section 3] Semantics widget with label, hint, value');
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFF3E5F5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Semantics(
            label: 'User profile picture',
            hint: 'Double tap to view full size',
            value: 'John Doe avatar',
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Color(0xFF7B1FA2),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  'JD',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 12),
          Semantics(
            label: 'Product rating',
            value: '4 out of 5 stars',
            hint: 'Based on 128 reviews',
            child: Row(
              children: [
                Icon(Icons.star, color: Colors.amber),
                Icon(Icons.star, color: Colors.amber),
                Icon(Icons.star, color: Colors.amber),
                Icon(Icons.star, color: Colors.amber),
                Icon(Icons.star_border, color: Colors.amber),
                SizedBox(width: 8),
                Text('4.0 (128 reviews)', style: TextStyle(fontSize: 14)),
              ],
            ),
          ),
          SizedBox(height: 12),
          Semantics(
            label: 'Price',
            value: '29 dollars and 99 cents',
            child: Text(
              '\$29.99',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4A148C),
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Each Semantics widget provides label/hint/value for assistive tech.',
            style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
          ),
        ],
      ),
    ),
  );
}

// Section 4: MergeSemantics grouping
Widget _buildMergeSemanticsDemo() {
  print('[Section 4] MergeSemantics grouping related elements');
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFE3F2FD),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0xFF1E88E5), width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Without MergeSemantics (3 separate nodes):',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.email, color: Color(0xFF1E88E5)),
                  SizedBox(width: 8),
                  Text('Email:', style: TextStyle(fontWeight: FontWeight.w600)),
                  SizedBox(width: 4),
                  Text('user@example.com'),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFE8F5E9),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0xFF43A047), width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'With MergeSemantics (1 merged node):',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              SizedBox(height: 8),
              MergeSemantics(
                child: Row(
                  children: [
                    Icon(Icons.phone, color: Color(0xFF43A047)),
                    SizedBox(width: 8),
                    Text(
                      'Phone:',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(width: 4),
                    Text('+1 555-0123'),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            'MergeSemantics combines multiple nodes into one for cleaner reading.',
            style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
          ),
        ),
      ],
    ),
  );
}

// Section 5: Decorative vs meaningful patterns
Widget _buildDecorativeVsMeaningful() {
  print('[Section 5] Decorative images excluded, meaningful text included');
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      children: [
        _buildPatternRow(
          'Decorative background pattern',
          true,
          Container(
            height: 40,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFE1BEE7),
                  Color(0xFFB39DDB),
                  Color(0xFF9FA8DA),
                ],
              ),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
        SizedBox(height: 8),
        _buildPatternRow(
          'Meaningful heading text',
          false,
          Text(
            'Welcome to your dashboard',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 8),
        _buildPatternRow(
          'Decorative separator line',
          true,
          Container(height: 2, color: Color(0xFFBDBDBD)),
        ),
        SizedBox(height: 8),
        _buildPatternRow(
          'Status notification text',
          false,
          Text(
            '3 new messages waiting',
            style: TextStyle(fontSize: 14, color: Color(0xFF1565C0)),
          ),
        ),
        SizedBox(height: 8),
        _buildPatternRow(
          'Decorative icon flourish',
          true,
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.auto_awesome, size: 16, color: Color(0xFFFFB300)),
              SizedBox(width: 4),
              Icon(Icons.auto_awesome, size: 16, color: Color(0xFFFFB300)),
              SizedBox(width: 4),
              Icon(Icons.auto_awesome, size: 16, color: Color(0xFFFFB300)),
            ],
          ),
        ),
        SizedBox(height: 8),
        _buildPatternRow(
          'Error message for user',
          false,
          Text(
            'Password must be 8+ characters',
            style: TextStyle(fontSize: 14, color: Color(0xFFD32F2F)),
          ),
        ),
      ],
    ),
  );
}

// Helper for decorative vs meaningful pattern rows
Widget _buildPatternRow(String description, bool isExcluded, Widget child) {
  print('[Pattern] $description -> excluded=$isExcluded');
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: isExcluded ? Color(0xFFFCE4EC) : Color(0xFFE8F5E9),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: isExcluded ? Color(0xFFE53935) : Color(0xFF43A047),
        width: 1,
      ),
    ),
    child: Row(
      children: [
        Icon(
          isExcluded ? Icons.visibility_off : Icons.visibility,
          color: isExcluded ? Color(0xFFE53935) : Color(0xFF43A047),
          size: 20,
        ),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isExcluded ? Color(0xFFB71C1C) : Color(0xFF1B5E20),
                ),
              ),
              SizedBox(height: 4),
              ExcludeSemantics(excluding: isExcluded, child: child),
            ],
          ),
        ),
      ],
    ),
  );
}

// Section 6: Color-coded visual comparison
Widget _buildColorCodedComparison() {
  print('[Section 6] Color-coded: green=visible, red=excluded');
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF43A047), width: 3),
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFFE8F5E9),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.accessibility_new,
                      color: Color(0xFF43A047),
                      size: 36,
                    ),
                    SizedBox(height: 6),
                    Text(
                      'SEMANTICS ON',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1B5E20),
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 6),
                    ExcludeSemantics(
                      excluding: false,
                      child: Text('Button: Submit Form'),
                    ),
                    SizedBox(height: 4),
                    ExcludeSemantics(
                      excluding: false,
                      child: Text('Alert: Session expiring'),
                    ),
                    SizedBox(height: 4),
                    ExcludeSemantics(
                      excluding: false,
                      child: Text('Link: View details'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFE53935), width: 3),
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFFFCE4EC),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.not_accessible,
                      color: Color(0xFFE53935),
                      size: 36,
                    ),
                    SizedBox(height: 6),
                    Text(
                      'SEMANTICS OFF',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFB71C1C),
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 6),
                    ExcludeSemantics(
                      excluding: true,
                      child: Text('Decorative bullet point'),
                    ),
                    SizedBox(height: 4),
                    ExcludeSemantics(
                      excluding: true,
                      child: Text('Background pattern text'),
                    ),
                    SizedBox(height: 4),
                    ExcludeSemantics(
                      excluding: true,
                      child: Text('Ornamental divider label'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          'Green border = screen reader announces | Red border = screen reader skips',
          style: TextStyle(fontSize: 11, color: Color(0xFF757575)),
        ),
      ],
    ),
  );
}

// Section 7: Accessibility tree visualization
Widget _buildAccessibilityTreeVisualization() {
  print('[Section 7] Accessibility tree visualization');
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFFFF8E1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFFFA000), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What the screen reader sees:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Color(0xFFE65100),
            ),
          ),
          SizedBox(height: 12),
          _buildTreeNode('Root', 0, true),
          _buildTreeNode('Header: Product Details', 1, true),
          _buildTreeNode('[EXCLUDED] decorative banner image', 1, false),
          _buildTreeNode('Text: Premium Wireless Headphones', 2, true),
          _buildTreeNode('[EXCLUDED] star rating icons', 2, false),
          _buildTreeNode('Semantics: Rating 4.5 out of 5', 2, true),
          _buildTreeNode('[EXCLUDED] decorative divider', 2, false),
          _buildTreeNode('Text: Price \$79.99', 2, true),
          _buildTreeNode('Button: Add to Cart', 2, true),
          _buildTreeNode('[EXCLUDED] background gradient', 1, false),
          _buildTreeNode('Footer: Reviews section', 1, true),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(0xFFFFECB3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, size: 18, color: Color(0xFFE65100)),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Items marked [EXCLUDED] are invisible to assistive technologies.',
                    style: TextStyle(fontSize: 12, color: Color(0xFF795548)),
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

// Helper for tree node visualization
Widget _buildTreeNode(String label, int depth, bool isVisible) {
  print(
    '[TreeNode] depth=$depth visible=$isVisible -> $label',
  );
  String indent = '';
  for (int i = 0; i < depth; i++) {
    indent = '$indent  ';
  }
  String prefix = depth > 0 ? '|- ' : '';
  return Padding(
    padding: EdgeInsets.only(left: (depth * 16).toDouble(), top: 2, bottom: 2),
    child: Row(
      children: [
        Text(
          prefix,
          style: TextStyle(fontFamily: 'monospace', color: Color(0xFF9E9E9E)),
        ),
        Icon(
          isVisible ? Icons.check_circle_outline : Icons.cancel_outlined,
          size: 14,
          color: isVisible ? Color(0xFF43A047) : Color(0xFFE53935),
        ),
        SizedBox(width: 4),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'monospace',
              color: isVisible ? Color(0xFF212121) : Color(0xFFBDBDBD),
              decoration: isVisible
                  ? TextDecoration.none
                  : TextDecoration.lineThrough,
            ),
          ),
        ),
      ],
    ),
  );
}

// Section 8: ExcludeSemantics in list items
Widget _buildListItemsDemo() {
  print('[Section 8] ExcludeSemantics in list items');
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      children: [
        _buildAccessibleListItem(
          'Meeting with design team',
          'Today at 2:00 PM',
          Icons.event,
          Color(0xFF1E88E5),
        ),
        SizedBox(height: 8),
        _buildAccessibleListItem(
          'Code review: Authentication module',
          'Due tomorrow',
          Icons.code,
          Color(0xFF43A047),
        ),
        SizedBox(height: 8),
        _buildAccessibleListItem(
          'Deploy v2.5 to staging',
          'Scheduled for Friday',
          Icons.cloud_upload,
          Color(0xFFE65100),
        ),
      ],
    ),
  );
}

// Helper for accessible list items with excluded decorative parts
Widget _buildAccessibleListItem(
  String title,
  String subtitle,
  IconData iconData,
  Color accentColor,
) {
  print('[ListItem] $title');
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Row(
      children: [
        // Decorative icon container - excluded from semantics
        ExcludeSemantics(
          excluding: true,
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(iconData, color: accentColor, size: 24),
          ),
        ),
        SizedBox(width: 12),
        // Meaningful text content - included in semantics
        Expanded(
          child: ExcludeSemantics(
            excluding: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
                SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
                ),
              ],
            ),
          ),
        ),
        // Decorative chevron - excluded from semantics
        ExcludeSemantics(
          excluding: true,
          child: Icon(Icons.chevron_right, color: Color(0xFFBDBDBD)),
        ),
      ],
    ),
  );
}

// Section 9: ExcludeSemantics in cards
Widget _buildCardsDemo() {
  print('[Section 9] ExcludeSemantics in card layouts');
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      children: [
        _buildAccessibleCard(
          'Monthly Report',
          'Revenue up 15% from last month',
          Icons.trending_up,
          Color(0xFF43A047),
          '\$142,500',
        ),
        SizedBox(height: 12),
        _buildAccessibleCard(
          'Active Users',
          'Peak usage at 3 PM daily',
          Icons.people,
          Color(0xFF1E88E5),
          '12,847',
        ),
        SizedBox(height: 12),
        _buildAccessibleCard(
          'Server Health',
          'All systems operational',
          Icons.dns,
          Color(0xFF7B1FA2),
          '99.9%',
        ),
      ],
    ),
  );
}

// Helper for accessible cards
Widget _buildAccessibleCard(
  String title,
  String description,
  IconData iconData,
  Color accentColor,
  String metricValue,
) {
  print('[Card] $title -> $metricValue');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Color(0xFFE0E0E0)),
      boxShadow: [
        BoxShadow(
          color: Color(0x1A000000),
          blurRadius: 6,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // Decorative gradient background excluded
            ExcludeSemantics(
              excluding: true,
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      accentColor.withOpacity(0.2),
                      accentColor.withOpacity(0.05),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(iconData, color: accentColor, size: 26),
              ),
            ),
            SizedBox(width: 12),
            // Meaningful metric - included
            Expanded(
              child: Semantics(
                label: '$title metric',
                value: metricValue,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 13, color: Color(0xFF757575)),
                    ),
                    Text(
                      metricValue,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: accentColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        // Decorative divider excluded
        ExcludeSemantics(
          excluding: true,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Container(
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Color(0xFFE0E0E0),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ),
        // Description is meaningful - included
        ExcludeSemantics(
          excluding: false,
          child: Text(
            description,
            style: TextStyle(fontSize: 13, color: Color(0xFF616161)),
          ),
        ),
      ],
    ),
  );
}

// Section 10: ExcludeSemantics in form layouts
Widget _buildFormLayoutDemo() {
  print('[Section 10] ExcludeSemantics in form layouts');
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Decorative form header decoration excluded
          ExcludeSemantics(
            excluding: true,
            child: Container(
              height: 4,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF6A1B9A),
                    Color(0xFF1E88E5),
                    Color(0xFF43A047),
                  ],
                ),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          SizedBox(height: 12),
          // Form title - meaningful, not excluded
          Semantics(
            label: 'Registration form',
            hint: 'Fill in your details to create an account',
            child: Text(
              'Create Account',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 16),
          // Name field with excluded decorative icon
          _buildFormField(
            'Full Name',
            Icons.person_outline,
            'Enter your full name',
          ),
          SizedBox(height: 12),
          // Email field
          _buildFormField(
            'Email Address',
            Icons.email_outlined,
            'Enter your email',
          ),
          SizedBox(height: 12),
          // Password field
          _buildFormField('Password', Icons.lock_outline, 'Create a password'),
          SizedBox(height: 16),
          // Decorative terms ornament excluded
          ExcludeSemantics(
            excluding: true,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(width: 40, height: 1, color: Color(0xFFBDBDBD)),
                SizedBox(width: 8),
                Icon(Icons.shield, size: 14, color: Color(0xFFBDBDBD)),
                SizedBox(width: 8),
                Container(width: 40, height: 1, color: Color(0xFFBDBDBD)),
              ],
            ),
          ),
          SizedBox(height: 8),
          // Terms text - meaningful, included
          ExcludeSemantics(
            excluding: false,
            child: Text(
              'By signing up you agree to our Terms of Service and Privacy Policy.',
              style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 16),
          // Submit button - fully accessible
          MergeSemantics(
            child: Semantics(
              label: 'Create account button',
              hint: 'Double tap to submit the form',
              button: true,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF6A1B9A), Color(0xFF8E24AA)],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'Create Account',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// Helper for form fields with excluded decorative icons
Widget _buildFormField(String label, IconData iconData, String hint) {
  print('[FormField] $label');
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Row(
      children: [
        // Decorative icon excluded from semantics
        ExcludeSemantics(
          excluding: true,
          child: Icon(iconData, color: Color(0xFF9E9E9E), size: 22),
        ),
        SizedBox(width: 10),
        // Label and hint are meaningful - included
        Expanded(
          child: Semantics(
            label: label,
            hint: hint,
            textField: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF9E9E9E),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  hint,
                  style: TextStyle(fontSize: 14, color: Color(0xFFBDBDBD)),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// Footer with summary
Widget _buildFooter() {
  print('[Footer] Building summary footer');
  print('=== RenderExcludeSemantics Demo Complete ===');
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [Color(0xFF4A148C), Color(0xFF6A1B9A)]),
    ),
    child: Column(
      children: [
        ExcludeSemantics(
          excluding: true,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.auto_awesome, color: Color(0xFFCE93D8), size: 18),
              SizedBox(width: 8),
              Icon(Icons.auto_awesome, color: Color(0xFFCE93D8), size: 18),
              SizedBox(width: 8),
              Icon(Icons.auto_awesome, color: Color(0xFFCE93D8), size: 18),
            ],
          ),
        ),
        SizedBox(height: 12),
        Text(
          'ExcludeSemantics Summary',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Use ExcludeSemantics to hide decorative elements from screen readers.',
          style: TextStyle(color: Color(0xFFCE93D8), fontSize: 13),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 4),
        Text(
          'Combine with Semantics and MergeSemantics for comprehensive accessibility.',
          style: TextStyle(color: Color(0xFFCE93D8), fontSize: 13),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
