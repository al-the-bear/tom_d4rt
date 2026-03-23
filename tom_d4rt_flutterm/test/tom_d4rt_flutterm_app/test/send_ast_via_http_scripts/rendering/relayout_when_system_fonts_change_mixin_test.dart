// ignore_for_file: avoid_print
// D4rt test script: Deep demo for RelayoutWhenSystemFontsChangeMixin from rendering
//
// RelayoutWhenSystemFontsChangeMixin is a mixin on RenderObject that
// automatically triggers relayout when the system fonts change. This
// ensures text-heavy render objects always display with the correct
// metrics after a font change event (e.g. user installs a new font,
// accessibility settings alter font scaling, or locale changes cause
// font substitution).
//
// Key responsibilities:
//   - Listens to PaintingBinding.systemFonts for font change events
//   - Marks the render object as needing layout on font change
//   - Properly attaches and detaches the font change listener
//   - Ensures layout is recomputed with fresh TextPainter metrics
//   - Works with any RenderObject that depends on font measurements
//
// Related classes:
//   - RenderObject: Base class for all render tree nodes
//   - RenderParagraph: Uses this mixin for text rendering
//   - RenderEditable: Uses this mixin for editable text
//   - PaintingBinding: Provides systemFonts notifier
//   - SystemFontsDidChangeNotifier: Notifier for font changes
//   - TextPainter: Measures and paints text runs
//
// Use cases:
//   - Text-heavy UIs that must respond to font installations
//   - Accessibility-driven font scale changes
//   - Locale switches causing font fallback changes
//   - Custom render objects that measure text
//   - Hybrid apps with dynamic system font loading

import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildHeader(String title, String subtitle) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF4A148C), Color(0xFF7B1FA2)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF4A148C).withAlpha(100),
          blurRadius: 12,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(Icons.font_download, size: 48, color: Colors.white),
        SizedBox(height: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(fontSize: 14, color: Colors.white.withAlpha(200)),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget _buildSectionTitle(String title, IconData icon) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 12),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(0xFF7B1FA2).withAlpha(30),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Color(0xFF4A148C), size: 20),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4A148C),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildInfoRow(String label, String value, {Color? valueColor}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 150,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xFF4A148C),
              fontSize: 13,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: valueColor ?? Color(0xFF6A1B9A),
              fontSize: 13,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildDiagramBox(
  String label,
  Color color, {
  IconData? icon,
  double width = 110,
}) {
  return Container(
    width: width,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
    decoration: BoxDecoration(
      color: color.withAlpha(30),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color, width: 2),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) Icon(icon, color: color, size: 20),
        if (icon != null) SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: color,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget _buildArrow({bool vertical = false, Color color = Colors.grey}) {
  if (vertical) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 2, height: 20, color: color),
        Icon(Icons.arrow_drop_down, color: color, size: 20),
      ],
    );
  }
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(width: 20, height: 2, color: color),
      Icon(Icons.arrow_right, color: color, size: 20),
    ],
  );
}

Widget _buildStepItem(
  String step,
  String description,
  IconData icon,
  Color color,
) {
  return Row(
    children: [
      Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            step,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
      SizedBox(width: 12),
      Icon(icon, color: color, size: 18),
      SizedBox(width: 8),
      Expanded(
        child: Text(
          description,
          style: TextStyle(fontSize: 13, color: Color(0xFF37474F)),
        ),
      ),
    ],
  );
}

Widget _buildFlowConnector(Color color) {
  return Padding(
    padding: EdgeInsets.only(left: 14),
    child: Column(
      children: [
        Container(width: 2, height: 16, color: color.withAlpha(120)),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 1: MIXIN OVERVIEW
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildMixinOverviewSection() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Mixin Overview', Icons.extension),
        Text(
          'RelayoutWhenSystemFontsChangeMixin is applied to RenderObject '
          'subclasses that depend on system font metrics. When the operating '
          'system reports a font change, the mixin automatically calls '
          'markNeedsLayout() so the render object recomputes its size and '
          'position using fresh font measurements.',
          style: TextStyle(color: Color(0xFF546E7A), fontSize: 13),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFF3E5F5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                'Mixin Declaration',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A148C),
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xFF212121),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'mixin RelayoutWhenSystemFontsChangeMixin\n'
                  '    on RenderObject {\n'
                  '  // Listens to systemFonts notifier\n'
                  '  // Calls markNeedsLayout on change\n'
                  '}',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    color: Color(0xFF80CBC4),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        _buildInfoRow('Type', 'Mixin on RenderObject'),
        _buildInfoRow('Library', 'package:flutter/rendering.dart'),
        _buildInfoRow('Purpose', 'Auto-relayout on system font changes'),
        _buildInfoRow('Lifecycle', 'attach() / detach() for listener management'),
        _buildInfoRow(
          'Key Users',
          'RenderParagraph, RenderEditable',
          valueColor: Color(0xFF00695C),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFEDE7F6),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFB39DDB)),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Color(0xFF5E35B1), size: 18),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'The mixin overrides attach() and detach() to subscribe '
                  'and unsubscribe from the system fonts change notifier. '
                  'This avoids memory leaks and dangling listeners.',
                  style: TextStyle(fontSize: 12, color: Color(0xFF4A148C)),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 2: SYSTEM FONT CHANGE PROPAGATION
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildFontChangePropagationSection() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('System Font Change Propagation', Icons.settings_system_daydream),
        Text(
          'When the operating system notifies Flutter that system fonts '
          'have changed, the event flows through PaintingBinding to all '
          'render objects using this mixin. Here is the full propagation path:',
          style: TextStyle(color: Color(0xFF546E7A), fontSize: 13),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFCE4EC), Color(0xFFF8BBD0)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Font Change Event Flow',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFC62828),
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 16),
              _buildStepItem(
                '1',
                'OS detects font change (install, remove, scale)',
                Icons.computer,
                Color(0xFFB71C1C),
              ),
              _buildFlowConnector(Color(0xFFE53935)),
              _buildStepItem(
                '2',
                'Platform channel sends fontChange message',
                Icons.swap_horiz,
                Color(0xFFC62828),
              ),
              _buildFlowConnector(Color(0xFFE53935)),
              _buildStepItem(
                '3',
                'PaintingBinding.handleSystemMessage processes event',
                Icons.settings_input_component,
                Color(0xFFD32F2F),
              ),
              _buildFlowConnector(Color(0xFFE53935)),
              _buildStepItem(
                '4',
                'SystemFontsDidChangeNotifier fires notification',
                Icons.notifications_active,
                Color(0xFFE53935),
              ),
              _buildFlowConnector(Color(0xFFE53935)),
              _buildStepItem(
                '5',
                'Mixin callback called: systemFontsDidChange()',
                Icons.refresh,
                Color(0xFFEF5350),
              ),
              _buildFlowConnector(Color(0xFFE53935)),
              _buildStepItem(
                '6',
                'markNeedsLayout() invoked on the render object',
                Icons.format_paint,
                Color(0xFFEF9A9A),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFF3E5F5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Platform Channel Detail',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A148C),
                  fontSize: 13,
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  _buildDiagramBox(
                    'Engine\n(C++)',
                    Color(0xFF795548),
                    icon: Icons.memory,
                  ),
                  _buildArrow(color: Color(0xFF795548)),
                  _buildDiagramBox(
                    'Platform\nChannel',
                    Color(0xFFFF6F00),
                    icon: Icons.settings_ethernet,
                  ),
                  _buildArrow(color: Color(0xFFFF6F00)),
                  _buildDiagramBox(
                    'Painting\nBinding',
                    Color(0xFF4A148C),
                    icon: Icons.brush,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        _buildInfoRow('Channel', 'flutter/system via handleSystemMessage'),
        _buildInfoRow('Message', "type: fontsChange"),
        _buildInfoRow('Notifier', 'PaintingBinding.systemFonts'),
        _buildInfoRow(
          'Cache',
          'FontLoader cache invalidated before notification',
          valueColor: Color(0xFFBF360C),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 3: LAYOUT INVALIDATION FLOW
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildLayoutInvalidationSection() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Layout Invalidation Flow', Icons.autorenew),
        Text(
          'When systemFontsDidChange() is called, the mixin marks the '
          'render object as needing layout. This triggers the standard '
          'layout pipeline: the object is added to the dirty list, and '
          'during the next frame the pipeline owner flushes layout.',
          style: TextStyle(color: Color(0xFF546E7A), fontSize: 13),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFE8F5E9),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                'Layout Pipeline Response',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B5E20),
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildDiagramBox(
                    'systemFonts\nDidChange()',
                    Color(0xFFC62828),
                    icon: Icons.hearing,
                    width: 100,
                  ),
                  _buildArrow(color: Color(0xFF388E3C)),
                  _buildDiagramBox(
                    'markNeeds\nLayout()',
                    Color(0xFFE65100),
                    icon: Icons.flag,
                    width: 100,
                  ),
                  _buildArrow(color: Color(0xFF388E3C)),
                  _buildDiagramBox(
                    'Dirty List\nEntry',
                    Color(0xFF1565C0),
                    icon: Icons.list,
                    width: 100,
                  ),
                ],
              ),
              SizedBox(height: 12),
              _buildArrow(vertical: true, color: Color(0xFF388E3C)),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildDiagramBox(
                    'flushLayout()',
                    Color(0xFF2E7D32),
                    icon: Icons.sync,
                    width: 100,
                  ),
                  _buildArrow(color: Color(0xFF388E3C)),
                  _buildDiagramBox(
                    'performLayout\n(fresh metrics)',
                    Color(0xFF00695C),
                    icon: Icons.check_circle,
                    width: 120,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFFFF3E0),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFFFB74D)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.warning_amber, color: Color(0xFFE65100), size: 18),
                  SizedBox(width: 8),
                  Text(
                    'Important Considerations',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Color(0xFFE65100),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              _buildBulletPoint(
                'markNeedsLayout() only schedules; it does not run layout immediately',
              ),
              _buildBulletPoint(
                'The font cache is cleared before the notification fires',
              ),
              _buildBulletPoint(
                'TextPainter instances re-measure on the next layout pass',
              ),
              _buildBulletPoint(
                'Paint is also invalidated because layout changes trigger repaint',
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        _buildInfoRow('Trigger', 'systemFontsDidChange callback'),
        _buildInfoRow('Effect', 'markNeedsLayout on the render object'),
        _buildInfoRow('Timing', 'Next frame during flushLayout phase'),
        _buildInfoRow(
          'Cascade',
          'Children may also relayout due to constraint changes',
        ),
      ],
    ),
  );
}

Widget _buildBulletPoint(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('  \u2022  ', style: TextStyle(color: Color(0xFFE65100), fontSize: 13)),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 12, color: Color(0xFF4E342E)),
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 4: USE CASES WITH TEXT-HEAVY UIS
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildTextHeavyUseCasesSection() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Use Cases: Text-Heavy UIs', Icons.text_fields),
        Text(
          'Text-heavy applications are the primary beneficiaries of this mixin. '
          'Whenever system fonts change, all text-dependent render objects '
          'recalculate their metrics to ensure proper display.',
          style: TextStyle(color: Color(0xFF546E7A), fontSize: 13),
        ),
        SizedBox(height: 16),
        _buildUseCaseCard(
          'Reading / News Apps',
          'Long-form article content uses RenderParagraph extensively. '
          'When a user changes their preferred reading font in system '
          'settings, the mixin ensures all paragraphs relayout with the '
          'new font metrics, adjusting line heights and word wrapping.',
          Icons.auto_stories,
          Color(0xFF1565C0),
        ),
        SizedBox(height: 12),
        _buildUseCaseCard(
          'Code Editors',
          'RenderEditable objects in IDE-style editors rely on precise '
          'monospace font metrics. Installing a new coding font triggers '
          'relayout so that cursor positioning, line numbering, and '
          'syntax highlighting remain pixel-perfect.',
          Icons.code,
          Color(0xFF2E7D32),
        ),
        SizedBox(height: 12),
        _buildUseCaseCard(
          'Accessibility and Large Text',
          'Users with vision impairments may adjust the system text scale. '
          'The mixin ensures render objects pick up the new scale factor '
          'and reflow text so that clipping and overflow are avoided.',
          Icons.accessibility_new,
          Color(0xFFE65100),
        ),
        SizedBox(height: 12),
        _buildUseCaseCard(
          'Internationalization',
          'Locale switches can cause the system to load different font '
          'families (e.g. CJK fallback fonts). Text blocks must relayout '
          'because glyph widths differ between font families, changing '
          'line lengths and paragraph heights.',
          Icons.language,
          Color(0xFF6A1B9A),
        ),
        SizedBox(height: 12),
        _buildUseCaseCard(
          'Custom Render Objects',
          'If you build a custom RenderBox that paints text via TextPainter, '
          'you should apply this mixin. Without it, your widget may display '
          'stale layout metrics after a system font change until the next '
          'explicit rebuild.',
          Icons.build_circle,
          Color(0xFF00838F),
        ),
      ],
    ),
  );
}

Widget _buildUseCaseCard(
  String title,
  String description,
  IconData icon,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: color.withAlpha(15),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withAlpha(60)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withAlpha(30),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 22),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: color,
                ),
              ),
              SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: Color(0xFF546E7A)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 5: INTEGRATION WITH RENDERING PIPELINE
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildRenderingPipelineIntegrationSection() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(
          'Integration with Rendering Pipeline',
          Icons.account_tree,
        ),
        Text(
          'The mixin hooks into the rendering pipeline at attach/detach '
          'time and participates in the standard layout phase. It does '
          'not introduce new pipeline stages; instead, it leverages '
          'the existing dirty-list and flush mechanism.',
          style: TextStyle(color: Color(0xFF546E7A), fontSize: 13),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFE8EAF6),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                'Lifecycle Integration',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF283593),
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 16),
              _buildLifecycleRow(
                'attach(PipelineOwner)',
                'Registers font change listener via '
                    'PaintingBinding.instance.systemFonts.addListener',
                Icons.link,
                Color(0xFF2E7D32),
              ),
              SizedBox(height: 10),
              _buildLifecycleRow(
                'detach()',
                'Unregisters font change listener via '
                    'PaintingBinding.instance.systemFonts.removeListener',
                Icons.link_off,
                Color(0xFFC62828),
              ),
              SizedBox(height: 10),
              _buildLifecycleRow(
                'systemFontsDidChange()',
                'Called by notifier; invokes markNeedsLayout() '
                    'to schedule relayout in the next frame',
                Icons.refresh,
                Color(0xFFE65100),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFF3E5F5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                'Render Tree Position',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A148C),
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 16),
              _buildDiagramBox(
                'RenderView\n(root)',
                Color(0xFF6A1B9A),
                icon: Icons.vertical_align_top,
                width: 130,
              ),
              _buildArrow(vertical: true, color: Color(0xFF7B1FA2)),
              _buildDiagramBox(
                'RenderFlex\n(Column)',
                Color(0xFF1565C0),
                icon: Icons.view_column,
                width: 130,
              ),
              _buildArrow(vertical: true, color: Color(0xFF7B1FA2)),
              Container(
                width: 200,
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF4A148C), Color(0xFF7B1FA2)],
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF4A148C).withAlpha(80),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Icon(Icons.font_download, color: Colors.white, size: 24),
                    SizedBox(height: 4),
                    Text(
                      'RenderParagraph',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      'with Relayout mixin',
                      style: TextStyle(
                        color: Colors.white.withAlpha(180),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xFFEDE7F6),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'Font change notification reaches this node '
                  'directly via the listener, bypassing the tree walk.',
                  style: TextStyle(fontSize: 11, color: Color(0xFF4A148C)),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        _buildInfoRow('Pipeline Phase', 'Layout (flushLayout)'),
        _buildInfoRow('Dirty Registration', 'Via markNeedsLayout on RenderObject'),
        _buildInfoRow('Listener Scope', 'Per-instance, managed by attach/detach'),
        _buildInfoRow(
          'Thread Safety',
          'Runs on UI thread, same as rendering pipeline',
        ),
        _buildInfoRow(
          'Performance',
          'O(1) notification per listener, O(n) total for n text nodes',
          valueColor: Color(0xFF00695C),
        ),
      ],
    ),
  );
}

Widget _buildLifecycleRow(
  String method,
  String description,
  IconData icon,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(60)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 18),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                method,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: color,
                ),
              ),
              SizedBox(height: 2),
              Text(
                description,
                style: TextStyle(fontSize: 11, color: Color(0xFF546E7A)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// MAIN BUILD FUNCTION
// ═══════════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(
              'RelayoutWhenSystemFonts\nChangeMixin',
              'Triggers relayout when system fonts change',
            ),
            SizedBox(height: 20),
            _buildMixinOverviewSection(),
            SizedBox(height: 16),
            _buildFontChangePropagationSection(),
            SizedBox(height: 16),
            _buildLayoutInvalidationSection(),
            SizedBox(height: 16),
            _buildTextHeavyUseCasesSection(),
            SizedBox(height: 16),
            _buildRenderingPipelineIntegrationSection(),
            SizedBox(height: 24),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFF3E5F5), Color(0xFFE1BEE7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Icon(Icons.check_circle, color: Color(0xFF4A148C), size: 36),
                  SizedBox(height: 8),
                  Text(
                    'RelayoutWhenSystemFontsChangeMixin Deep Demo Complete',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF4A148C),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Mixin overview, font propagation, layout invalidation, '
                    'use cases, and pipeline integration visualized',
                    style: TextStyle(fontSize: 12, color: Color(0xFF6A1B9A)),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
