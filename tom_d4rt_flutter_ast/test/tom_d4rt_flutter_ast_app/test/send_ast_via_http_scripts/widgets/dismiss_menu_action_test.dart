// ignore_for_file: avoid_print
// Deep demo: DismissMenuAction — a context-aware Action that closes the
// nearest open menu (popup menu, dropdown menu, cascading submenu) in
// response to a DismissIntent, typically triggered by the Escape key.
import 'package:flutter/material.dart';

// ────────────────────────────────────────────────────────────
// Theme: Forest Teal (#004D40) on Mint Cream (#E0F2F1)
// Prefix: _dm (dismiss menu)
// ────────────────────────────────────────────────────────────

const Color _dmTeal = Color(0xFF004D40);
const Color _dmMint = Color(0xFFE0F2F1);
const Color _dmDark = Color(0xFF00251A);
const Color _dmLight = Color(0xFF00796B);
const Color _dmMuted = Color(0xFF78909C);
const Color _dmAccent = Color(0xFF00897B);
const Color _dmDivider = Color(0xFF80CBC4);
const Color _dmWhite = Color(0xFFFFFFFF);
const Color _dmBlack = Color(0xFF212121);
const Color _dmError = Color(0xFFC62828);
const Color _dmInfo = Color(0xFF0277BD);
const Color _dmWarning = Color(0xFFF57F17);

dynamic build(BuildContext context) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Banner ──
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_dmTeal, _dmDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: _dmTeal.withValues(alpha: 0.35),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.menu_open, color: _dmMint, size: 36),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      'DismissMenuAction',
                      style: TextStyle(
                        color: _dmMint,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'A specialized Action for closing open menus in response '
                'to DismissIntent. Unlike the generic DismissAction, this '
                'action specifically targets menu overlays — popup menus, '
                'dropdown menus, and cascading submenus.',
                style: TextStyle(
                  color: _dmMint.withValues(alpha: 0.9),
                  fontSize: 15,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),

        // ── 1. What Is It ──
        _dmSection('1. What Is DismissMenuAction?'),
        _dmBody(
          'DismissMenuAction is a concrete Action<DismissIntent> subclass '
          'that is registered specifically within menu widgets. When a '
          'PopupMenuButton, DropdownButton, or MenuAnchor creates its '
          'overlay, it wraps the menu content in an Actions widget with '
          'DismissMenuAction as the handler for DismissIntent. This '
          'ensures that pressing Escape while a menu is open closes '
          'the menu rather than performing a broader dismiss action.',
        ),
        const SizedBox(height: 12),
        _dmInfoBox(
          'Menu-Specific Override',
          'Without this action, pressing Escape while a menu is open '
          'might dismiss the entire dialog or route instead. '
          'DismissMenuAction intercepts the intent before it propagates.',
        ),
        const SizedBox(height: 24),

        // ── 2. Where It Lives ──
        _dmSection('2. Where DismissMenuAction Is Registered'),
        _dmBody(
          'The framework registers DismissMenuAction inside the '
          'overlay entries created by menu-related widgets:',
        ),
        const SizedBox(height: 12),
        _buildRegistrationPoints(),
        const SizedBox(height: 24),

        // ── 3. DismissMenuAction vs DismissAction ──
        _dmSection('3. DismissMenuAction vs DismissAction'),
        _dmBody(
          'Both handle DismissIntent, but at different levels of '
          'specificity:',
        ),
        const SizedBox(height: 12),
        _buildActionComparison(),
        const SizedBox(height: 24),

        // ── 4. Action Resolution ──
        _dmSection('4. Action Resolution Chain'),
        _dmBody(
          'When Escape is pressed, the Actions framework walks up from '
          'the focused widget looking for DismissIntent handlers. '
          'DismissMenuAction wins because it is closest to the focus:',
        ),
        const SizedBox(height: 12),
        _buildResolutionChain(),
        const SizedBox(height: 24),

        // ── 5. Menu Types ──
        _dmSection('5. Menu Types That Use DismissMenuAction'),
        _dmBody(
          'Different menu widgets each install DismissMenuAction '
          'in their overlay:',
        ),
        const SizedBox(height: 12),
        _buildMenuTypes(),
        const SizedBox(height: 24),

        // ── 6. Cascading Submenus ──
        _dmSection('6. Cascading Submenu Behavior'),
        _dmBody(
          'With MenuAnchor cascading submenus, each level installs '
          'its own DismissMenuAction. Escape closes one submenu '
          'at a time from the innermost to outermost:',
        ),
        const SizedBox(height: 12),
        _buildCascadingSubmenus(),
        const SizedBox(height: 24),

        // ── 7. Return Value ──
        _dmSection('7. Return Value Handling'),
        _dmBody(
          'When a menu is dismissed (not selected), the popup/menu '
          'controller signals that no item was chosen:',
        ),
        const SizedBox(height: 12),
        _buildReturnValues(),
        const SizedBox(height: 24),

        // ── 8. Focus Behavior ──
        _dmSection('8. Focus and Keyboard Navigation'),
        _dmBody(
          'Menus manage their own focus scope. After DismissMenuAction '
          'closes the menu, focus returns to the widget that opened it:',
        ),
        const SizedBox(height: 12),
        _buildFocusBehavior(),
        const SizedBox(height: 24),

        // ── 9. Custom Menu with DismissMenuAction ──
        _dmSection('9. Custom Menu Implementation'),
        _dmBody(
          'When building a custom menu from scratch, you must register '
          'DismissMenuAction yourself to get Escape-to-close behavior:',
        ),
        const SizedBox(height: 12),
        _dmCodeBlock(
          '// Custom menu overlay requires manual action setup\n'
          'OverlayEntry _createMenuEntry() {\n'
          '  return OverlayEntry(\n'
          '    builder: (context) => FocusScope(\n'
          '      autofocus: true,\n'
          '      child: Actions(\n'
          '        actions: <Type, Action<Intent>>{\n'
          '          DismissIntent:\n'
          '            CallbackAction<DismissIntent>(\n'
          '              onInvoke: (_) {\n'
          '                _closeMenu();\n'
          '                return null;\n'
          '              },\n'
          '          ),\n'
          '        },\n'
          '        child: Shortcuts(\n'
          '          shortcuts: {\n'
          '            const SingleActivator(\n'
          '              LogicalKeyboardKey.escape,\n'
          '            ): const DismissIntent(),\n'
          '          },\n'
          '          child: _CustomMenuPanel(\n'
          '            items: items,\n'
          '            onSelected: _onItemSelected,\n'
          '          ),\n'
          '        ),\n'
          '      ),\n'
          '    ),\n'
          '  );\n'
          '}',
        ),
        const SizedBox(height: 24),

        // ── 10. Animation On Dismiss ──
        _dmSection('10. Menu Close Animation'),
        _dmBody(
          'When DismissMenuAction fires, the menu typically plays an '
          'exit animation before the overlay entry is removed:',
        ),
        const SizedBox(height: 12),
        _buildCloseAnimation(),
        const SizedBox(height: 24),

        // ── 11. Context Menu Scenario ──
        _dmSection('11. Context Menu Scenario'),
        _dmBody(
          'A practical walkthrough showing DismissMenuAction in '
          'a right-click context menu with nested submenus:',
        ),
        const SizedBox(height: 12),
        _buildContextMenuScenario(),
        const SizedBox(height: 24),

        // ── Summary ──
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                _dmTeal.withValues(alpha: 0.08),
                _dmMint,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _dmTeal.withValues(alpha: 0.25),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.summarize, color: _dmTeal, size: 22),
                  const SizedBox(width: 10),
                  Text(
                    'Summary',
                    style: TextStyle(
                      color: _dmTeal,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              _dmSummaryRow('Type', 'Action<DismissIntent>'),
              _dmSummaryRow('Purpose', 'Close the nearest open menu overlay'),
              _dmSummaryRow('Registered By', 'PopupMenuButton, DropdownButton, MenuAnchor'),
              _dmSummaryRow('Trigger', 'Escape key (via DismissIntent)'),
              _dmSummaryRow('Cascading', 'Closes one submenu level at a time'),
              _dmSummaryRow('Return', 'null (no selection made)'),
              _dmSummaryRow('Focus', 'Returns to menu opener after close'),
            ],
          ),
        ),
        const SizedBox(height: 32),
      ],
    ),
  );
}

// ─── Helper Widgets ──────────────────────────────────────────

Widget _dmSection(String title) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Text(
      title,
      style: TextStyle(
        color: _dmTeal,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.3,
      ),
    ),
  );
}

Widget _dmBody(String text) {
  return Text(
    text,
    style: TextStyle(
      color: _dmBlack,
      fontSize: 15,
      height: 1.6,
    ),
  );
}

Widget _dmCodeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFF1B2631),
      borderRadius: BorderRadius.circular(10),
    ),
    child: SelectableText(
      code,
      style: const TextStyle(
        color: Color(0xFFB2DFDB),
        fontSize: 13,
        fontFamily: 'monospace',
        height: 1.5,
      ),
    ),
  );
}

Widget _dmInfoBox(String title, String content) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _dmInfo.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _dmInfo.withValues(alpha: 0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.info_outline, color: _dmInfo, size: 18),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: _dmInfo,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: TextStyle(
            color: _dmBlack,
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

Widget _dmSummaryRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: TextStyle(
              color: _dmMuted,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: _dmBlack,
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

// ─── Builder Functions ───────────────────────────────────────

Widget _buildRegistrationPoints() {
  final points = <Map<String, dynamic>>[
    {
      'widget': 'PopupMenuButton',
      'where': 'Inside _PopupMenuRoute overlay',
      'icon': Icons.more_vert,
      'color': _dmTeal,
    },
    {
      'widget': 'DropdownButton',
      'where': 'Inside _DropdownRoute overlay',
      'icon': Icons.arrow_drop_down,
      'color': _dmAccent,
    },
    {
      'widget': 'MenuAnchor',
      'where': 'Inside _MenuAnchorState overlay',
      'icon': Icons.menu,
      'color': _dmLight,
    },
    {
      'widget': 'SubmenuButton',
      'where': 'Nested inside each cascade level',
      'icon': Icons.subdirectory_arrow_right,
      'color': _dmInfo,
    },
  ];

  return Column(
    children: [
      for (var i = 0; i < points.length; i++) ...[
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: (points[i]['color'] as Color).withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: (points[i]['color'] as Color).withValues(alpha: 0.2)),
          ),
          child: Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: (points[i]['color'] as Color).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(points[i]['icon'] as IconData,
                    color: points[i]['color'] as Color, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      points[i]['widget'] as String,
                      style: TextStyle(
                        color: points[i]['color'] as Color,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'monospace',
                      ),
                    ),
                    Text(
                      points[i]['where'] as String,
                      style: TextStyle(
                          color: _dmBlack, fontSize: 12, height: 1.3),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (i < points.length - 1) const SizedBox(height: 6),
      ],
    ],
  );
}

Widget _buildActionComparison() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _dmTeal.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _dmTeal.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('DismissMenuAction',
                  style: TextStyle(color: _dmTeal, fontSize: 13,
                      fontWeight: FontWeight.bold, fontFamily: 'monospace')),
              const SizedBox(height: 8),
              Text('\u2022 Menu-specific',
                  style: TextStyle(color: _dmBlack, fontSize: 12)),
              Text('\u2022 Closes only the menu overlay',
                  style: TextStyle(color: _dmBlack, fontSize: 12)),
              Text('\u2022 Registered by menu widgets',
                  style: TextStyle(color: _dmBlack, fontSize: 12)),
              Text('\u2022 Handles cascading levels',
                  style: TextStyle(color: _dmBlack, fontSize: 12)),
              Text('\u2022 Returns null (no selection)',
                  style: TextStyle(color: _dmBlack, fontSize: 12)),
            ],
          ),
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _dmInfo.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _dmInfo.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('DismissAction',
                  style: TextStyle(color: _dmInfo, fontSize: 13,
                      fontWeight: FontWeight.bold, fontFamily: 'monospace')),
              const SizedBox(height: 8),
              Text('\u2022 General-purpose',
                  style: TextStyle(color: _dmBlack, fontSize: 12)),
              Text('\u2022 Closes any dismissable overlay',
                  style: TextStyle(color: _dmBlack, fontSize: 12)),
              Text('\u2022 Registered by app framework',
                  style: TextStyle(color: _dmBlack, fontSize: 12)),
              Text('\u2022 No cascade awareness',
                  style: TextStyle(color: _dmBlack, fontSize: 12)),
              Text('\u2022 May pop routes',
                  style: TextStyle(color: _dmBlack, fontSize: 12)),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _buildResolutionChain() {
  final levels = <Map<String, dynamic>>[
    {
      'level': 'Menu Item (focused)',
      'handler': 'None — passes up',
      'color': _dmMuted,
    },
    {
      'level': 'Menu Overlay',
      'handler': 'DismissMenuAction \u2713',
      'color': _dmTeal,
    },
    {
      'level': 'Dialog',
      'handler': 'DismissAction (not reached)',
      'color': _dmAccent,
    },
    {
      'level': 'Scaffold / Route',
      'handler': 'DismissAction (not reached)',
      'color': _dmLight,
    },
  ];

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _dmMint,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _dmDivider),
    ),
    child: Column(
      children: [
        for (var i = 0; i < levels.length; i++) ...[
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: levels[i]['color'] as Color,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Text(
                    '${i + 1}',
                    style: TextStyle(
                        color: _dmWhite, fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      levels[i]['level'] as String,
                      style: TextStyle(
                        color: levels[i]['color'] as Color,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      levels[i]['handler'] as String,
                      style: TextStyle(
                        color: _dmBlack,
                        fontSize: 12,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (i < levels.length - 1)
            Padding(
              padding: const EdgeInsets.only(left: 13, top: 2, bottom: 2),
              child: Row(
                children: [
                  Container(width: 2, height: 10, color: _dmDivider),
                  const SizedBox(width: 10),
                  Text(
                    i == 0 ? '\u2191 bubbles up' : '\u2717 not reached',
                    style: TextStyle(
                        color: _dmMuted, fontSize: 10,
                        fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
        ],
      ],
    ),
  );
}

Widget _buildMenuTypes() {
  final types = <Map<String, dynamic>>[
    {
      'type': 'PopupMenuButton',
      'desc': 'Classic right-click or three-dot button menu. Overlay '
          'created via showMenu(). DismissMenuAction registered in the '
          'route overlay entry.',
      'icon': Icons.more_vert,
      'color': _dmTeal,
    },
    {
      'type': 'DropdownButton / DropdownMenu',
      'desc': 'Form-style selection dropdown. Each dropdown creates an '
          'overlay route with DismissMenuAction scoped to the dropdown.',
      'icon': Icons.arrow_drop_down_circle,
      'color': _dmAccent,
    },
    {
      'type': 'MenuAnchor / MenuBar',
      'desc': 'Material 3 menu system supporting cascading submenus. '
          'Each MenuAnchor level independently registers the action.',
      'icon': Icons.menu,
      'color': _dmLight,
    },
    {
      'type': 'CupertinoContextMenu',
      'desc': 'iOS-style long-press context menu. Uses its own dismiss '
          'mechanism but respects DismissIntent on desktop platforms.',
      'icon': Icons.phone_iphone,
      'color': _dmInfo,
    },
  ];

  return Column(
    children: [
      for (var i = 0; i < types.length; i++) ...[
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: (types[i]['color'] as Color).withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: (types[i]['color'] as Color).withValues(alpha: 0.2)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(types[i]['icon'] as IconData,
                  color: types[i]['color'] as Color, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      types[i]['type'] as String,
                      style: TextStyle(
                        color: types[i]['color'] as Color,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      types[i]['desc'] as String,
                      style: TextStyle(
                          color: _dmBlack, fontSize: 12, height: 1.4),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (i < types.length - 1) const SizedBox(height: 8),
      ],
    ],
  );
}

Widget _buildCascadingSubmenus() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _dmMint,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _dmDivider),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Escape Through Cascade Levels',
          style: TextStyle(
            color: _dmTeal, fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 14),
        // Cascade stack
        for (var i = 0; i < 3; i++) ...[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            margin: EdgeInsets.only(left: i * 22.0),
            decoration: BoxDecoration(
              color: [
                _dmTeal.withValues(alpha: 0.06),
                _dmAccent.withValues(alpha: 0.06),
                _dmLight.withValues(alpha: 0.06),
              ][i],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: [_dmTeal, _dmAccent, _dmLight][i]
                    .withValues(alpha: 0.25),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: [_dmTeal, _dmAccent, _dmLight][i]
                        .withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Esc ${3 - i}',
                    style: TextStyle(
                      color: [_dmTeal, _dmAccent, _dmLight][i],
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ['Root Menu', 'Format >', 'Alignment >'][i],
                        style: TextStyle(
                          color: _dmBlack,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        [
                          'File, Edit, View, Format...',
                          'Bold, Italic, Alignment...',
                          'Left, Center, Right, Justify',
                        ][i],
                        style: TextStyle(
                            color: _dmMuted, fontSize: 11, height: 1.3),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (i < 2) const SizedBox(height: 4),
        ],
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _dmTeal.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'First Esc: Alignment submenu closes\n'
            'Second Esc: Format submenu closes\n'
            'Third Esc: Root menu closes, focus returns to menu bar',
            style: TextStyle(
                color: _dmBlack, fontSize: 12, fontFamily: 'monospace',
                height: 1.5),
          ),
        ),
      ],
    ),
  );
}

Widget _buildReturnValues() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _dmTeal.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _dmTeal.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.touch_app, color: _dmTeal, size: 18),
                  const SizedBox(width: 6),
                  Text('Item Selected',
                      style: TextStyle(color: _dmTeal, fontSize: 12,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 8),
              Text('showMenu() returns the selected value',
                  style: TextStyle(color: _dmBlack, fontSize: 12)),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: _dmTeal.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Future<T?> \u2192 T',
                  style: TextStyle(
                      color: _dmTeal, fontSize: 11, fontFamily: 'monospace'),
                ),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _dmWarning.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _dmWarning.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.keyboard, color: _dmWarning, size: 18),
                  const SizedBox(width: 6),
                  Text('Escape Pressed',
                      style: TextStyle(color: _dmWarning, fontSize: 12,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 8),
              Text('showMenu() returns null (dismissed)',
                  style: TextStyle(color: _dmBlack, fontSize: 12)),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: _dmWarning.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Future<T?> \u2192 null',
                  style: TextStyle(
                      color: _dmWarning, fontSize: 11,
                      fontFamily: 'monospace'),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _buildFocusBehavior() {
  final steps = <Map<String, dynamic>>[
    {
      'step': 'User clicks menu button',
      'focus': 'Button loses focus',
      'icon': Icons.touch_app,
      'color': _dmMuted,
    },
    {
      'step': 'Menu overlay opens',
      'focus': 'FocusScope captures focus to menu',
      'icon': Icons.menu_open,
      'color': _dmTeal,
    },
    {
      'step': 'Arrow keys navigate items',
      'focus': 'Focus moves between menu items',
      'icon': Icons.keyboard_arrow_down,
      'color': _dmAccent,
    },
    {
      'step': 'Escape pressed',
      'focus': 'DismissMenuAction closes overlay',
      'icon': Icons.close,
      'color': _dmError,
    },
    {
      'step': 'Focus restored',
      'focus': 'Original button regains focus',
      'icon': Icons.center_focus_strong,
      'color': _dmLight,
    },
  ];

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _dmMint,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _dmDivider),
    ),
    child: Column(
      children: [
        for (var i = 0; i < steps.length; i++) ...[
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: steps[i]['color'] as Color,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Icon(steps[i]['icon'] as IconData,
                    color: _dmWhite, size: 16),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      steps[i]['step'] as String,
                      style: TextStyle(
                        color: steps[i]['color'] as Color,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      steps[i]['focus'] as String,
                      style: TextStyle(
                          color: _dmBlack, fontSize: 11, height: 1.3),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (i < steps.length - 1)
            Padding(
              padding: const EdgeInsets.only(left: 14, top: 2, bottom: 2),
              child: Container(width: 2, height: 8, color: _dmDivider),
            ),
        ],
      ],
    ),
  );
}

Widget _buildCloseAnimation() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _dmMint,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _dmDivider),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Animation Timeline',
          style: TextStyle(
            color: _dmTeal, fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 14),
        // Timeline bar
        Container(
          width: double.infinity,
          height: 30,
          decoration: BoxDecoration(
            color: _dmWhite,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: _dmDivider),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: _dmError.withValues(alpha: 0.15),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                    ),
                  ),
                  child: Center(
                    child: Text('Esc',
                        style: TextStyle(color: _dmError, fontSize: 10,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  color: _dmTeal.withValues(alpha: 0.12),
                  child: Center(
                    child: Text('Scale + Fade Out (200ms)',
                        style: TextStyle(color: _dmTeal, fontSize: 10)),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: _dmLight.withValues(alpha: 0.15),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                  ),
                  child: Center(
                    child: Text('Remove',
                        style: TextStyle(color: _dmLight, fontSize: 10,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            _dmAnimChip('Opacity', '1.0 \u2192 0.0', _dmTeal),
            const SizedBox(width: 8),
            _dmAnimChip('Scale', '1.0 \u2192 0.95', _dmAccent),
            const SizedBox(width: 8),
            _dmAnimChip('Curve', 'easeInOut', _dmLight),
          ],
        ),
      ],
    ),
  );
}

Widget _dmAnimChip(String label, String value, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label,
            style: TextStyle(color: color, fontSize: 11,
                fontWeight: FontWeight.bold)),
        const SizedBox(width: 4),
        Text(value,
            style: TextStyle(color: _dmBlack, fontSize: 11)),
      ],
    ),
  );
}

Widget _buildContextMenuScenario() {
  final steps = <Map<String, String>>[
    {
      'step': 'Right-click on text editor canvas',
      'detail': 'MenuAnchor detects secondary tap and opens root menu',
    },
    {
      'step': 'Root menu appears with Cut, Copy, Paste, Format...',
      'detail': 'DismissMenuAction registered at root menu level',
    },
    {
      'step': 'Hover over Format to open submenu',
      'detail': 'Submenu installs its own DismissMenuAction layer',
    },
    {
      'step': 'Hover over Text Style for nested submenu',
      'detail': 'Third DismissMenuAction layer added to the hierarchy',
    },
    {
      'step': 'Press Escape — Text Style submenu closes',
      'detail': 'Innermost DismissMenuAction handles the intent',
    },
    {
      'step': 'Press Escape — Format submenu closes',
      'detail': 'Next level DismissMenuAction takes over',
    },
    {
      'step': 'Press Escape — Root context menu closes',
      'detail': 'Final DismissMenuAction closes, focus returns to canvas',
    },
  ];

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _dmMint,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _dmDivider),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.ads_click, color: _dmTeal, size: 20),
            const SizedBox(width: 8),
            Text(
              'Right-Click Context Menu Walkthrough',
              style: TextStyle(
                color: _dmTeal,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        for (var i = 0; i < steps.length; i++) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  color: i >= 4
                      ? _dmError.withValues(alpha: 0.12)
                      : _dmTeal.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Text(
                    '${i + 1}',
                    style: TextStyle(
                      color: i >= 4 ? _dmError : _dmTeal,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      steps[i]['step']!,
                      style: TextStyle(
                        color: _dmBlack,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      steps[i]['detail']!,
                      style: TextStyle(
                          color: _dmMuted, fontSize: 11, height: 1.3),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (i < steps.length - 1) const SizedBox(height: 8),
        ],
      ],
    ),
  );
}
