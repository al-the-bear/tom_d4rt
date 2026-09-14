// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Live Demo for OverlayVisibilityMode (cupertino)
// Wires the enum into real CupertinoTextFields with live controllers so the
// rendered output reflects the actual prefix/suffix visibility rules.
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  // ============================================================================
  // LIVE CONTROLLERS FOR SECTION A (prefix gallery)
  // ============================================================================

  final ctrlPrefixAlways = TextEditingController(text: 'always');
  final ctrlPrefixNever = TextEditingController(text: 'never');
  final ctrlPrefixEditing = TextEditingController(text: 'editing');
  final ctrlPrefixNotEditing = TextEditingController(text: 'notEditing');

  // ============================================================================
  // LIVE CONTROLLERS FOR SECTION B (suffix gallery)
  // ============================================================================

  final ctrlSuffixAlways = TextEditingController(text: 'visible always');
  final ctrlSuffixNever = TextEditingController(text: 'never visible');
  final ctrlSuffixEditing = TextEditingController(text: 'edit me');
  final ctrlSuffixNotEditing = TextEditingController(text: 'idle text');

  // ============================================================================
  // LIVE CONTROLLERS FOR SECTION C (combined)
  // ============================================================================

  final ctrlComboLeft = TextEditingController(text: 'always + editing');
  final ctrlComboRight = TextEditingController(text: 'notEditing + always');

  // ============================================================================
  // LIVE CONTROLLERS FOR SECTION E (recipes)
  // ============================================================================

  final ctrlRecipeSearch = TextEditingController(text: 'flutter cupertino');
  final ctrlRecipePassword = TextEditingController(text: 'hunter2-secret');
  final ctrlRecipeEmail = TextEditingController(text: 'demo@example.com');

  // ============================================================================
  // SHARED PALETTES (one tone per section so the eye can navigate)
  // ============================================================================

  final paletteA = <String, Color>{
    'bg': Color(0xFFF1F5F9),
    'border': Color(0xFF94A3B8),
    'accent': Color(0xFF0F172A),
    'caption': Color(0xFF334155),
  };
  final paletteB = <String, Color>{
    'bg': Color(0xFFFFF7ED),
    'border': Color(0xFFFB923C),
    'accent': Color(0xFF9A3412),
    'caption': Color(0xFF7C2D12),
  };
  final paletteC = <String, Color>{
    'bg': Color(0xFFECFEFF),
    'border': Color(0xFF22D3EE),
    'accent': Color(0xFF155E75),
    'caption': Color(0xFF0E7490),
  };
  final paletteD = <String, Color>{
    'bg': Color(0xFFF5F3FF),
    'border': Color(0xFFA78BFA),
    'accent': Color(0xFF4C1D95),
    'caption': Color(0xFF6D28D9),
  };
  final paletteE = <String, Color>{
    'bg': Color(0xFFECFDF5),
    'border': Color(0xFF34D399),
    'accent': Color(0xFF065F46),
    'caption': Color(0xFF047857),
  };
  final paletteF = <String, Color>{
    'bg': Color(0xFFFFF1F2),
    'border': Color(0xFFFB7185),
    'accent': Color(0xFF881337),
    'caption': Color(0xFFBE123C),
  };

  // ============================================================================
  // BUILD HELPER VALUES (kept inline so this file stays single-build)
  // ============================================================================

  final modeOrder = <OverlayVisibilityMode>[
    OverlayVisibilityMode.always,
    OverlayVisibilityMode.never,
    OverlayVisibilityMode.editing,
    OverlayVisibilityMode.notEditing,
  ];

  print('OverlayVisibilityMode demo — ${modeOrder.length} enum values wired '
      'into live CupertinoTextFields.');
  for (final m in modeOrder) {
    print('  • ${m.name} → index ${m.index}');
  }

  // ============================================================================
  // SECTION A — Four-mode prefix gallery
  // ============================================================================

  Widget buildPrefixCard({
    required OverlayVisibilityMode mode,
    required TextEditingController controller,
    required String placeholder,
    required String caption,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 14.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: paletteA['border']!, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: paletteA['accent'],
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  'prefixMode: ${mode.name}',
                  style: TextStyle(
                    color: CupertinoColors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 8.0),
              Text(
                'index ${mode.index}',
                style: TextStyle(
                  color: paletteA['caption'],
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          CupertinoTextField(
            controller: controller,
            placeholder: placeholder,
            prefix: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(
                CupertinoIcons.search,
                color: paletteA['accent'],
                size: 18.0,
              ),
            ),
            prefixMode: mode,
            keyboardType: TextInputType.text,
            decoration: BoxDecoration(
              color: paletteA['bg'],
              border: Border.all(color: paletteA['border']!, width: 1.0),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            caption,
            style: TextStyle(
              fontSize: 12.0,
              color: paletteA['caption'],
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  final sectionA = Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: paletteA['bg'],
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: paletteA['border']!, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section A · Prefix gallery',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: paletteA['accent'],
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Each card sets prefixMode to one of the four enum values. The '
          'prefix is a search icon; tap into a field to see the rule fire.',
          style: TextStyle(fontSize: 13.0, color: paletteA['caption']),
        ),
        SizedBox(height: 14.0),
        buildPrefixCard(
          mode: OverlayVisibilityMode.always,
          controller: ctrlPrefixAlways,
          placeholder: 'always shows the prefix…',
          caption:
              'always — the prefix renders whether the field is empty, has '
              'text, focused, or unfocused. Use for permanent affordances.',
        ),
        buildPrefixCard(
          mode: OverlayVisibilityMode.never,
          controller: ctrlPrefixNever,
          placeholder: 'no prefix here…',
          caption:
              'never — the prefix is reserved in the API but is not painted. '
              'Useful when you want a single field to opt out without '
              'restructuring the widget tree.',
        ),
        buildPrefixCard(
          mode: OverlayVisibilityMode.editing,
          controller: ctrlPrefixEditing,
          placeholder: 'tap to reveal prefix…',
          caption:
              'editing — the prefix appears only while the user is actively '
              'editing (focused with text). Pairs nicely with contextual '
              'tools like a clear-text icon.',
        ),
        buildPrefixCard(
          mode: OverlayVisibilityMode.notEditing,
          controller: ctrlPrefixNotEditing,
          placeholder: 'prefix hides while typing…',
          caption:
              'notEditing — the prefix is shown when idle and hides while '
              'editing. Great for a placeholder ornament that shouldn\'t '
              'compete with the live caret.',
        ),
      ],
    ),
  );

  // ============================================================================
  // SECTION B — Four-mode suffix gallery
  // ============================================================================

  Widget buildSuffixCard({
    required OverlayVisibilityMode mode,
    required TextEditingController controller,
    required String placeholder,
    required String caption,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 14.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: paletteB['border']!, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: paletteB['accent'],
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  'suffixMode: ${mode.name}',
                  style: TextStyle(
                    color: CupertinoColors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 8.0),
              Text(
                'index ${mode.index}',
                style: TextStyle(
                  color: paletteB['caption'],
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          CupertinoTextField(
            controller: controller,
            placeholder: placeholder,
            suffix: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(
                CupertinoIcons.clear_circled_solid,
                color: paletteB['accent'],
                size: 18.0,
              ),
            ),
            suffixMode: mode,
            keyboardType: TextInputType.text,
            decoration: BoxDecoration(
              color: paletteB['bg'],
              border: Border.all(color: paletteB['border']!, width: 1.0),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            caption,
            style: TextStyle(
              fontSize: 12.0,
              color: paletteB['caption'],
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  final sectionB = Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: paletteB['bg'],
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: paletteB['border']!, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section B · Suffix gallery',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: paletteB['accent'],
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Same enum, different slot. The suffix is a "clear" icon — the '
          'classic example of a control that should appear only while a '
          'user is editing.',
          style: TextStyle(fontSize: 13.0, color: paletteB['caption']),
        ),
        SizedBox(height: 14.0),
        buildSuffixCard(
          mode: OverlayVisibilityMode.always,
          controller: ctrlSuffixAlways,
          placeholder: 'suffix always rendered…',
          caption:
              'always — suffix is painted unconditionally. Common for '
              'unit-of-measure labels that belong to the field forever.',
        ),
        buildSuffixCard(
          mode: OverlayVisibilityMode.never,
          controller: ctrlSuffixNever,
          placeholder: 'suffix is opted out…',
          caption:
              'never — the suffix slot is suppressed. The text field still '
              'reserves logical room internally, so layout stays stable.',
        ),
        buildSuffixCard(
          mode: OverlayVisibilityMode.editing,
          controller: ctrlSuffixEditing,
          placeholder: 'suffix joins while typing…',
          caption:
              'editing — the textbook clear-button mode. The icon shows '
              'while the user is interacting and hides once they leave.',
        ),
        buildSuffixCard(
          mode: OverlayVisibilityMode.notEditing,
          controller: ctrlSuffixNotEditing,
          placeholder: 'suffix appears when idle…',
          caption:
              'notEditing — useful for status badges (validation marks, '
              'selection chevrons) that should disappear while the user '
              'is mid-edit and reappear after they commit.',
        ),
      ],
    ),
  );

  // ============================================================================
  // SECTION C — Combined prefix + suffix
  // ============================================================================

  final sectionC = Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: paletteC['bg'],
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: paletteC['border']!, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section C · Combined prefix + suffix',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: paletteC['accent'],
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'OverlayVisibilityMode applies independently to each slot. Two '
          'live fields, two different rule combinations.',
          style: TextStyle(fontSize: 13.0, color: paletteC['caption']),
        ),
        SizedBox(height: 14.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  border:
                      Border.all(color: paletteC['border']!, width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'always + editing',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: paletteC['accent'],
                      ),
                    ),
                    SizedBox(height: 8.0),
                    CupertinoTextField(
                      controller: ctrlComboLeft,
                      placeholder: 'persistent search…',
                      prefix: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Icon(
                          CupertinoIcons.search,
                          color: paletteC['accent'],
                          size: 18.0,
                        ),
                      ),
                      prefixMode: OverlayVisibilityMode.always,
                      suffix: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Icon(
                          CupertinoIcons.clear_circled_solid,
                          color: paletteC['accent'],
                          size: 18.0,
                        ),
                      ),
                      suffixMode: OverlayVisibilityMode.editing,
                      decoration: BoxDecoration(
                        color: paletteC['bg'],
                        border: Border.all(
                          color: paletteC['border']!,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Magnifier always present. Clear button only while '
                      'the user is typing.',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: paletteC['caption'],
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  border:
                      Border.all(color: paletteC['border']!, width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'notEditing + always',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: paletteC['accent'],
                      ),
                    ),
                    SizedBox(height: 8.0),
                    CupertinoTextField(
                      controller: ctrlComboRight,
                      placeholder: 'idle ornament…',
                      prefix: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Icon(
                          CupertinoIcons.tag,
                          color: paletteC['accent'],
                          size: 18.0,
                        ),
                      ),
                      prefixMode: OverlayVisibilityMode.notEditing,
                      suffix: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Icon(
                          CupertinoIcons.chevron_right,
                          color: paletteC['accent'],
                          size: 18.0,
                        ),
                      ),
                      suffixMode: OverlayVisibilityMode.always,
                      decoration: BoxDecoration(
                        color: paletteC['bg'],
                        border: Border.all(
                          color: paletteC['border']!,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Tag prefix is decorative — it gets out of the way '
                      'when typing. Chevron suffix stays as a permanent '
                      'navigation hint.',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: paletteC['caption'],
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================================
  // SECTION D — Visibility decision matrix (4 rows × 3 columns)
  // ============================================================================

  // Returns true if the rule says "render the slot" for the given (mode, state).
  bool isVisible({
    required OverlayVisibilityMode mode,
    required bool hasText,
    required bool isFocused,
  }) {
    final isEditing = isFocused;
    switch (mode) {
      case OverlayVisibilityMode.always:
        return true;
      case OverlayVisibilityMode.never:
        return false;
      case OverlayVisibilityMode.editing:
        return isEditing;
      case OverlayVisibilityMode.notEditing:
        return !isEditing;
    }
    // Defensive: keep us future-proof if Flutter adds a new value.
    // ignore: dead_code
  }

  Widget buildMatrixCell({
    required OverlayVisibilityMode mode,
    required bool hasText,
    required bool isFocused,
  }) {
    final visible = isVisible(
      mode: mode,
      hasText: hasText,
      isFocused: isFocused,
    );
    return Container(
      height: 56.0,
      margin: EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        color: visible
            ? Color(0xFFEDE9FE)
            : Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: visible
              ? paletteD['border']!
              : Color(0xFFD1D5DB),
          width: 1.0,
        ),
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            visible
                ? CupertinoIcons.eye_solid
                : CupertinoIcons.eye_slash,
            size: 16.0,
            color: visible
                ? paletteD['accent']
                : Color(0xFF6B7280),
          ),
          SizedBox(width: 6.0),
          Text(
            visible ? 'shown' : 'hidden',
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: visible
                  ? paletteD['accent']
                  : Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMatrixHeader(String label) {
    return Container(
      height: 36.0,
      margin: EdgeInsets.all(2.0),
      padding: EdgeInsets.symmetric(horizontal: 6.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: paletteD['accent'],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 11.0,
          fontWeight: FontWeight.bold,
          color: CupertinoColors.white,
        ),
      ),
    );
  }

  Widget buildMatrixRowLabel(OverlayVisibilityMode mode) {
    return Container(
      height: 56.0,
      margin: EdgeInsets.all(2.0),
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: paletteD['border']!, width: 1.0),
      ),
      child: Text(
        mode.name,
        style: TextStyle(
          fontSize: 13.0,
          fontWeight: FontWeight.bold,
          color: paletteD['accent'],
        ),
      ),
    );
  }

  Widget buildMatrixRow(OverlayVisibilityMode mode) {
    return Row(
      children: [
        Expanded(flex: 2, child: buildMatrixRowLabel(mode)),
        Expanded(
          flex: 3,
          child: buildMatrixCell(
            mode: mode,
            hasText: false,
            isFocused: false,
          ),
        ),
        Expanded(
          flex: 3,
          child: buildMatrixCell(
            mode: mode,
            hasText: true,
            isFocused: false,
          ),
        ),
        Expanded(
          flex: 3,
          child: buildMatrixCell(
            mode: mode,
            hasText: true,
            isFocused: true,
          ),
        ),
      ],
    );
  }

  final sectionD = Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: paletteD['bg'],
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: paletteD['border']!, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section D · Visibility decision matrix',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: paletteD['accent'],
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'This is the rule the enum encodes. Rows are the four enum values, '
          'columns are concrete field states.',
          style: TextStyle(fontSize: 13.0, color: paletteD['caption']),
        ),
        SizedBox(height: 14.0),
        Row(
          children: [
            Expanded(flex: 2, child: buildMatrixHeader('mode')),
            Expanded(flex: 3, child: buildMatrixHeader('empty + idle')),
            Expanded(
              flex: 3,
              child: buildMatrixHeader('text + idle'),
            ),
            Expanded(
              flex: 3,
              child: buildMatrixHeader('text + focus'),
            ),
          ],
        ),
        buildMatrixRow(OverlayVisibilityMode.always),
        buildMatrixRow(OverlayVisibilityMode.never),
        buildMatrixRow(OverlayVisibilityMode.editing),
        buildMatrixRow(OverlayVisibilityMode.notEditing),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: CupertinoColors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: paletteD['border']!, width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'How to read the matrix',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: paletteD['accent'],
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                '"editing" in CupertinoTextField means the field currently '
                'has focus. The text content does not change visibility on '
                'its own — only focus does. The matrix shows that always/'
                'never short-circuit, while editing/notEditing flip on the '
                'focus column.',
                style: TextStyle(
                  fontSize: 12.0,
                  color: paletteD['caption'],
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================================
  // SECTION E — Real-world recipes
  // ============================================================================

  final recipeSearchField = CupertinoTextField(
    controller: ctrlRecipeSearch,
    placeholder: 'Search…',
    prefix: Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Icon(
        CupertinoIcons.search,
        color: paletteE['accent'],
        size: 18.0,
      ),
    ),
    prefixMode: OverlayVisibilityMode.always,
    suffix: Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Icon(
        CupertinoIcons.clear_circled_solid,
        color: paletteE['accent'],
        size: 18.0,
      ),
    ),
    suffixMode: OverlayVisibilityMode.editing,
    keyboardType: TextInputType.text,
    decoration: BoxDecoration(
      color: paletteE['bg'],
      border: Border.all(color: paletteE['border']!, width: 1.0),
      borderRadius: BorderRadius.circular(10.0),
    ),
  );

  final recipePasswordField = CupertinoTextField(
    controller: ctrlRecipePassword,
    placeholder: 'Password',
    obscureText: true,
    prefix: Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Icon(
        CupertinoIcons.lock_fill,
        color: paletteE['accent'],
        size: 18.0,
      ),
    ),
    prefixMode: OverlayVisibilityMode.always,
    suffix: Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Icon(
        CupertinoIcons.eye_solid,
        color: paletteE['accent'],
        size: 18.0,
      ),
    ),
    suffixMode: OverlayVisibilityMode.always,
    keyboardType: TextInputType.visiblePassword,
    decoration: BoxDecoration(
      color: paletteE['bg'],
      border: Border.all(color: paletteE['border']!, width: 1.0),
      borderRadius: BorderRadius.circular(10.0),
    ),
  );

  final recipeEmailField = CupertinoTextField(
    controller: ctrlRecipeEmail,
    placeholder: 'name@example.com',
    prefix: Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Icon(
        CupertinoIcons.envelope_fill,
        color: paletteE['accent'],
        size: 18.0,
      ),
    ),
    prefixMode: OverlayVisibilityMode.notEditing,
    suffix: Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Icon(
        CupertinoIcons.check_mark_circled_solid,
        color: Color(0xFF059669),
        size: 18.0,
      ),
    ),
    suffixMode: OverlayVisibilityMode.notEditing,
    keyboardType: TextInputType.emailAddress,
    decoration: BoxDecoration(
      color: paletteE['bg'],
      border: Border.all(color: paletteE['border']!, width: 1.0),
      borderRadius: BorderRadius.circular(10.0),
    ),
  );

  Widget buildRecipeBlock({
    required String title,
    required String prefixModeLabel,
    required String suffixModeLabel,
    required Widget field,
    required String description,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 14.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: paletteE['border']!, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: paletteE['accent'],
                ),
              ),
              SizedBox(width: 8.0),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                decoration: BoxDecoration(
                  color: paletteE['border'],
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  'prefix: $prefixModeLabel',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: CupertinoColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 6.0),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                decoration: BoxDecoration(
                  color: paletteE['accent'],
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  'suffix: $suffixModeLabel',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: CupertinoColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          field,
          SizedBox(height: 8.0),
          Text(
            description,
            style: TextStyle(
              fontSize: 12.0,
              color: paletteE['caption'],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  final sectionE = Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: paletteE['bg'],
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: paletteE['border']!, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section E · Real-world recipes',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: paletteE['accent'],
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Three production-shaped patterns. Each one uses different mode '
          'pairs to achieve a different feel.',
          style: TextStyle(fontSize: 13.0, color: paletteE['caption']),
        ),
        SizedBox(height: 14.0),
        buildRecipeBlock(
          title: 'Search bar',
          prefixModeLabel: 'always',
          suffixModeLabel: 'editing',
          field: recipeSearchField,
          description:
              'Apple\'s default pattern. The magnifying glass anchors the '
              'field, the clear button only appears while the user is '
              'actively interacting. Familiar and ergonomic.',
        ),
        buildRecipeBlock(
          title: 'Password field',
          prefixModeLabel: 'always',
          suffixModeLabel: 'always',
          field: recipePasswordField,
          description:
              'Lock icon and eye-toggle should both be reachable at all '
              'times — there\'s no point in hiding the show-password '
              'control while editing because that\'s when you need it.',
        ),
        buildRecipeBlock(
          title: 'Email field with inline validation icon',
          prefixModeLabel: 'notEditing',
          suffixModeLabel: 'notEditing',
          field: recipeEmailField,
          description:
              'While the user types, the field is uncluttered. When they '
              'leave it, both the envelope ornament and the green check '
              'reappear to confirm a valid value at a glance.',
        ),
      ],
    ),
  );

  // ============================================================================
  // SECTION F — Mode reference card
  // ============================================================================

  Widget buildReferenceTile({
    required OverlayVisibilityMode mode,
    required String description,
  }) {
    return Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: paletteF['border']!, width: 1.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 64.0,
            padding:
                EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
            decoration: BoxDecoration(
              color: paletteF['accent'],
              borderRadius: BorderRadius.circular(8.0),
            ),
            alignment: Alignment.center,
            child: Text(
              mode.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: CupertinoColors.white,
              ),
            ),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'OverlayVisibilityMode.${mode.name} · index ${mode.index}',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: paletteF['accent'],
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: paletteF['caption'],
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

  Widget buildFlowStep({
    required int step,
    required String question,
    required String yesBranch,
    required String noBranch,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: paletteF['border']!, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 22.0,
                height: 22.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: paletteF['accent'],
                  borderRadius: BorderRadius.circular(11.0),
                ),
                child: Text(
                  '$step',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: CupertinoColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  question,
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                    color: paletteF['accent'],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.0),
          Padding(
            padding: EdgeInsets.only(left: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '→ yes: $yesBranch',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: paletteF['caption'],
                  ),
                ),
                SizedBox(height: 2.0),
                Text(
                  '→ no:  $noBranch',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: paletteF['caption'],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final referenceList = CupertinoListSection.insetGrouped(
    header: Text(
      'OverlayVisibilityMode reference',
      style: TextStyle(
        fontSize: 13.0,
        fontWeight: FontWeight.bold,
        color: paletteF['accent'],
      ),
    ),
    children: <Widget>[
      CupertinoListTile(
        title: Text('always'),
        subtitle: Text('Render the slot in every state.'),
        trailing: Icon(
          CupertinoIcons.eye_solid,
          color: paletteF['accent'],
        ),
      ),
      CupertinoListTile(
        title: Text('never'),
        subtitle: Text('Suppress the slot regardless of state.'),
        trailing: Icon(
          CupertinoIcons.eye_slash,
          color: paletteF['accent'],
        ),
      ),
      CupertinoListTile(
        title: Text('editing'),
        subtitle: Text('Visible only while the field is focused.'),
        trailing: Icon(
          CupertinoIcons.pencil,
          color: paletteF['accent'],
        ),
      ),
      CupertinoListTile(
        title: Text('notEditing'),
        subtitle: Text('Visible only while the field is idle.'),
        trailing: Icon(
          CupertinoIcons.pause_circle,
          color: paletteF['accent'],
        ),
      ),
    ],
  );

  final sectionF = Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: paletteF['bg'],
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: paletteF['border']!, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section F · Mode reference card',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: paletteF['accent'],
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'A static cheat-sheet plus a decision flow you can run through '
          'when picking a mode for a new field.',
          style: TextStyle(fontSize: 13.0, color: paletteF['caption']),
        ),
        SizedBox(height: 14.0),
        buildReferenceTile(
          mode: OverlayVisibilityMode.always,
          description:
              'The slot is painted at all times. This is the right default '
              'whenever the prefix or suffix is part of the field\'s '
              'identity (search, lock, currency code, …).',
        ),
        SizedBox(height: 8.0),
        buildReferenceTile(
          mode: OverlayVisibilityMode.never,
          description:
              'The slot is reserved by API but never rendered. Useful when '
              'a parent widget toggles between modes and you want one of '
              'them to fully drop the affordance.',
        ),
        SizedBox(height: 8.0),
        buildReferenceTile(
          mode: OverlayVisibilityMode.editing,
          description:
              'The slot is rendered only while the field has focus. The '
              'canonical example is the round clear-text icon at the right '
              'edge of a search field.',
        ),
        SizedBox(height: 8.0),
        buildReferenceTile(
          mode: OverlayVisibilityMode.notEditing,
          description:
              'The slot is rendered only while the field is idle. Use it '
              'for status badges and ornaments that should not compete '
              'with the live caret while the user is typing.',
        ),
        SizedBox(height: 14.0),
        Text(
          'Decision flow',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: paletteF['accent'],
          ),
        ),
        SizedBox(height: 6.0),
        buildFlowStep(
          step: 1,
          question:
              'Should the slot ever be hidden based on user activity?',
          yesBranch: 'continue to step 2',
          noBranch: 'pick always (or never if it should never paint)',
        ),
        buildFlowStep(
          step: 2,
          question: 'Is the slot a tool the user reaches for *while* typing?',
          yesBranch: 'pick editing — show during focus',
          noBranch: 'continue to step 3',
        ),
        buildFlowStep(
          step: 3,
          question:
              'Is the slot a status hint that should rest while the caret is live?',
          yesBranch: 'pick notEditing — show only when idle',
          noBranch: 'fall back to always',
        ),
        SizedBox(height: 12.0),
        referenceList,
      ],
    ),
  );

  // ============================================================================
  // ROOT
  // ============================================================================

  return CupertinoApp(
    debugShowCheckedModeBanner: false,
    theme: CupertinoThemeData(
      brightness: Brightness.light,
      primaryColor: paletteA['accent'],
    ),
    home: CupertinoPageScaffold(
      backgroundColor: Color(0xFFF8FAFC),
      navigationBar: CupertinoNavigationBar(
        middle: Text('OverlayVisibilityMode · live demo'),
        backgroundColor: CupertinoColors.white,
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // ----- HEADER -----
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: paletteA['accent'],
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'OverlayVisibilityMode',
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.white,
                      ),
                    ),
                    SizedBox(height: 6.0),
                    Text(
                      'always · never · editing · notEditing',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Color(0xFFCBD5E1),
                      ),
                    ),
                    SizedBox(height: 14.0),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 6.0,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0x33FFFFFF),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Text(
                        'Live CupertinoTextField wiring · 6 sections',
                        style: TextStyle(
                          fontSize: 13.0,
                          color: CupertinoColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              sectionA,
              SizedBox(height: 20.0),
              sectionB,
              SizedBox(height: 20.0),
              sectionC,
              SizedBox(height: 20.0),
              sectionD,
              SizedBox(height: 20.0),
              sectionE,
              SizedBox(height: 20.0),
              sectionF,
              SizedBox(height: 24.0),
              // ----- FOOTER -----
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: Color(0xFFE2E8F0),
                    width: 1.0,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Summary',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: paletteA['accent'],
                      ),
                    ),
                    SizedBox(height: 6.0),
                    Text(
                      'OverlayVisibilityMode is a tiny enum with four values, '
                      'but it controls a high-traffic part of CupertinoTextField. '
                      'Choose always for permanent affordances, editing for '
                      'in-flight tools, notEditing for resting ornaments, and '
                      'never to fully opt a slot out.',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Color(0xFF334155),
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Keyboard hint sample: '
                      '${TextInputType.emailAddress.toString()}',
                      style: TextStyle(
                        fontSize: 11.0,
                        color: Color(0xFF64748B),
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Brightness in app: '
                      '${Brightness.light.name}',
                      style: TextStyle(
                        fontSize: 11.0,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    ),
  );
}
