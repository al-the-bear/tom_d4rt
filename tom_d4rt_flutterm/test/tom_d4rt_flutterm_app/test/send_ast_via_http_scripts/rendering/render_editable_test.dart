import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget _section({
  required String title,
  required String intro,
  required Widget child,
}) {
  return Container(
    margin: const EdgeInsets.only(top: 12),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14),
      color: Colors.white,
      boxShadow: const [
        BoxShadow(
          color: Color(0x14000000),
          blurRadius: 8,
          offset: Offset(0, 3),
        ),
      ],
      border: Border.all(color: const Color(0xFFDCE4FF)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F3280),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          intro,
          style: const TextStyle(fontSize: 12, color: Color(0xFF4E5A76)),
        ),
        const SizedBox(height: 10),
        child,
      ],
    ),
  );
}

Widget _tile({required String label, required Widget child}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: const Color(0xFFF5F8FF),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color(0xFFD1DBFB)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
        ),
        const SizedBox(height: 8),
        child,
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  final plain = TextEditingController(text: 'EditableText baseline sample');
  final dense = TextEditingController(
    text: 'Dense form line with compact metrics',
  );
  final obscured = TextEditingController(text: 'PasswordLikeInput');
  final rtl = TextEditingController(text: 'مرحبا بكم في عرض RenderEditable');
  final numeric = TextEditingController(text: '4021');
  final multi = TextEditingController(
    text:
        'RenderEditable manages text layout, selection and caret rendering.\n'
        'This block is intentionally multiline for editing behavior.',
  );
  final editableController = TextEditingController(
    text:
        'Direct EditableText gives fine-grained control over selection and style.',
  );
  final editableFocus = FocusNode();

  return Theme(
    data: ThemeData(
      useMaterial3: true,
      colorSchemeSeed: const Color(0xFF2A4AB8),
      scaffoldBackgroundColor: const Color(0xFFF3F6FF),
    ),
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1F3280), Color(0xFF4166D6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'RenderEditable Deep Demo',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Visual labs for text layout, directionality, formatting, obscuring, '
                  'and direct EditableText usage in interpreter execution.',
                  style: TextStyle(fontSize: 13, color: Color(0xFFDEE6FF)),
                ),
              ],
            ),
          ),
          _section(
            title: 'Scenario 1 — Text Alignment & Density',
            intro: 'Compare comfortable and dense field presentations.',
            child: Column(
              children: [
                _tile(
                  label: 'Default alignment, spacious padding',
                  child: TextField(
                    controller: plain,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Plain editable surface',
                    ),
                  ),
                ),
                _tile(
                  label: 'Centered text with compact metrics',
                  child: TextField(
                    controller: dense,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 9,
                      ),
                      hintText: 'Dense compact form style',
                    ),
                  ),
                ),
              ],
            ),
          ),
          _section(
            title: 'Scenario 2 — Directionality & Script Coverage',
            intro:
                'RenderEditable lays out glyphs and caret according to text direction.',
            child: Column(
              children: [
                _tile(
                  label: 'LTR business input',
                  child: TextField(
                    controller: plain,
                    textDirection: TextDirection.ltr,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                _tile(
                  label: 'RTL paragraph input',
                  child: TextField(
                    controller: rtl,
                    textDirection: TextDirection.rtl,
                    maxLines: 2,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _section(
            title: 'Scenario 3 — Keyboard + Formatter Interaction',
            intro:
                'Demonstrates interpreter-side behavior for keyboard types and formatters.',
            child: Column(
              children: [
                _tile(
                  label: 'Numeric keyboard + digits only formatter',
                  child: TextField(
                    controller: numeric,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.pin_outlined),
                    ),
                  ),
                ),
                _tile(
                  label: 'Obscured text mode',
                  child: TextField(
                    controller: obscured,
                    obscureText: true,
                    obscuringCharacter: '•',
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock_outline),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _section(
            title: 'Scenario 4 — Multiline Editing Surface',
            intro:
                'A larger editable region to visualize caret travel and selection over lines.',
            child: TextField(
              controller: multi,
              maxLines: 6,
              minLines: 4,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: const Color(0xFFEAF0FF),
              ),
            ),
          ),
          _section(
            title: 'Scenario 5 — Direct EditableText Widget',
            intro:
                'This uses EditableText directly to expose the underlying RenderEditable flow.',
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF8F5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF8FD1BE)),
              ),
              child: EditableText(
                controller: editableController,
                focusNode: editableFocus,
                style: const TextStyle(fontSize: 15, color: Color(0xFF103A33)),
                cursorColor: const Color(0xFF00796B),
                backgroundCursorColor: const Color(0xFFB2DFDB),
                maxLines: 5,
                minLines: 3,
                selectionColor: const Color(0x553AAFA0),
              ),
            ),
          ),
          _section(
            title: 'Scenario 6 — Usage Guidance',
            intro:
                'Operational guidance for choosing TextField wrappers vs direct EditableText.',
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  dense: true,
                  leading: Icon(
                    Icons.fact_check_outlined,
                    color: Color(0xFF2A4AB8),
                  ),
                  title: Text(
                    'Use TextField for standard forms and Material decoration.',
                  ),
                ),
                ListTile(
                  dense: true,
                  leading: Icon(Icons.tune, color: Color(0xFF00796B)),
                  title: Text(
                    'Use EditableText when you need low-level editing control.',
                  ),
                ),
                ListTile(
                  dense: true,
                  leading: Icon(Icons.language, color: Color(0xFF8E24AA)),
                  title: Text(
                    'Validate directionality and formatter behavior visually.',
                  ),
                ),
              ],
            ),
          ),
          _section(
            title: 'Scenario 7 — Form Variants Dashboard',
            intro:
                'A compact dashboard comparing helper text, error text, and prefix/suffix combinations.',
            child: Column(
              children: [
                _tile(
                  label: 'Helper text and prefix icon',
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person_outline),
                      labelText: 'Display name',
                      helperText: 'Shown in public activity feed',
                    ),
                  ),
                ),
                _tile(
                  label: 'Error presentation',
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.warning_amber_outlined),
                      labelText: 'Email',
                      errorText: 'Email format appears invalid',
                    ),
                  ),
                ),
                _tile(
                  label: 'Suffix action affordance',
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Search query',
                      suffixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _section(
            title: 'Scenario 8 — RenderEditable Review Checklist',
            intro:
                'Field-level review points for interpreter-driven visual QA of text editing.',
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  dense: true,
                  leading: Icon(
                    Icons.check_circle_outline,
                    color: Color(0xFF2A4AB8),
                  ),
                  title: Text('Caret remains visible across all backgrounds.'),
                ),
                ListTile(
                  dense: true,
                  leading: Icon(Icons.height, color: Color(0xFF00796B)),
                  title: Text(
                    'Line height and strut style keep text readable.',
                  ),
                ),
                ListTile(
                  dense: true,
                  leading: Icon(
                    Icons.format_align_left,
                    color: Color(0xFF8E24AA),
                  ),
                  title: Text(
                    'Alignment and directionality match locale expectations.',
                  ),
                ),
                ListTile(
                  dense: true,
                  leading: Icon(Icons.keyboard, color: Color(0xFFEF6C00)),
                  title: Text(
                    'Keyboard type and formatter pairings are practical.',
                  ),
                ),
                ListTile(
                  dense: true,
                  leading: Icon(Icons.layers, color: Color(0xFF546E7A)),
                  title: Text(
                    'Decoration density does not obscure selection visuals.',
                  ),
                ),
              ],
            ),
          ),
          _section(
            title: 'Scenario 9 — Final Validation Notes',
            intro: 'Quick pass items before marking an editable demo complete.',
            child: const Column(
              children: [
                ListTile(
                  dense: true,
                  leading: Icon(Icons.done_all, color: Color(0xFF2A4AB8)),
                  title: Text(
                    'Confirm cursor, selection, and keyboard behavior together.',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Deep demo completed: RenderEditable interactions are shown across multiple '
            'visual modes with practical usage context.',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF5D6785),
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    ),
  );
}
