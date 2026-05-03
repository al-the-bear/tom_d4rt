// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: RenderEditable / TextField deep demo
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // -------------------------------------------------------------------------
  // Pre-seeded controllers. Controllers are passive state holders; we never
  // attach listeners or mutate them after construction, so they are
  // compatible with the static-presentation constraints of this script.
  // -------------------------------------------------------------------------
  final TextEditingController nameController =
      TextEditingController(text: 'Ada Lovelace');
  final TextEditingController emailController =
      TextEditingController(text: 'ada@analytical.engine');
  final TextEditingController filledController =
      TextEditingController(text: 'Filled background variant');
  final TextEditingController searchController =
      TextEditingController(text: 'render editable');
  final TextEditingController passwordController =
      TextEditingController(text: 'super-secret-passphrase');
  final TextEditingController multilineController = TextEditingController(
    text: 'RenderEditable handles soft-wrapped multi-line content.\n'
        'Each newline produces a new visual run; the render object\n'
        'computes caret metrics line-by-line and paints selection\n'
        'rectangles per visual line, accounting for bidi runs.',
  );

  final TextEditingController anatomyController =
      TextEditingController(text: 'Hover the arrows');

  final TextEditingController themeRedController =
      TextEditingController(text: 'Selection painted in red');
  themeRedController.selection =
      const TextSelection(baseOffset: 10, extentOffset: 18);

  final TextEditingController themeGreenController =
      TextEditingController(text: 'Selection painted in green');
  themeGreenController.selection =
      const TextSelection(baseOffset: 10, extentOffset: 19);

  final TextEditingController themeBlueController =
      TextEditingController(text: 'Selection painted in blue');
  themeBlueController.selection =
      const TextSelection(baseOffset: 10, extentOffset: 18);

  final TextEditingController wideController =
      TextEditingController(text: 'I expand to fill available row space');
  final TextEditingController narrowController =
      TextEditingController(text: 'Fixed 120px');

  // -------------------------------------------------------------------------
  // Shared decoration helpers (just plain functions returning new instances).
  // -------------------------------------------------------------------------
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorSchemeSeed: const Color(0xFF6750A4),
      useMaterial3: true,
    ),
    home: Scaffold(
      backgroundColor: const Color(0xFFF7F4FB),
      appBar: AppBar(
        title: const Text('RenderEditable — Deep Demo'),
        backgroundColor: const Color(0xFF6750A4),
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          // ===================================================================
          // SECTION 1 — Hero header
          // ===================================================================
          Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: <Color>[
                  Color(0xFF6750A4),
                  Color(0xFF8E78C4),
                  Color(0xFFB8A6E0),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Color(0x55000000),
                  blurRadius: 16,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.edit_note,
                        color: Colors.white, size: 44),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'RenderEditable',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    Icon(Icons.keyboard,
                        color: Colors.white, size: 36),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  'The render object inside EditableText / TextField that '
                  'paints glyphs, the caret, selection rectangles, and drag '
                  'handles. It exposes hit-testing for cursor placement, '
                  'computes line metrics, and routes text-input events.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    height: 1.45,
                  ),
                ),
                SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: <Widget>[
                    _HeroChip(icon: Icons.text_fields, label: 'Glyph paint'),
                    _HeroChip(icon: Icons.straighten, label: 'Caret metrics'),
                    _HeroChip(icon: Icons.select_all, label: 'Selection'),
                    _HeroChip(icon: Icons.touch_app, label: 'Hit test'),
                    _HeroChip(icon: Icons.drag_handle, label: 'Handles'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),

          // ===================================================================
          // SECTION 2 — TextField gallery
          // ===================================================================
          _SectionBanner(
            color1: Color(0xFF1565C0),
            color2: Color(0xFF42A5F5),
            icon: Icons.dashboard_customize,
            title: 'TextField gallery',
            subtitle: 'Six visual variants, all backed by RenderEditable',
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Color(0x22000000),
                  blurRadius: 14,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Outline border field
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Outline border',
                    hintText: 'Enter your name',
                    helperText: 'OutlineInputBorder()',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                // Underline border field (default)
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Underline border',
                    hintText: 'name@example.com',
                    helperText: 'UnderlineInputBorder() — default',
                    prefixIcon: Icon(Icons.alternate_email),
                  ),
                ),
                const SizedBox(height: 16),
                // Filled field
                TextField(
                  controller: filledController,
                  decoration: InputDecoration(
                    labelText: 'Filled',
                    hintText: 'Material filled style',
                    helperText: 'filled: true + tonal background',
                    filled: true,
                    fillColor: const Color(0xFFEDE7F6),
                    prefixIcon: const Icon(Icons.format_color_fill),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Search-style field with prefix + clear suffix
                TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search documentation…',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: const Icon(Icons.cancel, color: Colors.grey),
                    filled: true,
                    fillColor: const Color(0xFFF1F3F4),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 0, horizontal: 16),
                  ),
                ),
                const SizedBox(height: 16),
                // Password-style field
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  obscuringCharacter: '\u2022',
                  decoration: const InputDecoration(
                    labelText: 'Password (obscured)',
                    helperText: 'obscureText: true; glyphs replaced with •',
                    prefixIcon: Icon(Icons.lock_outline),
                    suffixIcon: Icon(Icons.visibility_off),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                // Multiline field
                TextField(
                  controller: multilineController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Multiline (maxLines: 4)',
                    helperText:
                        'RenderEditable wraps and computes per-line metrics',
                    alignLabelWithHint: true,
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(bottom: 60),
                      child: Icon(Icons.notes),
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),

          // ===================================================================
          // SECTION 3 — InputDecoration anatomy
          // ===================================================================
          _SectionBanner(
            color1: Color(0xFF00695C),
            color2: Color(0xFF26A69A),
            icon: Icons.architecture,
            title: 'InputDecoration anatomy',
            subtitle: 'Anatomy of every visual slot around RenderEditable',
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0xFFB2DFDB), width: 2),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Color(0x1A009688),
                  blurRadius: 12,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextField(
                  controller: anatomyController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.label_important_outline),
                    labelText: 'labelText',
                    hintText: 'hintText',
                    helperText: 'helperText — explanatory copy below the field',
                    counterText: '13 / 50 (counterText)',
                    prefix: Text('@ '),
                    suffix: Text(' .com'),
                    prefixIcon: Icon(Icons.flag),
                    suffixIcon: Icon(Icons.check_circle, color: Colors.green),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 18),
                _AnatomyRow(
                    icon: Icons.label,
                    label: 'labelText',
                    description:
                        'Floats above the input on focus or when populated.'),
                _AnatomyRow(
                    icon: Icons.text_snippet,
                    label: 'hintText',
                    description:
                        'Greyed placeholder shown when the editable is empty.'),
                _AnatomyRow(
                    icon: Icons.help_outline,
                    label: 'helperText',
                    description:
                        'Persistent helper line beneath the input border.'),
                _AnatomyRow(
                    icon: Icons.exposure,
                    label: 'prefix / prefixIcon',
                    description:
                        'Inline content (e.g. @, currency symbol) or icon.'),
                _AnatomyRow(
                    icon: Icons.close,
                    label: 'suffix / suffixIcon',
                    description:
                        'Trailing slot for clear buttons, units, or status.'),
                _AnatomyRow(
                    icon: Icons.numbers,
                    label: 'counterText',
                    description:
                        'Bottom-right slot for character counts or limits.'),
              ],
            ),
          ),
          const SizedBox(height: 28),

          // ===================================================================
          // SECTION 4 — Selection theme demo
          // ===================================================================
          _SectionBanner(
            color1: Color(0xFFB71C1C),
            color2: Color(0xFFE57373),
            icon: Icons.format_color_text,
            title: 'TextSelectionTheme',
            subtitle: 'Re-skin caret, selection highlight, and handles',
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Color(0x33B71C1C),
                  blurRadius: 12,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _SelectionThemed(
                  cursor: const Color(0xFFB71C1C),
                  highlight: const Color(0x55B71C1C),
                  handle: const Color(0xFFB71C1C),
                  controller: themeRedController,
                  label: 'Red theme',
                ),
                const SizedBox(height: 14),
                _SelectionThemed(
                  cursor: const Color(0xFF1B5E20),
                  highlight: const Color(0x551B5E20),
                  handle: const Color(0xFF1B5E20),
                  controller: themeGreenController,
                  label: 'Green theme',
                ),
                const SizedBox(height: 14),
                _SelectionThemed(
                  cursor: const Color(0xFF0D47A1),
                  highlight: const Color(0x550D47A1),
                  handle: const Color(0xFF0D47A1),
                  controller: themeBlueController,
                  label: 'Blue theme',
                ),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF3E0),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFFFB74D)),
                  ),
                  child: const Row(
                    children: <Widget>[
                      Icon(Icons.lightbulb_outline,
                          color: Color(0xFFEF6C00)),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Selection literals are pre-seeded so the highlight '
                          'is visible without focus or interaction.',
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),

          // ===================================================================
          // SECTION 5 — SelectableText comparison
          // ===================================================================
          _SectionBanner(
            color1: Color(0xFF4527A0),
            color2: Color(0xFF7E57C2),
            icon: Icons.compare_arrows,
            title: 'SelectableText vs Text',
            subtitle: 'Identical glyphs, different render objects',
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Color(0x22000000),
                  blurRadius: 12,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _CompareCard(
                  icon: Icons.touch_app,
                  title: 'SelectableText',
                  caption:
                      'Uses RenderEditable under the hood. Long-press to '
                      'select; double-tap word; supports drag handles.',
                  body: SelectableText(
                    'RenderEditable powers SelectableText too. The render '
                    'object understands caret metrics, selection rectangles, '
                    'and gesture-driven selection extension — even though '
                    'the content is read-only.',
                    style: TextStyle(fontSize: 15, height: 1.4),
                  ),
                  accent: Color(0xFF4527A0),
                ),
                SizedBox(height: 14),
                _CompareCard(
                  icon: Icons.text_format,
                  title: 'Text',
                  caption:
                      'Uses RenderParagraph. No caret, no selection, no '
                      'gesture wiring — just glyph painting.',
                  body: Text(
                    'Plain Text uses RenderParagraph. It is cheaper but '
                    'cannot be selected by the user; if you need '
                    'selection without editing, prefer SelectableText.',
                    style: TextStyle(fontSize: 15, height: 1.4),
                  ),
                  accent: Color(0xFF7E57C2),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),

          // ===================================================================
          // SECTION 6 — Caret rendering reference
          // ===================================================================
          _SectionBanner(
            color1: Color(0xFFEF6C00),
            color2: Color(0xFFFFB74D),
            icon: Icons.crop_portrait,
            title: 'Caret rendering reference',
            subtitle: 'Knobs that control how the cursor is painted',
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Color(0x33EF6C00),
                  blurRadius: 12,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 80,
                      height: 80,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF3E0),
                        borderRadius: BorderRadius.circular(12),
                        border:
                            Border.all(color: const Color(0xFFFFB74D), width: 2),
                      ),
                      child: Container(
                        width: 3,
                        height: 36,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEF6C00),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Text(
                        'A caret is a thin painted rectangle anchored to the '
                        'logical cursor offset. RenderEditable computes its '
                        'position from line metrics on every layout pass.',
                        style: TextStyle(fontSize: 14, height: 1.4),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                _CaretRow(
                    icon: Icons.height,
                    name: 'cursorHeight',
                    description:
                        'Override caret height (defaults to line height).'),
                _CaretRow(
                    icon: Icons.line_weight,
                    name: 'cursorWidth',
                    description:
                        'Caret stroke width in logical pixels (default 2).'),
                _CaretRow(
                    icon: Icons.rounded_corner,
                    name: 'cursorRadius',
                    description:
                        'Corner radius for the caret rectangle (Cupertino-ish).'),
                _CaretRow(
                    icon: Icons.opacity,
                    name: 'cursorOpacityAnimates',
                    description:
                        'Whether the caret blinks via an opacity animation.'),
                _CaretRow(
                    icon: Icons.color_lens,
                    name: 'cursorColor',
                    description:
                        'Caret colour, also propagated to drag handle painting.'),
                _CaretRow(
                    icon: Icons.center_focus_strong,
                    name: 'showCursor',
                    description:
                        'Hide the caret without disabling editing.'),
              ],
            ),
          ),
          const SizedBox(height: 28),

          // ===================================================================
          // SECTION 7 — Magnifier configuration
          // ===================================================================
          _SectionBanner(
            color1: Color(0xFF006064),
            color2: Color(0xFF26C6DA),
            icon: Icons.search,
            title: 'TextMagnifierConfiguration',
            subtitle: 'Loupe-style magnifier on touch platforms',
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Color(0x22006064),
                  blurRadius: 12,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        gradient: const RadialGradient(
                          colors: <Color>[
                            Color(0xFFE0F7FA),
                            Color(0xFF80DEEA),
                          ],
                        ),
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: const Color(0xFF00838F), width: 3),
                        boxShadow: const <BoxShadow>[
                          BoxShadow(
                            color: Color(0x4400838F),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.zoom_in,
                          size: 36, color: Color(0xFF006064)),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Text(
                        'On iOS and Android, RenderEditable can summon a '
                        'magnifier loupe while the user drags a selection '
                        'handle. The configuration object lets you swap the '
                        'magnifier widget or disable the feature.',
                        style: TextStyle(fontSize: 14, height: 1.45),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _MagnifierBullet(
                    label: 'magnifierBuilder',
                    detail:
                        'Returns the widget displayed as the magnifier loupe.'),
                _MagnifierBullet(
                    label: 'shouldDisplayHandlesInMagnifier',
                    detail:
                        'Controls whether selection handles are visible inside '
                        'the magnifier viewport.'),
                _MagnifierBullet(
                    label: 'TextMagnifierConfiguration.disabled',
                    detail:
                        'Singleton that opts a TextField out of magnification '
                        'entirely.'),
              ],
            ),
          ),
          const SizedBox(height: 28),

          // ===================================================================
          // SECTION 8 — Layout / size
          // ===================================================================
          _SectionBanner(
            color1: Color(0xFF311B92),
            color2: Color(0xFF7C4DFF),
            icon: Icons.straighten,
            title: 'Constraints and sizing',
            subtitle: 'TextField in SizedBox, Expanded, and Row',
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Color(0x22311B92),
                  blurRadius: 12,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Text(
                  'RenderEditable participates in normal box-layout. Wrapping '
                  'a TextField in Expanded fills the row; a SizedBox locks a '
                  'fixed width.',
                  style: TextStyle(fontSize: 14, height: 1.4),
                ),
                const SizedBox(height: 14),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: wideController,
                        decoration: const InputDecoration(
                          labelText: 'Expanded',
                          helperText: 'Flexes to row width',
                          prefixIcon: Icon(Icons.unfold_more),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      width: 140,
                      child: TextField(
                        controller: narrowController,
                        decoration: const InputDecoration(
                          labelText: 'SizedBox',
                          helperText: '120 px',
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: <Color>[Color(0xFFEDE7F6), Color(0xFFD1C4E9)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    children: <Widget>[
                      Icon(Icons.info_outline, color: Color(0xFF311B92)),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'When a TextField has no parent constraint, it fills '
                          'the available cross-axis extent and is intrinsic on '
                          'the main axis. Use IntrinsicWidth for shrink-wrap.',
                          style: TextStyle(fontSize: 13, height: 1.4),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),

          // ===================================================================
          // SECTION 9 — API reference card matrix
          // ===================================================================
          _SectionBanner(
            color1: Color(0xFF263238),
            color2: Color(0xFF607D8B),
            icon: Icons.menu_book,
            title: 'API reference',
            subtitle: 'Key parameters of TextField / EditableText',
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: const <Widget>[
              _ApiCard(
                icon: Icons.tune,
                name: 'controller',
                signature: 'TextEditingController?',
                summary:
                    'Owns the editable value. If null a controller is '
                    'allocated internally.',
                accent: Color(0xFF1565C0),
              ),
              _ApiCard(
                icon: Icons.layers,
                name: 'decoration',
                signature: 'InputDecoration?',
                summary:
                    'Visual chrome around the editable: label, hint, helper, '
                    'icons, border.',
                accent: Color(0xFF6A1B9A),
              ),
              _ApiCard(
                icon: Icons.keyboard,
                name: 'keyboardType',
                signature: 'TextInputType',
                summary:
                    'Hints the platform IME (number, email, multiline, url).',
                accent: Color(0xFFAD1457),
              ),
              _ApiCard(
                icon: Icons.lock,
                name: 'obscureText',
                signature: 'bool',
                summary:
                    'Replaces glyphs with obscuringCharacter; disables '
                    'paste in OS-level shortcuts.',
                accent: Color(0xFFE65100),
              ),
              _ApiCard(
                icon: Icons.format_line_spacing,
                name: 'maxLines',
                signature: 'int? = 1',
                summary:
                    'Maximum visual lines. null grows unbounded; 1 forces a '
                    'single-line editor.',
                accent: Color(0xFF2E7D32),
              ),
              _ApiCard(
                icon: Icons.font_download,
                name: 'style',
                signature: 'TextStyle?',
                summary:
                    'Font, size, color of the editable glyphs (not the '
                    'decoration label/hint).',
                accent: Color(0xFF00838F),
              ),
              _ApiCard(
                icon: Icons.format_align_center,
                name: 'textAlign',
                signature: 'TextAlign',
                summary:
                    'Horizontal alignment of glyphs and caret within the '
                    'render box.',
                accent: Color(0xFF4E342E),
              ),
              _ApiCard(
                icon: Icons.filter_alt,
                name: 'inputFormatters',
                signature: 'List<TextInputFormatter>?',
                summary:
                    'Pre-commit hooks that mutate or veto incoming edits '
                    '(masks, length, regex).',
                accent: Color(0xFF455A64),
              ),
              _ApiCard(
                icon: Icons.color_lens,
                name: 'cursorColor',
                signature: 'Color?',
                summary:
                    'Caret colour, also propagates to drag handles when '
                    'no theme overrides them.',
                accent: Color(0xFF8E24AA),
              ),
            ],
          ),
          const SizedBox(height: 28),

          // ===================================================================
          // SECTION 10 — Pitfalls / see-also
          // ===================================================================
          _SectionBanner(
            color1: Color(0xFF3E2723),
            color2: Color(0xFF8D6E63),
            icon: Icons.warning_amber,
            title: 'Pitfalls and see-also',
            subtitle: 'Topics adjacent to RenderEditable',
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Color(0x223E2723),
                  blurRadius: 12,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _PitfallTile(
                  icon: Icons.tab,
                  title: 'Focus traversal',
                  body:
                      'TextField participates in FocusTraversalGroup. Tab order '
                      'is independent of paint order; configure with '
                      'FocusTraversalPolicy.',
                ),
                _PitfallTile(
                  icon: Icons.translate,
                  title: 'IME composition',
                  body:
                      'During CJK or accent composition, RenderEditable paints '
                      'a composing region underline. The composing range comes '
                      'from TextEditingValue.composing.',
                ),
                _PitfallTile(
                  icon: Icons.auto_fix_high,
                  title: 'Autofill hints',
                  body:
                      'autofillHints feeds the platform autofill service. '
                      'Group related fields in an AutofillGroup so the OS sees '
                      'them as a unit.',
                ),
                _PitfallTile(
                  icon: Icons.link,
                  title: 'See also: EditableText',
                  body:
                      'EditableText is the lower-level widget directly hosting '
                      'RenderEditable. TextField wraps it with Material '
                      'decoration; CupertinoTextField wraps it with iOS chrome.',
                ),
                _PitfallTile(
                  icon: Icons.link,
                  title: 'See also: TextSelectionTheme',
                  body:
                      'Theme inherited by all editable surfaces in a subtree. '
                      'Prefer this over per-field colours when you want a '
                      'consistent look.',
                ),
                _PitfallTile(
                  icon: Icons.link,
                  title: 'See also: RenderEditable',
                  body:
                      'The render object itself lives in '
                      'rendering/editable.dart. Most apps never reference it '
                      'directly, but it is the source of truth for caret and '
                      'selection geometry.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Footer
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: <Color>[Color(0xFF6750A4), Color(0xFF311B92)],
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Row(
              children: <Widget>[
                Icon(Icons.flag, color: Colors.white, size: 28),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'End of RenderEditable deep demo. Static composition only '
                    '— no AnimationController, no setState, no listeners.',
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
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
// Helper widgets — all stateless, no listeners, no animation.
// ===========================================================================

class _HeroChip extends StatelessWidget {
  const _HeroChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.18),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, color: Colors.white, size: 16),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class _SectionBanner extends StatelessWidget {
  const _SectionBanner({
    required this.color1,
    required this.color2,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final Color color1;
  final Color color2;
  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[color1, color2],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color1.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 48,
            height: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.22),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.4,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AnatomyRow extends StatelessWidget {
  const _AnatomyRow({
    required this.icon,
    required this.label,
    required this.description,
  });

  final IconData icon;
  final String label;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 32,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFFE0F2F1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 18, color: const Color(0xFF00695C)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF004D40),
                    fontSize: 13.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: const TextStyle(fontSize: 13, height: 1.35),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectionThemed extends StatelessWidget {
  const _SelectionThemed({
    required this.cursor,
    required this.highlight,
    required this.handle,
    required this.controller,
    required this.label,
  });

  final Color cursor;
  final Color highlight;
  final Color handle;
  final TextEditingController controller;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: handle.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 14,
                height: 14,
                decoration:
                    BoxDecoration(color: handle, shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style:
                    const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextSelectionTheme(
            data: TextSelectionThemeData(
              cursorColor: cursor,
              selectionColor: highlight,
              selectionHandleColor: handle,
            ),
            child: TextField(
              controller: controller,
              cursorColor: cursor,
              decoration: InputDecoration(
                isDense: true,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: handle),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: handle, width: 2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CompareCard extends StatelessWidget {
  const _CompareCard({
    required this.icon,
    required this.title,
    required this.caption,
    required this.body,
    required this.accent,
  });

  final IconData icon;
  final String title;
  final String caption;
  final Widget body;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withOpacity(0.35), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, color: accent),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: accent,
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            caption,
            style: const TextStyle(
                fontSize: 12.5, fontStyle: FontStyle.italic, height: 1.35),
          ),
          const SizedBox(height: 10),
          body,
        ],
      ),
    );
  }
}

class _CaretRow extends StatelessWidget {
  const _CaretRow({
    required this.icon,
    required this.name,
    required this.description,
  });

  final IconData icon;
  final String name;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 30,
            height: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFFFFF3E0),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 17, color: const Color(0xFFEF6C00)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                    color: Colors.black87, fontSize: 13.5, height: 1.35),
                children: <InlineSpan>[
                  TextSpan(
                    text: name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontFamily: 'monospace',
                      color: Color(0xFFE65100),
                    ),
                  ),
                  const TextSpan(text: '  —  '),
                  TextSpan(text: description),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MagnifierBullet extends StatelessWidget {
  const _MagnifierBullet({required this.label, required this.detail});

  final String label;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Icon(Icons.fiber_manual_record,
              size: 10, color: Color(0xFF006064)),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                    color: Colors.black87, fontSize: 13, height: 1.4),
                children: <InlineSpan>[
                  TextSpan(
                    text: label,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF006064),
                    ),
                  ),
                  const TextSpan(text: ' — '),
                  TextSpan(text: detail),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ApiCard extends StatelessWidget {
  const _ApiCard({
    required this.icon,
    required this.name,
    required this.signature,
    required this.summary,
    required this.accent,
  });

  final IconData icon;
  final String name;
  final String signature;
  final String summary;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: accent.withOpacity(0.4), width: 1.5),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: accent.withOpacity(0.18),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 32,
                height: 32,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: accent.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 18, color: accent),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                    color: accent,
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                    fontFamily: 'monospace',
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            signature,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            summary,
            style: const TextStyle(fontSize: 12.5, height: 1.35),
          ),
        ],
      ),
    );
  }
}

class _PitfallTile extends StatelessWidget {
  const _PitfallTile({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFFEFEBE9),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 20, color: const Color(0xFF5D4037)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF3E2723),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  body,
                  style: const TextStyle(fontSize: 13, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
