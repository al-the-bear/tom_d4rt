// ignore_for_file: avoid_print
// Deep demo: DialogWindow — the dialog window widget itself, representing a
// platform-rendered dialog with configurable title, content area, action buttons,
// barrier behavior, animation, and accessibility semantics.
import 'package:flutter/material.dart';

// ────────────────────────────────────────────────────────────
// Theme: Ocean Teal (#00695C) on Frost Glass (#E0F2F1)
// Prefix: _dg (dialog)
// ────────────────────────────────────────────────────────────

const Color _dgTeal = Color(0xFF00695C);
const Color _dgFrost = Color(0xFFE0F2F1);
const Color _dgDarkTeal = Color(0xFF004D40);
const Color _dgLightTeal = Color(0xFF00897B);
const Color _dgMuted = Color(0xFF607D8B);
const Color _dgAccent = Color(0xFF26A69A);
const Color _dgDivider = Color(0xFFB2DFDB);
const Color _dgWhite = Color(0xFFFFFFFF);
const Color _dgBlack = Color(0xFF212121);
const Color _dgError = Color(0xFFC62828);
const Color _dgWarning = Color(0xFFF57F17);
const Color _dgInfo = Color(0xFF1565C0);

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
              colors: [_dgTeal, _dgDarkTeal],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: _dgTeal.withValues(alpha: 0.35),
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
                  Icon(Icons.web_asset, color: _dgFrost, size: 36),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      'DialogWindow',
                      style: TextStyle(
                        color: _dgFrost,
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
                'The dialog window widget — a platform-rendered overlay that '
                'presents content, collects user input, and returns a result '
                'through configurable layout, actions, and animations.',
                style: TextStyle(
                  color: _dgFrost.withValues(alpha: 0.88),
                  fontSize: 15,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),

        // ── 1. What Is It ──
        _dgSection('1. What Is DialogWindow?'),
        _dgBody(
          'DialogWindow is the visual representation of a dialog in the '
          'Flutter framework. Unlike DialogWindowController (which manages '
          'platform-native dialog lifecycle), DialogWindow is the actual '
          'widget tree that gets rendered — the title bar, content area, '
          'action buttons, and the barrier overlay that dims the background. '
          'It encapsulates the visual structure, layout constraints, '
          'animation transitions, scrolling behavior, and accessibility '
          'semantics of a dialog.',
        ),
        const SizedBox(height: 12),
        _dgInfoBox(
          'Widget vs Controller',
          'DialogWindowController manages WHEN and HOW a dialog appears '
          '(platform APIs, window handles). DialogWindow manages WHAT '
          'the dialog looks like (widget tree, layout, style).',
        ),
        const SizedBox(height: 24),

        // ── 2. Anatomy of a DialogWindow ──
        _dgSection('2. Anatomy of a DialogWindow'),
        _dgBody(
          'A DialogWindow consists of distinct visual regions, each '
          'configurable independently:',
        ),
        const SizedBox(height: 12),
        _buildAnatomyDiagram(),
        const SizedBox(height: 12),
        _dgCodeBlock(
          '// DialogWindow structure\n'
          'class DialogWindow extends StatefulWidget {\n'
          '  final Widget? title;\n'
          '  final Widget content;\n'
          '  final List<DialogAction> actions;\n'
          '  final EdgeInsets contentPadding;\n'
          '  final EdgeInsets actionsPadding;\n'
          '  final bool scrollable;\n'
          '  final Color? backgroundColor;\n'
          '  final ShapeBorder? shape;\n'
          '  final double? elevation;\n'
          '  final Duration animationDuration;\n'
          '  final bool barrierDismissible;\n'
          '  final Color barrierColor;\n'
          '  final String? semanticLabel;\n'
          '\n'
          '  const DialogWindow({\n'
          '    super.key,\n'
          '    this.title,\n'
          '    required this.content,\n'
          '    this.actions = const [],\n'
          '    this.contentPadding = const EdgeInsets\n'
          '        .fromLTRB(24, 20, 24, 24),\n'
          '    this.actionsPadding = const EdgeInsets\n'
          '        .only(left: 24, right: 24, bottom: 20),\n'
          '    this.scrollable = false,\n'
          '    this.backgroundColor,\n'
          '    this.shape,\n'
          '    this.elevation,\n'
          '    this.animationDuration =\n'
          '        const Duration(milliseconds: 150),\n'
          '    this.barrierDismissible = true,\n'
          '    this.barrierColor =\n'
          '        const Color(0x80000000),\n'
          '    this.semanticLabel,\n'
          '  });\n'
          '}',
        ),
        const SizedBox(height: 24),

        // ── 3. Layout Constraints ──
        _dgSection('3. Layout Constraints'),
        _dgBody(
          'DialogWindow enforces specific sizing constraints to ensure '
          'dialogs remain usable across screen sizes. The Material Design '
          'spec requires minimum and maximum widths, and the dialog '
          'must never overflow the viewport:',
        ),
        const SizedBox(height: 12),
        _buildConstraintsTable(),
        const SizedBox(height: 12),
        _dgCodeBlock(
          '// Layout constraint application\n'
          '@override\n'
          'Widget build(BuildContext context) {\n'
          '  final mediaQuery = MediaQuery.of(context);\n'
          '  final maxHeight = mediaQuery.size.height\n'
          '      - mediaQuery.viewPadding.top\n'
          '      - mediaQuery.viewPadding.bottom\n'
          '      - 48; // minimum margin\n'
          '\n'
          '  return ConstrainedBox(\n'
          '    constraints: BoxConstraints(\n'
          '      minWidth: 280,\n'
          '      maxWidth: 560,\n'
          '      maxHeight: maxHeight,\n'
          '    ),\n'
          '    child: Material(\n'
          '      elevation: widget.elevation ?? 24,\n'
          '      color: widget.backgroundColor ??\n'
          '          Theme.of(context).dialogBackgroundColor,\n'
          '      shape: widget.shape ??\n'
          '          RoundedRectangleBorder(\n'
          '            borderRadius:\n'
          '                BorderRadius.circular(28),\n'
          '          ),\n'
          '      child: _buildContent(),\n'
          '    ),\n'
          '  );\n'
          '}',
        ),
        const SizedBox(height: 24),

        // ── 4. Title Configuration ──
        _dgSection('4. Title Configuration'),
        _dgBody(
          'The title area supports text, icons, and custom widgets. It '
          'receives special typography treatment and padding to separate '
          'it from the content area:',
        ),
        const SizedBox(height: 12),
        _buildTitleVariants(),
        const SizedBox(height: 24),

        // ── 5. Content Area ──
        _dgSection('5. Content Area & Scrolling'),
        _dgBody(
          'The content area is the main body of the dialog. When the '
          'scrollable property is true, the content wraps in a '
          'SingleChildScrollView with proper padding and scroll physics. '
          'Non-scrollable content assumes a fixed height:',
        ),
        const SizedBox(height: 12),
        _buildScrollBehaviorComparison(),
        const SizedBox(height: 12),
        _dgCodeBlock(
          '// Scrollable content handling\n'
          'Widget _buildContent() {\n'
          '  final titleWidget = widget.title != null\n'
          '      ? Padding(\n'
          '          padding: const EdgeInsets.fromLTRB(\n'
          '              24, 24, 24, 0),\n'
          '          child: DefaultTextStyle(\n'
          '            style:\n'
          '                Theme.of(context)\n'
          '                    .textTheme\n'
          '                    .headlineSmall!,\n'
          '            child: widget.title!,\n'
          '          ),\n'
          '        )\n'
          '      : null;\n'
          '\n'
          '  if (widget.scrollable) {\n'
          '    return Column(\n'
          '      mainAxisSize: MainAxisSize.min,\n'
          '      children: [\n'
          '        if (titleWidget != null) titleWidget,\n'
          '        Flexible(\n'
          '          child: SingleChildScrollView(\n'
          '            padding: widget.contentPadding,\n'
          '            child: widget.content,\n'
          '          ),\n'
          '        ),\n'
          '        _buildActions(),\n'
          '      ],\n'
          '    );\n'
          '  }\n'
          '  return Column(\n'
          '    mainAxisSize: MainAxisSize.min,\n'
          '    children: [\n'
          '      if (titleWidget != null) titleWidget,\n'
          '      Padding(\n'
          '        padding: widget.contentPadding,\n'
          '        child: widget.content,\n'
          '      ),\n'
          '      _buildActions(),\n'
          '    ],\n'
          '  );\n'
          '}',
        ),
        const SizedBox(height: 24),

        // ── 6. Action Buttons ──
        _dgSection('6. Action Buttons'),
        _dgBody(
          'DialogActions define the buttons at the bottom of the dialog. '
          'Each action has a label, callback, style, and optional '
          'attributes like auto-focus and destructive marking:',
        ),
        const SizedBox(height: 12),
        _buildActionButtonShowcase(),
        const SizedBox(height: 12),
        _dgCodeBlock(
          '// DialogAction model\n'
          'class DialogAction {\n'
          '  final String label;\n'
          '  final VoidCallback? onPressed;\n'
          '  final bool isDefault;\n'
          '  final bool isDestructive;\n'
          '  final bool autofocus;\n'
          '\n'
          '  const DialogAction({\n'
          '    required this.label,\n'
          '    this.onPressed,\n'
          '    this.isDefault = false,\n'
          '    this.isDestructive = false,\n'
          '    this.autofocus = false,\n'
          '  });\n'
          '}',
        ),
        const SizedBox(height: 24),

        // ── 7. Barrier Behavior ──
        _dgSection('7. Barrier Behavior'),
        _dgBody(
          'The barrier is the semi-transparent overlay behind the dialog. '
          'It controls whether tapping outside dismisses the dialog, '
          'its color/opacity, and how it interacts with the route:',
        ),
        const SizedBox(height: 12),
        _buildBarrierPropertiesTable(),
        const SizedBox(height: 24),

        // ── 8. Animation Transitions ──
        _dgSection('8. Animation Transitions'),
        _dgBody(
          'DialogWindow uses coordinated animations for entry and exit. '
          'The barrier fades, the dialog scales and fades, and all '
          'animations use the same curve for visual coherence:',
        ),
        const SizedBox(height: 12),
        _buildAnimationTimeline(),
        const SizedBox(height: 12),
        _dgCodeBlock(
          '// Animation controller setup\n'
          '@override\n'
          'void initState() {\n'
          '  super.initState();\n'
          '  _animController = AnimationController(\n'
          '    vsync: this,\n'
          '    duration: widget.animationDuration,\n'
          '  );\n'
          '  _scaleAnimation = CurvedAnimation(\n'
          '    parent: _animController,\n'
          '    curve: Curves.easeOutCubic,\n'
          '  );\n'
          '  _fadeAnimation = CurvedAnimation(\n'
          '    parent: _animController,\n'
          '    curve: Curves.easeIn,\n'
          '  );\n'
          '  _animController.forward();\n'
          '}\n'
          '\n'
          '// Animated dialog wrapper\n'
          'Widget _buildAnimatedDialog() {\n'
          '  return ScaleTransition(\n'
          '    scale: _scaleAnimation,\n'
          '    child: FadeTransition(\n'
          '      opacity: _fadeAnimation,\n'
          '      child: _buildDialogSurface(),\n'
          '    ),\n'
          '  );\n'
          '}',
        ),
        const SizedBox(height: 24),

        // ── 9. Accessibility Semantics ──
        _dgSection('9. Accessibility Semantics'),
        _dgBody(
          'DialogWindow provides semantic information to screen readers '
          'through Semantics widgets, focus management, and role '
          'annotations. This ensures dialogs are navigable via assistive '
          'technology:',
        ),
        const SizedBox(height: 12),
        _buildAccessibilityChecklist(),
        const SizedBox(height: 12),
        _dgCodeBlock(
          '// Accessibility wrapper\n'
          'Widget _wrapWithSemantics(Widget dialog) {\n'
          '  return Semantics(\n'
          '    scopesRoute: true,\n'
          '    explicitChildNodes: true,\n'
          '    namesRoute: true,\n'
          '    label: widget.semanticLabel ??\n'
          '        MaterialLocalizations.of(context)\n'
          '            .dialogLabel,\n'
          '    child: dialog,\n'
          '  );\n'
          '}',
        ),
        const SizedBox(height: 24),

        // ── 10. Dialog Result Handling ──
        _dgSection('10. Dialog Result Handling'),
        _dgBody(
          'Dialogs return results through Navigator.pop with a typed '
          'value. The dialog window coordinates between action button '
          'callbacks and the route to ensure clean result propagation:',
        ),
        const SizedBox(height: 12),
        _buildResultFlowDiagram(),
        const SizedBox(height: 24),

        // ── 11. Responsive Design ──
        _dgSection('11. Responsive Design Adaptations'),
        _dgBody(
          'DialogWindow adapts its layout based on screen size, '
          'orientation, and platform. On smaller screens, it may '
          'switch to a full-screen presentation:',
        ),
        const SizedBox(height: 12),
        _buildResponsiveBreakpoints(),
        const SizedBox(height: 24),

        // ── 12. Practical Scenario ──
        _dgSection('12. Confirmation Dialog Scenario'),
        _dgBody(
          'A complete walkthrough of building a confirmation dialog with '
          'title, message content, warning icon, and confirm/cancel '
          'action buttons — showing each component being assembled:',
        ),
        const SizedBox(height: 12),
        _buildConfirmationDialogScenario(),
        const SizedBox(height: 24),

        // ── Summary ──
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                _dgTeal.withValues(alpha: 0.08),
                _dgFrost,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _dgTeal.withValues(alpha: 0.25),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.summarize, color: _dgTeal, size: 22),
                  const SizedBox(width: 10),
                  Text(
                    'Summary',
                    style: TextStyle(
                      color: _dgTeal,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              _dgSummaryRow('Widget Type', 'StatefulWidget with AnimationController'),
              _dgSummaryRow('Regions', 'Title, Content, Actions, Barrier'),
              _dgSummaryRow('Constraints', '280–560px width, viewport-capped height'),
              _dgSummaryRow('Scrolling', 'Optional via scrollable property'),
              _dgSummaryRow('Animation', 'Scale + Fade with configurable duration'),
              _dgSummaryRow('Accessibility', 'Scoped route, semantic label, focus trap'),
              _dgSummaryRow('Result', 'Typed value via Navigator.pop<T>'),
            ],
          ),
        ),
        const SizedBox(height: 32),
      ],
    ),
  );
}

// ─── Helper Widgets ──────────────────────────────────────────

Widget _dgSection(String title) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Text(
      title,
      style: TextStyle(
        color: _dgTeal,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.3,
      ),
    ),
  );
}

Widget _dgBody(String text) {
  return Text(
    text,
    style: TextStyle(
      color: _dgBlack,
      fontSize: 15,
      height: 1.6,
    ),
  );
}

Widget _dgCodeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFF263238),
      borderRadius: BorderRadius.circular(10),
    ),
    child: SelectableText(
      code,
      style: const TextStyle(
        color: Color(0xFFE0E0E0),
        fontSize: 13,
        fontFamily: 'monospace',
        height: 1.5,
      ),
    ),
  );
}


Widget _dgInfoBox(String title, String content) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _dgInfo.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _dgInfo.withValues(alpha: 0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.info_outline, color: _dgInfo, size: 18),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: _dgInfo,
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
            color: _dgBlack,
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

Widget _dgSummaryRow(String label, String value) {
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
              color: _dgMuted,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: _dgBlack,
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

Widget _buildAnatomyDiagram() {
  final regions = <Map<String, dynamic>>[
    {
      'label': 'Barrier Overlay',
      'desc': 'Semi-transparent background dimming',
      'icon': Icons.layers,
      'color': _dgMuted,
    },
    {
      'label': 'Dialog Surface',
      'desc': 'Elevated Material with shape and shadow',
      'icon': Icons.crop_square,
      'color': _dgTeal,
    },
    {
      'label': 'Title Area',
      'desc': 'Optional header with typography treatment',
      'icon': Icons.title,
      'color': _dgDarkTeal,
    },
    {
      'label': 'Content Area',
      'desc': 'Main body — text, forms, custom widgets',
      'icon': Icons.article,
      'color': _dgLightTeal,
    },
    {
      'label': 'Actions Area',
      'desc': 'Bottom row of buttons (confirm, cancel, etc.)',
      'icon': Icons.smart_button,
      'color': _dgAccent,
    },
  ];

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _dgFrost,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _dgDivider),
    ),
    child: Column(
      children: [
        for (var i = 0; i < regions.length; i++) ...[
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: (regions[i]['color'] as Color).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  regions[i]['icon'] as IconData,
                  color: regions[i]['color'] as Color,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      regions[i]['label'] as String,
                      style: TextStyle(
                        color: regions[i]['color'] as Color,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      regions[i]['desc'] as String,
                      style: TextStyle(color: _dgMuted, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (i < regions.length - 1) const SizedBox(height: 10),
        ],
      ],
    ),
  );
}

Widget _buildConstraintsTable() {
  final constraints = <List<String>>[
    ['Min Width', '280px', 'Prevents too-narrow dialogs'],
    ['Max Width', '560px', 'Keeps content readable'],
    ['Max Height', 'Viewport - 48px', 'Stays within safe area'],
    ['Min Margin', '24px horizontal', 'Screen edge spacing'],
    ['Content Padding', '24px L/R, 20px top', 'Internal spacing'],
    ['Actions Padding', '24px L/R, 20px bottom', 'Button area spacing'],
  ];

  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _dgDivider),
    ),
    child: Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: _dgTeal.withValues(alpha: 0.08),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(9),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text('Constraint', style: TextStyle(
                  color: _dgTeal, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 3,
                child: Text('Value', style: TextStyle(
                  color: _dgTeal, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 4,
                child: Text('Purpose', style: TextStyle(
                  color: _dgTeal, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
        for (var row in constraints)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: _dgDivider)),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(row[0], style: TextStyle(
                    color: _dgDarkTeal, fontSize: 12, fontWeight: FontWeight.w600)),
                ),
                Expanded(
                  flex: 3,
                  child: Text(row[1], style: TextStyle(
                    color: _dgBlack, fontSize: 12, fontFamily: 'monospace')),
                ),
                Expanded(
                  flex: 4,
                  child: Text(row[2], style: TextStyle(
                    color: _dgMuted, fontSize: 12)),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

Widget _buildTitleVariants() {
  final variants = <Map<String, dynamic>>[
    {
      'variant': 'Text Only',
      'desc': 'Simple headline text title',
      'icon': Icons.text_fields,
      'example': 'Text("Delete Item?")',
    },
    {
      'variant': 'Icon + Text',
      'desc': 'Leading icon with title text',
      'icon': Icons.warning_amber,
      'example': 'Row([Icon(warn), Text("Warning")])',
    },
    {
      'variant': 'Custom Widget',
      'desc': 'Any widget as title content',
      'icon': Icons.widgets,
      'example': 'Column([avatar, name, subtitle])',
    },
    {
      'variant': 'No Title',
      'desc': 'Title omitted — content starts at top',
      'icon': Icons.block,
      'example': 'title: null',
    },
  ];

  return Wrap(
    spacing: 10,
    runSpacing: 10,
    children: [
      for (var v in variants)
        Container(
          width: 170,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _dgFrost,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _dgDivider),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(v['icon'] as IconData,
                      color: _dgTeal, size: 18),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      v['variant'] as String,
                      style: TextStyle(
                        color: _dgTeal,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                v['desc'] as String,
                style: TextStyle(color: _dgBlack, fontSize: 12),
              ),
              const SizedBox(height: 4),
              Text(
                v['example'] as String,
                style: TextStyle(
                  color: _dgMuted,
                  fontSize: 11,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),
    ],
  );
}

Widget _buildScrollBehaviorComparison() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _dgTeal.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _dgTeal.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.height, color: _dgTeal, size: 16),
                  const SizedBox(width: 6),
                  Text('scrollable: false', style: TextStyle(
                    color: _dgTeal, fontSize: 12, fontWeight: FontWeight.bold,
                    fontFamily: 'monospace')),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Content has fixed height. Dialog sizes to fit. '
                'Overflow causes layout error if content too tall.',
                style: TextStyle(color: _dgBlack, fontSize: 12, height: 1.4),
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
            color: _dgAccent.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _dgAccent.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.swap_vert, color: _dgAccent, size: 16),
                  const SizedBox(width: 6),
                  Text('scrollable: true', style: TextStyle(
                    color: _dgAccent, fontSize: 12, fontWeight: FontWeight.bold,
                    fontFamily: 'monospace')),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Content wraps in ScrollView. Title and actions '
                'stay fixed while content scrolls. Handles overflow.',
                style: TextStyle(color: _dgBlack, fontSize: 12, height: 1.4),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _buildActionButtonShowcase() {
  final actions = <Map<String, dynamic>>[
    {
      'label': 'Cancel',
      'style': 'TextButton',
      'flags': 'Default style',
      'color': _dgMuted,
    },
    {
      'label': 'Confirm',
      'style': 'FilledButton',
      'flags': 'isDefault: true',
      'color': _dgTeal,
    },
    {
      'label': 'Delete',
      'style': 'TextButton',
      'flags': 'isDestructive: true',
      'color': _dgError,
    },
    {
      'label': 'Save',
      'style': 'FilledButton',
      'flags': 'autofocus: true',
      'color': _dgAccent,
    },
    {
      'label': 'Details',
      'style': 'OutlinedButton',
      'flags': 'Custom style',
      'color': _dgInfo,
    },
    {
      'label': 'Later',
      'style': 'TextButton',
      'flags': 'Dismiss action',
      'color': _dgWarning,
    },
  ];

  return Wrap(
    spacing: 8,
    runSpacing: 8,
    children: [
      for (var a in actions)
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: (a['color'] as Color).withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: (a['color'] as Color).withValues(alpha: 0.25),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                a['label'] as String,
                style: TextStyle(
                  color: a['color'] as Color,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                a['style'] as String,
                style: TextStyle(
                  color: _dgBlack,
                  fontSize: 11,
                  fontFamily: 'monospace',
                ),
              ),
              Text(
                a['flags'] as String,
                style: TextStyle(color: _dgMuted, fontSize: 11),
              ),
            ],
          ),
        ),
    ],
  );
}

Widget _buildBarrierPropertiesTable() {
  final props = <List<String>>[
    ['barrierDismissible', 'bool', 'true', 'Tap outside to dismiss'],
    ['barrierColor', 'Color', '0x80000000', 'Overlay color/opacity'],
    ['barrierLabel', 'String?', 'null', 'Screen reader announcement'],
    ['useSafeArea', 'bool', 'true', 'Respect notch/status bar'],
    ['routeSettings', 'RouteSettings?', 'null', 'Route name for analytics'],
  ];

  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _dgDivider),
    ),
    child: Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: _dgTeal.withValues(alpha: 0.08),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(9),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Text('Property', style: TextStyle(
                  color: _dgTeal, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 2,
                child: Text('Type', style: TextStyle(
                  color: _dgTeal, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 2,
                child: Text('Default', style: TextStyle(
                  color: _dgTeal, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 4,
                child: Text('Purpose', style: TextStyle(
                  color: _dgTeal, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
        for (var row in props)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: _dgDivider)),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text(row[0], style: TextStyle(
                    color: _dgDarkTeal, fontSize: 11,
                    fontFamily: 'monospace', fontWeight: FontWeight.w600)),
                ),
                Expanded(
                  flex: 2,
                  child: Text(row[1], style: TextStyle(
                    color: _dgMuted, fontSize: 11)),
                ),
                Expanded(
                  flex: 2,
                  child: Text(row[2], style: TextStyle(
                    color: _dgBlack, fontSize: 11, fontFamily: 'monospace')),
                ),
                Expanded(
                  flex: 4,
                  child: Text(row[3], style: TextStyle(
                    color: _dgMuted, fontSize: 11)),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

Widget _buildAnimationTimeline() {
  final phases = <Map<String, dynamic>>[
    {
      'phase': 'Entry — Barrier Fade',
      'duration': '0ms → 150ms',
      'desc': 'Barrier color fades from transparent to barrierColor',
      'curve': 'Curves.easeIn',
      'color': _dgMuted,
    },
    {
      'phase': 'Entry — Dialog Scale',
      'duration': '0ms → 150ms',
      'desc': 'Dialog scales from 0.8 to 1.0 with easeOutCubic',
      'curve': 'Curves.easeOutCubic',
      'color': _dgTeal,
    },
    {
      'phase': 'Entry — Dialog Fade',
      'duration': '0ms → 100ms',
      'desc': 'Dialog opacity goes from 0.0 to 1.0',
      'curve': 'Curves.easeIn',
      'color': _dgAccent,
    },
    {
      'phase': 'Exit — Dialog Fade',
      'duration': '0ms → 75ms',
      'desc': 'Dialog fades out quickly',
      'curve': 'Curves.easeOut',
      'color': _dgWarning,
    },
    {
      'phase': 'Exit — Barrier Fade',
      'duration': '0ms → 150ms',
      'desc': 'Barrier fades to transparent',
      'curve': 'Curves.easeOut',
      'color': _dgError,
    },
  ];

  return Column(
    children: [
      for (var i = 0; i < phases.length; i++) ...[
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: (phases[i]['color'] as Color).withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: (phases[i]['color'] as Color).withValues(alpha: 0.2),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: (phases[i]['color'] as Color).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  phases[i]['duration'] as String,
                  style: TextStyle(
                    color: phases[i]['color'] as Color,
                    fontSize: 11,
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
                      phases[i]['phase'] as String,
                      style: TextStyle(
                        color: phases[i]['color'] as Color,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      phases[i]['desc'] as String,
                      style: TextStyle(color: _dgBlack, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (i < phases.length - 1) const SizedBox(height: 6),
      ],
    ],
  );
}

Widget _buildAccessibilityChecklist() {
  final items = <Map<String, dynamic>>[
    {
      'feature': 'Semantic Route Scope',
      'desc': 'scopesRoute: true — announces dialog entry to screen readers',
      'icon': Icons.route,
    },
    {
      'feature': 'Focus Trap',
      'desc': 'Tab key cycles only through dialog widgets, not background content',
      'icon': Icons.crop_free,
    },
    {
      'feature': 'Auto-Focus Default Action',
      'desc': 'Default action button receives focus on dialog open',
      'icon': Icons.center_focus_strong,
    },
    {
      'feature': 'Escape Key Binding',
      'desc': 'Pressing Escape triggers barrier dismiss if allowed',
      'icon': Icons.keyboard,
    },
    {
      'feature': 'Label Announcement',
      'desc': 'semanticLabel read aloud when dialog opens',
      'icon': Icons.record_voice_over,
    },
  ];

  return Column(
    children: [
      for (var i = 0; i < items.length; i++) ...[
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _dgFrost,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _dgDivider),
          ),
          child: Row(
            children: [
              Icon(items[i]['icon'] as IconData,
                  color: _dgTeal, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      items[i]['feature'] as String,
                      style: TextStyle(
                        color: _dgDarkTeal,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      items[i]['desc'] as String,
                      style: TextStyle(
                        color: _dgBlack, fontSize: 12, height: 1.4),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (i < items.length - 1) const SizedBox(height: 6),
      ],
    ],
  );
}

Widget _buildResultFlowDiagram() {
  final steps = <Map<String, String>>[
    {
      'step': 'User taps action button',
      'detail': 'DialogAction.onPressed callback fires',
    },
    {
      'step': 'Callback processes logic',
      'detail': 'Validation, data collection, etc.',
    },
    {
      'step': 'Navigator.pop<T>(context, result)',
      'detail': 'Typed result passed back to caller',
    },
    {
      'step': 'Exit animation plays',
      'detail': 'Dialog fades and scales out',
    },
    {
      'step': 'Route completes with Future<T>',
      'detail': 'showDialog() Future resolves with result',
    },
  ];

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _dgFrost,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _dgDivider),
    ),
    child: Column(
      children: [
        for (var i = 0; i < steps.length; i++) ...[
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: _dgTeal,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Center(
                  child: Text(
                    '${i + 1}',
                    style: TextStyle(
                      color: _dgWhite,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      steps[i]['step']!,
                      style: TextStyle(
                        color: _dgDarkTeal,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      steps[i]['detail']!,
                      style: TextStyle(
                        color: _dgMuted,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (i < steps.length - 1)
            Padding(
              padding: const EdgeInsets.only(left: 13, top: 4, bottom: 4),
              child: Container(width: 2, height: 10, color: _dgDivider),
            ),
        ],
      ],
    ),
  );
}

Widget _buildResponsiveBreakpoints() {
  final breakpoints = <Map<String, dynamic>>[
    {
      'range': '< 360px',
      'behavior': 'Full-screen dialog (fullscreenDialog route)',
      'icon': Icons.phone_android,
      'color': _dgError,
    },
    {
      'range': '360–599px',
      'behavior': 'Centered dialog, min-width 280px, snug padding',
      'icon': Icons.smartphone,
      'color': _dgWarning,
    },
    {
      'range': '600–839px',
      'behavior': 'Standard centered dialog, default constraints',
      'icon': Icons.tablet,
      'color': _dgTeal,
    },
    {
      'range': '840px+',
      'behavior': 'Centered dialog, max-width 560px, generous margin',
      'icon': Icons.desktop_mac,
      'color': _dgInfo,
    },
  ];

  return Column(
    children: [
      for (var i = 0; i < breakpoints.length; i++) ...[
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: (breakpoints[i]['color'] as Color).withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: (breakpoints[i]['color'] as Color).withValues(alpha: 0.2),
            ),
          ),
          child: Row(
            children: [
              Icon(breakpoints[i]['icon'] as IconData,
                  color: breakpoints[i]['color'] as Color, size: 22),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      breakpoints[i]['range'] as String,
                      style: TextStyle(
                        color: breakpoints[i]['color'] as Color,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'monospace',
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      breakpoints[i]['behavior'] as String,
                      style: TextStyle(
                        color: _dgBlack, fontSize: 12, height: 1.4),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (i < breakpoints.length - 1) const SizedBox(height: 6),
      ],
    ],
  );
}

Widget _buildConfirmationDialogScenario() {
  final assembly = <Map<String, String>>[
    {
      'component': 'Title',
      'code': 'Text("Delete Project?")',
      'note': 'Clear question format',
    },
    {
      'component': 'Icon',
      'code': 'Icon(Icons.warning, color: red)',
      'note': 'Visual severity indicator',
    },
    {
      'component': 'Message',
      'code': 'Text("This cannot be undone...")',
      'note': 'Explain consequences',
    },
    {
      'component': 'Cancel Action',
      'code': 'DialogAction(label: "Cancel")',
      'note': 'Default dismiss behavior',
    },
    {
      'component': 'Delete Action',
      'code': 'DialogAction(isDestructive: true)',
      'note': 'Red, requires explicit tap',
    },
    {
      'component': 'Barrier',
      'code': 'barrierDismissible: false',
      'note': 'Force explicit choice',
    },
  ];

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _dgFrost,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _dgDivider),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.build, color: _dgTeal, size: 20),
            const SizedBox(width: 8),
            Text(
              'Building a Delete Confirmation Dialog',
              style: TextStyle(
                color: _dgTeal,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        for (var i = 0; i < assembly.length; i++) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: _dgTeal.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Center(
                  child: Text(
                    '${i + 1}',
                    style: TextStyle(
                      color: _dgTeal,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      assembly[i]['component']!,
                      style: TextStyle(
                        color: _dgDarkTeal,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      assembly[i]['code']!,
                      style: TextStyle(
                        color: _dgBlack,
                        fontSize: 12,
                        fontFamily: 'monospace',
                      ),
                    ),
                    Text(
                      assembly[i]['note']!,
                      style: TextStyle(
                        color: _dgMuted,
                        fontSize: 11,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (i < assembly.length - 1) const SizedBox(height: 8),
        ],
      ],
    ),
  );
}
