// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable
// D4rt test script: Tests TooltipTriggerMode enum from package:flutter/material.dart
// (re-exported from package:flutter/widgets.dart). Values: manual, longPress, tap.
//
// Deep Demo: Visual tour of how TooltipTriggerMode shapes the gesture-to-reveal
// pipeline. Each value gets its own anatomy card, mock tooltip preview, gesture
// timeline diagram, recipe gallery entry, comparison row in the matrix, and a
// short "pitfalls and recommendations" entry. Motion is faked with
// AlwaysStoppedAnimation<double> + Duration.zero so the demo stays static and
// can be rendered headlessly via the d4rt-flutter-ast pipeline.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TooltipTriggerMode Deep Demo executing');

  // Static motion stand-ins. The widgets below pretend to animate, but every
  // tween is clamped to a fixed value via AlwaysStoppedAnimation so the demo
  // remains deterministic when serialized to AST and replayed.
  final AlwaysStoppedAnimation<double> heroPulse =
      const AlwaysStoppedAnimation<double>(0.65);
  final AlwaysStoppedAnimation<double> manualReveal =
      const AlwaysStoppedAnimation<double>(1.0);
  final AlwaysStoppedAnimation<double> longPressReveal =
      const AlwaysStoppedAnimation<double>(0.85);
  final AlwaysStoppedAnimation<double> tapReveal =
      const AlwaysStoppedAnimation<double>(0.5);
  const Duration instant = Duration.zero;
  print('Static motion configured: heroPulse=${heroPulse.value}, '
      'manualReveal=${manualReveal.value}, longPressReveal=${longPressReveal.value}, '
      'tapReveal=${tapReveal.value}, instantDuration=$instant');

  // ============================================================
  // SECTION 1: Hero header
  // ============================================================
  print('=== Section 1: Hero header ===');

  final Widget heroHeader = Container(
    padding: const EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Colors.indigo.shade700,
          Colors.deepPurple.shade500,
          Colors.purple.shade400,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.deepPurple.withValues(alpha: 0.35),
          blurRadius: 24.0,
          offset: const Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.25),
          blurRadius: 6.0,
          offset: const Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Colors.white.withValues(alpha: 0.30),
                    Colors.white.withValues(alpha: 0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.4),
                  width: 1.0,
                ),
              ),
              child: const Icon(
                Icons.touch_app,
                size: 56.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'TooltipTriggerMode',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'manual · longPress · tap',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'monospace',
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
            ),
            // Pulse indicator stays visually frozen at heroPulse.value.
            Container(
              width: 18.0 + 8.0 * heroPulse.value,
              height: 18.0 + 8.0 * heroPulse.value,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: <Color>[
                    Colors.white,
                    Colors.white.withValues(alpha: 0.0),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 18.0),
        Text(
          'TooltipTriggerMode controls which input gesture causes a Tooltip to '
          'reveal itself. The three constants describe a tiny but expressive '
          'state machine: silence (manual), patience (longPress), and '
          'immediacy (tap). This demo walks through each value with anatomy, '
          'gesture timing, and recipe-style usage.',
          style: TextStyle(
            fontSize: 13.5,
            height: 1.45,
            color: Colors.white.withValues(alpha: 0.95),
          ),
        ),
      ],
    ),
  );
  print('Hero header constructed');

  // ============================================================
  // SECTION 2: Anatomy / enum signature
  // ============================================================
  print('=== Section 2: Anatomy / enum signature ===');

  final Widget anatomy = Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Colors.grey.shade900, Colors.blueGrey.shade900],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.45),
          blurRadius: 16.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.code, color: Colors.cyan.shade300, size: 22.0),
            const SizedBox(width: 8.0),
            Text(
              'enum TooltipTriggerMode',
              style: TextStyle(
                color: Colors.cyan.shade300,
                fontWeight: FontWeight.bold,
                fontSize: 17.0,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        _buildCodeBlock(
          '// package:flutter/material.dart\n'
          'enum TooltipTriggerMode {\n'
          '  /// Tooltip will only show when called programmatically.\n'
          '  manual,\n'
          '\n'
          '  /// Tooltip will show after a long press.\n'
          '  longPress,\n'
          '\n'
          '  /// Tooltip will show after a single tap.\n'
          '  tap,\n'
          '}',
          Colors.lightGreenAccent.shade100,
        ),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            for (final TooltipTriggerMode mode in TooltipTriggerMode.values)
              _buildEnumChip(mode),
          ],
        ),
        const SizedBox(height: 10.0),
        Text(
          'TooltipTriggerMode.values has '
          '${TooltipTriggerMode.values.length} entries; '
          'first=${TooltipTriggerMode.values.first.name} '
          '(index ${TooltipTriggerMode.values.first.index}), '
          'last=${TooltipTriggerMode.values.last.name} '
          '(index ${TooltipTriggerMode.values.last.index}).',
          style: TextStyle(
            fontSize: 11.5,
            fontFamily: 'monospace',
            color: Colors.white.withValues(alpha: 0.85),
          ),
        ),
      ],
    ),
  );
  print('Anatomy section constructed');

  // ============================================================
  // SECTION 3: Per-value cards (manual / longPress / tap)
  // ============================================================
  print('=== Section 3: Per-value cards ===');

  final List<Map<String, Object>> valueSpecs = <Map<String, Object>>[
    <String, Object>{
      'mode': TooltipTriggerMode.manual,
      'icon': Icons.code,
      'gradient': <Color>[Colors.blueGrey.shade100, Colors.blueGrey.shade300],
      'accent': Colors.blueGrey.shade700,
      'tagline': 'Programmatic only',
      'reveal': manualReveal.value,
      'description':
          'No pointer event will reveal the tooltip. The application code must '
              'invoke TooltipState.ensureTooltipVisible(). Useful for guided '
              'tours, onboarding overlays, or accessibility-driven hints.',
      'gesture': 'show() · ensureTooltipVisible()',
    },
    <String, Object>{
      'mode': TooltipTriggerMode.longPress,
      'icon': Icons.touch_app_outlined,
      'gradient': <Color>[Colors.amber.shade100, Colors.orange.shade300],
      'accent': Colors.deepOrange.shade700,
      'tagline': 'Default on touch',
      'reveal': longPressReveal.value,
      'description':
          'The historical default: the tooltip appears after the long-press '
              'duration elapses. Mobile-friendly because it does not steal '
              'taps from the underlying interactive widget.',
      'gesture': 'press · hold · reveal',
    },
    <String, Object>{
      'mode': TooltipTriggerMode.tap,
      'icon': Icons.ads_click,
      'gradient': <Color>[Colors.lightBlue.shade100, Colors.cyan.shade300],
      'accent': Colors.teal.shade700,
      'tagline': 'Single tap reveal',
      'reveal': tapReveal.value,
      'description':
          'A single tap reveals the tooltip. Use sparingly: the gesture is '
              'shared with most buttons, so prefer this for read-only chips, '
              'badges, or info icons that have no other tap action.',
      'gesture': 'tap · reveal · auto-dismiss',
    },
  ];

  final List<Widget> perValueCards = <Widget>[];
  for (final Map<String, Object> spec in valueSpecs) {
    final TooltipTriggerMode mode = spec['mode'] as TooltipTriggerMode;
    final IconData icon = spec['icon'] as IconData;
    final List<Color> gradient = spec['gradient'] as List<Color>;
    final Color accent = spec['accent'] as Color;
    final String tagline = spec['tagline'] as String;
    final double reveal = spec['reveal'] as double;
    final String description = spec['description'] as String;
    final String gesture = spec['gesture'] as String;
    print('Building per-value card for ${mode.name} (index=${mode.index})');

    perValueCards.add(
      Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        padding: const EdgeInsets.all(18.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: accent, width: 1.5),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: accent.withValues(alpha: 0.30),
              blurRadius: 14.0,
              offset: const Offset(0.0, 6.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.55),
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: accent, width: 1.0),
                  ),
                  child: Icon(icon, size: 32.0, color: accent),
                ),
                const SizedBox(width: 14.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'TooltipTriggerMode.${mode.name}',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          color: accent,
                        ),
                      ),
                      const SizedBox(height: 2.0),
                      Text(
                        tagline,
                        style: TextStyle(
                          fontSize: 12.0,
                          fontStyle: FontStyle.italic,
                          color: accent.withValues(alpha: 0.85),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    color: accent,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Text(
                    'index ${mode.index}',
                    style: const TextStyle(
                      fontSize: 11.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14.0),
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.65),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                description,
                style: TextStyle(
                  fontSize: 12.5,
                  height: 1.4,
                  color: Colors.grey.shade900,
                ),
              ),
            ),
            const SizedBox(height: 12.0),
            Row(
              children: <Widget>[
                Icon(Icons.gesture, size: 16.0, color: accent),
                const SizedBox(width: 6.0),
                Expanded(
                  child: Text(
                    'Gesture: $gesture',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.5,
                      color: accent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            // Reveal-progress indicator (static, no animation).
            _buildRevealBar(reveal, accent),
          ],
        ),
      ),
    );
  }
  print('Built ${perValueCards.length} per-value cards');

  // ============================================================
  // SECTION 4: Gesture-trigger timeline
  // ============================================================
  print('=== Section 4: Gesture-trigger timeline ===');

  final Widget gestureTimeline = Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Colors.teal.shade50, Colors.cyan.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.teal.shade300, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.teal.withValues(alpha: 0.20),
          blurRadius: 12.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.timeline, color: Colors.teal.shade800, size: 22.0),
            const SizedBox(width: 8.0),
            Text(
              'Gesture → Reveal Timeline',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        Text(
          'The diagrams below show the lifecycle from initial pointer event to '
          'tooltip reveal. Each row corresponds to one TooltipTriggerMode.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.teal.shade900.withValues(alpha: 0.85),
            height: 1.35,
          ),
        ),
        const SizedBox(height: 14.0),
        _buildTimelineRow(
          mode: TooltipTriggerMode.manual,
          color: Colors.blueGrey.shade700,
          steps: const <String>['idle', '—', '—', 'show()'],
          stepIcons: const <IconData>[
            Icons.hourglass_empty,
            Icons.block,
            Icons.block,
            Icons.flash_on,
          ],
        ),
        const SizedBox(height: 10.0),
        _buildTimelineRow(
          mode: TooltipTriggerMode.longPress,
          color: Colors.deepOrange.shade700,
          steps: const <String>['down', 'hold', 'fire', 'visible'],
          stepIcons: const <IconData>[
            Icons.fiber_manual_record,
            Icons.timer,
            Icons.bolt,
            Icons.visibility,
          ],
        ),
        const SizedBox(height: 10.0),
        _buildTimelineRow(
          mode: TooltipTriggerMode.tap,
          color: Colors.teal.shade700,
          steps: const <String>['down', 'up', 'fire', 'visible'],
          stepIcons: const <IconData>[
            Icons.fiber_manual_record,
            Icons.arrow_upward,
            Icons.bolt,
            Icons.visibility,
          ],
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            'Hover (mouse pointer) is independent of TooltipTriggerMode. The '
            'tooltip will react to PointerEnter/PointerExit regardless of the '
            'configured trigger mode, which is why kiosk-style desktop UIs '
            'often pair manual or tap mode with hover.',
            style: TextStyle(
              fontSize: 11.5,
              fontStyle: FontStyle.italic,
              color: Colors.teal.shade900,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
  print('Gesture timeline constructed');

  // ============================================================
  // SECTION 5: Mock tooltip-preview gallery
  // ============================================================
  print('=== Section 5: Mock tooltip-preview gallery ===');

  final Widget previewGallery = Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Colors.pink.shade50, Colors.purple.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.pink.shade200, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.pink.withValues(alpha: 0.20),
          blurRadius: 12.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.preview, color: Colors.pink.shade700, size: 22.0),
            const SizedBox(width: 8.0),
            Text(
              'Mock Tooltip Previews',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.pink.shade900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        Text(
          'Each tile pairs a target widget with the tooltip bubble it would '
          'render. The opacity reflects the static reveal value for that '
          'TooltipTriggerMode (no real animation runs).',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.pink.shade900.withValues(alpha: 0.85),
            height: 1.35,
          ),
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 14.0,
          runSpacing: 14.0,
          children: <Widget>[
            _buildPreviewTile(
              mode: TooltipTriggerMode.manual,
              targetIcon: Icons.help_outline,
              targetLabel: 'Onboarding hint',
              tooltipText: 'Press the menu to begin tour',
              accent: Colors.blueGrey.shade700,
              reveal: manualReveal.value,
            ),
            _buildPreviewTile(
              mode: TooltipTriggerMode.longPress,
              targetIcon: Icons.delete_outline,
              targetLabel: 'Delete',
              tooltipText: 'Long-press to confirm',
              accent: Colors.deepOrange.shade700,
              reveal: longPressReveal.value,
            ),
            _buildPreviewTile(
              mode: TooltipTriggerMode.tap,
              targetIcon: Icons.info_outline,
              targetLabel: 'Info chip',
              tooltipText: 'Tap for definition',
              accent: Colors.teal.shade700,
              reveal: tapReveal.value,
            ),
          ],
        ),
      ],
    ),
  );
  print('Preview gallery constructed');

  // ============================================================
  // SECTION 6: Comparison matrix
  // ============================================================
  print('=== Section 6: Comparison matrix ===');

  final Widget comparisonMatrix = Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.grey.shade400, width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.grey.withValues(alpha: 0.15),
          blurRadius: 8.0,
          offset: const Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          'Comparison Matrix',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade900,
          ),
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Colors.indigo.shade100,
                Colors.indigo.shade50,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: <Widget>[
              _buildHeaderCell('Mode', 110.0),
              _buildHeaderCell('Pointer?', 70.0),
              _buildHeaderCell('Touch?', 70.0),
              _buildHeaderCell('Steals tap?', 90.0),
              _buildHeaderCell('Default', 70.0),
            ],
          ),
        ),
        const SizedBox(height: 4.0),
        _buildMatrixRow(
          mode: TooltipTriggerMode.manual,
          pointer: false,
          touch: false,
          stealsTap: false,
          isDefault: false,
        ),
        _buildMatrixRow(
          mode: TooltipTriggerMode.longPress,
          pointer: true,
          touch: true,
          stealsTap: false,
          isDefault: true,
        ),
        _buildMatrixRow(
          mode: TooltipTriggerMode.tap,
          pointer: true,
          touch: true,
          stealsTap: true,
          isDefault: false,
        ),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            '"Steals tap?" indicates whether choosing the mode prevents the '
            'underlying widget from reacting to a normal tap. tap mode does; '
            'longPress and manual leave taps untouched.',
            style: TextStyle(
              fontSize: 11.0,
              color: Colors.indigo.shade900,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
  print('Comparison matrix constructed');

  // ============================================================
  // SECTION 7: Recipes gallery
  // ============================================================
  print('=== Section 7: Recipes gallery ===');

  final Widget recipesGallery = Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Colors.lightGreen.shade50, Colors.green.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.green.shade300, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.green.withValues(alpha: 0.20),
          blurRadius: 12.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.restaurant_menu,
                color: Colors.green.shade800, size: 22.0),
            const SizedBox(width: 8.0),
            Text(
              'Recipes Gallery',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        _buildRecipeCard(
          title: 'Onboarding spotlight (manual)',
          mode: TooltipTriggerMode.manual,
          accent: Colors.blueGrey.shade700,
          code:
              'final GlobalKey<TooltipState> tipKey = GlobalKey<TooltipState>();\n'
              '\n'
              'Tooltip(\n'
              '  key: tipKey,\n'
              '  message: \'Welcome! Start here.\',\n'
              '  triggerMode: TooltipTriggerMode.manual,\n'
              '  child: Icon(Icons.menu),\n'
              ');\n'
              '\n'
              '// Later, from your tour controller:\n'
              'tipKey.currentState?.ensureTooltipVisible();',
        ),
        _buildRecipeCard(
          title: 'Destructive icon button (longPress)',
          mode: TooltipTriggerMode.longPress,
          accent: Colors.deepOrange.shade700,
          code: 'IconButton(\n'
              '  tooltip: \'Delete\',  // implies longPress on touch\n'
              '  icon: const Icon(Icons.delete_outline),\n'
              '  onPressed: confirmDelete,\n'
              ');\n'
              '\n'
              '// Equivalent explicit form:\n'
              'Tooltip(\n'
              '  message: \'Delete\',\n'
              '  triggerMode: TooltipTriggerMode.longPress,\n'
              '  child: IconButton(\n'
              '    icon: const Icon(Icons.delete_outline),\n'
              '    onPressed: confirmDelete,\n'
              '  ),\n'
              ');',
        ),
        _buildRecipeCard(
          title: 'Glossary chip (tap)',
          mode: TooltipTriggerMode.tap,
          accent: Colors.teal.shade700,
          code: 'Tooltip(\n'
              '  message: \'A managed pointer to a stream of values.\',\n'
              '  triggerMode: TooltipTriggerMode.tap,\n'
              '  showDuration: const Duration(seconds: 4),\n'
              '  child: Chip(\n'
              '    avatar: const Icon(Icons.info_outline, size: 16.0),\n'
              '    label: const Text(\'StreamSubscription\'),\n'
              '  ),\n'
              ');',
        ),
      ],
    ),
  );
  print('Recipes gallery constructed');

  // ============================================================
  // SECTION 8: Pitfalls and recommendations
  // ============================================================
  print('=== Section 8: Pitfalls and recommendations ===');

  final List<Map<String, Object>> pitfalls = <Map<String, Object>>[
    <String, Object>{
      'icon': Icons.error_outline,
      'color': Colors.red.shade700,
      'title': 'tap mode swallows clicks',
      'body':
          'Selecting TooltipTriggerMode.tap on an interactive widget hides the '
              'widget\'s real onTap behind the tooltip. Reserve tap for badges, '
              'chips, and decorative info icons that have no other action.',
    },
    <String, Object>{
      'icon': Icons.warning_amber_outlined,
      'color': Colors.orange.shade800,
      'title': 'manual without a key is silent',
      'body':
          'TooltipTriggerMode.manual requires a GlobalKey<TooltipState> (or '
              'another reference) so your code can call '
              'ensureTooltipVisible(). Without it the tooltip will never show.',
    },
    <String, Object>{
      'icon': Icons.accessibility_new,
      'color': Colors.purple.shade700,
      'title': 'Accessibility still uses message',
      'body':
          'Screen readers announce Tooltip.message regardless of trigger mode, '
              'so even manual tooltips contribute to semantics. Keep messages '
              'short, descriptive, and non-redundant with adjacent labels.',
    },
    <String, Object>{
      'icon': Icons.timer_outlined,
      'color': Colors.teal.shade700,
      'title': 'showDuration vs waitDuration',
      'body':
          'TooltipTriggerMode only chooses the input gesture. Reveal timing is '
              'controlled separately by Tooltip.waitDuration (delay before '
              'show) and Tooltip.showDuration (how long it stays visible).',
    },
    <String, Object>{
      'icon': Icons.devices_other,
      'color': Colors.indigo.shade700,
      'title': 'Hover is independent',
      'body':
          'Mouse-hover always reveals the tooltip after waitDuration, '
              'regardless of triggerMode. Plan desktop UX with hover in mind '
              'when choosing manual or tap on touch-first surfaces.',
    },
  ];

  final Widget pitfallsSection = Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Colors.red.shade50, Colors.amber.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.red.shade200, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.red.withValues(alpha: 0.15),
          blurRadius: 12.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.report_outlined,
                color: Colors.red.shade700, size: 22.0),
            const SizedBox(width: 8.0),
            Text(
              'Pitfalls & Recommendations',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        for (final Map<String, Object> p in pitfalls)
          _buildPitfallTile(
            icon: p['icon'] as IconData,
            color: p['color'] as Color,
            title: p['title'] as String,
            body: p['body'] as String,
          ),
      ],
    ),
  );
  print('Pitfalls section constructed');

  // ============================================================
  // SECTION 9: ASCII footer
  // ============================================================
  print('=== Section 9: ASCII footer ===');

  const String asciiBanner = '+------------------------------------------+\n'
      '|   T O O L T I P   T R I G G E R   M O D E |\n'
      '+------------------------------------------+\n'
      '|   manual    -> show()/ensureTooltipVisible|\n'
      '|   longPress -> press . . . hold => reveal |\n'
      '|   tap       -> click ===========> reveal  |\n'
      '+------------------------------------------+\n'
      '|   3 values · index 0..2 · stable enum     |\n'
      '+------------------------------------------+';

  final Widget asciiFooter = Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Colors.black87, Colors.grey.shade900],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.5),
          blurRadius: 14.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          asciiBanner,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12.0,
            color: Colors.greenAccent.shade100,
            height: 1.35,
          ),
        ),
        const SizedBox(height: 12.0),
        Text(
          'd4rt-flutter-ast deep-demo · TooltipTriggerMode · '
          'rendered statically (Duration.zero, AlwaysStoppedAnimation)',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10.5,
            color: Colors.white.withValues(alpha: 0.7),
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
  print('ASCII footer constructed');

  print('TooltipTriggerMode Deep Demo finished assembling sections');

  // ============================================================
  // Final layout — single MaterialApp/Scaffold/body call
  // ============================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'TooltipTriggerMode Deep Demo',
    home: Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              heroHeader,
              const SizedBox(height: 24.0),
              _sectionTitle('1. Anatomy & enum signature', Icons.account_tree),
              anatomy,
              const SizedBox(height: 24.0),
              _sectionTitle('2. Per-value cards', Icons.view_agenda_outlined),
              ...perValueCards,
              const SizedBox(height: 24.0),
              _sectionTitle('3. Gesture → reveal timeline', Icons.timeline),
              gestureTimeline,
              const SizedBox(height: 24.0),
              _sectionTitle('4. Mock tooltip preview gallery', Icons.preview),
              previewGallery,
              const SizedBox(height: 24.0),
              _sectionTitle('5. Comparison matrix', Icons.grid_on),
              comparisonMatrix,
              const SizedBox(height: 24.0),
              _sectionTitle('6. Recipes', Icons.restaurant_menu),
              recipesGallery,
              const SizedBox(height: 24.0),
              _sectionTitle(
                  '7. Pitfalls & recommendations', Icons.report_outlined),
              pitfallsSection,
              const SizedBox(height: 24.0),
              _sectionTitle('8. ASCII footer', Icons.terminal),
              asciiFooter,
              const SizedBox(height: 32.0),
            ],
          ),
        ),
      ),
    ),
  );
}

// ============================================================
// Helpers
// ============================================================

// Helper: section heading row used across the demo.
Widget _sectionTitle(String text, IconData icon) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8.0),
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Colors.indigo.shade50, Colors.purple.shade50],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(8.0),
      border: Border(
        left: BorderSide(color: Colors.indigo.shade400, width: 4.0),
      ),
    ),
    child: Row(
      children: <Widget>[
        Icon(icon, color: Colors.indigo.shade700, size: 20.0),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.indigo.shade900,
            ),
          ),
        ),
      ],
    ),
  );
}

// Helper: small chip representing one TooltipTriggerMode value.
Widget _buildEnumChip(TooltipTriggerMode mode) {
  Color color;
  IconData icon;
  switch (mode) {
    case TooltipTriggerMode.manual:
      color = Colors.blueGrey.shade300;
      icon = Icons.code;
      break;
    case TooltipTriggerMode.longPress:
      color = Colors.deepOrange.shade300;
      icon = Icons.touch_app_outlined;
      break;
    case TooltipTriggerMode.tap:
      color = Colors.cyan.shade300;
      icon = Icons.ads_click;
      break;
  }
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          color.withValues(alpha: 0.25),
          color.withValues(alpha: 0.55),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: color, width: 1.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, size: 14.0, color: Colors.white),
        const SizedBox(width: 6.0),
        Text(
          mode.name,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.5,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 4.0),
        Text(
          '#${mode.index}',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 10.0,
            color: Colors.white.withValues(alpha: 0.85),
          ),
        ),
      ],
    ),
  );
}

// Helper: shaded reveal-progress bar for a per-value card.
Widget _buildRevealBar(double reveal, Color accent) {
  return Container(
    height: 14.0,
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.55),
      borderRadius: BorderRadius.circular(7.0),
      border: Border.all(color: accent.withValues(alpha: 0.6), width: 1.0),
    ),
    child: Row(
      children: <Widget>[
        Expanded(
          flex: (reveal * 100).round(),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  accent.withValues(alpha: 0.6),
                  accent,
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(7.0),
            ),
          ),
        ),
        Expanded(
          flex: (100 - (reveal * 100).round()).clamp(0, 100),
          child: const SizedBox.shrink(),
        ),
      ],
    ),
  );
}

// Helper: one row in the gesture timeline.
Widget _buildTimelineRow({
  required TooltipTriggerMode mode,
  required Color color,
  required List<String> steps,
  required List<IconData> stepIcons,
}) {
  return Container(
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.5), width: 1.0),
    ),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 100.0,
          child: Text(
            mode.name,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              for (int i = 0; i < steps.length; i++) ...<Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                        border: Border.all(color: color, width: 1.0),
                      ),
                      child: Icon(stepIcons[i], size: 14.0, color: color),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      steps[i],
                      style: TextStyle(
                        fontSize: 10.0,
                        color: color,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
                if (i < steps.length - 1)
                  Expanded(
                    child: Container(
                      height: 2.0,
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            color.withValues(alpha: 0.6),
                            color.withValues(alpha: 0.2),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),
                  ),
              ],
            ],
          ),
        ),
      ],
    ),
  );
}

// Helper: a single mock tooltip preview tile.
Widget _buildPreviewTile({
  required TooltipTriggerMode mode,
  required IconData targetIcon,
  required String targetLabel,
  required String tooltipText,
  required Color accent,
  required double reveal,
}) {
  return SizedBox(
    width: 230.0,
    child: Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: accent.withValues(alpha: 0.6), width: 1.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: accent.withValues(alpha: 0.18),
            blurRadius: 8.0,
            offset: const Offset(0.0, 3.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Icon(targetIcon, color: accent, size: 22.0),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  targetLabel,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: accent,
                    fontSize: 13.0,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          // Mock tooltip bubble — opacity proxies the static reveal value.
          Opacity(
            opacity: reveal.clamp(0.15, 1.0),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 6.0,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.shade900.withValues(alpha: 0.92),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                tooltipText,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11.5,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 4.0,
            ),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text(
              'triggerMode: ${mode.name}',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.5,
                color: accent,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// Helper: a recipe card with title, mode badge, and code snippet.
Widget _buildRecipeCard({
  required String title,
  required TooltipTriggerMode mode,
  required Color accent,
  required String code,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: accent.withValues(alpha: 0.5), width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withValues(alpha: 0.15),
          blurRadius: 6.0,
          offset: const Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.bookmark_border, color: accent, size: 18.0),
            const SizedBox(width: 6.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.5,
                  color: accent,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 3.0,
              ),
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                mode.name,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10.5,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        _buildCodeBlock(code, Colors.lightGreenAccent.shade100),
      ],
    ),
  );
}

// Helper: pitfall tile with icon, title, and explanation.
Widget _buildPitfallTile({
  required IconData icon,
  required Color color,
  required String title,
  required String body,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.8),
      borderRadius: BorderRadius.circular(10.0),
      border: Border(
        left: BorderSide(color: color, width: 4.0),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, color: color, size: 22.0),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: color,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                body,
                style: TextStyle(
                  fontSize: 11.5,
                  color: Colors.grey.shade900,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// Helper: header cell for the comparison matrix.
Widget _buildHeaderCell(String text, double width) {
  return SizedBox(
    width: width,
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 11.0,
        color: Colors.indigo.shade900,
      ),
    ),
  );
}

// Helper: data row for the comparison matrix.
Widget _buildMatrixRow({
  required TooltipTriggerMode mode,
  required bool pointer,
  required bool touch,
  required bool stealsTap,
  required bool isDefault,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: Colors.grey.shade300, width: 1.0),
      ),
    ),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 110.0,
          child: Text(
            mode.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              fontWeight: FontWeight.bold,
              color: Colors.indigo.shade900,
            ),
          ),
        ),
        _buildBoolCell(pointer, 70.0),
        _buildBoolCell(touch, 70.0),
        _buildBoolCell(stealsTap, 90.0),
        _buildBoolCell(isDefault, 70.0),
      ],
    ),
  );
}

// Helper: yes/no boolean cell.
Widget _buildBoolCell(bool value, double width) {
  return SizedBox(
    width: width,
    child: Icon(
      value ? Icons.check_circle : Icons.cancel,
      color: value ? Colors.green : Colors.red.shade300,
      size: 18.0,
    ),
  );
}

// Helper: monospaced code block with dark background.
Widget _buildCodeBlock(String code, Color textColor) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(
        color: Colors.white.withValues(alpha: 0.08),
        width: 1.0,
      ),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        color: textColor,
        height: 1.4,
      ),
    ),
  );
}
