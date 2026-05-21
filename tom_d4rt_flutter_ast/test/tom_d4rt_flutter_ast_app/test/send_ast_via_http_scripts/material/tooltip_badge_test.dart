// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Tooltip and Badge widgets from material
// Deep Demo: Visual demonstration of tooltips and badges working together
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Tooltip and Badge Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept Overview - Tooltip vs Badge
  // ============================================================
  print('=== Section 1: Tooltip & Badge Concept Overview ===');

  final conceptCards = <Widget>[];

  // Concept Card 1: Tooltip
  conceptCards.add(
    Container(
      width: 220.0,
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo.shade50, Colors.blue.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.indigo.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.info_outline, size: 48.0, color: Colors.indigo),
          SizedBox(height: 12.0),
          Text(
            'Tooltip',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.indigo.shade900,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Floating label that appears\non hover or long-press to\nexplain a UI element',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.0, color: Colors.indigo.shade700),
          ),
          SizedBox(height: 10.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
            decoration: BoxDecoration(
              color: Colors.indigo.shade200,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              'a11y friendly',
              style: TextStyle(
                fontSize: 10.0,
                color: Colors.indigo.shade900,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  // Concept Card 2: Badge
  conceptCards.add(
    Container(
      width: 220.0,
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.red.shade50, Colors.pink.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.red.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Badge(
            label: Text('9'),
            backgroundColor: Colors.red,
            child: Icon(
              Icons.notifications_active,
              size: 48.0,
              color: Colors.red.shade700,
            ),
          ),
          SizedBox(height: 12.0),
          Text(
            'Badge',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.red.shade900,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Small status descriptor that\noverlays an icon, indicating\ncounts or new content',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.0, color: Colors.red.shade700),
          ),
          SizedBox(height: 10.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
            decoration: BoxDecoration(
              color: Colors.red.shade200,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              'attention-grabbing',
              style: TextStyle(
                fontSize: 10.0,
                color: Colors.red.shade900,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  // Concept Card 3: Combined
  conceptCards.add(
    Container(
      width: 220.0,
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple.shade50, Colors.deepPurple.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.purple.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Tooltip(
            message: 'You have 3 new messages',
            child: Badge(
              label: Text('3'),
              child: Icon(
                Icons.mail,
                size: 48.0,
                color: Colors.purple.shade700,
              ),
            ),
          ),
          SizedBox(height: 12.0),
          Text(
            'Combined Power',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.purple.shade900,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Use both together to show\na count and provide a\nrich explanation on hover',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.0, color: Colors.purple.shade700),
          ),
          SizedBox(height: 10.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
            decoration: BoxDecoration(
              color: Colors.purple.shade200,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              'great UX',
              style: TextStyle(
                fontSize: 10.0,
                color: Colors.purple.shade900,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
  );
  print('Created ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: Tooltip Configurations Gallery
  // ============================================================
  print('=== Section 2: Tooltip Configurations ===');

  // Different tooltip configurations
  final basicTooltip = Tooltip(
    message: 'Basic tooltip message',
    child: Icon(Icons.info, size: 36.0, color: Colors.blue),
  );
  print('Basic Tooltip created');

  final richTooltip = Tooltip(
    richMessage: TextSpan(
      children: [
        TextSpan(
          text: 'Bold ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextSpan(text: 'and '),
        TextSpan(
          text: 'italic',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ],
    ),
    child: Icon(Icons.text_fields, size: 36.0, color: Colors.teal),
  );
  print('Rich Tooltip created');

  final paddedTooltip = Tooltip(
    message: 'Tooltip with extra padding',
    padding: EdgeInsets.all(16.0),
    margin: EdgeInsets.symmetric(horizontal: 24.0),
    child: Icon(Icons.padding, size: 36.0, color: Colors.orange),
  );
  print('Padded Tooltip created');

  final offsetTooltip = Tooltip(
    message: 'Vertical offset 40',
    verticalOffset: 40.0,
    child: Icon(Icons.vertical_align_bottom, size: 36.0, color: Colors.green),
  );
  print('Offset Tooltip created');

  final aboveTooltip = Tooltip(
    message: 'Shows above target',
    preferBelow: false,
    child: Icon(Icons.arrow_upward, size: 36.0, color: Colors.purple),
  );
  print('Above Tooltip created');

  final decoratedTooltip = Tooltip(
    message: 'Custom decorated background',
    decoration: BoxDecoration(
      color: Colors.deepPurple,
      borderRadius: BorderRadius.circular(8.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black54,
          blurRadius: 6.0,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Icon(Icons.brush, size: 36.0, color: Colors.deepPurple),
  );
  print('Decorated Tooltip created');

  final styledTooltip = Tooltip(
    message: 'Yellow bold styled text',
    textStyle: TextStyle(
      color: Colors.yellow,
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
    ),
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: Icon(Icons.text_format, size: 36.0, color: Colors.amber),
  );
  print('Styled Tooltip created');

  final waitTooltip = Tooltip(
    message: 'Wait 1s before showing',
    waitDuration: Duration(seconds: 1),
    showDuration: Duration(seconds: 3),
    child: Icon(Icons.timer, size: 36.0, color: Colors.red),
  );
  print('Wait Tooltip created');

  final tapTooltip = Tooltip(
    message: 'Tap me to show tooltip',
    triggerMode: TooltipTriggerMode.tap,
    child: Icon(Icons.touch_app, size: 36.0, color: Colors.cyan),
  );
  print('Tap Tooltip created');

  final longPressTooltip = Tooltip(
    message: 'Long-press to trigger',
    triggerMode: TooltipTriggerMode.longPress,
    enableFeedback: true,
    child: Icon(Icons.touch_app, size: 36.0, color: Colors.indigo),
  );
  print('LongPress Tooltip created');

  final tallTooltip = Tooltip(
    message: 'Tooltip with min height 60',
    height: 60.0,
    textAlign: TextAlign.center,
    child: Icon(Icons.height, size: 36.0, color: Colors.brown),
  );
  print('Tall Tooltip created');

  final triggeredTooltip = Tooltip(
    message: 'Triggers callback',
    onTriggered: () {
      print('Tooltip triggered!');
    },
    child: Icon(Icons.notifications_active, size: 36.0, color: Colors.pink),
  );
  print('Triggered Tooltip created');

  // Build tooltip showcase cards
  final tooltipShowcase = <Map<String, dynamic>>[
    {'label': 'Basic', 'tip': basicTooltip, 'color': Colors.blue},
    {'label': 'Rich', 'tip': richTooltip, 'color': Colors.teal},
    {'label': 'Padded', 'tip': paddedTooltip, 'color': Colors.orange},
    {'label': 'Offset', 'tip': offsetTooltip, 'color': Colors.green},
    {'label': 'Above', 'tip': aboveTooltip, 'color': Colors.purple},
    {'label': 'Decorated', 'tip': decoratedTooltip, 'color': Colors.deepPurple},
    {'label': 'Styled', 'tip': styledTooltip, 'color': Colors.amber},
    {'label': 'Wait/Show', 'tip': waitTooltip, 'color': Colors.red},
    {'label': 'Tap', 'tip': tapTooltip, 'color': Colors.cyan},
    {'label': 'LongPress', 'tip': longPressTooltip, 'color': Colors.indigo},
    {'label': 'Tall', 'tip': tallTooltip, 'color': Colors.brown},
    {'label': 'Triggered', 'tip': triggeredTooltip, 'color': Colors.pink},
  ];

  final tooltipCards = <Widget>[];
  for (final entry in tooltipShowcase) {
    final color = entry['color'] as Color;
    tooltipCards.add(
      Container(
        width: 130.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.withValues(alpha: 0.5), width: 1.5),
        ),
        child: Column(
          children: [
            entry['tip'] as Widget,
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                entry['label'] as String,
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${tooltipCards.length} tooltip cards');

  // ============================================================
  // SECTION 3: Badge Configurations Gallery
  // ============================================================
  print('=== Section 3: Badge Configurations ===');

  final basicBadge = Badge(child: Icon(Icons.mail, size: 36.0));
  print('Basic Badge (dot) created');

  final labelBadge = Badge(
    label: Text('5'),
    child: Icon(Icons.notifications, size: 36.0),
  );
  print('Label Badge created');

  final overflowBadge = Badge(
    label: Text('99+'),
    child: Icon(Icons.shopping_cart, size: 36.0),
  );
  print('Overflow Badge created');

  final greenBadge = Badge(
    label: Text('New'),
    backgroundColor: Colors.green,
    child: Icon(Icons.star, size: 36.0),
  );
  print('Green Badge created');

  final blackBadge = Badge(
    label: Text('!'),
    textColor: Colors.yellow,
    backgroundColor: Colors.black,
    child: Icon(Icons.warning, size: 36.0),
  );
  print('Black/Yellow Badge created');

  final vipBadge = Badge(
    label: Text('VIP'),
    textStyle: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),
    backgroundColor: Colors.amber.shade700,
    child: Icon(Icons.person, size: 36.0),
  );
  print('VIP Badge created');

  final paddedBadge = Badge(
    label: Text('100'),
    padding: EdgeInsets.symmetric(horizontal: 8.0),
    backgroundColor: Colors.deepOrange,
    child: Icon(Icons.message, size: 36.0),
  );
  print('Padded Badge created');

  final largeBadge = Badge(
    label: Text('Big'),
    largeSize: 28.0,
    backgroundColor: Colors.indigo,
    child: Icon(Icons.circle_outlined, size: 36.0),
  );
  print('Large Badge created');

  final smallBadge = Badge(
    smallSize: 12.0,
    backgroundColor: Colors.pink,
    child: Icon(Icons.fiber_manual_record, size: 36.0),
  );
  print('Small Badge created');

  final alignedBadge = Badge(
    label: Text('1'),
    alignment: Alignment.bottomRight,
    backgroundColor: Colors.teal,
    child: Icon(Icons.folder, size: 36.0),
  );
  print('Aligned Badge created');

  final offsetBadge = Badge(
    label: Text('2'),
    offset: Offset(8.0, -8.0),
    backgroundColor: Colors.purple,
    child: Icon(Icons.attach_file, size: 36.0),
  );
  print('Offset Badge created');

  final hiddenBadge = Badge(
    label: Text('3'),
    isLabelVisible: false,
    child: Icon(Icons.inbox, size: 36.0),
  );
  print('Hidden Badge created');

  final factoryBadge = Badge.count(
    count: 42,
    backgroundColor: Colors.red,
    child: Icon(Icons.notifications, size: 36.0),
  );
  print('Badge.count(42) created');

  final factoryOverflowBadge = Badge.count(
    count: 1000,
    backgroundColor: Colors.red.shade800,
    child: Icon(Icons.email, size: 36.0),
  );
  print('Badge.count(1000) created');

  final badgeShowcase = <Map<String, dynamic>>[
    {'label': 'Dot', 'badge': basicBadge, 'color': Colors.red},
    {'label': 'Count 5', 'badge': labelBadge, 'color': Colors.red},
    {'label': '99+', 'badge': overflowBadge, 'color': Colors.red},
    {'label': 'Green New', 'badge': greenBadge, 'color': Colors.green},
    {'label': 'Black/Yellow', 'badge': blackBadge, 'color': Colors.black},
    {'label': 'VIP', 'badge': vipBadge, 'color': Colors.amber},
    {'label': 'Padded', 'badge': paddedBadge, 'color': Colors.deepOrange},
    {'label': 'Large', 'badge': largeBadge, 'color': Colors.indigo},
    {'label': 'Small Dot', 'badge': smallBadge, 'color': Colors.pink},
    {'label': 'Aligned', 'badge': alignedBadge, 'color': Colors.teal},
    {'label': 'Offset', 'badge': offsetBadge, 'color': Colors.purple},
    {'label': 'Hidden', 'badge': hiddenBadge, 'color': Colors.grey},
    {'label': 'count(42)', 'badge': factoryBadge, 'color': Colors.red},
    {'label': 'count(1000)', 'badge': factoryOverflowBadge, 'color': Colors.red.shade800},
  ];

  final badgeCards = <Widget>[];
  for (final entry in badgeShowcase) {
    final color = entry['color'] as Color;
    badgeCards.add(
      Container(
        width: 130.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.withValues(alpha: 0.5), width: 1.5),
        ),
        child: Column(
          children: [
            entry['badge'] as Widget,
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                entry['label'] as String,
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${badgeCards.length} badge cards');

  // ============================================================
  // SECTION 4: Real-World Combos
  // ============================================================
  print('=== Section 4: Real-World Combinations ===');

  // Notification icon with badge + tooltip
  final notificationCombo = Container(
    width: 200.0,
    padding: EdgeInsets.all(16.0),
    margin: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blue.shade50, Colors.blue.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.blue.shade300, width: 1.5),
    ),
    child: Column(
      children: [
        Tooltip(
          message: '7 unread notifications\nLast: 2 minutes ago',
          textAlign: TextAlign.center,
          waitDuration: Duration(milliseconds: 300),
          child: Badge(
            label: Text('7'),
            backgroundColor: Colors.red,
            child: Icon(
              Icons.notifications,
              size: 48.0,
              color: Colors.blue.shade900,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Text(
          'Notifications',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade900,
          ),
        ),
        Text(
          'Hover for details',
          style: TextStyle(fontSize: 10.0, color: Colors.blue.shade700),
        ),
      ],
    ),
  );
  print('Notification combo created');

  // Shopping cart with count badge
  final cartCombo = Container(
    width: 200.0,
    padding: EdgeInsets.all(16.0),
    margin: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.orange.shade50, Colors.orange.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.orange.shade300, width: 1.5),
    ),
    child: Column(
      children: [
        Tooltip(
          message: '3 items in cart\nSubtotal: \$42.99',
          decoration: BoxDecoration(
            color: Colors.orange.shade900,
            borderRadius: BorderRadius.circular(8.0),
          ),
          textStyle: TextStyle(color: Colors.white, fontSize: 12.0),
          padding: EdgeInsets.all(10.0),
          child: Badge.count(
            count: 3,
            backgroundColor: Colors.deepOrange,
            child: Icon(
              Icons.shopping_cart,
              size: 48.0,
              color: Colors.orange.shade900,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Text(
          'Shopping Cart',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.orange.shade900,
          ),
        ),
        Text(
          '3 items',
          style: TextStyle(fontSize: 10.0, color: Colors.orange.shade800),
        ),
      ],
    ),
  );
  print('Cart combo created');

  // IconButton with badge + tooltip
  final iconButtonCombo = Container(
    width: 200.0,
    padding: EdgeInsets.all(16.0),
    margin: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.green.shade50, Colors.green.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.green.shade300, width: 1.5),
    ),
    child: Column(
      children: [
        Badge(
          label: Text('12'),
          offset: Offset(2.0, -2.0),
          backgroundColor: Colors.green.shade700,
          child: Tooltip(
            message: '12 new chat messages',
            triggerMode: TooltipTriggerMode.tap,
            child: IconButton(
              iconSize: 40.0,
              icon: Icon(Icons.chat_bubble, color: Colors.green.shade800),
              onPressed: () {
                print('Chat button pressed');
              },
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'Messages',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green.shade900,
          ),
        ),
        Text(
          'Tap or hover',
          style: TextStyle(fontSize: 10.0, color: Colors.green.shade800),
        ),
      ],
    ),
  );
  print('IconButton combo created');

  // Gallery tile
  final galleryCombo = Container(
    width: 200.0,
    padding: EdgeInsets.all(16.0),
    margin: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.purple.shade50, Colors.purple.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.purple.shade300, width: 1.5),
    ),
    child: Column(
      children: [
        Tooltip(
          message: 'Photo Album\n8 new pictures\nLast updated today',
          textAlign: TextAlign.left,
          padding: EdgeInsets.all(12.0),
          child: Badge(
            label: Text('8'),
            backgroundColor: Colors.purple,
            largeSize: 20.0,
            child: Container(
              width: 56.0,
              height: 56.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple.shade300, Colors.purple.shade600],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(Icons.photo_library, size: 32.0, color: Colors.white),
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Text(
          'Photo Album',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.purple.shade900,
          ),
        ),
        Text(
          '8 new photos',
          style: TextStyle(fontSize: 10.0, color: Colors.purple.shade800),
        ),
      ],
    ),
  );
  print('Gallery combo created');

  // AppBar simulation row
  final appBarRow = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blueGrey.shade700, Colors.blueGrey.shade900],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Tooltip(
          message: 'Home',
          child: Badge(
            isLabelVisible: false,
            child: Icon(Icons.home, color: Colors.white, size: 28.0),
          ),
        ),
        Tooltip(
          message: '5 unread mails',
          child: Badge.count(
            count: 5,
            backgroundColor: Colors.red,
            child: Icon(Icons.mail, color: Colors.white, size: 28.0),
          ),
        ),
        Tooltip(
          message: '99+ notifications',
          child: Badge(
            label: Text('99+'),
            backgroundColor: Colors.red,
            child: Icon(Icons.notifications, color: Colors.white, size: 28.0),
          ),
        ),
        Tooltip(
          message: 'Profile',
          child: Badge(
            backgroundColor: Colors.green,
            smallSize: 10.0,
            child: Icon(Icons.account_circle, color: Colors.white, size: 28.0),
          ),
        ),
        Tooltip(
          message: 'Settings',
          child: Icon(Icons.settings, color: Colors.white, size: 28.0),
        ),
      ],
    ),
  );
  print('AppBar row created');

  // ============================================================
  // SECTION 5: Property Comparison Table
  // ============================================================
  print('=== Section 5: Property Comparison Table ===');

  final tableRows = <Map<String, String>>[
    {
      'property': 'message / label',
      'tooltip': 'message: String (text content)',
      'badge': 'label: Widget (count/text)',
    },
    {
      'property': 'rich content',
      'tooltip': 'richMessage: InlineSpan',
      'badge': 'label: Widget (any widget)',
    },
    {
      'property': 'background',
      'tooltip': 'decoration: Decoration',
      'badge': 'backgroundColor: Color',
    },
    {
      'property': 'text color',
      'tooltip': 'textStyle: TextStyle',
      'badge': 'textColor / textStyle',
    },
    {
      'property': 'padding',
      'tooltip': 'padding + margin',
      'badge': 'padding: EdgeInsetsGeometry',
    },
    {
      'property': 'position',
      'tooltip': 'preferBelow + verticalOffset',
      'badge': 'alignment + offset',
    },
    {
      'property': 'size',
      'tooltip': 'height: double',
      'badge': 'smallSize + largeSize',
    },
    {
      'property': 'visibility',
      'tooltip': 'always visible on trigger',
      'badge': 'isLabelVisible: bool',
    },
    {
      'property': 'trigger',
      'tooltip': 'triggerMode + wait/show',
      'badge': 'always rendered when visible',
    },
    {
      'property': 'callback',
      'tooltip': 'onTriggered',
      'badge': '(none, parent handles tap)',
    },
  ];

  final tableWidgets = <Widget>[];
  // Header row
  tableWidgets.add(
    Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade800,
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
              'Property',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'Tooltip',
              style: TextStyle(
                color: Colors.cyan.shade200,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'Badge',
              style: TextStyle(
                color: Colors.red.shade200,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  for (int i = 0; i < tableRows.length; i++) {
    final row = tableRows[i];
    final isEven = i % 2 == 0;
    final isLast = i == tableRows.length - 1;
    tableWidgets.add(
      Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: isEven ? Colors.grey.shade100 : Colors.grey.shade200,
          borderRadius: isLast
              ? BorderRadius.only(
                  bottomLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                )
              : null,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                row['property']!,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12.0,
                  color: Colors.blueGrey.shade900,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                row['tooltip']!,
                style: TextStyle(
                  fontSize: 11.0,
                  color: Colors.indigo.shade700,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                row['badge']!,
                style: TextStyle(
                  fontSize: 11.0,
                  color: Colors.red.shade700,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created comparison table with ${tableRows.length} rows');

  // Trigger mode comparison
  final triggerModes = <Map<String, dynamic>>[
    {
      'mode': 'longPress',
      'icon': Icons.touch_app,
      'desc': 'Default on mobile',
      'color': Colors.blue,
    },
    {
      'mode': 'tap',
      'icon': Icons.ads_click,
      'desc': 'Single tap shows',
      'color': Colors.green,
    },
    {
      'mode': 'manual',
      'icon': Icons.pan_tool,
      'desc': 'Programmatic only',
      'color': Colors.orange,
    },
  ];

  final triggerCards = <Widget>[];
  for (final mode in triggerModes) {
    final color = mode['color'] as Color;
    triggerCards.add(
      Container(
        width: 180.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.withValues(alpha: 0.5), width: 1.5),
        ),
        child: Column(
          children: [
            Icon(mode['icon'] as IconData, size: 36.0, color: color),
            SizedBox(height: 8.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                'TooltipTriggerMode.${mode['mode']}',
                style: TextStyle(
                  fontSize: 10.0,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
            SizedBox(height: 6.0),
            Text(
              mode['desc'] as String,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${triggerCards.length} trigger mode cards');

  // ============================================================
  // SECTION 6: Code Examples
  // ============================================================
  print('=== Section 6: Code Examples ===');

  final codePanel = Container(
    margin: EdgeInsets.all(16.0),
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
            Icon(Icons.code, color: Colors.cyan.shade400, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Tooltip Patterns',
              style: TextStyle(
                color: Colors.cyan.shade400,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// Basic tooltip\n'
            'Tooltip(\n'
            "  message: 'Delete item',\n"
            '  child: Icon(Icons.delete),\n'
            ');\n'
            '\n'
            '// Custom styled tooltip\n'
            'Tooltip(\n'
            "  message: 'Important info',\n"
            '  decoration: BoxDecoration(\n'
            '    color: Colors.deepPurple,\n'
            '    borderRadius: BorderRadius.circular(8),\n'
            '  ),\n'
            '  textStyle: TextStyle(color: Colors.yellow),\n'
            '  padding: EdgeInsets.all(12),\n'
            '  waitDuration: Duration(milliseconds: 500),\n'
            '  child: Icon(Icons.info),\n'
            ');',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.green.shade300,
            ),
          ),
        ),
        SizedBox(height: 16.0),
        Row(
          children: [
            Icon(Icons.code, color: Colors.red.shade300, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Badge Patterns',
              style: TextStyle(
                color: Colors.red.shade300,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// Dot badge\n'
            'Badge(child: Icon(Icons.mail));\n'
            '\n'
            '// Label badge\n'
            'Badge(\n'
            "  label: Text('NEW'),\n"
            '  backgroundColor: Colors.green,\n'
            '  child: Icon(Icons.star),\n'
            ');\n'
            '\n'
            '// Numeric badge factory\n'
            'Badge.count(\n'
            '  count: 42,\n'
            '  child: Icon(Icons.notifications),\n'
            ');\n'
            '\n'
            '// Hide badge dynamically\n'
            'Badge(\n'
            "  label: Text('3'),\n"
            '  isLabelVisible: hasNotifications,\n'
            '  child: Icon(Icons.inbox),\n'
            ');',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.orange.shade300,
            ),
          ),
        ),
        SizedBox(height: 16.0),
        Row(
          children: [
            Icon(Icons.code, color: Colors.purple.shade200, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Combined Pattern',
              style: TextStyle(
                color: Colors.purple.shade200,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// Notification icon with count and explanation\n'
            'Tooltip(\n'
            "  message: '\$count unread messages',\n"
            '  child: Badge.count(\n'
            '    count: count,\n'
            '    child: IconButton(\n'
            '      icon: Icon(Icons.notifications),\n'
            '      onPressed: openInbox,\n'
            '    ),\n'
            '  ),\n'
            ');',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.purple.shade300,
            ),
          ),
        ),
      ],
    ),
  );
  print('Created code panel');

  // ============================================================
  // SECTION 7: Summary Panel
  // ============================================================
  print('=== Section 7: Summary ===');

  final summaryPanel = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade100, Colors.pink.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade300, width: 2.0),
    ),
    child: Column(
      children: [
        Text(
          'Key Takeaways',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade900,
          ),
        ),
        SizedBox(height: 16.0),
        _buildSummaryItem(
          Icons.info_outline,
          'Tooltip = explanation',
          'Hover/longPress reveals helpful text',
          Colors.indigo,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.notifications_active,
          'Badge = status descriptor',
          'Tiny overlay for counts and "new" indicators',
          Colors.red,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.brush,
          'Style flexibility',
          'Custom decoration, padding, alignment, offset',
          Colors.deepPurple,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.touch_app,
          'Trigger modes',
          'longPress (default), tap, or manual control',
          Colors.green,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.accessibility,
          'Accessibility',
          'Tooltip integrates with screen readers',
          Colors.teal,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.merge,
          'Combine for power',
          'Badge count + Tooltip detail = great UX',
          Colors.pink,
        ),
      ],
    ),
  );
  print('Created summary panel');

  print('Tooltip and Badge Deep Demo completed successfully');

  // ============================================================
  // Final layout
  // ============================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Colors.grey.shade50,
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
                  colors: [Colors.indigo, Colors.pink.shade400],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.indigo.withValues(alpha: 0.3),
                    blurRadius: 12.0,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.info_outline, size: 48.0, color: Colors.white),
                      SizedBox(width: 12.0),
                      Badge(
                        label: Text('!'),
                        backgroundColor: Colors.amber,
                        textColor: Colors.black,
                        child: Icon(
                          Icons.notifications_active,
                          size: 48.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.0),
                  Text(
                    'Tooltip & Badge',
                    style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Material Information & Status Widgets',
                    style: TextStyle(fontSize: 14.0, color: Colors.white70),
                  ),
                ],
              ),
            ),
            SizedBox(height: 28.0),

            // Section 1
            Text(
              '1. Concept Overview',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            Wrap(
              alignment: WrapAlignment.center,
              children: conceptCards,
            ),
            SizedBox(height: 32.0),

            // Section 2
            Text(
              '2. Tooltip Configurations',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 6.0),
            Text(
              '(Hover or long-press the icons to see the tooltips)',
              style: TextStyle(fontSize: 12.0, color: Colors.grey.shade600),
            ),
            SizedBox(height: 12.0),
            Wrap(alignment: WrapAlignment.center, children: tooltipCards),
            SizedBox(height: 32.0),

            // Section 3
            Text(
              '3. Badge Configurations',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            Wrap(alignment: WrapAlignment.center, children: badgeCards),
            SizedBox(height: 32.0),

            // Section 4
            Text(
              '4. Real-World Combos',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            Wrap(
              alignment: WrapAlignment.center,
              children: [
                notificationCombo,
                cartCombo,
                iconButtonCombo,
                galleryCombo,
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Simulated AppBar Action Row:',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.grey.shade700,
                fontSize: 12.0,
              ),
            ),
            SizedBox(height: 8.0),
            appBarRow,
            SizedBox(height: 32.0),

            // Section 5
            Text(
              '5. Property Comparison',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(children: tableWidgets),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Tooltip Trigger Modes:',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                  fontSize: 13.0,
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Wrap(alignment: WrapAlignment.center, children: triggerCards),
            SizedBox(height: 32.0),

            // Section 6
            Text(
              '6. Code Examples',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            codePanel,
            SizedBox(height: 32.0),

            // Section 7
            Text(
              '7. Summary',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            summaryPanel,
            SizedBox(height: 24.0),
          ],
        ),
      ),
    ),
  );
}

// Helper: Build a summary list item
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
