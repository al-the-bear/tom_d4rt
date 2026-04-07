// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — ScrollAwareImageProvider
// Demonstrates ScrollAwareImageProvider — a wrapper around ImageProvider
// that defers image resolution while the user is actively scrolling.
// This avoids decoding off-screen images that the user will never see,
// dramatically reducing memory usage and jank in image-heavy lists.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ScrollAwareImageProvider Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept — Why Scroll-Aware Loading?
  // ============================================================
  print('=== Section 1: Concept ===');

  // In a fast-scrolling ListView with hundreds of images,
  // the image pipeline normally starts loading every image
  // that enters the viewport — even briefly. This wastes:
  //
  //   • Memory: decoded images consume ~width*height*4 bytes
  //   • CPU: JPEG/PNG decoding is expensive
  //   • Bandwidth: network images are fetched then discarded
  //
  // ScrollAwareImageProvider wraps an ImageProvider and checks
  // the current ScrollPosition velocity. If the user is
  // scrolling fast, it defers resolution until scrolling slows
  // or stops. This is used internally by Image widget.

  final conceptCard = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFFFF3E0), Color(0xFFFFE0B2)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Color(0xFFE65100), width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Colors.orange.withValues(alpha: 0.15),
          blurRadius: 12.0,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.speed, size: 36.0, color: Color(0xFFE65100)),
            SizedBox(width: 12.0),
            Expanded(
              child: Text(
                'ScrollAwareImageProvider',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFBF360C),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Text(
          'A smart wrapper that defers image resolution while '
          'the user is scrolling fast. It monitors '
          'ScrollPosition velocity and only resolves the image '
          'when scrolling slows down or the widget is still '
          'visible.',
          style: TextStyle(fontSize: 14.0, color: Color(0xFFE65100)),
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Resources saved during fast scroll:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: Color(0xFFBF360C),
                ),
              ),
              SizedBox(height: 8.0),
              _buildScrollBullet(
                'Memory — no decoded bitmap allocation',
                Color(0xFF1565C0),
              ),
              _buildScrollBullet(
                'CPU — no JPEG/PNG decode work',
                Color(0xFF2E7D32),
              ),
              _buildScrollBullet(
                'Network — no wasted HTTP requests',
                Color(0xFFE65100),
              ),
              _buildScrollBullet(
                'GPU — no texture uploads discarded',
                Color(0xFF6A1B9A),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: How It Works — Decision Flow
  // ============================================================
  print('=== Section 2: Decision flow ===');

  Widget buildDecisionNode(
    String label,
    IconData icon,
    Color color,
    bool isDecision,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDecision ? 16.0 : 14.0,
        vertical: 8.0,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: isDecision
            ? BorderRadius.circular(0.0)
            : BorderRadius.circular(8.0),
        border: Border.all(color: color.withValues(alpha: 0.5)),
        shape: isDecision ? BoxShape.rectangle : BoxShape.rectangle,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 18.0),
          SizedBox(width: 8.0),
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDecisionArrow(String label, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0),
      child: Column(
        children: [
          Icon(Icons.arrow_downward, color: color, size: 14.0),
          if (label.isNotEmpty)
            Text(
              label,
              style: TextStyle(
                fontSize: 9.0,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
        ],
      ),
    );
  }

  final flowSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFFAFAFA),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      children: [
        Text(
          'Resolution Decision Flow',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'What happens when Image widget requests an image.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade500),
        ),
        SizedBox(height: 16.0),
        buildDecisionNode(
          'Image widget calls resolve()',
          Icons.image,
          Color(0xFF37474F),
          false,
        ),
        buildDecisionArrow('', Colors.grey.shade400),
        buildDecisionNode(
          'ScrollAwareImageProvider.resolveStreamForKey()',
          Icons.speed,
          Color(0xFFE65100),
          false,
        ),
        buildDecisionArrow('', Colors.grey.shade400),
        buildDecisionNode(
          'Is user scrolling fast?',
          Icons.help_outline,
          Color(0xFF6A1B9A),
          true,
        ),
        SizedBox(height: 6.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  'YES',
                  style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFC62828),
                  ),
                ),
                Icon(
                  Icons.arrow_downward,
                  color: Color(0xFFC62828),
                  size: 14.0,
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFC62828).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(
                      color: Color(0xFFC62828).withValues(alpha: 0.5),
                    ),
                  ),
                  child: Text(
                    'DEFER\nresolution',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFC62828),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 40.0),
            Column(
              children: [
                Text(
                  'NO',
                  style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
                  ),
                ),
                Icon(
                  Icons.arrow_downward,
                  color: Color(0xFF2E7D32),
                  size: 14.0,
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Color(0xFF2E7D32).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(
                      color: Color(0xFF2E7D32).withValues(alpha: 0.5),
                    ),
                  ),
                  child: Text(
                    'RESOLVE\nnormally',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Memory Impact Visualization
  // ============================================================
  print('=== Section 3: Memory impact ===');

  Widget buildMemoryBar(
    String label,
    double fillPercent,
    Color color,
    String mbLabel,
    bool isOptimised,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 120.0,
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      height: 20.0,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: fillPercent,
                      child: Container(
                        height: 20.0,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Center(
                          child: Text(
                            mbLabel,
                            style: TextStyle(
                              fontSize: 9.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.0),
              if (isOptimised)
                Icon(
                  Icons.eco,
                  color: Color(0xFF2E7D32),
                  size: 16.0,
                ),
            ],
          ),
        ],
      ),
    );
  }

  final memorySection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.memory, color: Color(0xFF1565C0), size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Memory Impact',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Text(
          'Estimated image memory during fast scroll through '
          '100 items (350×350 images ≈ 490 KB each decoded).',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade500),
        ),
        SizedBox(height: 16.0),
        Text(
          'Without ScrollAwareImageProvider:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 11.0,
            color: Color(0xFFC62828),
          ),
        ),
        SizedBox(height: 4.0),
        buildMemoryBar(
          'Visible (5)',
          0.10,
          Color(0xFF2E7D32),
          '2.5 MB',
          false,
        ),
        buildMemoryBar(
          'Loading (20+)',
          0.40,
          Color(0xFFF57C00),
          '10 MB',
          false,
        ),
        buildMemoryBar(
          'Decoded, unseen',
          0.65,
          Color(0xFFC62828),
          '32 MB',
          false,
        ),
        SizedBox(height: 12.0),
        Text(
          'With ScrollAwareImageProvider:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 11.0,
            color: Color(0xFF2E7D32),
          ),
        ),
        SizedBox(height: 4.0),
        buildMemoryBar(
          'Visible (5)',
          0.10,
          Color(0xFF2E7D32),
          '2.5 MB',
          true,
        ),
        buildMemoryBar(
          'Deferred',
          0.0,
          Colors.grey.shade300,
          '',
          true,
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFFE8F5E9),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Color(0xFF2E7D32)),
          ),
          child: Row(
            children: [
              Icon(Icons.savings,
                  color: Color(0xFF2E7D32), size: 20.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Savings: ~40 MB less memory during fast scroll. '
                  'Images resolve only when scrolling stops and they '
                  'are still visible.',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Color(0xFF1B5E20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: Velocity Threshold
  // ============================================================
  print('=== Section 4: Velocity threshold ===');

  Widget buildVelocityRange(
    String range,
    String scrollState,
    Color color,
    String action,
    double barFill,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 80.0,
            child: Container(
              height: 12.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3.0),
                color: Colors.grey.shade200,
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: barFill,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.0),
                    color: color,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 10.0),
          SizedBox(
            width: 70.0,
            child: Text(
              range,
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: 'monospace',
                color: Colors.grey.shade700,
              ),
            ),
          ),
          SizedBox(width: 6.0),
          SizedBox(
            width: 60.0,
            child: Text(
              scrollState,
              style: TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
          Expanded(
            child: Text(
              action,
              style: TextStyle(
                fontSize: 10.0,
                color: Colors.grey.shade600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final velocitySection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFE8EAF6), Color(0xFFC5CAE9)],
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFF3F51B5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.speed, color: Color(0xFF3F51B5), size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Velocity-Based Deferral',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A237E),
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Text(
          'ScrollPosition.activity.velocity determines behaviour.',
          style: TextStyle(fontSize: 11.0, color: Color(0xFF3F51B5)),
        ),
        SizedBox(height: 12.0),
        buildVelocityRange(
          '0 px/s',
          'Idle',
          Color(0xFF2E7D32),
          'Resolve immediately',
          0.0,
        ),
        buildVelocityRange(
          '<100 px/s',
          'Slow',
          Color(0xFF2E7D32),
          'Resolve immediately',
          0.15,
        ),
        buildVelocityRange(
          '100-500',
          'Medium',
          Color(0xFFF57C00),
          'Resolve (may defer on low-end)',
          0.4,
        ),
        buildVelocityRange(
          '500-2000',
          'Fast',
          Color(0xFFC62828),
          'Defer resolution',
          0.7,
        ),
        buildVelocityRange(
          '>2000 px/s',
          'Fling',
          Color(0xFFC62828),
          'Defer — images skip entirely',
          1.0,
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'The exact threshold is internal to Flutter\'s Image widget. '
            'ScrollAwareImageProvider checks if the scroll activity '
            'recommends deferring image loading.',
            style: TextStyle(
              fontSize: 10.0,
              fontStyle: FontStyle.italic,
              color: Colors.grey.shade600,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Integration with Image Widget
  // ============================================================
  print('=== Section 5: Image widget integration ===');

  final integrationSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.integration_instructions,
                color: Color(0xFF37474F), size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Image Widget Integration',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'Flutter\'s Image widget automatically wraps your '
          'ImageProvider in a ScrollAwareImageProvider when '
          'the Image is inside a Scrollable.',
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 12.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0xFF263238),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// What you write:\n'
            'ListView.builder(\n'
            '  itemBuilder: (ctx, i) => Image.network(\n'
            '    urls[i],\n'
            '  ),\n'
            ')\n'
            '\n'
            '// What Flutter does internally:\n'
            'ScrollAwareImageProvider(\n'
            '  context: ScrollAwareImageProvider\n'
            '      .getScrollContext(context),\n'
            '  imageProvider: NetworkImage(urls[i]),\n'
            ')',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              color: Color(0xFF80CBC4),
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFFFFF8E1),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Color(0xFFF9A825)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_outline,
                  color: Color(0xFFF9A825), size: 18.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'You almost never need to create '
                  'ScrollAwareImageProvider manually. It is '
                  'automatically used by Image, Image.network, '
                  'Image.asset, etc. when inside a scrollable.',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Color(0xFF795548),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Scrollable Types Supported
  // ============================================================
  print('=== Section 6: Scrollable types ===');

  Widget buildScrollTypeCard(
    String name,
    IconData icon,
    Color color,
    String description,
    bool supported,
  ) {
    return Container(
      width: 160.0,
      margin: EdgeInsets.all(4.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: supported
            ? color.withValues(alpha: 0.06)
            : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: supported
              ? color.withValues(alpha: 0.4)
              : Colors.grey.shade300,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: supported ? color : Colors.grey.shade400,
            size: 24.0,
          ),
          SizedBox(height: 6.0),
          Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 11.0,
              color: supported ? color : Colors.grey.shade500,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 9.0,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(height: 6.0),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 6.0,
              vertical: 2.0,
            ),
            decoration: BoxDecoration(
              color: supported
                  ? Color(0xFF2E7D32).withValues(alpha: 0.15)
                  : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              supported ? 'Auto-enabled' : 'Manual wrap',
              style: TextStyle(
                fontSize: 8.0,
                fontWeight: FontWeight.bold,
                color: supported
                    ? Color(0xFF2E7D32)
                    : Colors.grey.shade500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final scrollTypesSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      children: [
        Text(
          'Scrollable Types',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Where ScrollAwareImageProvider activates automatically.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade500),
        ),
        SizedBox(height: 12.0),
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            buildScrollTypeCard(
              'ListView',
              Icons.view_list,
              Color(0xFF1565C0),
              'Vertical or horizontal list',
              true,
            ),
            buildScrollTypeCard(
              'GridView',
              Icons.grid_view,
              Color(0xFF2E7D32),
              'Grid of items with images',
              true,
            ),
            buildScrollTypeCard(
              'CustomScrollView',
              Icons.view_agenda,
              Color(0xFFE65100),
              'Slivers with images',
              true,
            ),
            buildScrollTypeCard(
              'SingleChildScroll',
              Icons.vertical_align_center,
              Color(0xFF6A1B9A),
              'Single child scrollable',
              true,
            ),
            buildScrollTypeCard(
              'PageView',
              Icons.pages,
              Color(0xFF37474F),
              'Page-by-page navigation',
              true,
            ),
            buildScrollTypeCard(
              'Non-scrollable',
              Icons.block,
              Colors.grey,
              'Image outside Scrollable',
              false,
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Image Loading Timeline
  // ============================================================
  print('=== Section 7: Loading timeline ===');

  Widget buildTimelineEvent(
    String time,
    String event,
    Color color,
    bool isDeferred,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 50.0,
            child: Text(
              time,
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: 'monospace',
                color: Colors.grey.shade500,
              ),
            ),
          ),
          Column(
            children: [
              Container(
                width: 10.0,
                height: 10.0,
                decoration: BoxDecoration(
                  color: isDeferred
                      ? Colors.grey.shade300
                      : color,
                  shape: BoxShape.circle,
                  border: Border.all(color: color),
                ),
              ),
              Container(
                width: 2.0,
                height: 20.0,
                color: Colors.grey.shade300,
              ),
            ],
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: isDeferred
                    ? Colors.grey.shade100
                    : color.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                event,
                style: TextStyle(
                  fontSize: 10.0,
                  color: isDeferred
                      ? Colors.grey.shade500
                      : Colors.grey.shade700,
                  decoration: isDeferred
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  final timelineSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Loading Timeline — Fast Scroll',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'What happens to images as user flings through a list.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade500),
        ),
        SizedBox(height: 12.0),
        buildTimelineEvent(
          '0 ms',
          'User starts fling gesture (velocity 2400 px/s)',
          Color(0xFF37474F),
          false,
        ),
        buildTimelineEvent(
          '50 ms',
          'Image A enters viewport — DEFERRED (fast scroll)',
          Color(0xFFC62828),
          true,
        ),
        buildTimelineEvent(
          '120 ms',
          'Image B enters viewport — DEFERRED',
          Color(0xFFC62828),
          true,
        ),
        buildTimelineEvent(
          '200 ms',
          'Image C enters viewport — DEFERRED',
          Color(0xFFC62828),
          true,
        ),
        buildTimelineEvent(
          '350 ms',
          'Scroll velocity drops below threshold',
          Color(0xFFF57C00),
          false,
        ),
        buildTimelineEvent(
          '400 ms',
          'Image D enters viewport — RESOLVED',
          Color(0xFF2E7D32),
          false,
        ),
        buildTimelineEvent(
          '500 ms',
          'Scroll stops — all visible images resolved',
          Color(0xFF2E7D32),
          false,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryPanel = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFFFF3E0), Color(0xFFFFE0B2)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFFE65100), width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.summarize, color: Color(0xFFE65100), size: 28.0),
            SizedBox(width: 8.0),
            Text(
              'Summary',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFBF360C),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _buildScrollSummaryItem(
          Icons.speed,
          'Velocity-aware loading',
          'Defers image resolution during fast scrolling',
          Color(0xFFE65100),
        ),
        SizedBox(height: 8.0),
        _buildScrollSummaryItem(
          Icons.memory,
          'Memory optimization',
          'Prevents decoding images the user will never see',
          Color(0xFF1565C0),
        ),
        SizedBox(height: 8.0),
        _buildScrollSummaryItem(
          Icons.image,
          'Automatic integration',
          'Image widget wraps providers automatically inside scrollables',
          Color(0xFF2E7D32),
        ),
        SizedBox(height: 8.0),
        _buildScrollSummaryItem(
          Icons.view_list,
          'All scrollable types',
          'Works with ListView, GridView, CustomScrollView, PageView',
          Color(0xFF6A1B9A),
        ),
        SizedBox(height: 8.0),
        _buildScrollSummaryItem(
          Icons.auto_awesome,
          'Zero configuration',
          'No code changes needed — built into Flutter\'s Image pipeline',
          Color(0xFF37474F),
        ),
      ],
    ),
  );

  print('ScrollAwareImageProvider Deep Demo complete');

  // ============================================================
  // ASSEMBLE FINAL LAYOUT
  // ============================================================
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFBF360C),
                Color(0xFFE65100),
                Color(0xFFF57C00),
              ],
            ),
          ),
          child: Column(
            children: [
              Icon(Icons.speed, size: 48.0, color: Colors.white),
              SizedBox(height: 8.0),
              Text(
                'ScrollAwareImageProvider',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Smart image loading during scroll',
                style: TextStyle(fontSize: 13.0, color: Colors.white70),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.0),

        conceptCard,

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '2. Decision Flow',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        flowSection,
        SizedBox(height: 16.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '3. Memory Impact',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        memorySection,
        SizedBox(height: 16.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '4. Velocity Threshold',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        velocitySection,
        SizedBox(height: 16.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '5. Image Widget Integration',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        integrationSection,
        SizedBox(height: 16.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '6. Scrollable Types',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        scrollTypesSection,
        SizedBox(height: 16.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '7. Loading Timeline',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        timelineSection,
        SizedBox(height: 16.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '8. Summary',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        summaryPanel,
        SizedBox(height: 40.0),
      ],
    ),
  );
}

// ================================================================
// Helpers
// ================================================================
Widget _buildScrollBullet(String text, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 5.0),
          width: 6.0,
          height: 6.0,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 12.0, color: color),
          ),
        ),
      ],
    ),
  );
}

Widget _buildScrollSummaryItem(
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
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
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
