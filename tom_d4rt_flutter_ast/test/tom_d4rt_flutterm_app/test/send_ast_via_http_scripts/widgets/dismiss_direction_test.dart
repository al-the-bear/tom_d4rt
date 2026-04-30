// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — DismissDirection
// Demonstrates DismissDirection, the enum that controls which
// direction(s) a Dismissible widget can be swiped. Covers all
// seven enum values (horizontal, vertical, endToStart, startToEnd,
// up, down, none), visual direction diagrams, Dismissible integration,
// background widget patterns, callback anatomy, confirmation dialogs,
// real-world patterns, and best practices.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DismissDirection Deep Demo executing');

  // ============================================================
  // SECTION 1: What is DismissDirection?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.swipe,
      'title': 'Swipe Direction Control',
      'body': 'DismissDirection is an enum that tells the Dismissible '
          'widget which swipe gestures to recognize. It determines '
          'whether the user can swipe left, right, up, down, or '
          'any combination. If the user swipes in a non-allowed '
          'direction, the gesture is ignored.',
      'accent': Colors.red[700]!,
    },
    {
      'icon': Icons.delete_sweep,
      'title': 'Part of the Dismissible Widget',
      'body': 'Dismissible is a widget that can be dismissed by '
          'dragging in one or more directions. The direction property '
          'accepts a DismissDirection value. When the drag is complete '
          '(past the threshold), the widget animates off-screen and '
          'the onDismissed callback fires.',
      'accent': Colors.red[600]!,
    },
    {
      'icon': Icons.compare_arrows,
      'title': 'Seven Values',
      'body': 'The enum has seven values:\n'
          '• vertical — up or down\n'
          '• horizontal — left or right (end/start)\n'
          '• endToStart — right-to-left (LTR)\n'
          '• startToEnd — left-to-right (LTR)\n'
          '• up — upward only\n'
          '• down — downward only\n'
          '• none — dismissal disabled',
      'accent': Colors.pink[600]!,
    },
    {
      'icon': Icons.language,
      'title': 'RTL-Aware Naming',
      'body': 'The names "startToEnd" and "endToStart" are '
          'directionality-aware. In LTR locales, startToEnd means '
          'left→right and endToStart means right→left. In RTL '
          'locales, they reverse. This ensures correct behavior '
          'regardless of text direction.',
      'accent': Colors.pink[700]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: The Seven Enum Values
  // ============================================================
  print('=== Section 2: Enum Values ===');

  final enumValues = <Map<String, dynamic>>[
    {
      'name': 'horizontal',
      'icon': Icons.swap_horiz,
      'color': Colors.blue[600]!,
      'bgColor': Colors.blue[50]!,
      'arrow': '← →',
      'meaning': 'Allows dismissal by swiping either left or right '
          '(both startToEnd and endToStart). The user can choose '
          'either direction. Useful for lists where both directions '
          'have different actions (e.g., archive left, delete right).',
      'usage': 'Default: swipe either way to dismiss.',
    },
    {
      'name': 'vertical',
      'icon': Icons.swap_vert,
      'color': Colors.green[600]!,
      'bgColor': Colors.green[50]!,
      'arrow': '↑ ↓',
      'meaning': 'Allows dismissal by swiping either up or down. '
          'Less common than horizontal, but used in card stacks, '
          'notification panels, and vertically-oriented lists.',
      'usage': 'Card stack: swipe up to like, down to discard.',
    },
    {
      'name': 'endToStart',
      'icon': Icons.arrow_back,
      'color': Colors.red[600]!,
      'bgColor': Colors.red[50]!,
      'arrow': '← (LTR)  /  → (RTL)',
      'meaning': 'Allows dismissal only from the end side toward the '
          'start side. In LTR layouts, this is right-to-left. In '
          'RTL layouts, this is left-to-right. This is the most '
          'common direction for "delete" actions, following the '
          'iOS swipe-to-delete convention.',
      'usage': 'Swipe-to-delete in list items.',
    },
    {
      'name': 'startToEnd',
      'icon': Icons.arrow_forward,
      'color': Colors.orange[600]!,
      'bgColor': Colors.orange[50]!,
      'arrow': '→ (LTR)  /  ← (RTL)',
      'meaning': 'Allows dismissal only from the start side toward '
          'the end side. In LTR layouts, this is left-to-right. '
          'Often used for "archive" or "mark as read" actions, '
          'providing a different semantic than the delete direction.',
      'usage': 'Swipe-to-archive (Gmail-style left swipe).',
    },
    {
      'name': 'up',
      'icon': Icons.arrow_upward,
      'color': Colors.teal[600]!,
      'bgColor': Colors.teal[50]!,
      'arrow': '↑',
      'meaning': 'Allows dismissal by swiping upward only. Used in '
          'card interfaces, bottom sheets, and notification toasts '
          'that the user can flick upward to dismiss.',
      'usage': 'Dismiss a bottom notification by swiping up.',
    },
    {
      'name': 'down',
      'icon': Icons.arrow_downward,
      'color': Colors.purple[600]!,
      'bgColor': Colors.purple[50]!,
      'arrow': '↓',
      'meaning': 'Allows dismissal by swiping downward only. Used '
          'for top-positioned elements like banners, app bars, '
          'or floating cards that slide down to dismiss.',
      'usage': 'Dismiss a top banner by swiping down.',
    },
    {
      'name': 'none',
      'icon': Icons.block,
      'color': Colors.grey[600]!,
      'bgColor': Colors.grey[100]!,
      'arrow': '✕',
      'meaning': 'Disables dismissal entirely. The Dismissible widget '
          'still exists in the tree but will not respond to any '
          'swipe gestures. Useful for conditionally disabling '
          'dismissal (e.g., in edit mode or for pinned items).',
      'usage': 'Pinned items in a swipeable list.',
    },
  ];

  print('  Prepared ${enumValues.length} enum value descriptions');

  // ============================================================
  // SECTION 3: Visual Direction Diagrams
  // ============================================================
  print('=== Section 3: Visual Direction Diagrams ===');

  // Visual representation of each direction using colored containers
  // with arrow indicators to show the swipe gesture
  final directionVisuals = <Map<String, dynamic>>[
    {
      'direction': 'endToStart',
      'label': 'End → Start (Delete)',
      'swipeColor': Colors.red[400]!,
      'bgIcon': Icons.delete,
      'arrowAlignment': Alignment.centerRight,
    },
    {
      'direction': 'startToEnd',
      'label': 'Start → End (Archive)',
      'swipeColor': Colors.green[400]!,
      'bgIcon': Icons.archive,
      'arrowAlignment': Alignment.centerLeft,
    },
    {
      'direction': 'up',
      'label': 'Up (Dismiss)',
      'swipeColor': Colors.teal[400]!,
      'bgIcon': Icons.expand_less,
      'arrowAlignment': Alignment.topCenter,
    },
    {
      'direction': 'down',
      'label': 'Down (Drop)',
      'swipeColor': Colors.purple[400]!,
      'bgIcon': Icons.expand_more,
      'arrowAlignment': Alignment.bottomCenter,
    },
  ];

  print('  Prepared ${directionVisuals.length} direction visuals');

  // ============================================================
  // SECTION 4: Dismissible Integration
  // ============================================================
  print('=== Section 4: Dismissible Integration ===');

  final integrationAnatomy = <Map<String, dynamic>>[
    {
      'param': 'key',
      'type': 'Key (required)',
      'role': 'Unique identifier so Flutter can track which item '
          'was dismissed. Must be unique per item in the list.',
      'icon': Icons.vpn_key,
      'color': Colors.red[600]!,
    },
    {
      'param': 'direction',
      'type': 'DismissDirection',
      'role': 'Which direction(s) allow dismissal. Defaults to '
          'DismissDirection.horizontal.',
      'icon': Icons.swap_horiz,
      'color': Colors.blue[600]!,
    },
    {
      'param': 'onDismissed',
      'type': 'DismissDirectionCallback?',
      'role': 'Called after the dismiss animation completes. Receives '
          'the DismissDirection that was used, so you can take '
          'different actions per direction.',
      'icon': Icons.check_circle,
      'color': Colors.green[600]!,
    },
    {
      'param': 'confirmDismiss',
      'type': 'ConfirmDismissCallback?',
      'role': 'Called before dismissal to ask for confirmation. '
          'Return true to allow, false to cancel. Can show a dialog '
          'and await the user\'s response.',
      'icon': Icons.help_outline,
      'color': Colors.orange[600]!,
    },
    {
      'param': 'background',
      'type': 'Widget?',
      'role': 'Widget shown behind the child when swiped in the '
          'primary direction (startToEnd). Typically a colored '
          'container with an icon.',
      'icon': Icons.layers,
      'color': Colors.teal[600]!,
    },
    {
      'param': 'secondaryBackground',
      'type': 'Widget?',
      'role': 'Widget shown behind the child when swiped in the '
          'secondary direction (endToStart). If only background is '
          'set, it\'s used for both directions.',
      'icon': Icons.flip,
      'color': Colors.purple[600]!,
    },
    {
      'param': 'dismissThresholds',
      'type': 'Map<DismissDirection, double>',
      'role': 'Minimum drag fraction (0–1) for each direction before '
          'the dismiss is triggered. Default is 0.4 (40%) for all.',
      'icon': Icons.tune,
      'color': Colors.indigo[600]!,
    },
    {
      'param': 'movementDuration',
      'type': 'Duration',
      'role': 'How long the dismiss animation takes once the user '
          'releases. Default is 200ms.',
      'icon': Icons.timer,
      'color': Colors.pink[600]!,
    },
  ];

  print('  Listed ${integrationAnatomy.length} Dismissible parameters');

  // ============================================================
  // SECTION 5: Background Widget Patterns
  // ============================================================
  print('=== Section 5: Background Patterns ===');

  final backgroundPatterns = <Map<String, dynamic>>[
    {
      'title': 'Delete Background (endToStart)',
      'color': Colors.red[500]!,
      'icon': Icons.delete,
      'alignment': Alignment.centerRight,
      'desc': 'Red background with a trash icon aligned to the side '
          'being revealed. As the user swipes right-to-left, the '
          'red background with the delete icon slides into view.',
    },
    {
      'title': 'Archive Background (startToEnd)',
      'color': Colors.green[500]!,
      'icon': Icons.archive,
      'alignment': Alignment.centerLeft,
      'desc': 'Green background with an archive icon aligned left. '
          'Swiping left-to-right reveals the archive action. Can '
          'also show "Mark as Read" or "Pin" actions.',
    },
    {
      'title': 'Gradient Background',
      'color': Colors.orange[500]!,
      'icon': Icons.star,
      'alignment': Alignment.centerRight,
      'desc': 'A gradient from transparent to colored, so the '
          'background intensifies as the user drags further. Creates '
          'a progressive reveal effect.',
    },
    {
      'title': 'Text + Icon Background',
      'color': Colors.blue[500]!,
      'icon': Icons.share,
      'alignment': Alignment.centerLeft,
      'desc': 'Both an icon and a text label shown together: "Share" '
          'with a share icon. The text gives explicit feedback about '
          'what the swipe action will do.',
    },
  ];

  print('  Prepared ${backgroundPatterns.length} background patterns');

  // ============================================================
  // SECTION 6: Direction Comparison Table
  // ============================================================
  print('=== Section 6: Direction Comparison ===');

  final comparisonRows = <Map<String, String>>[
    {
      'direction': 'horizontal',
      'axes': 'Both',
      'ltrGesture': '← and →',
      'rtlGesture': '← and →',
      'useCase': 'Dual-action lists (delete + archive)',
    },
    {
      'direction': 'vertical',
      'axes': 'Both',
      'ltrGesture': '↑ and ↓',
      'rtlGesture': '↑ and ↓',
      'useCase': 'Card stacks, notification panels',
    },
    {
      'direction': 'endToStart',
      'axes': 'One',
      'ltrGesture': '→ to ←',
      'rtlGesture': '← to →',
      'useCase': 'Swipe-to-delete (iOS convention)',
    },
    {
      'direction': 'startToEnd',
      'axes': 'One',
      'ltrGesture': '← to →',
      'rtlGesture': '→ to ←',
      'useCase': 'Swipe-to-archive (Gmail style)',
    },
    {
      'direction': 'up',
      'axes': 'One',
      'ltrGesture': '↑',
      'rtlGesture': '↑',
      'useCase': 'Dismiss bottom sheets/toasts',
    },
    {
      'direction': 'down',
      'axes': 'One',
      'ltrGesture': '↓',
      'rtlGesture': '↓',
      'useCase': 'Dismiss top banners/headers',
    },
    {
      'direction': 'none',
      'axes': '—',
      'ltrGesture': '(disabled)',
      'rtlGesture': '(disabled)',
      'useCase': 'Pinned/locked items in a list',
    },
  ];

  print('  Prepared ${comparisonRows.length} comparison rows');

  // ============================================================
  // SECTION 7: Callback Anatomy
  // ============================================================
  print('=== Section 7: Callback Anatomy ===');

  final callbackInfo = <Map<String, dynamic>>[
    {
      'title': 'onDismissed(DismissDirection direction)',
      'icon': Icons.check,
      'color': Colors.green[600]!,
      'body': 'Called AFTER the dismiss animation completes and the '
          'widget has left the screen. The direction parameter tells '
          'you which way the user swiped, so you can take different '
          'actions:\n\n'
          'onDismissed: (direction) {\n'
          '  if (direction == DismissDirection.endToStart) {\n'
          '    deleteItem(item);\n'
          '  } else {\n'
          '    archiveItem(item);\n'
          '  }\n'
          '}',
    },
    {
      'title': 'confirmDismiss(DismissDirection direction)',
      'icon': Icons.help,
      'color': Colors.orange[600]!,
      'body': 'Called BEFORE the dismiss happens. Must return a '
          'Future<bool?>. Return true to allow dismissal, false '
          'to cancel (the widget snaps back). You can show a dialog:\n\n'
          'confirmDismiss: (direction) async {\n'
          '  return await showDialog<bool>(\n'
          '    context: context,\n'
          '    builder: (ctx) => AlertDialog(\n'
          '      title: Text("Delete?"),\n'
          '      actions: [\n'
          '        TextButton(onPressed: () => \n'
          '          Navigator.pop(ctx, false), child: Text("No")),\n'
          '        TextButton(onPressed: () => \n'
          '          Navigator.pop(ctx, true), child: Text("Yes")),\n'
          '      ],\n'
          '    ),\n'
          '  );\n'
          '}',
    },
    {
      'title': 'onResize()',
      'icon': Icons.height,
      'color': Colors.teal[600]!,
      'body': 'Called each animation frame during the resize that '
          'happens after dismissal. The list item shrinks to zero '
          'height. Useful for progress reporting or triggering '
          'side effects during the collapse animation.',
    },
    {
      'title': 'onUpdate(DismissUpdateDetails details)',
      'icon': Icons.update,
      'color': Colors.blue[600]!,
      'body': 'Called on each frame while the item is being dragged. '
          'Receives DismissUpdateDetails with: direction, reached, '
          'previousReached, progress. Useful for real-time UI '
          'feedback as the user drags (e.g., color intensity '
          'based on progress).',
    },
  ];

  print('  Listed ${callbackInfo.length} callback descriptions');

  // ============================================================
  // SECTION 8: Real-World Patterns
  // ============================================================
  print('=== Section 8: Real-World Patterns ===');

  final patterns = <Map<String, dynamic>>[
    {
      'title': 'Email List (Gmail Style)',
      'icon': Icons.mail,
      'color': Colors.red[500]!,
      'body': 'Use DismissDirection.horizontal with different '
          'backgrounds: startToEnd reveals green "Archive" icon, '
          'endToStart reveals red "Delete" icon. The onDismissed '
          'callback checks direction to choose the action.',
    },
    {
      'title': 'Todo List Item',
      'icon': Icons.check_box,
      'color': Colors.green[600]!,
      'body': 'Use DismissDirection.endToStart for "complete" action. '
          'The background shows a green checkmark. confirmDismiss '
          'can show an undo snackbar instead of a dialog for '
          'faster interaction.',
    },
    {
      'title': 'Notification Panel',
      'icon': Icons.notifications,
      'color': Colors.blue[600]!,
      'body': 'Use DismissDirection.horizontal to let users swipe '
          'notifications away in either direction. No confirmation '
          'needed — immediate dismissal with a simple fade.',
    },
    {
      'title': 'Shopping Cart Item',
      'icon': Icons.shopping_cart,
      'color': Colors.orange[600]!,
      'body': 'Use DismissDirection.endToStart with confirmDismiss '
          'to show a "Remove from cart?" dialog. The background '
          'shows quantity and price info that was hidden behind '
          'the item card.',
    },
    {
      'title': 'Card Stack (Tinder Style)',
      'icon': Icons.favorite,
      'color': Colors.pink[500]!,
      'body': 'Use DismissDirection.horizontal with thresholds. '
          'startToEnd = like (green), endToStart = skip (red). '
          'The key insight: each card is a separate Dismissible '
          'with a unique key. When dismissed, the next card appears.',
    },
  ];

  print('  Prepared ${patterns.length} real-world patterns');

  // ============================================================
  // SECTION 9: Tips & Gotchas
  // ============================================================
  print('=== Section 9: Tips & Gotchas ===');

  final tips = <Map<String, dynamic>>[
    {
      'icon': Icons.warning_amber,
      'title': 'Always Provide a Key',
      'body': 'Dismissible requires a Key to track which item was '
          'dismissed. Without a proper key, Flutter may dismiss the '
          'wrong item or fail to update the list correctly. Use '
          'ValueKey(item.id) or UniqueKey().',
      'severity': 'warning',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Remove from Data Source in onDismissed',
      'body': 'The onDismissed callback is where you remove the item '
          'from your data list and call setState(). If you don\'t '
          'remove it, the widget rebuilds and the dismissed item '
          'reappears — a very common bug.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Undo Pattern with SnackBar',
      'body': 'Instead of confirmDismiss with a dialog, a smoother '
          'UX is to dismiss immediately, show a SnackBar with an '
          '"Undo" button, and only commit the deletion when the '
          'SnackBar closes without undo being pressed.',
      'severity': 'tip',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'dismissThresholds Per Direction',
      'body': 'The dismissThresholds map lets you set different '
          'thresholds per direction. For destructive actions '
          '(delete), use a higher threshold (0.6) to prevent '
          'accidental dismissal. For less destructive actions '
          '(archive), use the default (0.4).',
      'severity': 'warning',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'DismissDirection.none for Conditional Dismissal',
      'body': 'Toggle between DismissDirection.horizontal and '
          'DismissDirection.none to enable/disable dismissal '
          'dynamically. Useful for edit mode, locked items, or '
          'items with pending network operations.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Combine with AnimatedList',
      'body': 'For the best visual experience, use Dismissible inside '
          'an AnimatedList instead of a regular ListView. This gives '
          'you insert/remove animations that complement the '
          'dismiss animation.',
      'severity': 'tip',
    },
  ];

  print('  Prepared ${tips.length} tips');

  // ============================================================
  // BUILD THE VISUAL LAYOUT
  // ============================================================
  print('=== Building visual layout ===');

  return Scaffold(
    backgroundColor: Colors.grey[50],
    appBar: AppBar(
      title: Text('DismissDirection'),
      backgroundColor: Colors.red[700],
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header banner ──
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.red[700]!, Colors.pink[500]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.swipe, color: Colors.white, size: 40),
                SizedBox(height: 12),
                Text(
                  'DismissDirection',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Controls which direction(s) a Dismissible widget '
                  'can be swiped. Seven values covering horizontal, '
                  'vertical, directional, and disabled swipe modes.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24),

          // ── Section 1: Concept ──
          _heading('1', 'What is DismissDirection?'),
          SizedBox(height: 12),
          ...conceptCards.map((card) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: _accentCard(card),
              )),

          SizedBox(height: 24),

          // ── Section 2: Enum Values ──
          _heading('2', 'The Seven Enum Values'),
          SizedBox(height: 12),
          ...enumValues.map((ev) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: ev['bgColor'] as Color,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: (ev['color'] as Color).withOpacity(0.4)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: ev['color'] as Color,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(ev['icon'] as IconData,
                              color: Colors.white, size: 20),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'DismissDirection.${ev['name']}',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'monospace',
                                    color: ev['color'] as Color),
                              ),
                              Text(ev['arrow'] as String,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[600])),
                            ],
                          ),
                        ),
                      ]),
                      SizedBox(height: 10),
                      Text(ev['meaning'] as String,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[800],
                              height: 1.4)),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(children: [
                          Icon(Icons.lightbulb_outline,
                              size: 14, color: Colors.grey[500]),
                          SizedBox(width: 6),
                          Expanded(
                            child: Text(ev['usage'] as String,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.grey[700])),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 3: Direction Visuals ──
          _heading('3', 'Visual Direction Diagrams'),
          SizedBox(height: 8),
          Text(
            'How each swipe direction reveals an action background. '
            'The item slides in the swipe direction, exposing the '
            'colored background underneath.',
            style: TextStyle(
                fontSize: 13, color: Colors.grey[600], height: 1.5),
          ),
          SizedBox(height: 12),
          ...directionVisuals.map((dv) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Stack(children: [
                    // Background (action)
                    Container(
                      width: double.infinity,
                      height: 70,
                      decoration: BoxDecoration(
                        color: dv['swipeColor'] as Color,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: dv['arrowAlignment'] as Alignment,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Icon(dv['bgIcon'] as IconData,
                          color: Colors.white, size: 28),
                    ),
                    // Foreground (item partially swiped)
                    Positioned(
                      left: dv['direction'] == 'startToEnd' ? 80 : 0,
                      right: dv['direction'] == 'endToStart' ? 80 : 0,
                      top: dv['direction'] == 'down' ? 20 : 0,
                      bottom: dv['direction'] == 'up' ? 20 : 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Row(children: [
                          Icon(Icons.drag_handle, color: Colors.grey[400]),
                          SizedBox(width: 10),
                          Text(dv['label'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                  color: Colors.grey[800])),
                        ]),
                      ),
                    ),
                  ]),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 4: Dismissible Integration ──
          _heading('4', 'Dismissible Parameter Anatomy'),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2))
              ],
            ),
            child: Column(children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.red[700],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Row(children: [
                  _cell('Parameter', bold: true, white: true, flex: 2),
                  _cell('Type', bold: true, white: true, flex: 2),
                  _cell('Role', bold: true, white: true, flex: 4),
                ]),
              ),
              ...integrationAnatomy.asMap().entries.map((entry) {
                final idx = entry.key;
                final p = entry.value;
                return Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  color: idx.isEven ? Colors.grey[50] : Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(p['icon'] as IconData,
                                size: 13, color: p['color'] as Color),
                            SizedBox(width: 4),
                            Expanded(
                              child: Text(p['param'] as String,
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'monospace')),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(p['type'] as String,
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'monospace',
                                color: Colors.red[700])),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(p['role'] as String,
                            style: TextStyle(
                                fontSize: 11, color: Colors.grey[700])),
                      ),
                    ],
                  ),
                );
              }),
            ]),
          ),

          SizedBox(height: 24),

          // ── Section 5: Background Patterns ──
          _heading('5', 'Background Widget Patterns'),
          SizedBox(height: 12),
          ...backgroundPatterns.map((bp) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(children: [
                    // Action preview
                    Container(
                      width: double.infinity,
                      height: 52,
                      decoration: BoxDecoration(
                        color: bp['color'] as Color,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                      alignment: bp['alignment'] as Alignment,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(bp['icon'] as IconData,
                              color: Colors.white, size: 22),
                          SizedBox(width: 8),
                          Text(bp['title'] as String,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                        ],
                      ),
                    ),
                    // Description
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                      child: Text(bp['desc'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ),
                  ]),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 6: Comparison Table ──
          _heading('6', 'Direction Comparison'),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2))
              ],
            ),
            child: Column(children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.red[700],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Row(children: [
                  _cell('Direction', bold: true, white: true, flex: 2),
                  _cell('Axes', bold: true, white: true, flex: 1),
                  _cell('LTR', bold: true, white: true, flex: 1),
                  _cell('RTL', bold: true, white: true, flex: 1),
                  _cell('Use Case', bold: true, white: true, flex: 3),
                ]),
              ),
              ...comparisonRows.asMap().entries.map((entry) {
                final idx = entry.key;
                final row = entry.value;
                return Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                  color: idx.isEven ? Colors.grey[50] : Colors.white,
                  child: Row(children: [
                    _cell(row['direction']!, bold: true, flex: 2),
                    _cell(row['axes']!, flex: 1),
                    _cell(row['ltrGesture']!, flex: 1),
                    _cell(row['rtlGesture']!, flex: 1),
                    _cell(row['useCase']!, flex: 3),
                  ]),
                );
              }),
            ]),
          ),

          SizedBox(height: 24),

          // ── Section 7: Callback Anatomy ──
          _heading('7', 'Callback Anatomy'),
          SizedBox(height: 12),
          ...callbackInfo.map((ci) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: ci['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(ci['icon'] as IconData,
                            color: ci['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(ci['title'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  fontFamily: 'monospace',
                                  color: Colors.grey[900])),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(ci['body'] as String,
                            style: TextStyle(
                                fontSize: 11,
                                fontFamily: 'monospace',
                                color: Colors.grey[800],
                                height: 1.4)),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 8: Real-World Patterns ──
          _heading('8', 'Real-World Patterns'),
          SizedBox(height: 12),
          ...patterns.map((p) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: p['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(p['icon'] as IconData,
                            color: p['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(p['title'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Text(p['body'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 9: Tips & Gotchas ──
          _heading('9', 'Tips, Pitfalls & Gotchas'),
          SizedBox(height: 12),
          ...tips.map((tip) {
            Color bgColor;
            Color borderColor;
            switch (tip['severity']) {
              case 'warning':
                bgColor = Colors.amber[50]!;
                borderColor = Colors.amber[400]!;
                break;
              case 'tip':
                bgColor = Colors.green[50]!;
                borderColor = Colors.green[400]!;
                break;
              default:
                bgColor = Colors.blue[50]!;
                borderColor = Colors.blue[300]!;
            }
            return Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border(
                      left: BorderSide(color: borderColor, width: 4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Icon(tip['icon'] as IconData,
                          color: borderColor, size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(tip['title'] as String,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Colors.grey[900])),
                      ),
                    ]),
                    SizedBox(height: 6),
                    Text(tip['body'] as String,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[800],
                            height: 1.4)),
                  ],
                ),
              ),
            );
          }),

          SizedBox(height: 32),

          // ── Footer ──
          Center(
            child: Text(
              'End of DismissDirection Deep Demo',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[400],
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    ),
  );
}

// ──────────────────────────────────────────────────────────
// Helper: Section heading
// ──────────────────────────────────────────────────────────
Widget _heading(String number, String title) {
  return Row(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.red[700],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(number,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14)),
        ),
      ),
      SizedBox(width: 10),
      Expanded(
        child: Text(title,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[900])),
      ),
    ],
  );
}

// ──────────────────────────────────────────────────────────
// Helper: accent card (left-border card)
// ──────────────────────────────────────────────────────────
Widget _accentCard(Map<String, dynamic> card) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border(
        left: BorderSide(color: card['accent'] as Color, width: 4),
      ),
      boxShadow: [
        BoxShadow(
            color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Icon(card['icon'] as IconData,
              color: card['accent'] as Color, size: 22),
          SizedBox(width: 10),
          Expanded(
            child: Text(card['title'] as String,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[900])),
          ),
        ]),
        SizedBox(height: 10),
        Text(card['body'] as String,
            style: TextStyle(
                fontSize: 13, color: Colors.grey[700], height: 1.5)),
      ],
    ),
  );
}

// ──────────────────────────────────────────────────────────
// Helper: Table cell
// ──────────────────────────────────────────────────────────
Widget _cell(String text,
    {bool bold = false, bool white = false, int flex = 1}) {
  return Expanded(
    flex: flex,
    child: Text(
      text,
      style: TextStyle(
        fontSize: 11,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        color: white ? Colors.white : Colors.grey[800],
        height: 1.3,
      ),
    ),
  );
}
