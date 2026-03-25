import 'package:flutter/material.dart';

Widget _demoCard({
  required String title,
  required String description,
  required Widget child,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: const [
        BoxShadow(
          color: Color(0x16000000),
          blurRadius: 8,
          offset: Offset(0, 3),
        ),
      ],
      border: Border.all(color: const Color(0xFFD8E2FF)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF243B8F),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: const TextStyle(fontSize: 12, color: Color(0xFF505A73)),
        ),
        const SizedBox(height: 12),
        child,
      ],
    ),
  );
}

Widget _fieldPreview({
  required String label,
  required Color accent,
  required Widget field,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: accent.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: accent.withValues(alpha: 0.35)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: accent,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 8),
        field,
      ],
    ),
  );
}

Widget _legendChip(Color color, String text) {
  return Container(
    margin: const EdgeInsets.only(right: 8, bottom: 8),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.13),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: color.withValues(alpha: 0.4)),
    ),
    child: Text(
      text,
      style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 11),
    ),
  );
}

dynamic build(BuildContext context) {
  final monoController = TextEditingController(
    text: 'Monospace cursor and compact decoration',
  );
  final denseController = TextEditingController(
    text: 'Dense layout with subtle painter settings',
  );
  final vividController = TextEditingController(
    text: 'Bright cursor + high-contrast selection painter',
  );
  final roundedController = TextEditingController(
    text: 'Rounded cursor and soft selection region',
  );
  final multilineController = TextEditingController(
    text: 'RenderEditablePainter also drives cursor and selection painting\n'
        'for multiline editable areas.\n'
        'Try selecting across lines to inspect visuals.',
  );

  return Theme(
    data: ThemeData(
      useMaterial3: true,
      colorSchemeSeed: const Color(0xFF3553C7),
      scaffoldBackgroundColor: const Color(0xFFF4F7FF),
    ),
    child: DefaultTextStyle(
      style: const TextStyle(fontFamily: 'Roboto', color: Color(0xFF1D2745)),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF2B46A8), Color(0xFF5B78E8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'RenderEditablePainter Deep Demo',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'This demo visualizes how editable text cursor, handles, '
                    'selection overlays, and decoration density present to users. '
                    'Focus is interpreter interaction, not API assertions.',
                    style: TextStyle(color: Color(0xFFE9EEFF), fontSize: 13),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Wrap(
              children: [
                _legendChip(const Color(0xFF3553C7), 'Cursor paint profile'),
                _legendChip(const Color(0xFF00796B), 'Selection color contrast'),
                _legendChip(const Color(0xFF8E24AA), 'Handle visibility'),
                _legendChip(const Color(0xFFEF6C00), 'Dense vs spacious fields'),
              ],
            ),
            _demoCard(
              title: 'Scenario 1 — Cursor Personality Gallery',
              description:
                  'Each field configures cursor width, radius, color, and text style '
                  'to demonstrate painter differences at a glance.',
              child: Column(
                children: [
                  _fieldPreview(
                    label: 'Monospace thin cursor',
                    accent: const Color(0xFF3553C7),
                    field: TextField(
                      controller: monoController,
                      cursorColor: const Color(0xFF3553C7),
                      cursorWidth: 1.2,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        letterSpacing: 0.2,
                      ),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                        hintText: 'Cursor should feel precise and technical',
                      ),
                    ),
                  ),
                  _fieldPreview(
                    label: 'Bold rounded cursor',
                    accent: const Color(0xFF8E24AA),
                    field: TextField(
                      controller: roundedController,
                      cursorColor: const Color(0xFF8E24AA),
                      cursorWidth: 3.2,
                      cursorRadius: const Radius.circular(6),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Rounded cursor demonstrates painter shape',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _demoCard(
              title: 'Scenario 2 — Selection & Handle Contrast',
              description:
                  'TextSelectionThemeData changes highlight and handle painting. '
                  'Select text in both fields to compare readability.',
              child: Column(
                children: [
                  Theme(
                    data: Theme.of(context).copyWith(
                      textSelectionTheme: const TextSelectionThemeData(
                        selectionColor: Color(0x553553C7),
                        cursorColor: Color(0xFF3553C7),
                        selectionHandleColor: Color(0xFF3553C7),
                      ),
                    ),
                    child: _fieldPreview(
                      label: 'Cool blue selection profile',
                      accent: const Color(0xFF3553C7),
                      field: TextField(
                        controller: vividController,
                        maxLines: 2,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Selection should appear bright and crisp',
                        ),
                      ),
                    ),
                  ),
                  Theme(
                    data: Theme.of(context).copyWith(
                      textSelectionTheme: const TextSelectionThemeData(
                        selectionColor: Color(0x557D5A00),
                        cursorColor: Color(0xFF7D5A00),
                        selectionHandleColor: Color(0xFFE39A00),
                      ),
                    ),
                    child: _fieldPreview(
                      label: 'Warm amber selection profile',
                      accent: const Color(0xFFE39A00),
                      field: TextField(
                        controller: denseController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 9,
                          ),
                          hintText: 'Dense field with high-visibility handles',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _demoCard(
              title: 'Scenario 3 — Multiline Editing Surface',
              description:
                  'RenderEditablePainter also controls cursor and selection painting '
                  'inside larger text surfaces where users annotate documents.',
              child: TextField(
                controller: multilineController,
                maxLines: 6,
                minLines: 4,
                cursorWidth: 2.6,
                cursorColor: const Color(0xFF00796B),
                cursorRadius: const Radius.circular(2),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF00796B)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFF00796B),
                      width: 2,
                    ),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFE9F8F5),
                  hintText: 'Try selections across lines and cursor navigation',
                ),
              ),
            ),
            _demoCard(
              title: 'Scenario 4 — Usage Guidance',
              description:
                  'Practical guidance for when to tune painter-relevant properties.',
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    dense: true,
                    leading: Icon(Icons.visibility, color: Color(0xFF3553C7)),
                    title: Text('Increase cursor width for large desktop forms.'),
                  ),
                  ListTile(
                    dense: true,
                    leading: Icon(Icons.brush, color: Color(0xFF00796B)),
                    title: Text('Tune selection colors for dark/light contrast.'),
                  ),
                  ListTile(
                    dense: true,
                    leading: Icon(Icons.accessibility, color: Color(0xFF8E24AA)),
                    title: Text('Keep handles visible for touch-first surfaces.'),
                  ),
                  ListTile(
                    dense: true,
                    leading: Icon(Icons.compress, color: Color(0xFFEF6C00)),
                    title: Text('Use dense decoration only where readability remains good.'),
                  ),
                ],
              ),
            ),
              _demoCard(
                title: 'Scenario 5 — Theme Profile Matrix',
                description:
                    'Three themed text zones illustrate how painter behavior should be reviewed '
                    'in light, dark, and high-contrast palettes.',
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFC9D5FF)),
                      ),
                      child: const Text('Light profile: verify subtle handle visibility.'),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF21243A),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'Dark profile: selection overlays need stronger alpha balance.',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF000000),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFFFD54F), width: 2),
                      ),
                      child: const Text(
                        'High contrast: cursor and selection must remain unmistakable.',
                        style: TextStyle(color: Color(0xFFFFF59D)),
                      ),
                    ),
                  ],
                ),
              ),
              _demoCard(
                title: 'Scenario 6 — Troubleshooting Checklist',
                description:
                    'Operational checklist for debugging painter-side text-editing visuals.',
                child: const Column(
                  children: [
                    ListTile(
                      dense: true,
                      leading: Icon(Icons.rule, color: Color(0xFF3553C7)),
                      title: Text('Check cursor thickness against font weight and scale.'),
                    ),
                    ListTile(
                      dense: true,
                      leading: Icon(Icons.layers_clear, color: Color(0xFF00796B)),
                      title: Text('Ensure selection alpha does not hide text glyphs.'),
                    ),
                    ListTile(
                      dense: true,
                      leading: Icon(Icons.touch_app, color: Color(0xFF8E24AA)),
                      title: Text('Validate handle visibility on touch and mouse devices.'),
                    ),
                    ListTile(
                      dense: true,
                      leading: Icon(Icons.tune, color: Color(0xFFEF6C00)),
                      title: Text('Compare dense and regular input decoration spacing.'),
                    ),
                    ListTile(
                      dense: true,
                      leading: Icon(Icons.check_circle, color: Color(0xFF2E7D32)),
                      title: Text('Record a final visual pass in all supported themes.'),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 20),
            const Text(
              'Deep demo completed: RenderEditablePainter behavior is demonstrated '
              'via multiple visual interaction surfaces and practical usage patterns.',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF5B6686),
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
