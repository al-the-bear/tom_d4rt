// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element
// D4rt test script: Deep Demo - Form Field Atelier
// A richly designed gallery exploring Form, FormField, FormState, TextFormField,
// DropdownButtonFormField, InputDecoration, InputBorder variants, AutovalidateMode,
// validator showcases, prefilled snapshots showing valid/invalid/disabled states.
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
// HELPER BUILDERS - top-level functions only (no Stateless/Stateful subclasses).
// -----------------------------------------------------------------------------

Widget _sectionHeader(String number, String title, String subtitle,
    Color background, Color border, Color accent) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12.0),
        topRight: Radius.circular(12.0),
      ),
      border: Border.all(color: border, width: 1.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 42.0,
          height: 42.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Color(0x33000000),
                blurRadius: 4.0,
                offset: Offset(0.0, 2.0),
              ),
            ],
          ),
          child: Text(
            number,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFFFFFF),
            ),
          ),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: accent,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Color(0xFF555555),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _sectionBody(Color background, Color border, List<Widget> children) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(12.0),
        bottomRight: Radius.circular(12.0),
      ),
      border: Border.all(color: border, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    ),
  );
}

Widget _captionLabel(String text, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 11.0,
        fontWeight: FontWeight.w600,
        color: color,
        letterSpacing: 0.6,
      ),
    ),
  );
}

Widget _fieldCard(Widget field, Color tint) {
  return Container(
    margin: EdgeInsets.only(bottom: 10.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: tint, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Color(0x11000000),
          blurRadius: 4.0,
          offset: Offset(0.0, 1.0),
        ),
      ],
    ),
    child: field,
  );
}

Widget _recipeCard(String title, String description, Color accent,
    List<Widget> fields) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(bottom: 12.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: accent, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Color(0x14000000),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 8.0,
              height: 24.0,
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF222222),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Text(
            description,
            style: TextStyle(
              fontSize: 12.0,
              color: Color(0xFF666666),
              height: 1.4,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0xFFFAFAFA),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Color(0xFFE0E0E0), width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: fields,
          ),
        ),
      ],
    ),
  );
}

Widget _codeQuote(String label, String code, Color accent) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(bottom: 12.0),
    decoration: BoxDecoration(
      color: Color(0xFF1E1E1E),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: accent, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(7.0),
              topRight: Radius.circular(7.0),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFFFFFF),
              letterSpacing: 0.6,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(12.0),
          child: Text(
            code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Color(0xFFE0E0E0),
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _comparisonRow(String key, String left, String right, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            key,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
              color: Color(0xFF333333),
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: color.withOpacity(0.18),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              left,
              style: TextStyle(
                fontSize: 11.0,
                fontFamily: 'monospace',
                color: Color(0xFF222222),
              ),
            ),
          ),
        ),
        SizedBox(width: 6.0),
        Expanded(
          flex: 4,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: color.withOpacity(0.32),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              right,
              style: TextStyle(
                fontSize: 11.0,
                fontFamily: 'monospace',
                color: Color(0xFF111111),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _glossaryEntry(String term, String definition, Color tint) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 4.0),
          width: 10.0,
          height: 10.0,
          decoration: BoxDecoration(
            color: tint,
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 12.0,
                color: Color(0xFF333333),
                height: 1.4,
              ),
              children: [
                TextSpan(
                  text: '$term — ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: tint,
                  ),
                ),
                TextSpan(text: definition),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _stateBadge(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
    margin: EdgeInsets.only(right: 6.0, bottom: 4.0),
    decoration: BoxDecoration(
      color: color.withOpacity(0.18),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color, width: 1.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 10.0,
        fontWeight: FontWeight.w600,
        color: color,
        letterSpacing: 0.4,
      ),
    ),
  );
}

Widget _heroChip(String label) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: Color(0x22FFFFFF),
      borderRadius: BorderRadius.circular(4.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 10.0,
      ),
    ),
  );
}

dynamic build(BuildContext context) {
  print('Form Field Atelier deep demo executing');

  // ==========================================================================
  // SECTION 1: FORM PRIMITIVES (Form, FormState, GlobalKey, autovalidate)
  // ==========================================================================
  // Palette: Indigo
  final Color s1Bg = Color(0xFFE8EAF6);
  final Color s1Border = Color(0xFF9FA8DA);
  final Color s1Accent = Color(0xFF3949AB);

  final formKeyDisabled = GlobalKey<FormState>();
  final formKeyAlways = GlobalKey<FormState>();
  final formKeyOnUser = GlobalKey<FormState>();
  final formKeyOnUnfocus = GlobalKey<FormState>();

  final primitiveFormDisabled = Form(
    key: formKeyDisabled,
    autovalidateMode: AutovalidateMode.disabled,
    child: TextFormField(
      initialValue: '',
      decoration: InputDecoration(
        labelText: 'autovalidateMode.disabled',
        hintText: 'Validation only on save()',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.shield_outlined, color: s1Accent),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Required field';
        return null;
      },
    ),
  );

  final primitiveFormAlways = Form(
    key: formKeyAlways,
    autovalidateMode: AutovalidateMode.always,
    child: TextFormField(
      initialValue: '',
      decoration: InputDecoration(
        labelText: 'autovalidateMode.always',
        hintText: 'Validates on every rebuild',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.bolt, color: s1Accent),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Required field';
        return null;
      },
    ),
  );

  final primitiveFormOnUser = Form(
    key: formKeyOnUser,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    child: TextFormField(
      initialValue: 'preset',
      decoration: InputDecoration(
        labelText: 'autovalidateMode.onUserInteraction',
        hintText: 'Awaits first user edit',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.touch_app, color: s1Accent),
      ),
      validator: (value) {
        if (value == null || value.length < 3) return 'Need at least 3 chars';
        return null;
      },
    ),
  );

  final primitiveFormOnUnfocus = Form(
    key: formKeyOnUnfocus,
    autovalidateMode: AutovalidateMode.onUnfocus,
    child: TextFormField(
      initialValue: '',
      decoration: InputDecoration(
        labelText: 'autovalidateMode.onUnfocus',
        hintText: 'Validates when field loses focus',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.center_focus_weak, color: s1Accent),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Required field';
        return null;
      },
    ),
  );

  // ==========================================================================
  // SECTION 2: TEXTFORMFIELD SPECTRUM (single line, multiline, obscured)
  // ==========================================================================
  // Palette: Teal
  final Color s2Bg = Color(0xFFE0F2F1);
  final Color s2Border = Color(0xFF80CBC4);
  final Color s2Accent = Color(0xFF00796B);

  final spectrumSingleLine = TextFormField(
    initialValue: 'Ada Lovelace',
    decoration: InputDecoration(
      labelText: 'Single-line text',
      hintText: 'maxLines: 1',
      border: OutlineInputBorder(),
      prefixIcon: Icon(Icons.short_text, color: s2Accent),
    ),
    maxLines: 1,
    keyboardType: TextInputType.text,
    textInputAction: TextInputAction.next,
  );

  final spectrumMultiLine = TextFormField(
    initialValue:
        'A multi-line text area is useful for descriptions, notes, and any long-form text content that benefits from soft-wrapping over multiple visible rows.',
    decoration: InputDecoration(
      labelText: 'Multi-line text',
      hintText: 'maxLines: 4, minLines: 2',
      border: OutlineInputBorder(),
      alignLabelWithHint: true,
      prefixIcon: Icon(Icons.notes, color: s2Accent),
    ),
    maxLines: 4,
    minLines: 2,
    keyboardType: TextInputType.multiline,
  );

  final spectrumExpands = TextFormField(
    initialValue: 'Auto-growing field — try typing several lines.',
    decoration: InputDecoration(
      labelText: 'Auto-growing field',
      hintText: 'maxLines: null',
      border: OutlineInputBorder(),
      prefixIcon: Icon(Icons.unfold_more, color: s2Accent),
    ),
    maxLines: null,
    keyboardType: TextInputType.multiline,
  );

  final spectrumObscured = TextFormField(
    initialValue: 'topsecret',
    decoration: InputDecoration(
      labelText: 'Password (obscured)',
      hintText: 'obscureText: true',
      border: OutlineInputBorder(),
      prefixIcon: Icon(Icons.lock, color: s2Accent),
      suffixIcon: Icon(Icons.visibility_off, color: s2Accent),
    ),
    obscureText: true,
    obscuringCharacter: '*',
    enableSuggestions: false,
    autocorrect: false,
  );

  final spectrumNumeric = TextFormField(
    initialValue: '42',
    decoration: InputDecoration(
      labelText: 'Numeric input',
      hintText: 'keyboardType: number',
      border: OutlineInputBorder(),
      prefixIcon: Icon(Icons.pin, color: s2Accent),
    ),
    keyboardType: TextInputType.number,
  );

  final spectrumEmail = TextFormField(
    initialValue: 'ada@analytical.engine',
    decoration: InputDecoration(
      labelText: 'Email address',
      hintText: 'keyboardType: emailAddress',
      border: OutlineInputBorder(),
      prefixIcon: Icon(Icons.alternate_email, color: s2Accent),
    ),
    keyboardType: TextInputType.emailAddress,
    autocorrect: false,
  );

  // ==========================================================================
  // SECTION 3: INPUTDECORATION WORKSHOP (label / hint / helper / counter)
  // ==========================================================================
  // Palette: Orange
  final Color s3Bg = Color(0xFFFFF3E0);
  final Color s3Border = Color(0xFFFFB74D);
  final Color s3Accent = Color(0xFFE65100);

  final decoLabel = TextFormField(
    initialValue: '',
    decoration: InputDecoration(
      labelText: 'labelText only',
      border: OutlineInputBorder(),
    ),
  );

  final decoLabelHint = TextFormField(
    initialValue: '',
    decoration: InputDecoration(
      labelText: 'Username',
      hintText: 'e.g. ada_lovelace',
      border: OutlineInputBorder(),
    ),
  );

  final decoLabelHintHelper = TextFormField(
    initialValue: '',
    decoration: InputDecoration(
      labelText: 'Username',
      hintText: 'e.g. ada_lovelace',
      helperText: '3-20 characters, lowercase letters and underscores',
      helperMaxLines: 2,
      border: OutlineInputBorder(),
    ),
  );

  final decoFullStack = TextFormField(
    initialValue: 'ada',
    decoration: InputDecoration(
      labelText: 'Username',
      labelStyle: TextStyle(color: s3Accent, fontWeight: FontWeight.w600),
      floatingLabelStyle: TextStyle(color: s3Accent),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      floatingLabelAlignment: FloatingLabelAlignment.start,
      hintText: 'pick a unique handle',
      hintStyle: TextStyle(color: Color(0xFF9E9E9E)),
      helperText: 'Visible to other users',
      helperStyle: TextStyle(color: Color(0xFF757575)),
      counterText: '3 / 20',
      counterStyle: TextStyle(color: s3Accent, fontWeight: FontWeight.w600),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      prefixIcon: Icon(Icons.person, color: s3Accent),
      filled: true,
      fillColor: Color(0xFFFFF8E1),
    ),
  );

  final decoFloatingAlwaysCenter = TextFormField(
    initialValue: 'pinned',
    decoration: InputDecoration(
      labelText: 'Centered floating label',
      labelStyle: TextStyle(color: s3Accent),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      floatingLabelAlignment: FloatingLabelAlignment.center,
      border: OutlineInputBorder(),
    ),
  );

  final decoFloatingNever = TextFormField(
    initialValue: '',
    decoration: InputDecoration(
      labelText: 'Never-floating label',
      floatingLabelBehavior: FloatingLabelBehavior.never,
      border: OutlineInputBorder(),
    ),
  );

  final decoCollapsed = TextFormField(
    initialValue: 'collapsed text',
    decoration: InputDecoration.collapsed(
      hintText: 'collapsed: no decoration, no border',
      hintStyle: TextStyle(color: Color(0xFF9E9E9E)),
    ),
  );

  // ==========================================================================
  // SECTION 4: INPUTBORDER VARIANTS (Outline / Underline / None / Custom)
  // ==========================================================================
  // Palette: Pink
  final Color s4Bg = Color(0xFFFCE4EC);
  final Color s4Border = Color(0xFFF48FB1);
  final Color s4Accent = Color(0xFFC2185B);

  final borderOutline = TextFormField(
    initialValue: 'OutlineInputBorder',
    decoration: InputDecoration(
      labelText: 'Outline (default radius)',
      border: OutlineInputBorder(),
    ),
  );

  final borderOutlineRounded = TextFormField(
    initialValue: 'rounded outline',
    decoration: InputDecoration(
      labelText: 'Outline (radius: 24)',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24.0),
        borderSide: BorderSide(color: s4Accent, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24.0),
        borderSide: BorderSide(color: s4Accent, width: 1.5),
      ),
    ),
  );

  final borderOutlineThick = TextFormField(
    initialValue: 'thick outline',
    decoration: InputDecoration(
      labelText: 'Outline (width: 3)',
      border: OutlineInputBorder(
        borderSide: BorderSide(color: s4Accent, width: 3.0),
        borderRadius: BorderRadius.circular(10.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: s4Accent, width: 3.0),
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  );

  final borderUnderline = TextFormField(
    initialValue: 'UnderlineInputBorder',
    decoration: InputDecoration(
      labelText: 'Underline (default)',
      border: UnderlineInputBorder(),
    ),
  );

  final borderUnderlineColored = TextFormField(
    initialValue: 'colored underline',
    decoration: InputDecoration(
      labelText: 'Underline (colored)',
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: s4Accent, width: 2.0),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: s4Accent, width: 2.0),
      ),
    ),
  );

  final borderNone = TextFormField(
    initialValue: 'InputBorder.none',
    decoration: InputDecoration(
      labelText: 'No border',
      border: InputBorder.none,
      filled: true,
      fillColor: Color(0xFFFCE4EC),
    ),
  );

  final borderAsymmetric = TextFormField(
    initialValue: 'asymmetric radius',
    decoration: InputDecoration(
      labelText: 'Asymmetric outline',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
        borderSide: BorderSide(color: s4Accent, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
        borderSide: BorderSide(color: s4Accent, width: 1.5),
      ),
    ),
  );

  // ==========================================================================
  // SECTION 5: PREFIX/SUFFIX ICONOGRAPHY
  // ==========================================================================
  // Palette: Blue Grey
  final Color s5Bg = Color(0xFFECEFF1);
  final Color s5Border = Color(0xFF90A4AE);
  final Color s5Accent = Color(0xFF455A64);

  final iconPrefix = TextFormField(
    initialValue: 'Search the docs',
    decoration: InputDecoration(
      labelText: 'prefixIcon',
      prefixIcon: Icon(Icons.search, color: s5Accent),
      border: OutlineInputBorder(),
    ),
  );

  final iconSuffix = TextFormField(
    initialValue: 'clearable',
    decoration: InputDecoration(
      labelText: 'suffixIcon',
      suffixIcon: Icon(Icons.cancel, color: s5Accent),
      border: OutlineInputBorder(),
    ),
  );

  final iconBoth = TextFormField(
    initialValue: 'find@example.com',
    decoration: InputDecoration(
      labelText: 'prefix + suffix icons',
      prefixIcon: Icon(Icons.alternate_email, color: s5Accent),
      suffixIcon: Icon(Icons.check_circle, color: Color(0xFF2E7D32)),
      border: OutlineInputBorder(),
    ),
  );

  final iconPrefixText = TextFormField(
    initialValue: '14.99',
    decoration: InputDecoration(
      labelText: 'prefix / suffix text',
      prefixText: '\$ ',
      suffixText: ' USD',
      prefixStyle: TextStyle(color: s5Accent, fontWeight: FontWeight.w600),
      suffixStyle: TextStyle(color: s5Accent),
      border: OutlineInputBorder(),
    ),
  );

  final iconRichPrefix = TextFormField(
    initialValue: 'github.com',
    decoration: InputDecoration(
      labelText: 'prefix widget',
      prefix: Padding(
        padding: EdgeInsets.only(right: 6.0),
        child: Text(
          'https://',
          style: TextStyle(color: s5Accent, fontWeight: FontWeight.w600),
        ),
      ),
      border: OutlineInputBorder(),
    ),
  );

  final iconConstraints = TextFormField(
    initialValue: 'compact icons',
    decoration: InputDecoration(
      labelText: 'prefixIconConstraints',
      prefixIcon: Icon(Icons.tag, color: s5Accent),
      prefixIconConstraints: BoxConstraints(minWidth: 32.0, minHeight: 32.0),
      suffixIcon: Icon(Icons.info_outline, color: s5Accent),
      suffixIconConstraints: BoxConstraints(minWidth: 32.0, minHeight: 32.0),
      border: OutlineInputBorder(),
    ),
  );

  // ==========================================================================
  // SECTION 6: HELPER / ERROR / COUNTER TEXT
  // ==========================================================================
  // Palette: Light Blue
  final Color s6Bg = Color(0xFFE1F5FE);
  final Color s6Border = Color(0xFF4FC3F7);
  final Color s6Accent = Color(0xFF0277BD);

  final helperOnly = TextFormField(
    initialValue: '',
    decoration: InputDecoration(
      labelText: 'Helper text only',
      helperText: 'We will never share your email',
      border: OutlineInputBorder(),
    ),
  );

  final errorStatic = TextFormField(
    initialValue: 'oops',
    decoration: InputDecoration(
      labelText: 'Static errorText',
      errorText: 'Forced error message (not via validator)',
      border: OutlineInputBorder(),
    ),
  );

  final counterStatic = TextFormField(
    initialValue: 'four',
    decoration: InputDecoration(
      labelText: 'counterText',
      counterText: '4 / 12',
      border: OutlineInputBorder(),
    ),
    maxLength: 12,
  );

  final counterWithMaxLength = TextFormField(
    initialValue: 'Material',
    decoration: InputDecoration(
      labelText: 'maxLength auto-counter',
      hintText: 'Up to 30 characters',
      border: OutlineInputBorder(),
    ),
    maxLength: 30,
  );

  final helperStyled = TextFormField(
    initialValue: 'styled',
    decoration: InputDecoration(
      labelText: 'helperStyle / errorStyle',
      helperText: 'Custom helper styling',
      helperStyle: TextStyle(color: s6Accent, fontStyle: FontStyle.italic),
      errorStyle: TextStyle(color: Color(0xFFD81B60)),
      border: OutlineInputBorder(),
    ),
  );

  final helperMaxLines = TextFormField(
    initialValue: '',
    decoration: InputDecoration(
      labelText: 'helperMaxLines: 3',
      helperText:
          'A long helper that intentionally wraps to multiple rows so it can describe the rules in more detail without truncation cutting off important hints.',
      helperMaxLines: 3,
      border: OutlineInputBorder(),
    ),
  );

  // ==========================================================================
  // SECTION 7: AUTOVALIDATEMODE PATTERNS (snapshots in each mode)
  // ==========================================================================
  // Palette: Purple
  final Color s7Bg = Color(0xFFF3E5F5);
  final Color s7Border = Color(0xFFCE93D8);
  final Color s7Accent = Color(0xFF7B1FA2);

  final avDisabled = TextFormField(
    initialValue: '',
    autovalidateMode: AutovalidateMode.disabled,
    decoration: InputDecoration(
      labelText: 'AutovalidateMode.disabled',
      helperText: 'No automatic validation',
      border: OutlineInputBorder(),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) return 'Required';
      return null;
    },
  );

  final avAlways = TextFormField(
    initialValue: '',
    autovalidateMode: AutovalidateMode.always,
    decoration: InputDecoration(
      labelText: 'AutovalidateMode.always',
      helperText: 'Validates on every rebuild',
      border: OutlineInputBorder(),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) return 'Required (always)';
      return null;
    },
  );

  final avOnUser = TextFormField(
    initialValue: 'ok',
    autovalidateMode: AutovalidateMode.onUserInteraction,
    decoration: InputDecoration(
      labelText: 'AutovalidateMode.onUserInteraction',
      helperText: 'Waits for first edit',
      border: OutlineInputBorder(),
    ),
    validator: (value) {
      if (value == null || value.length < 3) return 'Need 3+ chars';
      return null;
    },
  );

  final avOnUnfocus = TextFormField(
    initialValue: '',
    autovalidateMode: AutovalidateMode.onUnfocus,
    decoration: InputDecoration(
      labelText: 'AutovalidateMode.onUnfocus',
      helperText: 'Validates when focus leaves',
      border: OutlineInputBorder(),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) return 'Required (on unfocus)';
      return null;
    },
  );

  // ==========================================================================
  // SECTION 8: DROPDOWNBUTTONFORMFIELD
  // ==========================================================================
  // Palette: Green
  final Color s8Bg = Color(0xFFE8F5E9);
  final Color s8Border = Color(0xFFA5D6A7);
  final Color s8Accent = Color(0xFF2E7D32);

  final dropdownBasic = DropdownButtonFormField<String>(
    value: 'Medium',
    decoration: InputDecoration(
      labelText: 'Priority',
      border: OutlineInputBorder(),
      prefixIcon: Icon(Icons.flag_outlined, color: s8Accent),
    ),
    items: [
      DropdownMenuItem<String>(value: 'Low', child: Text('Low')),
      DropdownMenuItem<String>(value: 'Medium', child: Text('Medium')),
      DropdownMenuItem<String>(value: 'High', child: Text('High')),
      DropdownMenuItem<String>(value: 'Critical', child: Text('Critical')),
    ],
    onChanged: (value) => print('Priority: $value'),
  );

  final dropdownIconValues = DropdownButtonFormField<String>(
    value: 'flutter',
    decoration: InputDecoration(
      labelText: 'Framework',
      border: OutlineInputBorder(),
      prefixIcon: Icon(Icons.code, color: s8Accent),
    ),
    items: [
      DropdownMenuItem<String>(
        value: 'flutter',
        child: Row(
          children: [
            Icon(Icons.flutter_dash, color: s8Accent, size: 18.0),
            SizedBox(width: 8.0),
            Text('Flutter'),
          ],
        ),
      ),
      DropdownMenuItem<String>(
        value: 'react',
        child: Row(
          children: [
            Icon(Icons.code, color: s8Accent, size: 18.0),
            SizedBox(width: 8.0),
            Text('React'),
          ],
        ),
      ),
      DropdownMenuItem<String>(
        value: 'vue',
        child: Row(
          children: [
            Icon(Icons.web, color: s8Accent, size: 18.0),
            SizedBox(width: 8.0),
            Text('Vue'),
          ],
        ),
      ),
    ],
    onChanged: (value) => print('Framework: $value'),
  );

  final dropdownValidated = DropdownButtonFormField<String>(
    value: null,
    decoration: InputDecoration(
      labelText: 'Country (required)',
      hintText: 'Select a country',
      border: OutlineInputBorder(),
      prefixIcon: Icon(Icons.public, color: s8Accent),
    ),
    items: [
      DropdownMenuItem<String>(value: 'us', child: Text('United States')),
      DropdownMenuItem<String>(value: 'uk', child: Text('United Kingdom')),
      DropdownMenuItem<String>(value: 'de', child: Text('Germany')),
      DropdownMenuItem<String>(value: 'jp', child: Text('Japan')),
    ],
    onChanged: (value) => print('Country: $value'),
    validator: (value) => value == null ? 'Please select a country' : null,
  );

  final dropdownDisabled = DropdownButtonFormField<String>(
    value: 'fixed',
    decoration: InputDecoration(
      labelText: 'Locked dropdown',
      enabled: false,
      border: OutlineInputBorder(),
      prefixIcon: Icon(Icons.lock, color: Color(0xFFBDBDBD)),
    ),
    items: [
      DropdownMenuItem<String>(value: 'fixed', child: Text('Fixed selection')),
    ],
    onChanged: null,
  );

  final dropdownColored = DropdownButtonFormField<String>(
    value: 'amber',
    decoration: InputDecoration(
      labelText: 'Color palette',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      prefixIcon: Icon(Icons.palette, color: s8Accent),
    ),
    items: [
      DropdownMenuItem<String>(value: 'amber', child: Text('Amber')),
      DropdownMenuItem<String>(value: 'teal', child: Text('Teal')),
      DropdownMenuItem<String>(value: 'pink', child: Text('Pink')),
      DropdownMenuItem<String>(value: 'indigo', child: Text('Indigo')),
    ],
    onChanged: (value) => print('Palette: $value'),
    dropdownColor: Color(0xFFF1F8E9),
    iconEnabledColor: s8Accent,
  );

  // ==========================================================================
  // SECTION 9: VALIDATOR SHOWCASES (length / email / range / regex-like)
  // ==========================================================================
  // Palette: Red
  final Color s9Bg = Color(0xFFFFEBEE);
  final Color s9Border = Color(0xFFEF9A9A);
  final Color s9Accent = Color(0xFFC62828);

  final validatorRequired = TextFormField(
    initialValue: '',
    autovalidateMode: AutovalidateMode.always,
    decoration: InputDecoration(
      labelText: 'Required (non-empty)',
      border: OutlineInputBorder(),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) return 'This field is required';
      return null;
    },
  );

  final validatorMinLength = TextFormField(
    initialValue: 'ab',
    autovalidateMode: AutovalidateMode.always,
    decoration: InputDecoration(
      labelText: 'Min length (>= 3)',
      border: OutlineInputBorder(),
    ),
    validator: (value) {
      if (value == null || value.length < 3) {
        return 'Must be at least 3 characters';
      }
      return null;
    },
  );

  final validatorMaxLength = TextFormField(
    initialValue: 'this is a very long input that exceeds the limit',
    autovalidateMode: AutovalidateMode.always,
    decoration: InputDecoration(
      labelText: 'Max length (<= 20)',
      border: OutlineInputBorder(),
    ),
    validator: (value) {
      if (value != null && value.length > 20) {
        return 'Must be 20 characters or fewer';
      }
      return null;
    },
  );

  final validatorEmail = TextFormField(
    initialValue: 'not-an-email',
    autovalidateMode: AutovalidateMode.always,
    decoration: InputDecoration(
      labelText: 'Email validator',
      border: OutlineInputBorder(),
      prefixIcon: Icon(Icons.email_outlined, color: s9Accent),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) return 'Email is required';
      if (!value.contains('@') || !value.contains('.')) {
        return 'Please enter a valid email';
      }
      return null;
    },
  );

  final validatorRange = TextFormField(
    initialValue: '999',
    autovalidateMode: AutovalidateMode.always,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
      labelText: 'Range (1-100)',
      border: OutlineInputBorder(),
      prefixIcon: Icon(Icons.calculate, color: s9Accent),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) return 'Please enter a number';
      final parsed = int.tryParse(value);
      if (parsed == null) return 'Must be an integer';
      if (parsed < 1 || parsed > 100) return 'Out of range (1-100)';
      return null;
    },
  );

  final validatorPattern = TextFormField(
    initialValue: 'BAD code!',
    autovalidateMode: AutovalidateMode.always,
    decoration: InputDecoration(
      labelText: 'Lowercase letters only',
      border: OutlineInputBorder(),
      prefixIcon: Icon(Icons.text_fields, color: s9Accent),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) return 'Required';
      for (var i = 0; i < value.length; i++) {
        final c = value.codeUnitAt(i);
        if (c < 0x61 || c > 0x7A) {
          return 'Only lowercase a-z allowed';
        }
      }
      return null;
    },
  );

  final validatorCombined = TextFormField(
    initialValue: '',
    autovalidateMode: AutovalidateMode.always,
    decoration: InputDecoration(
      labelText: 'Combined rules (3-20, lowercase)',
      border: OutlineInputBorder(),
      prefixIcon: Icon(Icons.rule, color: s9Accent),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) return 'Required';
      if (value.length < 3) return 'Need at least 3 chars';
      if (value.length > 20) return 'At most 20 chars';
      for (var i = 0; i < value.length; i++) {
        final c = value.codeUnitAt(i);
        if (c < 0x61 || c > 0x7A) {
          return 'Lowercase letters only';
        }
      }
      return null;
    },
  );

  // ==========================================================================
  // SECTION 10: DISABLED / READ-ONLY STATES
  // ==========================================================================
  // Palette: Brown
  final Color s10Bg = Color(0xFFEFEBE9);
  final Color s10Border = Color(0xFFA1887F);
  final Color s10Accent = Color(0xFF5D4037);

  final stateEnabled = TextFormField(
    initialValue: 'Editable value',
    decoration: InputDecoration(
      labelText: 'enabled: true',
      border: OutlineInputBorder(),
      prefixIcon: Icon(Icons.edit, color: s10Accent),
    ),
    enabled: true,
  );

  final stateDisabled = TextFormField(
    initialValue: 'Disabled value',
    decoration: InputDecoration(
      labelText: 'enabled: false',
      border: OutlineInputBorder(),
      prefixIcon: Icon(Icons.block, color: Color(0xFFBDBDBD)),
    ),
    enabled: false,
  );

  final stateReadOnly = TextFormField(
    initialValue: 'Read-only value (focusable, not editable)',
    decoration: InputDecoration(
      labelText: 'readOnly: true',
      border: OutlineInputBorder(),
      prefixIcon: Icon(Icons.visibility, color: s10Accent),
    ),
    readOnly: true,
  );

  final stateDisabledBorder = TextFormField(
    initialValue: 'Custom disabled border',
    decoration: InputDecoration(
      labelText: 'disabledBorder',
      border: OutlineInputBorder(),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: s10Accent, width: 1.0, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(8.0),
      ),
      prefixIcon: Icon(Icons.no_encryption_gmailerrorred, color: s10Accent),
    ),
    enabled: false,
  );

  final stateAutofocus = TextFormField(
    initialValue: 'autofocus snapshot',
    decoration: InputDecoration(
      labelText: 'autofocus (snapshot)',
      border: OutlineInputBorder(),
      prefixIcon: Icon(Icons.center_focus_strong, color: s10Accent),
    ),
  );

  final stateFilled = TextFormField(
    initialValue: 'filled background',
    decoration: InputDecoration(
      labelText: 'filled + fillColor',
      filled: true,
      fillColor: Color(0xFFD7CCC8),
      border: OutlineInputBorder(),
      prefixIcon: Icon(Icons.format_color_fill, color: s10Accent),
    ),
  );

  // ==========================================================================
  // SECTION 11: COMPOSED FORM LAYOUTS (sign-up, address, checkout)
  // ==========================================================================
  // Palette: Deep Purple
  final Color s11Bg = Color(0xFFEDE7F6);
  final Color s11Border = Color(0xFFB39DDB);
  final Color s11Accent = Color(0xFF5E35B1);

  final composedKeySignup = GlobalKey<FormState>();
  final composedSignup = Form(
    key: composedKeySignup,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          initialValue: 'ada_lovelace',
          decoration: InputDecoration(
            labelText: 'Username',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.person, color: s11Accent),
          ),
          validator: (v) => (v == null || v.length < 3) ? 'Min 3 chars' : null,
        ),
        SizedBox(height: 12.0),
        TextFormField(
          initialValue: 'ada@analytical.engine',
          decoration: InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.email, color: s11Accent),
          ),
          keyboardType: TextInputType.emailAddress,
          validator: (v) =>
              (v == null || !v.contains('@')) ? 'Invalid email' : null,
        ),
        SizedBox(height: 12.0),
        TextFormField(
          initialValue: 'supersecret',
          decoration: InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.lock, color: s11Accent),
            suffixIcon: Icon(Icons.visibility_off, color: s11Accent),
          ),
          obscureText: true,
          validator: (v) =>
              (v == null || v.length < 8) ? 'Need 8+ chars' : null,
        ),
      ],
    ),
  );

  final composedKeyAddress = GlobalKey<FormState>();
  final composedAddress = Form(
    key: composedKeyAddress,
    autovalidateMode: AutovalidateMode.always,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          initialValue: '221B Baker Street',
          decoration: InputDecoration(
            labelText: 'Street',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.home, color: s11Accent),
          ),
          validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
        ),
        SizedBox(height: 12.0),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: TextFormField(
                initialValue: 'London',
                decoration: InputDecoration(
                  labelText: 'City',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => (v == null || v.isEmpty) ? 'Req.' : null,
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              flex: 1,
              child: TextFormField(
                initialValue: 'NW1',
                decoration: InputDecoration(
                  labelText: 'ZIP',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => (v == null || v.isEmpty) ? 'Req.' : null,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        DropdownButtonFormField<String>(
          value: 'uk',
          decoration: InputDecoration(
            labelText: 'Country',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.flag, color: s11Accent),
          ),
          items: [
            DropdownMenuItem<String>(value: 'uk', child: Text('United Kingdom')),
            DropdownMenuItem<String>(value: 'us', child: Text('United States')),
            DropdownMenuItem<String>(value: 'fr', child: Text('France')),
          ],
          onChanged: (v) => print('Country: $v'),
        ),
      ],
    ),
  );

  final composedKeyCheckout = GlobalKey<FormState>();
  final composedCheckout = Form(
    key: composedKeyCheckout,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          initialValue: '4242 4242 4242 4242',
          decoration: InputDecoration(
            labelText: 'Card number',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.credit_card, color: s11Accent),
          ),
          keyboardType: TextInputType.number,
          validator: (v) =>
              (v == null || v.length < 16) ? 'Card too short' : null,
        ),
        SizedBox(height: 12.0),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                initialValue: '12/29',
                decoration: InputDecoration(
                  labelText: 'Expiry',
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    (v == null || !v.contains('/')) ? 'MM/YY' : null,
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: TextFormField(
                initialValue: '123',
                decoration: InputDecoration(
                  labelText: 'CVC',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (v) =>
                    (v == null || v.length < 3) ? '3 digits' : null,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        TextFormField(
          initialValue: 'Ada Lovelace',
          decoration: InputDecoration(
            labelText: 'Name on card',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.badge, color: s11Accent),
          ),
          validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
        ),
      ],
    ),
  );

  // ==========================================================================
  // BUILD THE PAGE
  // ==========================================================================

  print('Building Form Field Atelier visual page');

  return MaterialApp(
    title: 'Form Field Atelier',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.deepPurple,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ============================================================
            // HERO HEADER
            // ============================================================
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(20.0, 32.0, 20.0, 28.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF1A237E),
                    Color(0xFF5E35B1),
                    Color(0xFFAD1457),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: Color(0x33FFFFFF),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text(
                      'Widgets - Form & FormField deep demo',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 11.0,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.0),
                  Text(
                    'Form Field Atelier',
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFFFFF),
                      height: 1.1,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    'A guided tour of Form, FormField, decoration,\n'
                    'borders, validators, and autovalidate modes.',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Color(0xFFE1BEE7),
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Wrap(
                    spacing: 6.0,
                    runSpacing: 6.0,
                    children: [
                      _heroChip('Form'),
                      _heroChip('FormField'),
                      _heroChip('TextFormField'),
                      _heroChip('DropdownButtonFormField'),
                      _heroChip('InputDecoration'),
                      _heroChip('InputBorder'),
                      _heroChip('OutlineInputBorder'),
                      _heroChip('UnderlineInputBorder'),
                      _heroChip('AutovalidateMode'),
                      _heroChip('Validators'),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.0),

            // ============================================================
            // CONCEPT OVERVIEW
            // ============================================================
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: Color(0xFFE0E0E0), width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Color(0xFF5E35B1),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Icon(Icons.menu_book,
                              color: Color(0xFFFFFFFF), size: 20.0),
                        ),
                        SizedBox(width: 12.0),
                        Text(
                          'What this demo covers',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A237E),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      'Forms anchor user-entered data in Flutter. A Form widget '
                      'groups any number of FormField descendants, owns a '
                      'FormState (reached via a GlobalKey<FormState>), and '
                      'coordinates save / reset / validate across all of them.',
                      style: TextStyle(
                        fontSize: 13.0,
                        color: Color(0xFF333333),
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'The most common FormField in practice is TextFormField, '
                      'which wraps a TextField with validator / onSaved hooks. '
                      'DropdownButtonFormField extends this pattern to picker '
                      'fields, and any custom FormField<T> can plug into the '
                      'same lifecycle by exposing builder + initialValue.',
                      style: TextStyle(
                        fontSize: 13.0,
                        color: Color(0xFF333333),
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20.0),

            // ============================================================
            // SECTION 1: Form primitives
            // ============================================================
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  _sectionHeader('1', 'Form primitives',
                      'Form, FormState, GlobalKey, autovalidate axis',
                      s1Bg, s1Border, s1Accent),
                  _sectionBody(Color(0xFFFFFFFF), s1Border, [
                    _captionLabel('AUTOVALIDATEMODE.DISABLED', s1Accent),
                    _fieldCard(primitiveFormDisabled, s1Border),
                    _captionLabel('AUTOVALIDATEMODE.ALWAYS', s1Accent),
                    _fieldCard(primitiveFormAlways, s1Border),
                    _captionLabel('AUTOVALIDATEMODE.ONUSERINTERACTION', s1Accent),
                    _fieldCard(primitiveFormOnUser, s1Border),
                    _captionLabel('AUTOVALIDATEMODE.ONUNFOCUS', s1Accent),
                    _fieldCard(primitiveFormOnUnfocus, s1Border),
                    _codeQuote(
                        'RECIPE: declaring a Form with a state key',
                        'final formKey = GlobalKey<FormState>();\n'
                            'Form(\n'
                            '  key: formKey,\n'
                            '  autovalidateMode: AutovalidateMode.onUserInteraction,\n'
                            '  child: Column(children: [\n'
                            '    TextFormField(...),\n'
                            '    TextFormField(...),\n'
                            '  ]),\n'
                            ');\n'
                            '// later: formKey.currentState!.validate();',
                        s1Accent),
                  ]),
                ],
              ),
            ),

            SizedBox(height: 20.0),

            // ============================================================
            // SECTION 2: TextFormField spectrum
            // ============================================================
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  _sectionHeader('2', 'TextFormField spectrum',
                      'Single-line, multi-line, expanding, obscured, typed',
                      s2Bg, s2Border, s2Accent),
                  _sectionBody(Color(0xFFFFFFFF), s2Border, [
                    _captionLabel('SINGLE-LINE (maxLines: 1)', s2Accent),
                    _fieldCard(spectrumSingleLine, s2Border),
                    _captionLabel('MULTI-LINE (maxLines: 4, minLines: 2)',
                        s2Accent),
                    _fieldCard(spectrumMultiLine, s2Border),
                    _captionLabel('AUTO-GROWING (maxLines: null)', s2Accent),
                    _fieldCard(spectrumExpands, s2Border),
                    _captionLabel('OBSCURED (obscureText: true)', s2Accent),
                    _fieldCard(spectrumObscured, s2Border),
                    _captionLabel('NUMERIC (keyboardType: number)', s2Accent),
                    _fieldCard(spectrumNumeric, s2Border),
                    _captionLabel('EMAIL (keyboardType: emailAddress)',
                        s2Accent),
                    _fieldCard(spectrumEmail, s2Border),
                  ]),
                ],
              ),
            ),

            SizedBox(height: 20.0),

            // ============================================================
            // SECTION 3: InputDecoration workshop
            // ============================================================
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  _sectionHeader('3', 'InputDecoration workshop',
                      'label / hint / helper / counter / floating behavior',
                      s3Bg, s3Border, s3Accent),
                  _sectionBody(Color(0xFFFFFFFF), s3Border, [
                    _captionLabel('LABEL ONLY', s3Accent),
                    _fieldCard(decoLabel, s3Border),
                    _captionLabel('LABEL + HINT', s3Accent),
                    _fieldCard(decoLabelHint, s3Border),
                    _captionLabel('LABEL + HINT + HELPER', s3Accent),
                    _fieldCard(decoLabelHintHelper, s3Border),
                    _captionLabel('FULL STACK (styled, filled, counter)',
                        s3Accent),
                    _fieldCard(decoFullStack, s3Border),
                    _captionLabel('FLOATING ALWAYS / CENTER', s3Accent),
                    _fieldCard(decoFloatingAlwaysCenter, s3Border),
                    _captionLabel('FLOATING NEVER', s3Accent),
                    _fieldCard(decoFloatingNever, s3Border),
                    _captionLabel('INPUTDECORATION.COLLAPSED', s3Accent),
                    _fieldCard(decoCollapsed, s3Border),
                  ]),
                ],
              ),
            ),

            SizedBox(height: 20.0),

            // ============================================================
            // SECTION 4: InputBorder variants
            // ============================================================
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  _sectionHeader('4', 'InputBorder variants',
                      'OutlineInputBorder, UnderlineInputBorder, none, custom',
                      s4Bg, s4Border, s4Accent),
                  _sectionBody(Color(0xFFFFFFFF), s4Border, [
                    _captionLabel('OUTLINE (DEFAULT)', s4Accent),
                    _fieldCard(borderOutline, s4Border),
                    _captionLabel('OUTLINE (rounded 24)', s4Accent),
                    _fieldCard(borderOutlineRounded, s4Border),
                    _captionLabel('OUTLINE (thick 3px)', s4Accent),
                    _fieldCard(borderOutlineThick, s4Border),
                    _captionLabel('UNDERLINE (DEFAULT)', s4Accent),
                    _fieldCard(borderUnderline, s4Border),
                    _captionLabel('UNDERLINE (colored 2px)', s4Accent),
                    _fieldCard(borderUnderlineColored, s4Border),
                    _captionLabel('INPUTBORDER.NONE', s4Accent),
                    _fieldCard(borderNone, s4Border),
                    _captionLabel('ASYMMETRIC RADII', s4Accent),
                    _fieldCard(borderAsymmetric, s4Border),
                  ]),
                ],
              ),
            ),

            SizedBox(height: 20.0),

            // ============================================================
            // SECTION 5: Prefix/Suffix iconography
            // ============================================================
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  _sectionHeader('5', 'Prefix / suffix iconography',
                      'prefixIcon, suffixIcon, prefixText, prefix widget',
                      s5Bg, s5Border, s5Accent),
                  _sectionBody(Color(0xFFFFFFFF), s5Border, [
                    _captionLabel('PREFIX ICON', s5Accent),
                    _fieldCard(iconPrefix, s5Border),
                    _captionLabel('SUFFIX ICON', s5Accent),
                    _fieldCard(iconSuffix, s5Border),
                    _captionLabel('BOTH', s5Accent),
                    _fieldCard(iconBoth, s5Border),
                    _captionLabel('PREFIX / SUFFIX TEXT', s5Accent),
                    _fieldCard(iconPrefixText, s5Border),
                    _captionLabel('RICH PREFIX WIDGET', s5Accent),
                    _fieldCard(iconRichPrefix, s5Border),
                    _captionLabel('ICON CONSTRAINTS', s5Accent),
                    _fieldCard(iconConstraints, s5Border),
                  ]),
                ],
              ),
            ),

            SizedBox(height: 20.0),

            // ============================================================
            // SECTION 6: helper / error / counter text
            // ============================================================
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  _sectionHeader('6', 'helper / error / counter text',
                      'Static helper, forced error, character counters',
                      s6Bg, s6Border, s6Accent),
                  _sectionBody(Color(0xFFFFFFFF), s6Border, [
                    _captionLabel('HELPER ONLY', s6Accent),
                    _fieldCard(helperOnly, s6Border),
                    _captionLabel('FORCED ERROR (errorText)', s6Accent),
                    _fieldCard(errorStatic, s6Border),
                    _captionLabel('STATIC COUNTER', s6Accent),
                    _fieldCard(counterStatic, s6Border),
                    _captionLabel('AUTO COUNTER (maxLength: 30)', s6Accent),
                    _fieldCard(counterWithMaxLength, s6Border),
                    _captionLabel('STYLED HELPER / ERROR', s6Accent),
                    _fieldCard(helperStyled, s6Border),
                    _captionLabel('HELPER MAXLINES: 3', s6Accent),
                    _fieldCard(helperMaxLines, s6Border),
                  ]),
                ],
              ),
            ),

            SizedBox(height: 20.0),

            // ============================================================
            // SECTION 7: AutovalidateMode patterns
            // ============================================================
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  _sectionHeader('7', 'AutovalidateMode patterns',
                      'disabled / always / onUserInteraction / onUnfocus',
                      s7Bg, s7Border, s7Accent),
                  _sectionBody(Color(0xFFFFFFFF), s7Border, [
                    _captionLabel('DISABLED', s7Accent),
                    _fieldCard(avDisabled, s7Border),
                    _captionLabel('ALWAYS (error shows immediately)', s7Accent),
                    _fieldCard(avAlways, s7Border),
                    _captionLabel('ON USER INTERACTION', s7Accent),
                    _fieldCard(avOnUser, s7Border),
                    _captionLabel('ON UNFOCUS', s7Accent),
                    _fieldCard(avOnUnfocus, s7Border),
                    SizedBox(height: 8.0),
                    Container(
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFF3E5F5),
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: s7Border, width: 1.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'AutovalidateMode comparison',
                            style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                              color: s7Accent,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          _comparisonRow('disabled', 'manual validate()',
                              'no auto check', s7Accent),
                          _comparisonRow('always', 'rebuild = revalidate',
                              'errors persist', s7Accent),
                          _comparisonRow('onUserInteraction', 'waits for edit',
                              'no flash on load', s7Accent),
                          _comparisonRow('onUnfocus', 'after focus leaves',
                              'gentle UX', s7Accent),
                        ],
                      ),
                    ),
                  ]),
                ],
              ),
            ),

            SizedBox(height: 20.0),

            // ============================================================
            // SECTION 8: DropdownButtonFormField
            // ============================================================
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  _sectionHeader('8', 'DropdownButtonFormField',
                      'Single-select picker as a first-class FormField',
                      s8Bg, s8Border, s8Accent),
                  _sectionBody(Color(0xFFFFFFFF), s8Border, [
                    _captionLabel('BASIC', s8Accent),
                    _fieldCard(dropdownBasic, s8Border),
                    _captionLabel('ICONIC ITEMS', s8Accent),
                    _fieldCard(dropdownIconValues, s8Border),
                    _captionLabel('VALIDATED (no initial value)', s8Accent),
                    _fieldCard(dropdownValidated, s8Border),
                    _captionLabel('DISABLED', s8Accent),
                    _fieldCard(dropdownDisabled, s8Border),
                    _captionLabel('THEMED (dropdownColor, iconEnabledColor)',
                        s8Accent),
                    _fieldCard(dropdownColored, s8Border),
                  ]),
                ],
              ),
            ),

            SizedBox(height: 20.0),

            // ============================================================
            // SECTION 9: Validator showcases
            // ============================================================
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  _sectionHeader('9', 'Validator showcases',
                      'Required, length, email, range, pattern, combined',
                      s9Bg, s9Border, s9Accent),
                  _sectionBody(Color(0xFFFFFFFF), s9Border, [
                    _captionLabel('REQUIRED (empty -> error)', s9Accent),
                    _fieldCard(validatorRequired, s9Border),
                    _captionLabel('MIN LENGTH (>= 3)', s9Accent),
                    _fieldCard(validatorMinLength, s9Border),
                    _captionLabel('MAX LENGTH (<= 20)', s9Accent),
                    _fieldCard(validatorMaxLength, s9Border),
                    _captionLabel('EMAIL', s9Accent),
                    _fieldCard(validatorEmail, s9Border),
                    _captionLabel('NUMERIC RANGE (1-100)', s9Accent),
                    _fieldCard(validatorRange, s9Border),
                    _captionLabel('PATTERN (lowercase only)', s9Accent),
                    _fieldCard(validatorPattern, s9Border),
                    _captionLabel('COMBINED RULES', s9Accent),
                    _fieldCard(validatorCombined, s9Border),
                    _codeQuote(
                        'RECIPE: composing validator rules',
                        'String? validator(String? v) {\n'
                            "  if (v == null || v.isEmpty) return 'Required';\n"
                            "  if (v.length < 3) return 'Min 3 chars';\n"
                            "  if (v.length > 20) return 'Max 20 chars';\n"
                            '  return null; // valid\n'
                            '}',
                        s9Accent),
                  ]),
                ],
              ),
            ),

            SizedBox(height: 20.0),

            // ============================================================
            // SECTION 10: Disabled / read-only states
            // ============================================================
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  _sectionHeader('10', 'Disabled / read-only states',
                      'enabled, readOnly, disabledBorder, filled snapshots',
                      s10Bg, s10Border, s10Accent),
                  _sectionBody(Color(0xFFFFFFFF), s10Border, [
                    _captionLabel('ENABLED', s10Accent),
                    _fieldCard(stateEnabled, s10Border),
                    Wrap(
                      children: [
                        _stateBadge('editable', Color(0xFF2E7D32)),
                        _stateBadge('focusable', Color(0xFF1565C0)),
                      ],
                    ),
                    _captionLabel('DISABLED', s10Accent),
                    _fieldCard(stateDisabled, s10Border),
                    Wrap(
                      children: [
                        _stateBadge('greyed', Color(0xFF757575)),
                        _stateBadge('no focus', Color(0xFF9E9E9E)),
                      ],
                    ),
                    _captionLabel('READ-ONLY', s10Accent),
                    _fieldCard(stateReadOnly, s10Border),
                    Wrap(
                      children: [
                        _stateBadge('focusable', Color(0xFF1565C0)),
                        _stateBadge('not editable', Color(0xFFEF6C00)),
                      ],
                    ),
                    _captionLabel('CUSTOM DISABLED BORDER', s10Accent),
                    _fieldCard(stateDisabledBorder, s10Border),
                    _captionLabel('AUTOFOCUS (SNAPSHOT)', s10Accent),
                    _fieldCard(stateAutofocus, s10Border),
                    _captionLabel('FILLED + FILLCOLOR', s10Accent),
                    _fieldCard(stateFilled, s10Border),
                  ]),
                ],
              ),
            ),

            SizedBox(height: 20.0),

            // ============================================================
            // SECTION 11: Composed form layouts
            // ============================================================
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  _sectionHeader('11', 'Composed form layouts',
                      'Sign-up, address, checkout - real-world recipes',
                      s11Bg, s11Border, s11Accent),
                  _sectionBody(Color(0xFFFFFFFF), s11Border, [
                    _recipeCard(
                      'Sign-up form',
                      'Username + email + password with onUserInteraction '
                          'autovalidate. Each field is a TextFormField whose '
                          'validator returns null on success and an error '
                          'string otherwise.',
                      s11Accent,
                      [composedSignup],
                    ),
                    _recipeCard(
                      'Address form',
                      'Mixed widths via Row + Expanded, a DropdownButtonFormField '
                          'for the country, and AutovalidateMode.always so the '
                          'snapshot can show populated valid rows.',
                      s11Accent,
                      [composedAddress],
                    ),
                    _recipeCard(
                      'Checkout form',
                      'Credit-card number, expiry + CVC in a Row, name on card. '
                          'Validators here are deliberately simple - real PCI '
                          'flows defer card validation to a payment SDK.',
                      s11Accent,
                      [composedCheckout],
                    ),
                  ]),
                ],
              ),
            ),

            SizedBox(height: 20.0),

            // ============================================================
            // COMPARISON TABLE: InputBorder styles
            // ============================================================
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Color(0xFFF3E5F5),
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: Color(0xFFCE93D8), width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.compare_arrows,
                            color: Color(0xFF6A1B9A), size: 22.0),
                        SizedBox(width: 10.0),
                        Text(
                          'InputBorder variants - at a glance',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF6A1B9A),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    _comparisonRow('OutlineInputBorder', 'rounded box',
                        'classic Material', Color(0xFF6A1B9A)),
                    _comparisonRow('UnderlineInputBorder', 'single bottom line',
                        'low chrome', Color(0xFF6A1B9A)),
                    _comparisonRow('InputBorder.none', 'no chrome',
                        'pair w/ filled', Color(0xFF6A1B9A)),
                    _comparisonRow('errorBorder', 'red outline',
                        'when error active', Color(0xFF6A1B9A)),
                    _comparisonRow('focusedBorder', 'colored outline',
                        'when field has focus', Color(0xFF6A1B9A)),
                    _comparisonRow('disabledBorder', 'muted outline',
                        'when enabled: false', Color(0xFF6A1B9A)),
                    _comparisonRow('enabledBorder', 'default outline',
                        'when idle + enabled', Color(0xFF6A1B9A)),
                    _comparisonRow('focusedErrorBorder', 'red focused',
                        'error + focused combo', Color(0xFF6A1B9A)),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20.0),

            // ============================================================
            // GLOSSARY
            // ============================================================
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFDE7),
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: Color(0xFFFFF59D), width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.local_library,
                            color: Color(0xFFF57F17), size: 22.0),
                        SizedBox(width: 10.0),
                        Text(
                          'Glossary',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFF57F17),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    _glossaryEntry('Form',
                        'Container widget that groups FormFields and exposes a FormState via GlobalKey.',
                        Color(0xFF3949AB)),
                    _glossaryEntry('FormField<T>',
                        'Generic base class for fields that participate in Form lifecycle (validate / save / reset).',
                        Color(0xFF00796B)),
                    _glossaryEntry('FormState',
                        'Companion State object: validate(), save(), reset(), and listens to onChanged.',
                        Color(0xFFE65100)),
                    _glossaryEntry('TextFormField',
                        'Concrete FormField wrapping a TextField with validator / onSaved hooks.',
                        Color(0xFFC2185B)),
                    _glossaryEntry('DropdownButtonFormField',
                        'FormField variant for single-select pickers; pairs with InputDecoration.',
                        Color(0xFF2E7D32)),
                    _glossaryEntry('InputDecoration',
                        'Description of the visual shell around a field: labels, hints, borders, icons.',
                        Color(0xFF0277BD)),
                    _glossaryEntry('InputBorder',
                        'Abstract border type; OutlineInputBorder and UnderlineInputBorder are the main subclasses.',
                        Color(0xFF7B1FA2)),
                    _glossaryEntry('OutlineInputBorder',
                        'Rounded rectangular border drawn around the entire field.',
                        Color(0xFF455A64)),
                    _glossaryEntry('UnderlineInputBorder',
                        'Single line below the field; classic Material 2 style.',
                        Color(0xFF5D4037)),
                    _glossaryEntry('AutovalidateMode',
                        'Enum: disabled / always / onUserInteraction / onUnfocus.',
                        Color(0xFF512DA8)),
                    _glossaryEntry('validator',
                        'Function (T?) -> String? that returns an error message or null when valid.',
                        Color(0xFFFF8F00)),
                    _glossaryEntry('onSaved',
                        'Callback invoked when FormState.save() runs - typically copies value to a model.',
                        Color(0xFF00838F)),
                    _glossaryEntry('initialValue',
                        'Seed value for the field; visible until the user edits or onReset() fires.',
                        Color(0xFF827717)),
                    _glossaryEntry('helperText',
                        'Supportive text under the field; collapses to errorText when invalid.',
                        Color(0xFFC62828)),
                    _glossaryEntry('counterText',
                        'Bottom-right indicator; auto-populates when maxLength is set.',
                        Color(0xFF6A1B9A)),
                    _glossaryEntry('FloatingLabelBehavior',
                        'Enum: auto / always / never - controls when the label floats above.',
                        Color(0xFF1A237E)),
                  ],
                ),
              ),
            ),

            SizedBox(height: 24.0),

            // ============================================================
            // EPILOGUE
            // ============================================================
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF1A237E),
                    Color(0xFF5E35B1),
                    Color(0xFFAD1457),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.flag,
                          color: Color(0xFFFFFFFF), size: 22.0),
                      SizedBox(width: 10.0),
                      Text(
                        'Closing notes',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Form, FormField, and InputDecoration give you a complete '
                    'kit for collecting and validating user input. Anchor the '
                    'tree with a Form and a GlobalKey<FormState>, decorate each '
                    'field with InputDecoration, pick an AutovalidateMode that '
                    'matches the UX you want, and let validators return null '
                    'for success or a short message on failure.',
                    style: TextStyle(
                      color: Color(0xFFEDE7F6),
                      fontSize: 13.0,
                      height: 1.6,
                    ),
                  ),
                  SizedBox(height: 14.0),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 6.0),
                    decoration: BoxDecoration(
                      color: Color(0x33FFFFFF),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text(
                      'End of demo - 11 sections covered',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 11.0,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 40.0),
          ],
        ),
      ),
    ),
  );
}
