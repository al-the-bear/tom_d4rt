// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: deep visual demo of TextButtonThemeData.
// Showcases TextButtonThemeData, ButtonStyle, WidgetStateProperty, and the
// difference between MaterialApp.theme.textButtonTheme and a local Theme
// override. The script renders meaningful, varied visuals fully within
// d4rt's static-only sandbox (no setState, no controllers, no animations).
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Section header strip with gradient background.
// ---------------------------------------------------------------------------
Widget _buildHeaderStrip({
  required String title,
  required String subtitle,
  required IconData icon,
  required List<Color> gradientColors,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: gradientColors,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
      boxShadow: [
        BoxShadow(
          color: gradientColors.last.withOpacity(0.35),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.4), width: 1),
          ),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.92),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Explanatory paragraph block.
// ---------------------------------------------------------------------------
Widget _buildExplanation(String text, {Color? accent}) {
  final Color color = accent ?? Colors.indigo;
  return Container(
    margin: const EdgeInsets.fromLTRB(16, 12, 16, 12),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: color.withOpacity(0.06),
      borderRadius: BorderRadius.circular(10),
      border: Border(
        left: BorderSide(color: color, width: 4),
      ),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 13,
        height: 1.4,
        color: Colors.grey.shade800,
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Generic comparison row label.
// ---------------------------------------------------------------------------
Widget _buildComparisonLabel(String label, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: color.withOpacity(0.15),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: color.withOpacity(0.5)),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: color,
        letterSpacing: 0.4,
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Card frame for each section.
// ---------------------------------------------------------------------------
Widget _wrapInCard({
  required Widget header,
  required Widget body,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 18),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 14,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        header,
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 6, 0, 16),
          child: body,
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 1: Intro card — gives orientation about TextButtonThemeData.
// ===========================================================================
Widget _buildIntroCard() {
  return _wrapInCard(
    header: _buildHeaderStrip(
      title: 'TextButtonThemeData',
      subtitle: 'Centralized styling for every TextButton in the subtree',
      icon: Icons.text_fields,
      gradientColors: const [Color(0xFF3949AB), Color(0xFF5C6BC0)],
    ),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildExplanation(
          'TextButtonThemeData lets you declare a default ButtonStyle once and '
          'have every TextButton in the widget subtree pick it up automatically. '
          'You can place it on MaterialApp.theme.textButtonTheme for the whole '
          'app, or wrap a localized Theme around any subtree to override the '
          'app-level defaults for that region.',
          accent: Colors.indigo,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.indigo.shade50, Colors.blue.shade50],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.indigo.shade100),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.lightbulb, color: Colors.amber.shade700, size: 18),
                    const SizedBox(width: 6),
                    const Text(
                      'Three places it lives',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _buildBullet('1. ThemeData(textButtonTheme: …) on MaterialApp'),
                _buildBullet('2. Theme(data: parent.copyWith(textButtonTheme: …))'),
                _buildBullet('3. Per-button TextButton.styleFrom(…) overrides'),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildBullet(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 6),
          width: 6,
          height: 6,
          decoration: const BoxDecoration(
            color: Color(0xFF3949AB),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12.5,
              color: Colors.grey.shade800,
              height: 1.35,
            ),
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 2: App-level theme card — buttons inherit MaterialApp theme.
// ===========================================================================
Widget _buildAppLevelThemeCard() {
  return _wrapInCard(
    header: _buildHeaderStrip(
      title: 'App-level textButtonTheme',
      subtitle: 'Defaults set on MaterialApp.theme — every TextButton inherits',
      icon: Icons.public,
      gradientColors: const [Color(0xFF00897B), Color(0xFF26A69A)],
    ),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildExplanation(
          'These TextButtons live in this MaterialApp without any local Theme '
          'override. They pick up the rounded shape, padding, and font weight '
          'defined in the root ThemeData(textButtonTheme: …). Notice the '
          'consistency without any per-button styling.',
          accent: Colors.teal,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              TextButton(
                onPressed: () {},
                child: const Text('Save draft'),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Publish'),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.cloud_upload, size: 18),
                label: const Text('Upload'),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.share, size: 18),
                label: const Text('Share'),
              ),
              const TextButton(
                onPressed: null,
                child: Text('Disabled action'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal.shade50, Colors.cyan.shade50],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.teal.shade100),
              boxShadow: [
                BoxShadow(
                  color: Colors.teal.shade100.withOpacity(0.5),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(Icons.tips_and_updates, color: Colors.teal.shade700, size: 22),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'All five buttons above use the same padding, shape, and '
                    'font weight from the app theme, with no per-button setup.',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.teal.shade900,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 3: Local Theme override card — themed vs unthemed comparison.
// ===========================================================================
Widget _buildLocalThemeOverrideCard() {
  return _wrapInCard(
    header: _buildHeaderStrip(
      title: 'Local Theme override',
      subtitle: 'Wrap a Theme to override TextButton style for one subtree',
      icon: Icons.layers,
      gradientColors: const [Color(0xFF6A1B9A), Color(0xFF8E24AA)],
    ),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildExplanation(
          'A Builder gets a BuildContext under MaterialApp. We use '
          'Theme.of(context).copyWith(textButtonTheme: TextButtonThemeData(...)) '
          'to override only the TextButtons inside this Theme widget. Other '
          'TextButtons in the page keep using the app-level defaults.',
          accent: Colors.purple,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Builder(
            builder: (BuildContext context) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Unthemed baseline row (uses MaterialApp theme).
                  _buildComparisonRow(
                    label: 'App theme (default)',
                    accent: Colors.teal,
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 8,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Text('Edit'),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text('Cancel'),
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.bolt, size: 18),
                          label: const Text('Run'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  // Locally overridden row.
                  Theme(
                    data: Theme.of(context).copyWith(
                      textButtonTheme: TextButtonThemeData(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.purple.shade600,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 22, vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.6,
                          ),
                        ),
                      ),
                    ),
                    child: _buildComparisonRow(
                      label: 'Local override (Theme widget)',
                      accent: Colors.purple,
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 8,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: const Text('Edit'),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text('Cancel'),
                          ),
                          TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.bolt, size: 18),
                            label: const Text('Run'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    ),
  );
}

Widget _buildComparisonRow({
  required String label,
  required Widget child,
  required Color accent,
}) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: accent.withOpacity(0.05),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: accent.withOpacity(0.25)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildComparisonLabel(label, accent),
        const SizedBox(height: 10),
        child,
      ],
    ),
  );
}

// ===========================================================================
// SECTION 4: TextButton.styleFrom shortcut.
// ===========================================================================
Widget _buildStyleFromShortcutCard() {
  return _wrapInCard(
    header: _buildHeaderStrip(
      title: 'TextButton.styleFrom shortcut',
      subtitle: 'Concise builder for ButtonStyle without typing WidgetStateProperty',
      icon: Icons.flash_on,
      gradientColors: const [Color(0xFFEF6C00), Color(0xFFFB8C00)],
    ),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildExplanation(
          'TextButton.styleFrom(...) returns a ButtonStyle with all the right '
          'WidgetStateProperty wrappers built for you. It is the recommended '
          'shortcut whenever your style does not need different values for '
          'different states. You can pass the resulting style to a single '
          'TextButton or feed it into a TextButtonThemeData.',
          accent: Colors.orange,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Per-button styleFrom variants',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: Colors.orange.shade900,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.orange.shade50, Colors.amber.shade50],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.orange.shade200),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange.shade100.withOpacity(0.6),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.deepOrange,
                        textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      child: const Text('Plain orange'),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.deepOrange,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text('Filled pill'),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.orange.shade800,
                        side: BorderSide(
                          color: Colors.orange.shade800, width: 2,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 12,
                        ),
                      ),
                      child: const Text('Outlined'),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.local_fire_department, size: 18),
                      label: const Text('Hot path'),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.red.shade700,
                        backgroundColor: Colors.red.shade50,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 12,
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
    ),
  );
}

// ===========================================================================
// SECTION 5: WidgetStateProperty.resolveWith.
// ===========================================================================
Widget _buildWidgetStatePropertySection() {
  return _wrapInCard(
    header: _buildHeaderStrip(
      title: 'WidgetStateProperty.resolveWith',
      subtitle: 'Different colors for hover/pressed/disabled states',
      icon: Icons.settings_input_component,
      gradientColors: const [Color(0xFF1565C0), Color(0xFF1E88E5)],
    ),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildExplanation(
          'When you need different style for hover, pressed, focused, or '
          'disabled states, drop down to ButtonStyle directly with '
          'WidgetStateProperty.resolveWith<X>((states) { … }). The function '
          'inspects the Set<WidgetState> and returns the value to use right '
          'now. Below: a button whose foreground darkens when pressed and '
          'fades when disabled, with a separate disabled-only sample.',
          accent: Colors.blue,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Builder(
            builder: (BuildContext context) {
              return Theme(
                data: Theme.of(context).copyWith(
                  textButtonTheme: TextButtonThemeData(
                    style: ButtonStyle(
                      foregroundColor:
                          WidgetStateProperty.resolveWith<Color>((states) {
                        if (states.contains(WidgetState.disabled)) {
                          return Colors.grey.shade400;
                        }
                        if (states.contains(WidgetState.pressed)) {
                          return Colors.blue.shade900;
                        }
                        if (states.contains(WidgetState.hovered)) {
                          return Colors.blue.shade600;
                        }
                        return Colors.blue.shade700;
                      }),
                      backgroundColor:
                          WidgetStateProperty.resolveWith<Color>((states) {
                        if (states.contains(WidgetState.disabled)) {
                          return Colors.grey.shade100;
                        }
                        if (states.contains(WidgetState.pressed)) {
                          return Colors.blue.shade100;
                        }
                        return Colors.blue.shade50;
                      }),
                      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                      ),
                      shape: WidgetStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade50, Colors.indigo.shade50],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue.shade100),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.shade100.withOpacity(0.5),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildComparisonLabel('State-driven theme', Colors.blue),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: const Text('Hover me'),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text('Tap me'),
                          ),
                          TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.touch_app, size: 18),
                            label: const Text('Press here'),
                          ),
                          const TextButton(
                            onPressed: null,
                            child: Text('Disabled (faded)'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.amber.shade200),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline, color: Colors.amber.shade800, size: 20),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    'WidgetStateProperty<T> stores a function from the current '
                    'set of widget states to a value of type T. Theme machinery '
                    'calls this each frame the state changes, so the same '
                    'TextButton can render very differently when hovered, '
                    'focused, pressed, or disabled — without writing a single '
                    'StatefulWidget.',
                    style: TextStyle(fontSize: 12, height: 1.4),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 6: Shape and padding showcase.
// ===========================================================================
Widget _buildShapeAndPaddingShowcase() {
  return _wrapInCard(
    header: _buildHeaderStrip(
      title: 'Shape and padding showcase',
      subtitle: 'Six different theme overrides side-by-side',
      icon: Icons.crop_square,
      gradientColors: const [Color(0xFFC2185B), Color(0xFFE91E63)],
    ),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildExplanation(
          'Each tile below wraps the same TextButton text in its own local '
          'Theme widget. The TextButtonThemeData inside differs in shape, '
          'padding, and colors. Notice how the button itself stays '
          'declaratively identical — only the surrounding theme changes.',
          accent: Colors.pink,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Builder(
            builder: (BuildContext context) {
              return Wrap(
                spacing: 14,
                runSpacing: 14,
                children: [
                  _buildShapeTile(
                    context: context,
                    label: 'Sharp rectangle',
                    bg: Colors.red.shade50,
                    fg: Colors.red.shade800,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18, vertical: 12,
                    ),
                  ),
                  _buildShapeTile(
                    context: context,
                    label: 'Slight round',
                    bg: Colors.pink.shade50,
                    fg: Colors.pink.shade800,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 12,
                    ),
                  ),
                  _buildShapeTile(
                    context: context,
                    label: 'Rounded',
                    bg: Colors.purple.shade50,
                    fg: Colors.purple.shade800,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22, vertical: 14,
                    ),
                  ),
                  _buildShapeTile(
                    context: context,
                    label: 'Pill',
                    bg: Colors.deepPurple.shade50,
                    fg: Colors.deepPurple.shade800,
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 14,
                    ),
                  ),
                  _buildShapeTile(
                    context: context,
                    label: 'Stitched border',
                    bg: Colors.indigo.shade50,
                    fg: Colors.indigo.shade800,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.indigo.shade400, width: 2),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 12,
                    ),
                  ),
                  _buildShapeTile(
                    context: context,
                    label: 'Chunky padding',
                    bg: Colors.blue.shade50,
                    fg: Colors.blue.shade900,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32, vertical: 20,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    ),
  );
}

Widget _buildShapeTile({
  required BuildContext context,
  required String label,
  required Color bg,
  required Color fg,
  required OutlinedBorder shape,
  required EdgeInsetsGeometry padding,
}) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade200),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.04),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: Colors.grey.shade700,
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 8),
        Theme(
          data: Theme.of(context).copyWith(
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: fg,
                backgroundColor: bg,
                padding: padding,
                shape: shape,
                textStyle: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          child: TextButton(
            onPressed: () {},
            child: const Text('Action'),
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 7: Alignment and TextTheme integration.
// ===========================================================================
Widget _buildAlignmentShowcase() {
  return _wrapInCard(
    header: _buildHeaderStrip(
      title: 'Alignment and TextTheme combo',
      subtitle: 'TextButtonThemeData paired with TextTheme font choices',
      icon: Icons.format_align_center,
      gradientColors: const [Color(0xFF2E7D32), Color(0xFF43A047)],
    ),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildExplanation(
          'Combine TextButtonThemeData with TextTheme entries to keep button '
          'typography aligned with the rest of the app. Below, three groups '
          'show the same button under three different font weight/size '
          'profiles — small caption-like, body, and emphasis — each driven by '
          'a local theme override.',
          accent: Colors.green,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Builder(
            builder: (BuildContext context) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildTypographyRow(
                    context: context,
                    label: 'Caption profile',
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    fg: Colors.green.shade800,
                    bg: Colors.green.shade50,
                  ),
                  const SizedBox(height: 10),
                  _buildTypographyRow(
                    context: context,
                    label: 'Body profile',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fg: Colors.teal.shade800,
                    bg: Colors.teal.shade50,
                  ),
                  const SizedBox(height: 10),
                  _buildTypographyRow(
                    context: context,
                    label: 'Emphasis profile',
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    fg: Colors.indigo.shade900,
                    bg: Colors.indigo.shade50,
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 14),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green.shade50, Colors.lime.shade50],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.green.shade100),
            ),
            child: Row(
              children: [
                Icon(Icons.text_format, color: Colors.green.shade700, size: 20),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    'Pair textButtonTheme.style.textStyle with theme.textTheme '
                    'so display copy and call-to-actions feel consistent.',
                    style: TextStyle(fontSize: 12, height: 1.4),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildTypographyRow({
  required BuildContext context,
  required String label,
  required double fontSize,
  required FontWeight fontWeight,
  required Color fg,
  required Color bg,
}) {
  return Theme(
    data: Theme.of(context).copyWith(
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: fg,
          backgroundColor: bg,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            letterSpacing: 0.3,
          ),
        ),
      ),
    ),
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Wrap(
              spacing: 10,
              runSpacing: 8,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text('Primary'),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Secondary'),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_forward, size: 16),
                  label: const Text('Continue'),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

// ===========================================================================
// SECTION 8: Themed vs raw side-by-side detailed comparison.
// ===========================================================================
Widget _buildSideBySideComparisonCard() {
  return _wrapInCard(
    header: _buildHeaderStrip(
      title: 'Themed vs raw, side-by-side',
      subtitle: 'Identical TextButton declarations, three different ambients',
      icon: Icons.compare_arrows,
      gradientColors: const [Color(0xFF455A64), Color(0xFF607D8B)],
    ),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildExplanation(
          'The buttons below are written exactly the same way in source code. '
          'The only difference is the ambient TextButtonThemeData. This is '
          'the central reason theme data exists: it lets a designer or '
          'theming layer change every TextButton in a region without '
          'touching call sites.',
          accent: Colors.blueGrey,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Builder(
            builder: (BuildContext context) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildComparisonRow(
                    label: 'A — App theme defaults',
                    accent: Colors.teal,
                    child: _buildSampleButtons(),
                  ),
                  const SizedBox(height: 12),
                  Theme(
                    data: Theme.of(context).copyWith(
                      textButtonTheme: TextButtonThemeData(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blueGrey.shade700,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 22, vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 13,
                            letterSpacing: 1.4,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    child: _buildComparisonRow(
                      label: 'B — Industrial slab style',
                      accent: Colors.blueGrey,
                      child: _buildSampleButtons(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Theme(
                    data: Theme.of(context).copyWith(
                      textButtonTheme: TextButtonThemeData(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.pink.shade900,
                          backgroundColor: Colors.pink.shade50,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12,
                          ),
                          shape: const StadiumBorder(),
                          textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                          side: BorderSide(
                            color: Colors.pink.shade300, width: 1.5,
                          ),
                        ),
                      ),
                    ),
                    child: _buildComparisonRow(
                      label: 'C — Soft pill style',
                      accent: Colors.pink,
                      child: _buildSampleButtons(),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    ),
  );
}

Widget _buildSampleButtons() {
  return Wrap(
    spacing: 10,
    runSpacing: 10,
    children: [
      TextButton(
        onPressed: () {},
        child: const Text('OK'),
      ),
      TextButton(
        onPressed: () {},
        child: const Text('Cancel'),
      ),
      TextButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.send, size: 18),
        label: const Text('Send'),
      ),
      const TextButton(
        onPressed: null,
        child: Text('Disabled'),
      ),
    ],
  );
}

// ===========================================================================
// SECTION 9: Decision guide — when to use which override.
// ===========================================================================
Widget _buildDecisionGuide() {
  return _wrapInCard(
    header: _buildHeaderStrip(
      title: 'Decision guide',
      subtitle: 'Choose the right TextButton styling layer',
      icon: Icons.account_tree,
      gradientColors: const [Color(0xFFD84315), Color(0xFFFF7043)],
    ),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildExplanation(
          'Three layers, each with its own scope. Use them in order from '
          'broadest to narrowest, only stepping down when you actually need '
          'a more localized override. Skipping levels is a common source of '
          'inconsistent UIs.',
          accent: Colors.deepOrange,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              _buildDecisionRow(
                level: '1',
                title: 'MaterialApp.theme.textButtonTheme',
                tag: 'App-wide',
                tagColor: Colors.indigo,
                description:
                    'Use when the style applies to every TextButton across '
                    'the entire app. Define once on the root ThemeData.',
                gradientStart: Colors.indigo.shade50,
                gradientEnd: Colors.blue.shade50,
              ),
              const SizedBox(height: 12),
              _buildDecisionRow(
                level: '2',
                title: 'Theme(data: parent.copyWith(...), child: ...)',
                tag: 'Subtree',
                tagColor: Colors.purple,
                description:
                    'Use to override style for a specific page, dialog, or '
                    'panel without touching the rest of the app.',
                gradientStart: Colors.purple.shade50,
                gradientEnd: Colors.pink.shade50,
              ),
              const SizedBox(height: 12),
              _buildDecisionRow(
                level: '3',
                title: 'TextButton(style: ..., …)',
                tag: 'One button',
                tagColor: Colors.orange,
                description:
                    'Use only for true one-off cases — a destructive button '
                    'in a dialog, an unusual call to action. If you write '
                    'the same per-button style twice, hoist it.',
                gradientStart: Colors.orange.shade50,
                gradientEnd: Colors.amber.shade50,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepOrange.shade50, Colors.red.shade50],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.deepOrange.shade100),
              boxShadow: [
                BoxShadow(
                  color: Colors.deepOrange.shade100.withOpacity(0.5),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.deepOrange.shade700,
                  size: 22,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Avoid copy-pasting per-button styles across screens. The '
                    'moment you have two TextButtons that should look the '
                    'same, lift the style into a TextButtonThemeData on a '
                    'shared Theme widget or on the app theme.',
                    style: TextStyle(
                      fontSize: 12,
                      height: 1.4,
                      color: Colors.deepOrange.shade900,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildDecisionRow({
  required String level,
  required String title,
  required String tag,
  required Color tagColor,
  required String description,
  required Color gradientStart,
  required Color gradientEnd,
}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [gradientStart, gradientEnd],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: tagColor.withOpacity(0.25)),
      boxShadow: [
        BoxShadow(
          color: tagColor.withOpacity(0.12),
          blurRadius: 8,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: tagColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: tagColor.withOpacity(0.4),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            level,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  _buildComparisonLabel(tag, tagColor),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade800,
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

// ===========================================================================
// build entry
// ===========================================================================
dynamic build(BuildContext context) {
  return MaterialApp(
    title: 'TextButtonThemeData Demo',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorSchemeSeed: Colors.indigo,
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    ),
    home: Scaffold(
      backgroundColor: const Color(0xFFF3F4F8),
      appBar: AppBar(
        title: const Text('TextButtonThemeData'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF3949AB), Color(0xFF5C6BC0)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildIntroCard(),
          _buildAppLevelThemeCard(),
          _buildLocalThemeOverrideCard(),
          _buildStyleFromShortcutCard(),
          _buildWidgetStatePropertySection(),
          _buildShapeAndPaddingShowcase(),
          _buildAlignmentShowcase(),
          _buildSideBySideComparisonCard(),
          _buildDecisionGuide(),
        ],
      ),
    ),
  );
}
