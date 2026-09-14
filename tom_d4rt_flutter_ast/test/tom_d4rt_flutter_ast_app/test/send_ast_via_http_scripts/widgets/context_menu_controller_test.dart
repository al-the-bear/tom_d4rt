// ignore_for_file: avoid_print
// D4rt test script: Tests ContextMenuController from widgets/context_menu_controller.dart
// Deep Demo: Visual exploration of ContextMenuController — the overlay-based
// context menu manager that ensures only one menu is shown at a time.
//
// ContextMenuController manages a context menu displayed via the Overlay system.
// Key characteristics:
// - Only ONE context menu can be shown in the entire app at any time
// - Calling show() on one controller automatically hides any other visible menu
// - Menus are rendered as OverlayEntry widgets, layered above the main content
// - Captures InheritedTheme to style the menu consistently
// - Provides onRemove callback for cleanup when menu is dismissed
// - markNeedsBuild() allows dynamic menu content updates
//
// Scene 1 — Context Menu Architecture: how the controller/overlay system works
// Scene 2 — Basic Show/Remove: simple menu with lifecycle callbacks
// Scene 3 — Position-Aware Menus: showing menus at specific screen coordinates
// Scene 4 — Single Menu Enforcement: demonstrating the "one at a time" rule
// Scene 5 — Dynamic Menu Content: updating menus with markNeedsBuild()
// Scene 6 — Practical Patterns: action menus, icons, separators, auto-dismiss
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ContextMenuController Deep Demo executing');
  print('=' * 60);

  // ──────────────────────────────────────────────────────────
  // Color palette — slate/coral/cream professional menu theme
  // ──────────────────────────────────────────────────────────
  const cSlate = Color(0xFF37474F);       // blue-grey slate - primary
  const cCoral = Color(0xFFE57373);       // soft coral - accent
  const cCream = Color(0xFFFFFBF5);       // warm cream - surface
  const cNavy = Color(0xFF1A237E);        // deep navy - secondary
  const cTeal = Color(0xFF00695C);        // teal - success
  const cAmber = Color(0xFFF57F17);       // amber - warning
  const cForest = Color(0xFF2E7D32);      // forest - positive
  const cRose = Color(0xFFAD1457);        // rose - highlight
  const cPurple = Color(0xFF6A1B9A);      // purple - info

  // ──────────────────────────────────────────────────────────
  // Helper builders
  // ──────────────────────────────────────────────────────────

  Widget sceneHeader(String title, String subtitle, IconData icon, Color color) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 34.0, bottom: 14.0),
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 14.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withValues(alpha: 0.15), color.withValues(alpha: 0.03)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1.5),
      ),
      child: Row(
        children: [
          Container(
            width: 44.0,
            height: 44.0,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Icon(icon, color: color, size: 24.0),
          ),
          const SizedBox(width: 14.0),
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
                const SizedBox(height: 2.0),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: color.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget infoBox(String text, Color color) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11.5,
          color: cSlate.withValues(alpha: 0.85),
          height: 1.5,
        ),
      ),
    );
  }

  Widget codeSnippet(String code, Color borderColor) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: cSlate.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: borderColor.withValues(alpha: 0.15)),
      ),
      child: Text(
        code,
        style: TextStyle(
          fontSize: 10.0,
          fontFamily: 'monospace',
          color: cSlate.withValues(alpha: 0.8),
          height: 1.4,
        ),
      ),
    );
  }

  Widget tagLabel(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10.0,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  Widget demoCard({
    required String title,
    required String description,
    required Widget child,
    required Color accent,
    double? width,
  }) {
    return Container(
      width: width ?? 320.0,
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: accent.withValues(alpha: 0.3), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.08),
            blurRadius: 8.0,
            offset: const Offset(0.0, 3.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.06),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(11.0),
                topRight: Radius.circular(11.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                    color: accent,
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 10.5,
                    color: cSlate.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: child,
          ),
        ],
      ),
    );
  }

  /// Builds a styled menu widget suitable for context menu display.
  Widget buildStyledMenu({
    required List<_MenuItem> items,
    required Color accent,
    required VoidCallback? onDismiss,
  }) {
    return Container(
      width: 180.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: cSlate.withValues(alpha: 0.15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 12.0,
            offset: const Offset(0.0, 4.0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < items.length; i++) ...[
            if (items[i].isSeparator)
              Container(
                height: 1.0,
                margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                color: cSlate.withValues(alpha: 0.1),
              )
            else
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    print('  Menu item tapped: ${items[i].label}');
                    onDismiss?.call();
                  },
                  borderRadius: BorderRadius.vertical(
                    top: i == 0 ? const Radius.circular(8.0) : Radius.zero,
                    bottom: i == items.length - 1 ? const Radius.circular(8.0) : Radius.zero,
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                    child: Row(
                      children: [
                        if (items[i].icon != null) ...[
                          Icon(items[i].icon, size: 18.0, color: items[i].color ?? cSlate),
                          const SizedBox(width: 10.0),
                        ],
                        Expanded(
                          child: Text(
                            items[i].label,
                            style: TextStyle(
                              fontSize: 13.0,
                              color: items[i].color ?? cSlate,
                            ),
                          ),
                        ),
                        if (items[i].shortcut != null)
                          Text(
                            items[i].shortcut!,
                            style: TextStyle(
                              fontSize: 10.0,
                              color: cSlate.withValues(alpha: 0.4),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }

  // ════════════════════════════════════════════════════════════
  // SCENE 1 — Context Menu Architecture
  // ════════════════════════════════════════════════════════════
  print('\n--- Scene 1: Context Menu Architecture ---');
  print('How ContextMenuController uses Overlay to display menus');

  Widget pipelineBox(String label, String detail, IconData icon, Color color) {
    return Container(
      width: 100.0,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 22.0),
          const SizedBox(height: 4.0),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: color),
          ),
          const SizedBox(height: 2.0),
          Text(
            detail,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 8.0, color: color.withValues(alpha: 0.7)),
          ),
        ],
      ),
    );
  }

  final scene1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sceneHeader(
        'Scene 1 — Context Menu Architecture',
        'How ContextMenuController uses the Overlay system',
        Icons.layers,
        cSlate,
      ),
      infoBox(
        'ContextMenuController manages context menus as Overlay entries. When you '
        'call show(), it creates an OverlayEntry and inserts it into the root '
        'Overlay. The menu floats above all other content. A key rule: only ONE '
        'context menu can be shown at a time in the entire app. Calling show() '
        'on a second controller automatically removes any existing menu.',
        cSlate,
      ),

      // Pipeline diagram
      Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: cCream,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: cSlate.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Text(
              'Context Menu Flow',
              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: cSlate),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                pipelineBox('User\nGesture', 'Right-click\nLong-press', Icons.touch_app, cCoral),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Icon(Icons.arrow_forward, color: cSlate.withValues(alpha: 0.4), size: 16.0),
                ),
                pipelineBox('Controller\n.show()', 'Creates\nOverlayEntry', Icons.settings, cNavy),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Icon(Icons.arrow_forward, color: cSlate.withValues(alpha: 0.4), size: 16.0),
                ),
                pipelineBox('Overlay', 'Inserts\nentry', Icons.layers, cTeal),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Icon(Icons.arrow_forward, color: cSlate.withValues(alpha: 0.4), size: 16.0),
                ),
                pipelineBox('Menu\nWidget', 'Your custom\nmenu UI', Icons.menu, cForest),
              ],
            ),
            const SizedBox(height: 16.0),
            // Single menu rule callout
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: cCoral.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: cCoral.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning_amber, color: cCoral, size: 20.0),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Text(
                      'Only ONE context menu at a time! Calling show() on controller B '
                      'will automatically call removeAny() first, hiding controller A\'s menu.',
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.w600,
                        color: cCoral,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // Key methods table
      Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 6.0),
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: cNavy.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ContextMenuController API',
              style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: cNavy),
            ),
            const SizedBox(height: 10.0),
            for (final method in [
              {'name': 'show({context, contextMenuBuilder})', 'desc': 'Display the menu as an OverlayEntry', 'color': cForest},
              {'name': 'remove()', 'desc': 'Hide this controller\'s menu (if shown)', 'color': cTeal},
              {'name': 'removeAny() [static]', 'desc': 'Hide ANY currently shown menu', 'color': cAmber},
              {'name': 'isShown', 'desc': 'True if this controller\'s menu is visible', 'color': cPurple},
              {'name': 'markNeedsBuild()', 'desc': 'Rebuild the menu to reflect state changes', 'color': cCoral},
              {'name': 'onRemove callback', 'desc': 'Called when the menu is dismissed', 'color': cRose},
            ])
              Padding(
                padding: const EdgeInsets.only(bottom: 6.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 8.0,
                      height: 8.0,
                      margin: const EdgeInsets.only(top: 4.0),
                      decoration: BoxDecoration(
                        color: method['color'] as Color,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            method['name'] as String,
                            style: TextStyle(
                              fontSize: 11.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'monospace',
                              color: cSlate,
                            ),
                          ),
                          Text(
                            method['desc'] as String,
                            style: TextStyle(fontSize: 10.0, color: cSlate.withValues(alpha: 0.6)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),

      codeSnippet(
        'final controller = ContextMenuController(\n'
        '  onRemove: () => print("Menu dismissed"),\n'
        ');\n'
        '\n'
        '// Show the menu\n'
        'controller.show(\n'
        '  context: context,\n'
        '  contextMenuBuilder: (ctx) => MyMenuWidget(),\n'
        ');\n'
        '\n'
        '// Later: hide it\n'
        'controller.remove();',
        cSlate,
      ),
    ],
  );

  print('Scene 1 built: architecture pipeline + API reference');

  // ════════════════════════════════════════════════════════════
  // SCENE 2 — Basic Show/Remove Lifecycle
  // ════════════════════════════════════════════════════════════
  print('\n--- Scene 2: Basic Show/Remove Lifecycle ---');
  print('Creating a controller and managing menu visibility');

  final scene2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sceneHeader(
        'Scene 2 — Basic Show/Remove Lifecycle',
        'Creating and managing a simple context menu',
        Icons.play_circle_outline,
        cNavy,
      ),
      infoBox(
        'The basic flow: (1) create a ContextMenuController with an optional '
        'onRemove callback, (2) call show() with a context and builder function, '
        '(3) the menu appears as an overlay, (4) call remove() or removeAny() to '
        'hide it. The isShown property tracks visibility state.',
        cNavy,
      ),

      // Lifecycle visualization
      demoCard(
        title: 'Lifecycle Steps',
        description: 'From creation to dismissal',
        accent: cNavy,
        width: 400.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < 4; i++)
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    Container(
                      width: 28.0,
                      height: 28.0,
                      decoration: BoxDecoration(
                        color: [cNavy, cTeal, cForest, cCoral][i].withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(14.0),
                        border: Border.all(
                          color: [cNavy, cTeal, cForest, cCoral][i].withValues(alpha: 0.4),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '${i + 1}',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: [cNavy, cTeal, cForest, cCoral][i],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ['Create Controller', 'Call show()', 'Menu Visible', 'Call remove()'][i],
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              color: [cNavy, cTeal, cForest, cCoral][i],
                            ),
                          ),
                          Text(
                            [
                              'ContextMenuController(onRemove: callback)',
                              'controller.show(context: ctx, contextMenuBuilder: fn)',
                              'controller.isShown == true, menu floats in Overlay',
                              'Menu removed, onRemove called, isShown == false',
                            ][i],
                            style: TextStyle(fontSize: 10.0, color: cSlate.withValues(alpha: 0.6)),
                          ),
                        ],
                      ),
                    ),
                    if (i < 3)
                      Icon(Icons.arrow_downward, color: cSlate.withValues(alpha: 0.3), size: 16.0),
                  ],
                ),
              ),
          ],
        ),
      ),

      // onRemove callback demo
      demoCard(
        title: 'onRemove Callback',
        description: 'Getting notified when the menu is dismissed',
        accent: cCoral,
        width: 400.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: cCoral.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: cCoral.withValues(alpha: 0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.notifications_active, color: cCoral, size: 18.0),
                      const SizedBox(width: 8.0),
                      Text(
                        'onRemove fires when:',
                        style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: cCoral),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  for (final trigger in [
                    'User clicks outside the menu',
                    'controller.remove() is called',
                    'ContextMenuController.removeAny() is called',
                    'Another controller calls show() (auto-dismiss)',
                  ])
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Row(
                        children: [
                          Container(
                            width: 6.0,
                            height: 6.0,
                            decoration: BoxDecoration(
                              color: cCoral,
                              borderRadius: BorderRadius.circular(3.0),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: Text(
                              trigger,
                              style: TextStyle(fontSize: 10.5, color: cSlate.withValues(alpha: 0.7)),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            codeSnippet(
              'final controller = ContextMenuController(\n'
              '  onRemove: () {\n'
              '    // Clean up state, update UI, log analytics...\n'
              '    setState(() => _menuVisible = false);\n'
              '  },\n'
              ');',
              cCoral,
            ),
          ],
        ),
      ),

      // isShown property visualization
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          demoCard(
            title: 'isShown == false',
            description: 'Menu not visible',
            accent: cSlate,
            width: 180.0,
            child: Column(
              children: [
                Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: cSlate.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(30.0),
                    border: Border.all(color: cSlate.withValues(alpha: 0.2)),
                  ),
                  child: Icon(Icons.visibility_off, color: cSlate.withValues(alpha: 0.4), size: 28.0),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'No OverlayEntry',
                  style: TextStyle(fontSize: 11.0, color: cSlate.withValues(alpha: 0.6)),
                ),
              ],
            ),
          ),
          demoCard(
            title: 'isShown == true',
            description: 'Menu is visible',
            accent: cForest,
            width: 180.0,
            child: Column(
              children: [
                Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: cForest.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(30.0),
                    border: Border.all(color: cForest.withValues(alpha: 0.4)),
                  ),
                  child: Icon(Icons.visibility, color: cForest, size: 28.0),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Menu in Overlay',
                  style: TextStyle(fontSize: 11.0, color: cForest),
                ),
              ],
            ),
          ),
        ],
      ),
    ],
  );

  print('Scene 2 built: lifecycle steps + onRemove + isShown visualization');

  // ════════════════════════════════════════════════════════════
  // SCENE 3 — Position-Aware Menus
  // ════════════════════════════════════════════════════════════
  print('\n--- Scene 3: Position-Aware Menus ---');
  print('Showing menus at specific screen coordinates');

  final scene3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sceneHeader(
        'Scene 3 — Position-Aware Menus',
        'Displaying menus at specific screen coordinates',
        Icons.gps_fixed,
        cTeal,
      ),
      infoBox(
        'Context menus typically appear at the location of the user\'s gesture — '
        'right-click position, long-press point, etc. The contextMenuBuilder '
        'receives a BuildContext, but positioning is YOUR responsibility. You '
        'typically wrap your menu in a Positioned widget and calculate the offset.',
        cTeal,
      ),

      // Positioning pattern
      demoCard(
        title: 'Positioning Pattern',
        description: 'How to position a menu at tap coordinates',
        accent: cTeal,
        width: 400.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Visual coordinate system
            Container(
              width: double.infinity,
              height: 140.0,
              decoration: BoxDecoration(
                color: cCream,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: cTeal.withValues(alpha: 0.2)),
              ),
              child: Stack(
                children: [
                  // Grid lines
                  for (var i = 1; i < 4; i++)
                    Positioned(
                      left: i * 90.0,
                      top: 0.0,
                      bottom: 0.0,
                      child: Container(width: 1.0, color: cSlate.withValues(alpha: 0.1)),
                    ),
                  for (var i = 1; i < 3; i++)
                    Positioned(
                      top: i * 45.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(height: 1.0, color: cSlate.withValues(alpha: 0.1)),
                    ),
                  // Tap point indicator
                  Positioned(
                    left: 150.0,
                    top: 60.0,
                    child: Container(
                      width: 20.0,
                      height: 20.0,
                      decoration: BoxDecoration(
                        color: cCoral.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: cCoral, width: 2.0),
                      ),
                      child: Icon(Icons.touch_app, color: cCoral, size: 12.0),
                    ),
                  ),
                  // Positioned label
                  Positioned(
                    left: 130.0,
                    top: 35.0,
                    child: Text(
                      'globalPosition',
                      style: TextStyle(
                        fontSize: 9.0,
                        fontWeight: FontWeight.bold,
                        color: cCoral,
                      ),
                    ),
                  ),
                  // Menu mockup at position
                  Positioned(
                    left: 175.0,
                    top: 60.0,
                    child: Container(
                      width: 100.0,
                      padding: const EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6.0),
                        border: Border.all(color: cSlate.withValues(alpha: 0.2)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 6.0,
                            offset: const Offset(0.0, 2.0),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Menu Item', style: TextStyle(fontSize: 9.0, color: cSlate)),
                          Text('Menu Item', style: TextStyle(fontSize: 9.0, color: cSlate)),
                        ],
                      ),
                    ),
                  ),
                  // Arrow showing direction
                  Positioned(
                    left: 167.0,
                    top: 68.0,
                    child: Icon(Icons.arrow_right_alt, color: cTeal, size: 14.0),
                  ),
                  // Origin label
                  Positioned(
                    left: 4.0,
                    top: 4.0,
                    child: Text(
                      '(0,0)',
                      style: TextStyle(fontSize: 8.0, color: cSlate.withValues(alpha: 0.4)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            codeSnippet(
              'GestureDetector(\n'
              '  onSecondaryTapDown: (details) {\n'
              '    _tapPosition = details.globalPosition;\n'
              '    _controller.show(\n'
              '      context: context,\n'
              '      contextMenuBuilder: (ctx) => Positioned(\n'
              '        left: _tapPosition.dx,\n'
              '        top: _tapPosition.dy,\n'
              '        child: MyMenu(),\n'
              '      ),\n'
              '    );\n'
              '  },\n'
              '  child: content,\n'
              ')',
              cTeal,
            ),
          ],
        ),
      ),

      // Gesture types comparison
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          demoCard(
            title: 'Right-Click (Desktop)',
            description: 'onSecondaryTapDown for mouse',
            accent: cNavy,
            width: 185.0,
            child: Column(
              children: [
                Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: cNavy.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: cNavy.withValues(alpha: 0.3)),
                  ),
                  child: Icon(Icons.mouse, color: cNavy, size: 24.0),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Secondary button\nor two-finger tap',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10.0, color: cSlate.withValues(alpha: 0.6)),
                ),
              ],
            ),
          ),
          demoCard(
            title: 'Long-Press (Mobile)',
            description: 'onLongPressStart for touch',
            accent: cCoral,
            width: 185.0,
            child: Column(
              children: [
                Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: cCoral.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: cCoral.withValues(alpha: 0.3)),
                  ),
                  child: Icon(Icons.touch_app, color: cCoral, size: 24.0),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Press and hold\nfor ~500ms',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10.0, color: cSlate.withValues(alpha: 0.6)),
                ),
              ],
            ),
          ),
        ],
      ),

      // Edge case handling
      demoCard(
        title: 'Edge Detection',
        description: 'Preventing menus from going off-screen',
        accent: cAmber,
        width: 400.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: cAmber.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: cAmber.withValues(alpha: 0.2)),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning_amber, color: cAmber, size: 20.0),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Text(
                      'If user clicks near screen edge, menu may overflow. '
                      'Calculate adjusted position based on menu size and screen bounds.',
                      style: TextStyle(fontSize: 10.5, color: cSlate.withValues(alpha: 0.7)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8.0),
            codeSnippet(
              '// Adjust position if too close to edge\n'
              'final screenSize = MediaQuery.sizeOf(context);\n'
              'final menuWidth = 180.0;\n'
              'final menuHeight = 200.0;\n'
              '\n'
              'var x = tapPosition.dx;\n'
              'var y = tapPosition.dy;\n'
              '\n'
              'if (x + menuWidth > screenSize.width) {\n'
              '  x = screenSize.width - menuWidth - 8;\n'
              '}\n'
              'if (y + menuHeight > screenSize.height) {\n'
              '  y = screenSize.height - menuHeight - 8;\n'
              '}',
              cAmber,
            ),
          ],
        ),
      ),
    ],
  );

  print('Scene 3 built: positioning pattern + gesture types + edge detection');

  // ════════════════════════════════════════════════════════════
  // SCENE 4 — Single Menu Enforcement
  // ════════════════════════════════════════════════════════════
  print('\n--- Scene 4: Single Menu Enforcement ---');
  print('Demonstrating that only one menu can be shown at a time');

  final scene4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sceneHeader(
        'Scene 4 — Single Menu Enforcement',
        'Only ONE context menu can be visible in the entire app',
        Icons.filter_1,
        cCoral,
      ),
      infoBox(
        'This is a critical design decision in Flutter: context menus are '
        'exclusive. If controller A\'s menu is showing and you call show() on '
        'controller B, the framework first calls removeAny() to hide A\'s menu, '
        'then shows B\'s menu. Both controllers\' onRemove callbacks fire appropriately.',
        cCoral,
      ),

      // Visual demonstration
      Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: cCream,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: cCoral.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Text(
              'Two Controllers, One Menu Slot',
              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: cCoral),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Controller A
                Column(
                  children: [
                    Container(
                      width: 120.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                        color: cNavy.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: cNavy.withValues(alpha: 0.3)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.looks_one, color: cNavy, size: 28.0),
                          const SizedBox(height: 4.0),
                          Text(
                            'Controller A',
                            style: TextStyle(
                              fontSize: 11.0,
                              fontWeight: FontWeight.bold,
                              color: cNavy,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                      decoration: BoxDecoration(
                        color: cForest.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Text(
                        'Menu A (was showing)',
                        style: TextStyle(fontSize: 9.0, color: cForest),
                      ),
                    ),
                  ],
                ),
                // Arrow and "show()" label
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                      decoration: BoxDecoration(
                        color: cCoral.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Text(
                        'B.show() called',
                        style: TextStyle(
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,
                          color: cCoral,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Icon(Icons.arrow_forward, color: cCoral, size: 24.0),
                    const SizedBox(height: 8.0),
                    Text(
                      'A is auto-\nremoved',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 9.0, color: cSlate.withValues(alpha: 0.5)),
                    ),
                  ],
                ),
                // Controller B
                Column(
                  children: [
                    Container(
                      width: 120.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                        color: cTeal.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: cTeal.withValues(alpha: 0.4), width: 2.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.looks_two, color: cTeal, size: 28.0),
                          const SizedBox(height: 4.0),
                          Text(
                            'Controller B',
                            style: TextStyle(
                              fontSize: 11.0,
                              fontWeight: FontWeight.bold,
                              color: cTeal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                      decoration: BoxDecoration(
                        color: cTeal.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(6.0),
                        border: Border.all(color: cTeal),
                      ),
                      child: Text(
                        'Menu B (now showing)',
                        style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.bold, color: cTeal),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            // Sequence callout
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: cSlate.withValues(alpha: 0.15)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'What happens when B.show() is called:',
                    style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold, color: cSlate),
                  ),
                  const SizedBox(height: 6.0),
                  for (var i = 0; i < 4; i++)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3.0),
                      child: Row(
                        children: [
                          Container(
                            width: 18.0,
                            height: 18.0,
                            decoration: BoxDecoration(
                              color: [cCoral, cCoral, cTeal, cTeal][i].withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(9.0),
                            ),
                            child: Center(
                              child: Text(
                                '${i + 1}',
                                style: TextStyle(
                                  fontSize: 9.0,
                                  fontWeight: FontWeight.bold,
                                  color: [cCoral, cCoral, cTeal, cTeal][i],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: Text(
                              [
                                'removeAny() is called (hides A\'s menu)',
                                'A.onRemove callback fires',
                                'B\'s OverlayEntry is created and inserted',
                                '_shownInstance is set to B',
                              ][i],
                              style: TextStyle(fontSize: 10.0, color: cSlate.withValues(alpha: 0.7)),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),

      // Why single-menu?
      demoCard(
        title: 'Why Single Menu?',
        description: 'Design rationale behind this constraint',
        accent: cPurple,
        width: 400.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final reason in [
              {'icon': Icons.psychology, 'text': 'User focus: Multiple menus are confusing'},
              {'icon': Icons.layers_clear, 'text': 'Visual clarity: Overlapping menus look broken'},
              {'icon': Icons.touch_app, 'text': 'Interaction simplicity: One decision at a time'},
              {'icon': Icons.memory, 'text': 'Resource efficiency: One overlay entry, not many'},
            ])
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    Container(
                      width: 32.0,
                      height: 32.0,
                      decoration: BoxDecoration(
                        color: cPurple.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Icon(reason['icon'] as IconData, color: cPurple, size: 18.0),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: Text(
                        reason['text'] as String,
                        style: TextStyle(fontSize: 11.0, color: cSlate.withValues(alpha: 0.7)),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    ],
  );

  print('Scene 4 built: single-menu enforcement + sequence + rationale');

  // ════════════════════════════════════════════════════════════
  // SCENE 5 — Dynamic Menu Content (markNeedsBuild)
  // ════════════════════════════════════════════════════════════
  print('\n--- Scene 5: Dynamic Menu Content ---');
  print('Updating menu content with markNeedsBuild()');

  final scene5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sceneHeader(
        'Scene 5 — Dynamic Menu Content',
        'Updating menu content while it\'s visible using markNeedsBuild()',
        Icons.sync,
        cForest,
      ),
      infoBox(
        'Sometimes a menu\'s content needs to change after it\'s already shown — '
        'for example, showing download progress, toggling a checkbox, or updating '
        'based on external state. Call markNeedsBuild() on the controller to '
        'trigger a rebuild of the OverlayEntry. Your contextMenuBuilder will be '
        'called again with fresh state.',
        cForest,
      ),

      // markNeedsBuild pattern
      demoCard(
        title: 'markNeedsBuild() Pattern',
        description: 'Rebuild the menu to reflect state changes',
        accent: cForest,
        width: 400.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: cForest.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: cForest.withValues(alpha: 0.2)),
              ),
              child: Row(
                children: [
                  // Before state
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'Before',
                          style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: cSlate.withValues(alpha: 0.6)),
                        ),
                        const SizedBox(height: 6.0),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6.0),
                            border: Border.all(color: cSlate.withValues(alpha: 0.15)),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.check_box_outline_blank, color: cSlate, size: 14.0),
                                  const SizedBox(width: 4.0),
                                  Text('Option A', style: TextStyle(fontSize: 10.0, color: cSlate)),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.check_box_outline_blank, color: cSlate, size: 14.0),
                                  const SizedBox(width: 4.0),
                                  Text('Option B', style: TextStyle(fontSize: 10.0, color: cSlate)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Arrow
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        Icon(Icons.arrow_forward, color: cForest, size: 20.0),
                        Text(
                          'markNeeds\nBuild()',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 8.0, fontWeight: FontWeight.bold, color: cForest),
                        ),
                      ],
                    ),
                  ),
                  // After state
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'After',
                          style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: cForest),
                        ),
                        const SizedBox(height: 6.0),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6.0),
                            border: Border.all(color: cForest.withValues(alpha: 0.3)),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.check_box, color: cForest, size: 14.0),
                                  const SizedBox(width: 4.0),
                                  Text('Option A', style: TextStyle(fontSize: 10.0, color: cForest)),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.check_box_outline_blank, color: cSlate, size: 14.0),
                                  const SizedBox(width: 4.0),
                                  Text('Option B', style: TextStyle(fontSize: 10.0, color: cSlate)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            codeSnippet(
              'Set<String> _selected = {};\n'
              '\n'
              'void _toggleOption(String option) {\n'
              '  setState(() {\n'
              '    if (_selected.contains(option)) {\n'
              '      _selected.remove(option);\n'
              '    } else {\n'
              '      _selected.add(option);\n'
              '    }\n'
              '  });\n'
              '  // Trigger menu rebuild to show new checkboxes\n'
              '  if (_controller.isShown) {\n'
              '    _controller.markNeedsBuild();\n'
              '  }\n'
              '}',
              cForest,
            ),
          ],
        ),
      ),

      // Use cases for dynamic menus
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          demoCard(
            title: 'Progress Indicators',
            description: 'Show ongoing operation status',
            accent: cAmber,
            width: 175.0,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: cSlate.withValues(alpha: 0.15)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 14.0,
                        height: 14.0,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                          color: cAmber,
                        ),
                      ),
                      const SizedBox(width: 6.0),
                      Text('Downloading...', style: TextStyle(fontSize: 10.0, color: cSlate)),
                    ],
                  ),
                  const SizedBox(height: 6.0),
                  Container(
                    height: 4.0,
                    decoration: BoxDecoration(
                      color: cSlate.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                    child: FractionallySizedBox(
                      widthFactor: 0.65,
                      alignment: Alignment.centerLeft,
                      child: Container(
                        decoration: BoxDecoration(
                          color: cAmber,
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text('65%', style: TextStyle(fontSize: 9.0, color: cAmber, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          demoCard(
            title: 'Toggle Options',
            description: 'Multi-select checkboxes',
            accent: cTeal,
            width: 175.0,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: cSlate.withValues(alpha: 0.15)),
              ),
              child: Column(
                children: [
                  for (final opt in [
                    {'label': 'Bold', 'checked': true},
                    {'label': 'Italic', 'checked': false},
                    {'label': 'Underline', 'checked': true},
                  ])
                    Row(
                      children: [
                        Icon(
                          (opt['checked'] as bool) ? Icons.check_box : Icons.check_box_outline_blank,
                          size: 14.0,
                          color: (opt['checked'] as bool) ? cTeal : cSlate.withValues(alpha: 0.4),
                        ),
                        const SizedBox(width: 6.0),
                        Text(opt['label'] as String, style: TextStyle(fontSize: 10.0, color: cSlate)),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),

      // Warning about markNeedsBuild
      Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: cCoral.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: cCoral.withValues(alpha: 0.3)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.warning_amber, color: cCoral, size: 22.0),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Important: Only call markNeedsBuild() when isShown == true',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: cCoral,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'Calling markNeedsBuild() when the menu is not shown will cause an '
                    'assertion error. Always check controller.isShown first.',
                    style: TextStyle(fontSize: 10.5, color: cSlate.withValues(alpha: 0.7)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );

  print('Scene 5 built: markNeedsBuild pattern + use cases + warning');

  // ════════════════════════════════════════════════════════════
  // SCENE 6 — Practical Patterns
  // ════════════════════════════════════════════════════════════
  print('\n--- Scene 6: Practical Patterns ---');
  print('Real-world context menu patterns and implementations');

  final scene6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sceneHeader(
        'Scene 6 — Practical Patterns',
        'Real-world context menu implementations',
        Icons.build_circle,
        cPurple,
      ),
      infoBox(
        'Here are common patterns for implementing context menus in production '
        'apps. These cover action menus with icons, menus with separators, '
        'keyboard shortcuts display, and proper dismiss handling.',
        cPurple,
      ),

      // Pattern 1: Action Menu with icons
      demoCard(
        title: 'Pattern: Action Menu with Icons',
        description: 'Standard edit operations with keyboard shortcuts',
        accent: cNavy,
        width: 380.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildStyledMenu(
              items: [
                _MenuItem(icon: Icons.content_cut, label: 'Cut', shortcut: '⌘X'),
                _MenuItem(icon: Icons.content_copy, label: 'Copy', shortcut: '⌘C'),
                _MenuItem(icon: Icons.content_paste, label: 'Paste', shortcut: '⌘V'),
                _MenuItem.separator(),
                _MenuItem(icon: Icons.select_all, label: 'Select All', shortcut: '⌘A'),
              ],
              accent: cNavy,
              onDismiss: null,
            ),
            const SizedBox(height: 12.0),
            Wrap(
              spacing: 6.0,
              runSpacing: 4.0,
              children: [
                tagLabel('Icons', cNavy),
                tagLabel('Shortcuts', cTeal),
                tagLabel('Separator', cSlate),
              ],
            ),
          ],
        ),
      ),

      // Pattern 2: Contextual actions
      demoCard(
        title: 'Pattern: Contextual Actions',
        description: 'Actions vary based on selection type',
        accent: cTeal,
        width: 380.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text selection menu
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Text Selected',
                    style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: cTeal),
                  ),
                  const SizedBox(height: 6.0),
                  buildStyledMenu(
                    items: [
                      _MenuItem(icon: Icons.content_copy, label: 'Copy'),
                      _MenuItem(icon: Icons.format_quote, label: 'Quote'),
                      _MenuItem(icon: Icons.search, label: 'Look Up'),
                    ],
                    accent: cTeal,
                    onDismiss: null,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12.0),
            // Image selection menu
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Image Selected',
                    style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: cCoral),
                  ),
                  const SizedBox(height: 6.0),
                  buildStyledMenu(
                    items: [
                      _MenuItem(icon: Icons.save_alt, label: 'Save Image'),
                      _MenuItem(icon: Icons.share, label: 'Share'),
                      _MenuItem(icon: Icons.open_in_new, label: 'Open'),
                    ],
                    accent: cCoral,
                    onDismiss: null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // Pattern 3: Dangerous actions
      demoCard(
        title: 'Pattern: Destructive Actions',
        description: 'Highlighting dangerous operations with color',
        accent: cRose,
        width: 380.0,
        child: Row(
          children: [
            buildStyledMenu(
              items: [
                _MenuItem(icon: Icons.edit, label: 'Rename'),
                _MenuItem(icon: Icons.drive_file_move, label: 'Move to...'),
                _MenuItem(icon: Icons.folder_copy, label: 'Duplicate'),
                _MenuItem.separator(),
                _MenuItem(icon: Icons.delete, label: 'Delete', color: cRose),
              ],
              accent: cSlate,
              onDismiss: null,
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: cRose.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(color: cRose.withValues(alpha: 0.2)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.warning, color: cRose, size: 16.0),
                        const SizedBox(width: 6.0),
                        Expanded(
                          child: Text(
                            'Destructive actions should stand out visually',
                            style: TextStyle(fontSize: 10.0, color: cRose),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Use red/warning colors for delete, remove, or '
                    'other irreversible operations. A separator helps '
                    'visually isolate dangerous actions.',
                    style: TextStyle(fontSize: 10.0, color: cSlate.withValues(alpha: 0.6)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // Pattern 4: Auto-dismiss on action
      demoCard(
        title: 'Pattern: Auto-Dismiss on Action',
        description: 'Menu closes when a menu item is tapped',
        accent: cForest,
        width: 380.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            codeSnippet(
              'void _handleItemTap(String action) {\n'
              '  // First, close the menu\n'
              '  _controller.remove();\n'
              '  \n'
              '  // Then perform the action\n'
              '  switch (action) {\n'
              '    case \'copy\':\n'
              '      _copySelection();\n'
              '      break;\n'
              '    case \'paste\':\n'
              '      _pasteClipboard();\n'
              '      break;\n'
              '  }\n'
              '}',
              cForest,
            ),
            const SizedBox(height: 8.0),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: cForest.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Row(
                children: [
                  Icon(Icons.lightbulb_outline, color: cForest, size: 18.0),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      'Always close the menu first, then perform the action. '
                      'This ensures clean UI state if the action triggers navigation.',
                      style: TextStyle(fontSize: 10.0, color: cForest),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // Pattern 5: Dismiss on outside tap
      demoCard(
        title: 'Pattern: Dismiss on Outside Tap',
        description: 'Use a barrier to detect taps outside the menu',
        accent: cAmber,
        width: 380.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 100.0,
              decoration: BoxDecoration(
                color: cCream,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: cAmber.withValues(alpha: 0.2)),
              ),
              child: Stack(
                children: [
                  // Barrier
                  Positioned.fill(
                    child: Container(
                      color: cSlate.withValues(alpha: 0.03),
                      child: Center(
                        child: Text(
                          'GestureDetector barrier\n(tapping here dismisses menu)',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 9.0, color: cSlate.withValues(alpha: 0.4)),
                        ),
                      ),
                    ),
                  ),
                  // Menu mockup
                  Positioned(
                    right: 20.0,
                    top: 20.0,
                    child: Container(
                      width: 100.0,
                      padding: const EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6.0),
                        border: Border.all(color: cSlate.withValues(alpha: 0.2)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Menu', style: TextStyle(fontSize: 10.0, color: cAmber, fontWeight: FontWeight.bold)),
                          Text('Item 1', style: TextStyle(fontSize: 9.0, color: cSlate)),
                          Text('Item 2', style: TextStyle(fontSize: 9.0, color: cSlate)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8.0),
            codeSnippet(
              'contextMenuBuilder: (ctx) => Stack(\n'
              '  children: [\n'
              '    // Full-screen gesture barrier\n'
              '    Positioned.fill(\n'
              '      child: GestureDetector(\n'
              '        onTap: () => _controller.remove(),\n'
              '        child: Container(color: Colors.transparent),\n'
              '      ),\n'
              '    ),\n'
              '    // Positioned menu\n'
              '    Positioned(\n'
              '      left: _position.dx,\n'
              '      top: _position.dy,\n'
              '      child: MyMenu(),\n'
              '    ),\n'
              '  ],\n'
              ')',
              cAmber,
            ),
          ],
        ),
      ),

      const SizedBox(height: 10.0),

      // Closing summary
      Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [cSlate.withValues(alpha: 0.08), cCoral.withValues(alpha: 0.06)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: cSlate.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.lightbulb_outline, color: cSlate, size: 18.0),
                const SizedBox(width: 8.0),
                Text(
                  'When to use ContextMenuController',
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                    color: cSlate,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              '• Right-click (desktop) or long-press (mobile) context menus\n'
              '• Custom menus triggered by secondary tap gestures\n'
              '• Menus that need dynamic content updates while shown\n'
              '• When you need fine control over menu lifecycle and callbacks\n'
              '• Replacing platform context menus with custom Flutter UI\n\n'
              'For simpler cases, consider PopupMenuButton or showMenu() which '
              'handle positioning and dismissal automatically. Use ContextMenuController '
              'when you need full control over the menu\'s appearance and behavior.',
              style: TextStyle(
                fontSize: 11.0,
                color: cSlate.withValues(alpha: 0.8),
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    ],
  );

  print('Scene 6 built: 5 practical patterns + summary');

  // ════════════════════════════════════════════════════════════
  // TITLE BANNER
  // ════════════════════════════════════════════════════════════
  final titleBanner = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [cSlate.withValues(alpha: 0.12), cCoral.withValues(alpha: 0.08)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: cSlate.withValues(alpha: 0.2)),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.menu_open, color: cSlate, size: 28.0),
            const SizedBox(width: 10.0),
            Text(
              'ContextMenuController',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: cSlate,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        Text(
          'Overlay-Based Context Menu Management',
          style: TextStyle(
            fontSize: 13.0,
            color: cSlate.withValues(alpha: 0.7),
          ),
        ),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 6.0,
          alignment: WrapAlignment.center,
          children: [
            tagLabel('show()', cNavy),
            tagLabel('remove()', cTeal),
            tagLabel('removeAny()', cCoral),
            tagLabel('isShown', cForest),
            tagLabel('markNeedsBuild()', cPurple),
            tagLabel('onRemove', cAmber),
          ],
        ),
      ],
    ),
  );

  // ════════════════════════════════════════════════════════════
  // ASSEMBLE APP
  // ════════════════════════════════════════════════════════════
  print('\n=== Assembling final layout ===');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: cCream,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleBanner,
            scene1,
            scene2,
            scene3,
            scene4,
            scene5,
            scene6,
            const SizedBox(height: 40.0),
          ],
        ),
      ),
    ),
  );
}

/// Helper class for menu items.
class _MenuItem {
  _MenuItem({
    this.icon,
    this.label = '',
    this.shortcut,
    this.color,
    this.isSeparator = false,
  });

  factory _MenuItem.separator() => _MenuItem(isSeparator: true);

  final IconData? icon;
  final String label;
  final String? shortcut;
  final Color? color;
  final bool isSeparator;
}
