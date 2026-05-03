// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: deep visual demo of SegmentedButton + ToggleButtons.
//
// Showcases:
//   * SegmentedButton<T> single & multi-select with varied selected sets.
//   * ButtonSegment<T> with label only, icon only, label + icon, tooltips, disabled.
//   * SegmentedButton.styleFrom shortcut + ButtonStyle customisation.
//   * ToggleButtons (older API) with vertical / horizontal layouts and styling.
//   * Side-by-side comparison and Material 3 vs older API decision guide.
//
// Constraints:
//   * Static, sandbox-friendly: no setState, no controllers, no Stateful widgets.
//   * `selected` is a literal `<T>{...}` set; `isSelected` is a literal `<bool>[...]`.
//   * All callbacks are no-ops `(s) {}` / `(i) {}`.
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Generic enums used across demo sections.
// ---------------------------------------------------------------------------
enum _ViewMode { list, grid, table }

enum _Alignment { left, center, right, justify }

enum _Filter { all, active, archived, draft }

enum _SizeOpt { sm, md, lg, xl }

enum _Pace { slow, medium, fast }

enum _Theme { light, dark, system }

enum _Channel { email, sms, push, voice }

// ---------------------------------------------------------------------------
// Entry point.
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  return MaterialApp(
    title: 'SegmentedButton / ToggleButtons Demo',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.cyan),
    home: Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        title: const Text('Segmented vs Toggle'),
        backgroundColor: const Color(0xFF0E7490),
        foregroundColor: Colors.white,
        elevation: 4,
        actions: const <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Center(
              child: Text(
                'M3 picker controls',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          _buildIntroCard(),
          const SizedBox(height: 18),
          _buildAnatomySection(),
          const SizedBox(height: 18),
          _buildSimpleSegmentedSection(),
          const SizedBox(height: 18),
          _buildMultiSelectSection(),
          const SizedBox(height: 18),
          _buildIconOnlySection(),
          const SizedBox(height: 18),
          _buildLabelAndIconSection(),
          const SizedBox(height: 18),
          _buildCustomStyleSection(),
          const SizedBox(height: 18),
          _buildToggleButtonsSection(),
          const SizedBox(height: 18),
          _buildSideBySideComparison(),
          const SizedBox(height: 18),
          _buildDecisionGuide(),
          const SizedBox(height: 24),
          _buildFooter(),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// 1. Intro card.
// ---------------------------------------------------------------------------
Widget _buildIntroCard() {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFF0E7490), Color(0xFF155E75), Color(0xFF1E3A8A)],
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: const Color(0xFF0E7490).withValues(alpha: 0.35),
          blurRadius: 18,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.tune, color: Colors.white, size: 32),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'SegmentedButton & ToggleButtons',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Text(
          'Two ways to express a small set of mutually-related options. '
          'SegmentedButton is the Material 3 successor to ToggleButtons, '
          'with typed values, accessible labels, and a polished look.',
          style: TextStyle(color: Colors.white, fontSize: 14, height: 1.45),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: <Widget>[
            _introChip('SegmentedButton<T>', Icons.crop_din, Colors.cyanAccent),
            _introChip('ButtonSegment<T>', Icons.label_outline, Colors.amberAccent),
            _introChip('ToggleButtons', Icons.toggle_on, Colors.lightGreenAccent),
            _introChip('Material 3', Icons.auto_awesome, Colors.pinkAccent),
            _introChip('Type-safe', Icons.verified_user, Colors.lightBlueAccent),
          ],
        ),
      ],
    ),
  );
}

Widget _introChip(String label, IconData icon, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: color.withValues(alpha: 0.6)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, color: color, size: 14),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section header used by every subsequent section.
// ---------------------------------------------------------------------------
Widget _sectionHeader(String number, String title, String subtitle, IconData icon, Color color) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[color, color.withValues(alpha: 0.75)],
      ),
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color.withValues(alpha: 0.3),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
          ),
          child: Center(
            child: Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Icon(icon, color: Colors.white, size: 22),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.92),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _sectionBody(Widget child, {Color border = const Color(0xFFE2E8F0)}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
      border: Border.all(color: border),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.04),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: child,
  );
}

Widget _label(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6, top: 4),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: Color(0xFF334155),
      ),
    ),
  );
}

Widget _captionRow(String selectedDesc, IconData icon, Color color) {
  return Padding(
    padding: const EdgeInsets.only(top: 6),
    child: Row(
      children: <Widget>[
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            selectedDesc,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade700,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _divider() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: Container(height: 1, color: const Color(0xFFE2E8F0)),
  );
}

// ---------------------------------------------------------------------------
// 2. Anatomy diagram.
// ---------------------------------------------------------------------------
Widget _buildAnatomySection() {
  return Column(
    children: <Widget>[
      _sectionHeader('A', 'Anatomy of a SegmentedButton',
          'Segments, divider, selected fill, optional checkmark icon.',
          Icons.architecture, const Color(0xFF6366F1)),
      _sectionBody(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _label('Visual breakdown'),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xFFEEF2FF), Color(0xFFE0E7FF)],
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFC7D2FE)),
              ),
              child: Column(
                children: <Widget>[
                  // Big rendered SegmentedButton.
                  SegmentedButton<_ViewMode>(
                    segments: const <ButtonSegment<_ViewMode>>[
                      ButtonSegment<_ViewMode>(
                        value: _ViewMode.list,
                        label: Text('List'),
                        icon: Icon(Icons.view_list),
                      ),
                      ButtonSegment<_ViewMode>(
                        value: _ViewMode.grid,
                        label: Text('Grid'),
                        icon: Icon(Icons.grid_view),
                      ),
                      ButtonSegment<_ViewMode>(
                        value: _ViewMode.table,
                        label: Text('Table'),
                        icon: Icon(Icons.table_chart),
                      ),
                    ],
                    selected: const <_ViewMode>{_ViewMode.grid},
                    onSelectionChanged: (Set<_ViewMode> s) {},
                  ),
                  const SizedBox(height: 18),
                  // Annotation rows.
                  _annotationRow('Segment', 'A single ButtonSegment<T> entry.',
                      Icons.crop_din, const Color(0xFF6366F1)),
                  _annotationRow('Selected fill',
                      'Segment whose value is in the `selected` set is highlighted.',
                      Icons.format_color_fill, const Color(0xFFEC4899)),
                  _annotationRow('Divider',
                      'Thin vertical line separates adjacent segments.',
                      Icons.more_vert, const Color(0xFF94A3B8)),
                  _annotationRow('Optional icon',
                      'ButtonSegment.icon renders left of the label by default.',
                      Icons.label_important, const Color(0xFF0EA5E9)),
                  _annotationRow('Checkmark',
                      '`showSelectedIcon` (default true) prepends a check on selected items.',
                      Icons.check_circle_outline, const Color(0xFF22C55E)),
                ],
              ),
            ),
            _divider(),
            _label('Constructor sketch'),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF0F172A),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'SegmentedButton<T>(\n'
                '  segments: <ButtonSegment<T>>[ ... ],\n'
                '  selected: <T>{value1, value2},\n'
                '  multiSelectionEnabled: false,\n'
                '  showSelectedIcon: true,\n'
                '  emptySelectionAllowed: false,\n'
                '  onSelectionChanged: (Set<T> s) { ... },\n'
                '  style: SegmentedButton.styleFrom(...),\n'
                ')',
                style: TextStyle(
                  color: Color(0xFFE2E8F0),
                  fontFamily: 'monospace',
                  fontSize: 12,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _annotationRow(String title, String desc, IconData icon, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: color.withValues(alpha: 0.4)),
          ),
          child: Icon(icon, size: 14, color: color),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
              Text(
                desc,
                style: const TextStyle(fontSize: 12, color: Color(0xFF475569)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// 3. Simple single-select SegmentedButton.
// ---------------------------------------------------------------------------
Widget _buildSimpleSegmentedSection() {
  return Column(
    children: <Widget>[
      _sectionHeader('1', 'Simple SegmentedButton (single-select)',
          'One value at a time. Common picker pattern.',
          Icons.radio_button_checked, const Color(0xFF0EA5E9)),
      _sectionBody(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _label('View mode picker — three options, "grid" selected'),
            SegmentedButton<_ViewMode>(
              segments: const <ButtonSegment<_ViewMode>>[
                ButtonSegment<_ViewMode>(
                  value: _ViewMode.list,
                  label: Text('List'),
                  icon: Icon(Icons.view_list),
                ),
                ButtonSegment<_ViewMode>(
                  value: _ViewMode.grid,
                  label: Text('Grid'),
                  icon: Icon(Icons.grid_view),
                ),
                ButtonSegment<_ViewMode>(
                  value: _ViewMode.table,
                  label: Text('Table'),
                  icon: Icon(Icons.table_chart),
                ),
              ],
              selected: const <_ViewMode>{_ViewMode.grid},
              onSelectionChanged: (Set<_ViewMode> s) {},
            ),
            _captionRow(
                'selected: <_ViewMode>{_ViewMode.grid}',
                Icons.code,
                const Color(0xFF0EA5E9)),
            _divider(),
            _label('Theme picker — three options, "system" selected'),
            SegmentedButton<_Theme>(
              segments: const <ButtonSegment<_Theme>>[
                ButtonSegment<_Theme>(
                  value: _Theme.light,
                  label: Text('Light'),
                  icon: Icon(Icons.light_mode),
                ),
                ButtonSegment<_Theme>(
                  value: _Theme.dark,
                  label: Text('Dark'),
                  icon: Icon(Icons.dark_mode),
                ),
                ButtonSegment<_Theme>(
                  value: _Theme.system,
                  label: Text('System'),
                  icon: Icon(Icons.settings_brightness),
                ),
              ],
              selected: const <_Theme>{_Theme.system},
              onSelectionChanged: (Set<_Theme> s) {},
            ),
            _captionRow(
                'selected: <_Theme>{_Theme.system}',
                Icons.code,
                const Color(0xFF0EA5E9)),
            _divider(),
            _label('Pace picker — slow/medium/fast, "fast" selected'),
            SegmentedButton<_Pace>(
              segments: const <ButtonSegment<_Pace>>[
                ButtonSegment<_Pace>(
                  value: _Pace.slow,
                  label: Text('Slow'),
                ),
                ButtonSegment<_Pace>(
                  value: _Pace.medium,
                  label: Text('Medium'),
                ),
                ButtonSegment<_Pace>(
                  value: _Pace.fast,
                  label: Text('Fast'),
                ),
              ],
              selected: const <_Pace>{_Pace.fast},
              onSelectionChanged: (Set<_Pace> s) {},
            ),
            _captionRow(
                'Label-only segments. selected: {fast}',
                Icons.code,
                const Color(0xFF0EA5E9)),
            _divider(),
            _label('Disabled segment — "draft" cannot be picked'),
            SegmentedButton<_Filter>(
              segments: const <ButtonSegment<_Filter>>[
                ButtonSegment<_Filter>(
                  value: _Filter.all,
                  label: Text('All'),
                ),
                ButtonSegment<_Filter>(
                  value: _Filter.active,
                  label: Text('Active'),
                ),
                ButtonSegment<_Filter>(
                  value: _Filter.archived,
                  label: Text('Archived'),
                ),
                ButtonSegment<_Filter>(
                  value: _Filter.draft,
                  label: Text('Draft'),
                  enabled: false,
                ),
              ],
              selected: const <_Filter>{_Filter.active},
              onSelectionChanged: (Set<_Filter> s) {},
            ),
            _captionRow(
                'enabled: false on the "draft" segment.',
                Icons.block,
                const Color(0xFFEF4444)),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// 4. Multi-select SegmentedButton.
// ---------------------------------------------------------------------------
Widget _buildMultiSelectSection() {
  return Column(
    children: <Widget>[
      _sectionHeader('2', 'Multi-select SegmentedButton',
          'multiSelectionEnabled: true allows multiple values.',
          Icons.checklist, const Color(0xFF22C55E)),
      _sectionBody(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _label('Notification channels — email + push selected'),
            SegmentedButton<_Channel>(
              multiSelectionEnabled: true,
              segments: const <ButtonSegment<_Channel>>[
                ButtonSegment<_Channel>(
                  value: _Channel.email,
                  label: Text('Email'),
                  icon: Icon(Icons.email),
                ),
                ButtonSegment<_Channel>(
                  value: _Channel.sms,
                  label: Text('SMS'),
                  icon: Icon(Icons.sms),
                ),
                ButtonSegment<_Channel>(
                  value: _Channel.push,
                  label: Text('Push'),
                  icon: Icon(Icons.notifications_active),
                ),
                ButtonSegment<_Channel>(
                  value: _Channel.voice,
                  label: Text('Voice'),
                  icon: Icon(Icons.call),
                ),
              ],
              selected: const <_Channel>{_Channel.email, _Channel.push},
              onSelectionChanged: (Set<_Channel> s) {},
            ),
            _captionRow('selected: {email, push}',
                Icons.check_circle_outline, const Color(0xFF22C55E)),
            _divider(),
            _label('Empty selection allowed — none selected'),
            SegmentedButton<_Channel>(
              multiSelectionEnabled: true,
              emptySelectionAllowed: true,
              segments: const <ButtonSegment<_Channel>>[
                ButtonSegment<_Channel>(
                  value: _Channel.email,
                  label: Text('Email'),
                ),
                ButtonSegment<_Channel>(
                  value: _Channel.sms,
                  label: Text('SMS'),
                ),
                ButtonSegment<_Channel>(
                  value: _Channel.push,
                  label: Text('Push'),
                ),
              ],
              selected: const <_Channel>{},
              onSelectionChanged: (Set<_Channel> s) {},
            ),
            _captionRow('emptySelectionAllowed: true; selected: <_Channel>{}',
                Icons.do_not_disturb_alt, const Color(0xFF94A3B8)),
            _divider(),
            _label('All selected — every value present'),
            SegmentedButton<_Channel>(
              multiSelectionEnabled: true,
              segments: const <ButtonSegment<_Channel>>[
                ButtonSegment<_Channel>(
                  value: _Channel.email,
                  label: Text('Email'),
                  icon: Icon(Icons.email),
                ),
                ButtonSegment<_Channel>(
                  value: _Channel.sms,
                  label: Text('SMS'),
                  icon: Icon(Icons.sms),
                ),
                ButtonSegment<_Channel>(
                  value: _Channel.push,
                  label: Text('Push'),
                  icon: Icon(Icons.notifications),
                ),
              ],
              selected: const <_Channel>{
                _Channel.email,
                _Channel.sms,
                _Channel.push,
              },
              onSelectionChanged: (Set<_Channel> s) {},
            ),
            _captionRow('selected: {email, sms, push}',
                Icons.done_all, const Color(0xFF22C55E)),
            _divider(),
            _label('No selected icon (showSelectedIcon: false)'),
            SegmentedButton<_Channel>(
              multiSelectionEnabled: true,
              showSelectedIcon: false,
              segments: const <ButtonSegment<_Channel>>[
                ButtonSegment<_Channel>(
                  value: _Channel.email,
                  label: Text('Email'),
                ),
                ButtonSegment<_Channel>(
                  value: _Channel.sms,
                  label: Text('SMS'),
                ),
                ButtonSegment<_Channel>(
                  value: _Channel.push,
                  label: Text('Push'),
                ),
              ],
              selected: const <_Channel>{_Channel.sms},
              onSelectionChanged: (Set<_Channel> s) {},
            ),
            _captionRow('showSelectedIcon: false hides the leading checkmark.',
                Icons.visibility_off, const Color(0xFF64748B)),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// 5. Icon-only segments.
// ---------------------------------------------------------------------------
Widget _buildIconOnlySection() {
  return Column(
    children: <Widget>[
      _sectionHeader('3', 'Icon-only segments',
          'Compact picker that uses only icons + tooltips.',
          Icons.format_align_left, const Color(0xFFF97316)),
      _sectionBody(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _label('Text alignment — center selected'),
            SegmentedButton<_Alignment>(
              showSelectedIcon: false,
              segments: const <ButtonSegment<_Alignment>>[
                ButtonSegment<_Alignment>(
                  value: _Alignment.left,
                  icon: Icon(Icons.format_align_left),
                  tooltip: 'Align left',
                ),
                ButtonSegment<_Alignment>(
                  value: _Alignment.center,
                  icon: Icon(Icons.format_align_center),
                  tooltip: 'Align center',
                ),
                ButtonSegment<_Alignment>(
                  value: _Alignment.right,
                  icon: Icon(Icons.format_align_right),
                  tooltip: 'Align right',
                ),
                ButtonSegment<_Alignment>(
                  value: _Alignment.justify,
                  icon: Icon(Icons.format_align_justify),
                  tooltip: 'Justify',
                ),
              ],
              selected: const <_Alignment>{_Alignment.center},
              onSelectionChanged: (Set<_Alignment> s) {},
            ),
            _captionRow('Each segment has icon + tooltip; no label widget.',
                Icons.touch_app, const Color(0xFFF97316)),
            _divider(),
            _label('Size picker — md selected'),
            SegmentedButton<_SizeOpt>(
              showSelectedIcon: false,
              segments: const <ButtonSegment<_SizeOpt>>[
                ButtonSegment<_SizeOpt>(
                  value: _SizeOpt.sm,
                  icon: Icon(Icons.crop_3_2),
                  tooltip: 'Small',
                ),
                ButtonSegment<_SizeOpt>(
                  value: _SizeOpt.md,
                  icon: Icon(Icons.crop_5_4),
                  tooltip: 'Medium',
                ),
                ButtonSegment<_SizeOpt>(
                  value: _SizeOpt.lg,
                  icon: Icon(Icons.crop_7_5),
                  tooltip: 'Large',
                ),
                ButtonSegment<_SizeOpt>(
                  value: _SizeOpt.xl,
                  icon: Icon(Icons.crop_16_9),
                  tooltip: 'Extra large',
                ),
              ],
              selected: const <_SizeOpt>{_SizeOpt.md},
              onSelectionChanged: (Set<_SizeOpt> s) {},
            ),
            _captionRow('Tooltips communicate semantics for icon-only buttons.',
                Icons.info_outline, const Color(0xFFF97316)),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// 6. Label + icon segments.
// ---------------------------------------------------------------------------
Widget _buildLabelAndIconSection() {
  return Column(
    children: <Widget>[
      _sectionHeader('4', 'Label + Icon segments',
          'Best for clarity — both an icon and explicit text label.',
          Icons.style, const Color(0xFFA855F7)),
      _sectionBody(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _label('Filter — active selected'),
            SegmentedButton<_Filter>(
              segments: const <ButtonSegment<_Filter>>[
                ButtonSegment<_Filter>(
                  value: _Filter.all,
                  label: Text('All'),
                  icon: Icon(Icons.list),
                ),
                ButtonSegment<_Filter>(
                  value: _Filter.active,
                  label: Text('Active'),
                  icon: Icon(Icons.bolt),
                ),
                ButtonSegment<_Filter>(
                  value: _Filter.archived,
                  label: Text('Archived'),
                  icon: Icon(Icons.archive),
                ),
              ],
              selected: const <_Filter>{_Filter.active},
              onSelectionChanged: (Set<_Filter> s) {},
            ),
            _divider(),
            _label('Multi-line label workflow steps — first two selected'),
            SegmentedButton<int>(
              multiSelectionEnabled: true,
              segments: const <ButtonSegment<int>>[
                ButtonSegment<int>(
                  value: 1,
                  label: Text('Plan'),
                  icon: Icon(Icons.edit_note),
                ),
                ButtonSegment<int>(
                  value: 2,
                  label: Text('Build'),
                  icon: Icon(Icons.build),
                ),
                ButtonSegment<int>(
                  value: 3,
                  label: Text('Ship'),
                  icon: Icon(Icons.local_shipping),
                ),
                ButtonSegment<int>(
                  value: 4,
                  label: Text('Review'),
                  icon: Icon(Icons.reviews),
                ),
              ],
              selected: const <int>{1, 2},
              onSelectionChanged: (Set<int> s) {},
            ),
            _captionRow('Generic type parameter <int> works the same as enums.',
                Icons.tag, const Color(0xFFA855F7)),
            _divider(),
            _label('Visual breakdown of label-and-icon segments'),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: <Color>[Color(0xFFFAF5FF), Color(0xFFF3E8FF)],
                ),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFE9D5FF)),
              ),
              child: Column(
                children: <Widget>[
                  _featRow('Leading icon', Icons.label_important_outline,
                      'Renders to the left of the label by default.'),
                  _featRow('Centered label', Icons.short_text,
                      'Each ButtonSegment.label receives the foreground colour.'),
                  _featRow('Selected check', Icons.check,
                      'Replaces the icon for selected items unless disabled.'),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _featRow(String label, IconData icon, String desc) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, size: 16, color: const Color(0xFFA855F7)),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 12, color: Color(0xFF475569)),
              children: <InlineSpan>[
                TextSpan(
                  text: '$label: ',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF581C87),
                  ),
                ),
                TextSpan(text: desc),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// 7. Custom style with SegmentedButton.styleFrom.
// ---------------------------------------------------------------------------
Widget _buildCustomStyleSection() {
  return Column(
    children: <Widget>[
      _sectionHeader('5', 'Custom styling',
          'SegmentedButton.styleFrom shortcut + ButtonStyle.',
          Icons.palette, const Color(0xFFEC4899)),
      _sectionBody(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _label('Pink-themed via SegmentedButton.styleFrom'),
            SegmentedButton<_ViewMode>(
              style: SegmentedButton.styleFrom(
                backgroundColor: const Color(0xFFFDF2F8),
                foregroundColor: const Color(0xFF9D174D),
                selectedBackgroundColor: const Color(0xFFEC4899),
                selectedForegroundColor: Colors.white,
                side: const BorderSide(color: Color(0xFFEC4899), width: 1.4),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
              segments: const <ButtonSegment<_ViewMode>>[
                ButtonSegment<_ViewMode>(
                  value: _ViewMode.list,
                  label: Text('List'),
                  icon: Icon(Icons.view_list),
                ),
                ButtonSegment<_ViewMode>(
                  value: _ViewMode.grid,
                  label: Text('Grid'),
                  icon: Icon(Icons.grid_view),
                ),
                ButtonSegment<_ViewMode>(
                  value: _ViewMode.table,
                  label: Text('Table'),
                  icon: Icon(Icons.table_chart),
                ),
              ],
              selected: const <_ViewMode>{_ViewMode.list},
              onSelectionChanged: (Set<_ViewMode> s) {},
            ),
            _divider(),
            _label('Indigo / amber gradient surround'),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xFFEEF2FF), Color(0xFFFEF3C7)],
                ),
                borderRadius: BorderRadius.circular(14),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: const Color(0xFF6366F1).withValues(alpha: 0.18),
                    blurRadius: 14,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: SegmentedButton<_Pace>(
                style: SegmentedButton.styleFrom(
                  backgroundColor: Colors.white,
                  selectedBackgroundColor: const Color(0xFF6366F1),
                  selectedForegroundColor: Colors.white,
                  foregroundColor: const Color(0xFF312E81),
                ),
                segments: const <ButtonSegment<_Pace>>[
                  ButtonSegment<_Pace>(
                    value: _Pace.slow,
                    label: Text('Slow'),
                    icon: Icon(Icons.directions_walk),
                  ),
                  ButtonSegment<_Pace>(
                    value: _Pace.medium,
                    label: Text('Medium'),
                    icon: Icon(Icons.directions_bike),
                  ),
                  ButtonSegment<_Pace>(
                    value: _Pace.fast,
                    label: Text('Fast'),
                    icon: Icon(Icons.directions_run),
                  ),
                ],
                selected: const <_Pace>{_Pace.medium},
                onSelectionChanged: (Set<_Pace> s) {},
              ),
            ),
            _divider(),
            _label('Dark themed picker'),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xFF0F172A), Color(0xFF1E293B)],
                ),
                borderRadius: BorderRadius.circular(14),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.4),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: SegmentedButton<_Theme>(
                style: SegmentedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E293B),
                  selectedBackgroundColor: const Color(0xFF22D3EE),
                  selectedForegroundColor: const Color(0xFF0F172A),
                  foregroundColor: const Color(0xFFE2E8F0),
                  side: const BorderSide(color: Color(0xFF334155)),
                ),
                segments: const <ButtonSegment<_Theme>>[
                  ButtonSegment<_Theme>(
                    value: _Theme.light,
                    label: Text('Light'),
                    icon: Icon(Icons.wb_sunny),
                  ),
                  ButtonSegment<_Theme>(
                    value: _Theme.dark,
                    label: Text('Dark'),
                    icon: Icon(Icons.nights_stay),
                  ),
                  ButtonSegment<_Theme>(
                    value: _Theme.system,
                    label: Text('Auto'),
                    icon: Icon(Icons.smart_toy),
                  ),
                ],
                selected: const <_Theme>{_Theme.dark},
                onSelectionChanged: (Set<_Theme> s) {},
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// 8. ToggleButtons (older API).
// ---------------------------------------------------------------------------
Widget _buildToggleButtonsSection() {
  return Column(
    children: <Widget>[
      _sectionHeader('6', 'ToggleButtons (older API)',
          'Index-based selection with a parallel List<bool>.',
          Icons.toggle_on, const Color(0xFF14B8A6)),
      _sectionBody(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _label('Bold / Italic / Underline — bold + underline on'),
            ToggleButtons(
              isSelected: const <bool>[true, false, true],
              onPressed: (int index) {},
              borderRadius: BorderRadius.circular(8),
              selectedColor: Colors.white,
              fillColor: const Color(0xFF14B8A6),
              color: const Color(0xFF334155),
              borderColor: const Color(0xFFCBD5E1),
              selectedBorderColor: const Color(0xFF0F766E),
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(Icons.format_bold),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(Icons.format_italic),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(Icons.format_underline),
                ),
              ],
            ),
            _captionRow(
                'isSelected: const <bool>[true, false, true]',
                Icons.code,
                const Color(0xFF14B8A6)),
            _divider(),
            _label('Vertical layout — option two selected'),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ToggleButtons(
                  direction: Axis.vertical,
                  isSelected: const <bool>[false, true, false, false],
                  onPressed: (int index) {},
                  borderRadius: BorderRadius.circular(10),
                  selectedColor: Colors.white,
                  fillColor: const Color(0xFFA855F7),
                  color: const Color(0xFF334155),
                  children: const <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(Icons.home),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(Icons.search),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(Icons.notifications),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(Icons.person),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    height: 184,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[Color(0xFFFAF5FF), Color(0xFFEDE9FE)],
                      ),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFDDD6FE)),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Search',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF581C87),
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Vertical ToggleButtons can build a sidebar-style picker. '
                          'Index 1 (search) is the active value because '
                          'isSelected[1] == true.',
                          style: TextStyle(fontSize: 12, color: Color(0xFF475569)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            _divider(),
            _label('Mixed text + custom radius — first / third selected'),
            ToggleButtons(
              isSelected: const <bool>[true, false, true, false],
              onPressed: (int index) {},
              borderRadius: BorderRadius.circular(20),
              selectedColor: Colors.white,
              fillColor: const Color(0xFFF59E0B),
              color: const Color(0xFF92400E),
              borderColor: const Color(0xFFFCD34D),
              selectedBorderColor: const Color(0xFFB45309),
              constraints: const BoxConstraints(minHeight: 36, minWidth: 70),
              children: const <Widget>[
                Text('XS'),
                Text('S'),
                Text('M'),
                Text('L'),
              ],
            ),
            _captionRow(
                'isSelected vector controls multi-selection by index.',
                Icons.list_alt,
                const Color(0xFFF59E0B)),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// 9. Side-by-side comparison.
// ---------------------------------------------------------------------------
Widget _buildSideBySideComparison() {
  return Column(
    children: <Widget>[
      _sectionHeader('7', 'Side-by-side comparison',
          'Same task — two different APIs.',
          Icons.compare_arrows, const Color(0xFF1D4ED8)),
      _sectionBody(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _label('Same picker, two implementations'),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(child: _comparisonCard(
                  title: 'SegmentedButton<T> (M3)',
                  subtitle: 'Type-safe values',
                  color: const Color(0xFF22C55E),
                  body: SegmentedButton<_ViewMode>(
                    segments: const <ButtonSegment<_ViewMode>>[
                      ButtonSegment<_ViewMode>(
                        value: _ViewMode.list,
                        label: Text('List'),
                        icon: Icon(Icons.view_list),
                      ),
                      ButtonSegment<_ViewMode>(
                        value: _ViewMode.grid,
                        label: Text('Grid'),
                        icon: Icon(Icons.grid_view),
                      ),
                      ButtonSegment<_ViewMode>(
                        value: _ViewMode.table,
                        label: Text('Table'),
                        icon: Icon(Icons.table_chart),
                      ),
                    ],
                    selected: const <_ViewMode>{_ViewMode.grid},
                    onSelectionChanged: (Set<_ViewMode> s) {},
                  ),
                  bullets: const <String>[
                    'Pass values directly, not indices.',
                    'Built-in selected check icon.',
                    'Multi-select via Set<T>.',
                    'M3 styling out of the box.',
                  ],
                )),
                const SizedBox(width: 12),
                Expanded(child: _comparisonCard(
                  title: 'ToggleButtons (older)',
                  subtitle: 'Index-based',
                  color: const Color(0xFFF97316),
                  body: ToggleButtons(
                    isSelected: const <bool>[false, true, false],
                    onPressed: (int index) {},
                    borderRadius: BorderRadius.circular(8),
                    selectedColor: Colors.white,
                    fillColor: const Color(0xFFF97316),
                    color: const Color(0xFF7C2D12),
                    children: const <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        child: Icon(Icons.view_list),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        child: Icon(Icons.grid_view),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        child: Icon(Icons.table_chart),
                      ),
                    ],
                  ),
                  bullets: const <String>[
                    'Track selection with List<bool>.',
                    'No built-in checkmark.',
                    'Free-form children Widget list.',
                    'Lighter weight, classic look.',
                  ],
                )),
              ],
            ),
            _divider(),
            _comparisonRowTable(),
          ],
        ),
      ),
    ],
  );
}

Widget _comparisonCard({
  required String title,
  required String subtitle,
  required Color color,
  required Widget body,
  required List<String> bullets,
}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[color.withValues(alpha: 0.08), Colors.white],
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withValues(alpha: 0.4)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color.withValues(alpha: 0.15),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 8,
              height: 28,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Center(child: body),
        const SizedBox(height: 12),
        ..._bulletList(bullets, color),
      ],
    ),
  );
}

List<Widget> _bulletList(List<String> items, Color color) {
  return <Widget>[
    for (int i = 0; i < items.length; i++)
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(Icons.check, size: 14, color: color),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                items[i],
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF334155),
                  height: 1.35,
                ),
              ),
            ),
          ],
        ),
      ),
  ];
}

Widget _comparisonRowTable() {
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFFF8FAFC),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color(0xFFE2E8F0)),
    ),
    child: Column(
      children: <Widget>[
        _tableHeaderRow(),
        _tableDataRow('Selection model', 'Set<T>', 'List<bool>', false),
        _tableDataRow('Type safety', 'Compile-checked enum / type', 'Index ↔ value mapping by hand', false),
        _tableDataRow('Selected icon', 'showSelectedIcon (default true)', 'Render manually', false),
        _tableDataRow('Multi-select', 'multiSelectionEnabled flag', 'Multiple `true` entries', false),
        _tableDataRow('Disabled segment', 'ButtonSegment.enabled', 'children + isSelected combo', false),
        _tableDataRow('Material spec', 'Material 3 picker', 'Material 2 era', true),
      ],
    ),
  );
}

Widget _tableHeaderRow() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFF1D4ED8), Color(0xFF2563EB)],
      ),
      borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
    ),
    child: Row(
      children: const <Widget>[
        Expanded(flex: 3, child: Text('Aspect', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))),
        Expanded(flex: 4, child: Text('SegmentedButton<T>', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))),
        Expanded(flex: 4, child: Text('ToggleButtons', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))),
      ],
    ),
  );
}

Widget _tableDataRow(String aspect, String segCol, String togCol, bool last) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
    decoration: BoxDecoration(
      border: Border(
        bottom: last
            ? BorderSide.none
            : const BorderSide(color: Color(0xFFE2E8F0)),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Text(
            aspect,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1E3A8A),
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            segCol,
            style: const TextStyle(fontSize: 11, color: Color(0xFF334155)),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            togCol,
            style: const TextStyle(fontSize: 11, color: Color(0xFF475569)),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// 10. Decision guide.
// ---------------------------------------------------------------------------
Widget _buildDecisionGuide() {
  return Column(
    children: <Widget>[
      _sectionHeader('8', 'Decision guide',
          'When to prefer SegmentedButton over ToggleButtons.',
          Icons.checklist_rtl, const Color(0xFF0F766E)),
      _sectionBody(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _label('Pick SegmentedButton when…'),
            _decisionRow('You target Material 3 design.',
                Icons.auto_awesome, const Color(0xFF22C55E)),
            _decisionRow('You want compile-time-safe values (enum / typed).',
                Icons.verified, const Color(0xFF22C55E)),
            _decisionRow('Selection should round-trip as a Set<T>.',
                Icons.share, const Color(0xFF22C55E)),
            _decisionRow('You need multiSelectionEnabled or emptySelectionAllowed.',
                Icons.checklist, const Color(0xFF22C55E)),
            _decisionRow('You like the built-in selected-check icon.',
                Icons.check_circle, const Color(0xFF22C55E)),
            const SizedBox(height: 10),
            _label('Pick ToggleButtons when…'),
            _decisionRow('You target Material 2 / older themes.',
                Icons.history, const Color(0xFFF97316)),
            _decisionRow('Children are already arbitrary widgets, not labels.',
                Icons.widgets, const Color(0xFFF97316)),
            _decisionRow('You want a vertical bar (Axis.vertical).',
                Icons.swap_vert, const Color(0xFFF97316)),
            _decisionRow('You only need the lightest possible look.',
                Icons.air, const Color(0xFFF97316)),
            _divider(),
            _label('Quick rule of thumb'),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xFFECFEFF), Color(0xFFCFFAFE)],
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF06B6D4)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: const Color(0xFF06B6D4).withValues(alpha: 0.18),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Icon(Icons.tips_and_updates, color: Color(0xFF155E75)),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'In new Material 3 codebases, prefer SegmentedButton<T>. '
                      'Reach for ToggleButtons only when you need maximum control '
                      'over child widgets, are stuck on M2, or want a vertical group.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF155E75),
                        height: 1.45,
                        fontWeight: FontWeight.w500,
                      ),
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
}

Widget _decisionRow(String text, IconData icon, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, size: 14, color: color),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 12, color: Color(0xFF334155), height: 1.4),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Footer.
// ---------------------------------------------------------------------------
Widget _buildFooter() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFF0F172A), Color(0xFF1E293B)],
      ),
      borderRadius: BorderRadius.circular(14),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.18),
          blurRadius: 14,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Row(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: <Color>[Color(0xFF06B6D4), Color(0xFF0EA5E9)],
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.tune, color: Colors.white),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Static demo — every selection is a const literal.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Rendered live via the d4rt analyzer-free interpreter.',
                style: TextStyle(color: Color(0xFF94A3B8), fontSize: 11),
              ),
            ],
          ),
        ),
        const Icon(Icons.bolt, color: Color(0xFF22D3EE), size: 22),
      ],
    ),
  );
}
