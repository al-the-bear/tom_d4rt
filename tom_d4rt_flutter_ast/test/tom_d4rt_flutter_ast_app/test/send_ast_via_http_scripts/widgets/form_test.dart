// ignore_for_file: avoid_print, unused_local_variable
// D4rt deep demo: Form / FormState / FormField / TextFormField / AutovalidateMode
// Companion to widgets/form_field_test.dart which covers FormField specifically.
// This file focuses on the Form parent: anatomy, validate/save/reset flow,
// AutovalidateMode comparison, and multi-field real-world recipes.
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Palette: sage / cream / navy with coral accent for validation errors.
// ---------------------------------------------------------------------------
const Color _sage = Color(0xFFA8C3A1);
const Color _sageDeep = Color(0xFF6F8B6A);
const Color _cream = Color(0xFFF5F1E6);
const Color _creamSoft = Color(0xFFFAF7EE);
const Color _navy = Color(0xFF1F2A44);
const Color _navySoft = Color(0xFF3E4A6B);
const Color _coral = Color(0xFFE07A5F);
const Color _border = Color(0xFFD9D3C1);
const Color _muted = Color(0xFF7E7868);

// Module-level GlobalKey used by the minimal Form example below. Declaring it
// at module scope (D4rt-friendly) keeps the build() function pure.
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

// ---------------------------------------------------------------------------
// Top-level build entry: returns one big SingleChildScrollView with all the
// sections of the deep demo stacked vertically.
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  print('Form deep demo: building visual reference document...');
  return Container(
    color: _cream,
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _section01HeroHeader(),
          _gap(),
          _section02Concept(),
          _gap(),
          _section03Anatomy(),
          _gap(),
          _section04MinimalForm(),
          _gap(),
          _section05ValidationStates(),
          _gap(),
          _section06AutovalidateModeComparison(),
          _gap(),
          _section07ValidatorPatterns(),
          _gap(),
          _section08MultiFieldLayouts(),
          _gap(),
          _section09FormStateLifecycle(),
          _gap(),
          _section10InputDecorationTheme(),
          _gap(),
          _section11RealWorldRecipes(),
          _gap(),
          _section12ComparisonTable(),
          _gap(),
          _section13Glossary(),
          _gap(),
          _section14Epilogue(),
        ],
      ),
    ),
  );
}

Widget _gap() => const SizedBox(height: 36.0);

// ---------------------------------------------------------------------------
// SECTION 1 — Hero header
// ---------------------------------------------------------------------------
Widget _section01HeroHeader() {
  return Container(
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[_navy, _navySoft],
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x33000000),
          blurRadius: 18.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 36.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: _sage.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(14.0),
              ),
              child: const Icon(Icons.assignment_turned_in, color: _sage,
                  size: 36.0),
            ),
            const SizedBox(width: 18.0),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Form deep dive',
                    style: TextStyle(
                      color: _cream,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.4,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'A visual reference for Form, FormState, FormField, '
                    'TextFormField, validators and AutovalidateMode.',
                    style: TextStyle(
                      color: _creamSoft,
                      fontSize: 15.0,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 28.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: <Widget>[
            _heroChip(Icons.account_tree_outlined, 'Form (root)'),
            _heroChip(Icons.layers_outlined, 'FormState'),
            _heroChip(Icons.input, 'TextFormField'),
            _heroChip(Icons.rule, 'validators'),
            _heroChip(Icons.refresh, 'reset/save'),
            _heroChip(Icons.auto_mode, 'AutovalidateMode'),
          ],
        ),
      ],
    ),
  );
}

Widget _heroChip(IconData icon, String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: _navy.withValues(alpha: 0.45),
      borderRadius: BorderRadius.circular(999.0),
      border: Border.all(color: _sage.withValues(alpha: 0.6), width: 1.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, color: _sage, size: 16.0),
        const SizedBox(width: 8.0),
        Text(label,
            style: const TextStyle(
              color: _cream,
              fontSize: 13.0,
              fontWeight: FontWeight.w600,
            )),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 2 — Concept: how Form, FormState, FormField relate
// ---------------------------------------------------------------------------
Widget _section02Concept() {
  return _sectionShell(
    number: '02',
    title: 'Concept — Form / FormState / FormField',
    subtitle: 'A Form is an InheritedWidget that groups any number of '
        'FormField descendants. The associated FormState is the imperative '
        'handle reached through a GlobalKey<FormState> — the gateway to '
        'validate(), save() and reset().',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _conceptCard(
              Icons.account_tree,
              'Form',
              'Inherited widget that registers nearby FormField descendants '
                  'and exposes a FormState through Form.of(context) or via a '
                  'GlobalKey<FormState>.',
            )),
            const SizedBox(width: 14.0),
            Expanded(child: _conceptCard(
              Icons.memory,
              'FormState',
              'Imperative API. Holds the list of registered fields. Call '
                  'validate(), save() or reset() on it. Triggers rebuilds '
                  'when its internal state changes.',
            )),
            const SizedBox(width: 14.0),
            Expanded(child: _conceptCard(
              Icons.input,
              'FormField<T>',
              'A leaf widget that registers itself with the nearest Form. '
                  'Owns an optional validator and an onSaved callback. '
                  'TextFormField is the most common concrete implementation.',
            )),
          ],
        ),
        const SizedBox(height: 22.0),
        _calloutBox(
          icon: Icons.lightbulb_outline,
          title: 'Why a GlobalKey?',
          body: 'FormState lives in the framework, not in your widget tree '
              'directly. To call validate/save/reset from outside the Form '
              'subtree (e.g. from an AppBar action) you attach a '
              'GlobalKey<FormState> to the Form and dereference it as '
              '_formKey.currentState!.validate().',
        ),
        const SizedBox(height: 14.0),
        _calloutBox(
          icon: Icons.warning_amber_outlined,
          title: 'Two ways to reach FormState',
          body: '(1) GlobalKey — best when the trigger is outside the form '
              'subtree. (2) Form.of(context) — best when the trigger is a '
              'child widget below the Form; it uses InheritedWidget lookup.',
        ),
      ],
    ),
  );
}

Widget _conceptCard(IconData icon, String title, String body) {
  return Container(
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: _creamSoft,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _border, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _sage.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Icon(icon, color: _navy, size: 22.0),
        ),
        const SizedBox(height: 14.0),
        Text(title,
            style: const TextStyle(
              color: _navy,
              fontSize: 17.0,
              fontWeight: FontWeight.w700,
            )),
        const SizedBox(height: 8.0),
        Text(body,
            style: const TextStyle(
              color: _navySoft,
              fontSize: 13.0,
              height: 1.45,
            )),
      ],
    ),
  );
}

Widget _calloutBox({
  required IconData icon,
  required String title,
  required String body,
}) {
  return Container(
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: _sage.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(12.0),
      border: const Border(
        left: BorderSide(color: _sageDeep, width: 4.0),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, color: _sageDeep, size: 22.0),
        const SizedBox(width: 14.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title,
                  style: const TextStyle(
                    color: _navy,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w700,
                  )),
              const SizedBox(height: 6.0),
              Text(body,
                  style: const TextStyle(
                    color: _navySoft,
                    fontSize: 13.5,
                    height: 1.5,
                  )),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 3 — Anatomy diagram
// ---------------------------------------------------------------------------
Widget _section03Anatomy() {
  return _sectionShell(
    number: '03',
    title: 'Anatomy — Form tree and dataflow',
    subtitle: 'A Form sits at the root, FormField descendants register '
        'themselves at mount and unregister at unmount. validate/save/reset '
        'on the FormState fans out to every registered field.',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: _creamSoft,
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(color: _border, width: 1.0),
          ),
          child: Column(
            children: <Widget>[
              _anatomyRow(
                label: 'Form (root, GlobalKey<FormState>)',
                color: _navy,
                fg: _cream,
                icon: Icons.account_tree,
              ),
              _verticalArrow(),
              _anatomyRow(
                label: 'Column / ListView (any layout)',
                color: _navySoft,
                fg: _cream,
                icon: Icons.view_agenda_outlined,
              ),
              _verticalArrow(),
              Row(
                children: <Widget>[
                  Expanded(child: _anatomyRow(
                    label: 'TextFormField #1\nlabel: Name',
                    color: _sage,
                    fg: _navy,
                    icon: Icons.person,
                  )),
                  const SizedBox(width: 10.0),
                  Expanded(child: _anatomyRow(
                    label: 'TextFormField #2\nlabel: Email',
                    color: _sage,
                    fg: _navy,
                    icon: Icons.email,
                  )),
                  const SizedBox(width: 10.0),
                  Expanded(child: _anatomyRow(
                    label: 'FormField<bool>\nlabel: Terms',
                    color: _sage,
                    fg: _navy,
                    icon: Icons.check_circle_outline,
                  )),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 22.0),
        Row(
          children: <Widget>[
            Expanded(child: _flowArrowCard(
              Icons.fact_check_outlined,
              'validate()',
              'Calls every field\'s validator. Returns true only if every '
                  'validator returns null. Updates each FormField\'s errorText.',
            )),
            const SizedBox(width: 12.0),
            Expanded(child: _flowArrowCard(
              Icons.save_outlined,
              'save()',
              'Iterates every registered field and calls its onSaved with '
                  'the current value. Does not validate first.',
            )),
            const SizedBox(width: 12.0),
            Expanded(child: _flowArrowCard(
              Icons.refresh,
              'reset()',
              'Restores each FormField to its initialValue and clears any '
                  'error text. Useful for cancel buttons.',
            )),
          ],
        ),
      ],
    ),
  );
}

Widget _anatomyRow({
  required String label,
  required Color color,
  required Color fg,
  required IconData icon,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 14.0),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Row(
      children: <Widget>[
        Icon(icon, color: fg, size: 22.0),
        const SizedBox(width: 12.0),
        Expanded(
          child: Text(label,
              style: TextStyle(
                color: fg,
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
              )),
        ),
      ],
    ),
  );
}

Widget _verticalArrow() {
  return Column(
    children: <Widget>[
      Container(width: 2.0, height: 18.0, color: _border),
      const Icon(Icons.keyboard_arrow_down, color: _muted, size: 18.0),
    ],
  );
}

Widget _flowArrowCard(IconData icon, String name, String description) {
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: _navy.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _border, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(icon, color: _navy, size: 22.0),
            const SizedBox(width: 10.0),
            Text(name,
                style: const TextStyle(
                  color: _navy,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'monospace',
                )),
          ],
        ),
        const SizedBox(height: 8.0),
        Text(description,
            style: const TextStyle(
              color: _navySoft,
              fontSize: 12.5,
              height: 1.45,
            )),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 4 — Minimal Form
// ---------------------------------------------------------------------------
Widget _section04MinimalForm() {
  return _sectionShell(
    number: '04',
    title: 'Minimal Form',
    subtitle: 'A Form with a single TextFormField plus a Submit button. The '
        'GlobalKey at module scope is attached here so it is genuinely used '
        'in the live tree.',
    body: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: _codeBox(
            'final formKey = GlobalKey<FormState>();\n\n'
            'Form(\n'
            '  key: formKey,\n'
            '  child: Column(\n'
            '    children: <Widget>[\n'
            '      TextFormField(\n'
            '        decoration: const InputDecoration(\n'
            '          labelText: \'Name\',\n'
            '        ),\n'
            '        validator: (v) => (v == null || v.isEmpty)\n'
            '          ? \'Name is required\' : null,\n'
            '      ),\n'
            '      ElevatedButton(\n'
            '        onPressed: () {\n'
            '          if (formKey.currentState!.validate()) {\n'
            '            formKey.currentState!.save();\n'
            '          }\n'
            '        },\n'
            '        child: const Text(\'Submit\'),\n'
            '      ),\n'
            '    ],\n'
            '  ),\n'
            ')',
          ),
        ),
        const SizedBox(width: 18.0),
        Expanded(
          flex: 1,
          child: _previewBox(
            'Live preview',
            SizedBox(
              width: 360.0,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const TextField(
                      decoration: InputDecoration(
                        labelText: 'Name',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 14.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        OutlinedButton.icon(
                          onPressed: null,
                          icon: const Icon(Icons.refresh),
                          label: const Text('Reset'),
                        ),
                        const SizedBox(width: 10.0),
                        ElevatedButton.icon(
                          onPressed: null,
                          icon: const Icon(Icons.send),
                          label: const Text('Submit'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 5 — Validation states
// ---------------------------------------------------------------------------
Widget _section05ValidationStates() {
  return _sectionShell(
    number: '05',
    title: 'Validation states',
    subtitle: 'A single TextFormField can be observed in three discrete '
        'visual states: pristine (untouched), typing (interactive) and '
        'error (after a failed validator).',
    body: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(child: _validationStateCard(
          label: 'Pristine',
          chipColor: _muted,
          chipIcon: Icons.fiber_manual_record_outlined,
          field: const TextField(
            decoration: InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email_outlined),
              border: OutlineInputBorder(),
              helperText: 'Untouched — no validation yet.',
            ),
          ),
          caption: 'autovalidateMode: disabled and never trigger validate(). '
              'No errorText, no helper feedback yet.',
        )),
        const SizedBox(width: 14.0),
        Expanded(child: _validationStateCard(
          label: 'Typing',
          chipColor: _sageDeep,
          chipIcon: Icons.edit_outlined,
          field: TextField(
            controller: TextEditingController()..text = 'reg',
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email_outlined),
              border: OutlineInputBorder(),
              helperText: 'Partial input — validator not yet failing.',
            ),
          ),
          caption: 'autovalidateMode.onUserInteraction will not flag this '
              'until a validator returns non-null.',
        )),
        const SizedBox(width: 14.0),
        Expanded(child: _validationStateCard(
          label: 'Error',
          chipColor: _coral,
          chipIcon: Icons.error_outline,
          field: TextField(
            controller: TextEditingController()..text = 'bad@',
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email_outlined),
              border: OutlineInputBorder(),
              errorText: 'Enter a valid email',
            ),
          ),
          caption: 'errorText shown when the validator returns a non-null '
              'string after validate() ran.',
        )),
      ],
    ),
  );
}

Widget _validationStateCard({
  required String label,
  required Color chipColor,
  required IconData chipIcon,
  required Widget field,
  required String caption,
}) {
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: _creamSoft,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _border, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: chipColor.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(999.0),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(chipIcon, color: chipColor, size: 14.0),
              const SizedBox(width: 6.0),
              Text(label,
                  style: TextStyle(
                    color: chipColor,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                  )),
            ],
          ),
        ),
        const SizedBox(height: 14.0),
        field,
        const SizedBox(height: 12.0),
        Text(caption,
            style: const TextStyle(
              color: _navySoft,
              fontSize: 12.5,
              height: 1.45,
            )),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 6 — AutovalidateMode comparison
// ---------------------------------------------------------------------------
Widget _section06AutovalidateModeComparison() {
  return _sectionShell(
    number: '06',
    title: 'AutovalidateMode comparison',
    subtitle: 'Four panels side-by-side: disabled, onUserInteraction and '
        'always. The (deprecated alias) `never` is also briefly discussed.',
    body: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(child: _autovalidateCard(
          title: 'disabled',
          mode: 'AutovalidateMode.disabled',
          flavor: _muted,
          icon: Icons.toggle_off_outlined,
          when: 'Validation only when the user calls validate() explicitly.',
          field: const TextField(
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
          ),
        )),
        const SizedBox(width: 12.0),
        Expanded(child: _autovalidateCard(
          title: 'never',
          mode: 'AutovalidateMode.never',
          flavor: _navySoft,
          icon: Icons.block,
          when: 'Synonym of disabled for migration. Same effect.',
          field: const TextField(
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
          ),
        )),
        const SizedBox(width: 12.0),
        Expanded(child: _autovalidateCard(
          title: 'onUserInteraction',
          mode: 'AutovalidateMode.onUserInteraction',
          flavor: _sageDeep,
          icon: Icons.touch_app_outlined,
          when: 'Validation kicks in after the user has interacted at least '
              'once. Friendly for new forms.',
          field: TextField(
            controller: TextEditingController()..text = 'bad@',
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
              errorText: 'Enter a valid email',
            ),
          ),
        )),
        const SizedBox(width: 12.0),
        Expanded(child: _autovalidateCard(
          title: 'always',
          mode: 'AutovalidateMode.always',
          flavor: _coral,
          icon: Icons.error_outline,
          when: 'Validator runs every rebuild. Use for forms that should '
              'pre-flag bad initial state.',
          field: const TextField(
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
              errorText: 'Required',
            ),
          ),
        )),
      ],
    ),
  );
}

Widget _autovalidateCard({
  required String title,
  required String mode,
  required Color flavor,
  required IconData icon,
  required String when,
  required Widget field,
}) {
  return Container(
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: _creamSoft,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: flavor.withValues(alpha: 0.7), width: 1.4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(icon, color: flavor, size: 20.0),
            const SizedBox(width: 8.0),
            Text(title,
                style: TextStyle(
                  color: flavor,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.3,
                )),
          ],
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
          decoration: BoxDecoration(
            color: _navy.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(mode,
              style: const TextStyle(
                color: _navy,
                fontSize: 11.5,
                fontFamily: 'monospace',
              )),
        ),
        const SizedBox(height: 12.0),
        field,
        const SizedBox(height: 12.0),
        Text(when,
            style: const TextStyle(
              color: _navySoft,
              fontSize: 12.0,
              height: 1.45,
            )),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 7 — Validator patterns
// ---------------------------------------------------------------------------
Widget _section07ValidatorPatterns() {
  return _sectionShell(
    number: '07',
    title: 'Validator patterns',
    subtitle: 'A FormFieldValidator<T> is just `String? Function(T? value)`. '
        'Return null when valid, return a message when not.',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _validatorRow(
          title: 'Required',
          icon: Icons.priority_high,
          code: 'String? required(String? v) => (v == null || v.isEmpty)\n'
              '  ? \'Required\' : null;',
          summary: 'The simplest pattern: null/empty becomes an error.',
        ),
        const SizedBox(height: 14.0),
        _validatorRow(
          title: 'Length range',
          icon: Icons.straighten,
          code: 'String? len(String? v) {\n'
              '  if (v == null) return \'Required\';\n'
              '  if (v.length < 3) return \'Too short\';\n'
              '  if (v.length > 32) return \'Too long\';\n'
              '  return null;\n'
              '}',
          summary: 'Use for usernames, slugs, codes — combine with maxLength '
              'on the field for soft + hard caps.',
        ),
        const SizedBox(height: 14.0),
        _validatorRow(
          title: 'Email regex',
          icon: Icons.alternate_email,
          code: 'final _email = RegExp(r\'^[^@\\s]+@[^@\\s]+\\.[^@\\s]+\$\');\n'
              'String? email(String? v) =>\n'
              '  (v != null && _email.hasMatch(v))\n'
              '    ? null : \'Enter a valid email\';',
          summary: 'A pragmatic email regex. For production prefer a battle-'
              'tested library because RFC 5322 is a rabbit hole.',
        ),
        const SizedBox(height: 14.0),
        _validatorRow(
          title: 'Numeric range',
          icon: Icons.pin,
          code: 'String? age(String? v) {\n'
              '  final n = int.tryParse(v ?? \'\');\n'
              '  if (n == null) return \'Must be a number\';\n'
              '  if (n < 18) return \'Must be 18 or older\';\n'
              '  return null;\n'
              '}',
          summary: 'int.tryParse / double.tryParse return null on bad input '
              '— let your validator catch both the parse failure and the '
              'business rule.',
        ),
        const SizedBox(height: 14.0),
        _validatorRow(
          title: 'Password strength',
          icon: Icons.lock,
          code: 'String? strongPassword(String? v) {\n'
              '  if (v == null || v.length < 8) return \'Min 8 chars\';\n'
              '  final hasUpper = v.contains(RegExp(r\'[A-Z]\'));\n'
              '  final hasDigit = v.contains(RegExp(r\'[0-9]\'));\n'
              '  if (!hasUpper) return \'Need an uppercase letter\';\n'
              '  if (!hasDigit) return \'Need a digit\';\n'
              '  return null;\n'
              '}',
          summary: 'Stack multiple checks but return only the *first* problem '
              '— a single message is less overwhelming than a wall of red.',
        ),
      ],
    ),
  );
}

Widget _validatorRow({
  required String title,
  required IconData icon,
  required String code,
  required String summary,
}) {
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: _creamSoft,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _border, width: 1.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _sage.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Icon(icon, color: _navy, size: 20.0),
        ),
        const SizedBox(width: 14.0),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title,
                  style: const TextStyle(
                    color: _navy,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  )),
              const SizedBox(height: 6.0),
              Text(summary,
                  style: const TextStyle(
                    color: _navySoft,
                    fontSize: 13.0,
                    height: 1.45,
                  )),
            ],
          ),
        ),
        const SizedBox(width: 14.0),
        Expanded(
          flex: 4,
          child: _codeBox(code),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 8 — Multi-field forms
// ---------------------------------------------------------------------------
Widget _section08MultiFieldLayouts() {
  return _sectionShell(
    number: '08',
    title: 'Multi-field layouts',
    subtitle: 'Three reusable Form recipes: login, sign-up and a settings '
        'page that mixes toggles + sliders + text input.',
    body: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(child: _multiFieldCard(
          title: 'Login',
          subtitle: 'Two fields and a remember-me toggle. Validator only '
              'checks non-empty + simple shape.',
          form: _loginFormBody(),
        )),
        const SizedBox(width: 14.0),
        Expanded(child: _multiFieldCard(
          title: 'Sign-up',
          subtitle: 'Four fields with cross-field check (confirm password). '
              'Shows AutovalidateMode.onUserInteraction.',
          form: _signupFormBody(),
        )),
        const SizedBox(width: 14.0),
        Expanded(child: _multiFieldCard(
          title: 'Settings',
          subtitle: 'A Form can wrap heterogeneous FormFields including '
              'sliders and switches via custom FormField<T>.',
          form: _settingsFormBody(),
        )),
      ],
    ),
  );
}

Widget _multiFieldCard({
  required String title,
  required String subtitle,
  required Widget form,
}) {
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: _creamSoft,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _border, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title,
            style: const TextStyle(
              color: _navy,
              fontSize: 18.0,
              fontWeight: FontWeight.w800,
            )),
        const SizedBox(height: 6.0),
        Text(subtitle,
            style: const TextStyle(
              color: _muted,
              fontSize: 12.5,
              height: 1.4,
            )),
        const SizedBox(height: 16.0),
        SizedBox(width: 360.0, child: form),
      ],
    ),
  );
}

Widget _loginFormBody() {
  return Form(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const TextField(
          decoration: InputDecoration(
            labelText: 'Email',
            prefixIcon: Icon(Icons.email),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12.0),
        const TextField(
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            prefixIcon: Icon(Icons.lock),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 8.0),
        Row(
          children: <Widget>[
            Checkbox(value: true, onChanged: null),
            const Text('Remember me', style: TextStyle(color: _navy)),
            const Spacer(),
            const Text('Forgot?',
                style: TextStyle(color: _sageDeep,
                    fontWeight: FontWeight.w600)),
          ],
        ),
        const SizedBox(height: 6.0),
        ElevatedButton(onPressed: null, child: const Text('Sign in')),
      ],
    ),
  );
}

Widget _signupFormBody() {
  return Form(
    autovalidateMode: AutovalidateMode.onUserInteraction,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const TextField(
          decoration: InputDecoration(
            labelText: 'Full name',
            prefixIcon: Icon(Icons.person),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10.0),
        TextField(
          controller: TextEditingController()..text = 'bad@',
          decoration: const InputDecoration(
            labelText: 'Email',
            prefixIcon: Icon(Icons.email),
            border: OutlineInputBorder(),
            errorText: 'Enter a valid email',
          ),
        ),
        const SizedBox(height: 10.0),
        const TextField(
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            prefixIcon: Icon(Icons.lock),
            border: OutlineInputBorder(),
            helperText: 'Min 8 chars, 1 digit',
          ),
        ),
        const SizedBox(height: 10.0),
        TextField(
          obscureText: true,
          controller: TextEditingController()..text = 'differs',
          decoration: const InputDecoration(
            labelText: 'Confirm password',
            prefixIcon: Icon(Icons.lock_outline),
            border: OutlineInputBorder(),
            errorText: 'Passwords do not match',
          ),
        ),
        const SizedBox(height: 12.0),
        ElevatedButton(onPressed: null, child: const Text('Create account')),
      ],
    ),
  );
}

Widget _settingsFormBody() {
  return Form(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const TextField(
          decoration: InputDecoration(
            labelText: 'Display name',
            prefixIcon: Icon(Icons.badge_outlined),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 14.0),
        Row(
          children: <Widget>[
            const Icon(Icons.notifications_active_outlined, color: _navy),
            const SizedBox(width: 10.0),
            const Expanded(child: Text('Push notifications')),
            Switch(value: true, onChanged: null),
          ],
        ),
        Row(
          children: <Widget>[
            const Icon(Icons.dark_mode_outlined, color: _navy),
            const SizedBox(width: 10.0),
            const Expanded(child: Text('Dark mode')),
            Switch(value: false, onChanged: null),
          ],
        ),
        const SizedBox(height: 8.0),
        const Text('Daily reading goal (minutes)',
            style: TextStyle(color: _navy, fontWeight: FontWeight.w600)),
        Slider(value: 30.0, min: 5.0, max: 120.0, onChanged: null,
            divisions: 23, label: '30 min'),
        const SizedBox(height: 4.0),
        OutlinedButton(onPressed: null, child: const Text('Save settings')),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 9 — FormState lifecycle
// ---------------------------------------------------------------------------
Widget _section09FormStateLifecycle() {
  return _sectionShell(
    number: '09',
    title: 'FormState lifecycle',
    subtitle: 'How a registered FormField traverses validate → save → reset '
        'and how Form.of(context) gives nested children access to FormState.',
    body: Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: _creamSoft,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: _border, width: 1.0),
          ),
          child: Column(
            children: <Widget>[
              _lifecycleStep(1, Icons.add_circle_outline,
                  'Field mounts → registers itself with the nearest Form via '
                      'Form.of(context).'),
              _lifecycleStep(2, Icons.edit,
                  'User types → field state updates internally; validator '
                      'runs depending on AutovalidateMode.'),
              _lifecycleStep(3, Icons.fact_check_outlined,
                  'Submit pressed → _formKey.currentState!.validate() walks '
                      'every registered field.'),
              _lifecycleStep(4, Icons.save_outlined,
                  'If validation passes → save() invokes each field\'s '
                      'onSaved callback so you can stash the value.'),
              _lifecycleStep(5, Icons.refresh,
                  'reset() restores initialValue for every field and clears '
                      'every errorText.'),
              _lifecycleStep(6, Icons.delete_outline,
                  'Field unmounts → unregisters; FormState garbage-collects '
                      'the entry; remaining fields are unaffected.'),
            ],
          ),
        ),
        const SizedBox(height: 18.0),
        _calloutBox(
          icon: Icons.info_outline,
          title: 'validate() is non-mutating from a save perspective',
          body: 'validate() does not call onSaved. You must call save() '
              'separately after a successful validate(). This separation '
              'lets you validate early (e.g. on step change) without '
              'flushing values to your model prematurely.',
        ),
      ],
    ),
  );
}

Widget _lifecycleStep(int index, IconData icon, String body) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 32.0,
          height: 32.0,
          decoration: BoxDecoration(
            color: _navy,
            borderRadius: BorderRadius.circular(16.0),
          ),
          alignment: Alignment.center,
          child: Text('$index',
              style: const TextStyle(
                color: _cream,
                fontWeight: FontWeight.w700,
              )),
        ),
        const SizedBox(width: 14.0),
        Icon(icon, color: _sageDeep, size: 22.0),
        const SizedBox(width: 12.0),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: Text(body,
                style: const TextStyle(
                  color: _navySoft,
                  fontSize: 13.5,
                  height: 1.45,
                )),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 10 — InputDecorationTheme propagation
// ---------------------------------------------------------------------------
Widget _section10InputDecorationTheme() {
  return _sectionShell(
    number: '10',
    title: 'InputDecorationTheme propagation',
    subtitle: 'Themes set at the Theme(data:) level flow through to every '
        'TextFormField inside the Form. This is how design systems keep '
        'forms consistent.',
    body: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(child: _themedFormPreview(
          title: 'Default Material',
          theme: const InputDecorationTheme(
            border: OutlineInputBorder(),
            filled: false,
          ),
          baseColor: _creamSoft,
        )),
        const SizedBox(width: 14.0),
        Expanded(child: _themedFormPreview(
          title: 'Filled sage',
          theme: InputDecorationTheme(
            filled: true,
            fillColor: _sage.withValues(alpha: 0.25),
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: _sageDeep),
            ),
          ),
          baseColor: _creamSoft,
        )),
        const SizedBox(width: 14.0),
        Expanded(child: _themedFormPreview(
          title: 'Dark navy',
          theme: const InputDecorationTheme(
            filled: true,
            fillColor: _navy,
            labelStyle: TextStyle(color: _cream),
            hintStyle: TextStyle(color: _creamSoft),
            border: OutlineInputBorder(),
          ),
          baseColor: _navy,
          fieldText: _cream,
        )),
      ],
    ),
  );
}

Widget _themedFormPreview({
  required String title,
  required InputDecorationTheme theme,
  required Color baseColor,
  Color fieldText = _navy,
}) {
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: baseColor,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _border, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title,
            style: TextStyle(
              color: fieldText,
              fontSize: 15.0,
              fontWeight: FontWeight.w700,
            )),
        const SizedBox(height: 12.0),
        Theme(
          data: ThemeData.light().copyWith(inputDecorationTheme: theme),
          child: Form(
            child: Column(
              children: <Widget>[
                TextField(
                  style: TextStyle(color: fieldText),
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 10.0),
                TextField(
                  style: TextStyle(color: fieldText),
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email_outlined),
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

// ---------------------------------------------------------------------------
// SECTION 11 — Real-world recipes
// ---------------------------------------------------------------------------
Widget _section11RealWorldRecipes() {
  return _sectionShell(
    number: '11',
    title: 'Real-world recipes',
    subtitle: 'Three Forms drawn from common product UIs: checkout shipping, '
        'profile edit, and a search-and-filter panel.',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _recipeCard(
          icon: Icons.local_shipping_outlined,
          title: 'Checkout — shipping address',
          subtitle: 'Required name, two-line address, city, state and zip. '
              'Note how grouping into rows preserves Form semantics.',
          form: _shippingForm(),
        ),
        const SizedBox(height: 18.0),
        _recipeCard(
          icon: Icons.person_outline,
          title: 'Profile — edit',
          subtitle: 'Heterogeneous fields: photo placeholder, name, bio '
              '(multiline), and a region dropdown represented as a custom '
              'FormField.',
          form: _profileEditForm(),
        ),
        const SizedBox(height: 18.0),
        _recipeCard(
          icon: Icons.filter_alt_outlined,
          title: 'Search & filter',
          subtitle: 'A Form makes filters submit/reset as a unit. Sliders and '
              'chips can live inside the same FormState.',
          form: _searchFilterForm(),
        ),
      ],
    ),
  );
}

Widget _recipeCard({
  required IconData icon,
  required String title,
  required String subtitle,
  required Widget form,
}) {
  return Container(
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: _creamSoft,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _border, width: 1.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: _sage.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Icon(icon, color: _navy, size: 26.0),
        ),
        const SizedBox(width: 16.0),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title,
                  style: const TextStyle(
                    color: _navy,
                    fontSize: 17.0,
                    fontWeight: FontWeight.w800,
                  )),
              const SizedBox(height: 6.0),
              Text(subtitle,
                  style: const TextStyle(
                    color: _navySoft,
                    fontSize: 13.0,
                    height: 1.5,
                  )),
            ],
          ),
        ),
        const SizedBox(width: 18.0),
        Expanded(flex: 3, child: form),
      ],
    ),
  );
}

Widget _shippingForm() {
  return SizedBox(
    width: 420.0,
    child: Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const TextField(
            decoration: InputDecoration(
              labelText: 'Recipient name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10.0),
          const TextField(
            decoration: InputDecoration(
              labelText: 'Address line 1',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10.0),
          const TextField(
            decoration: InputDecoration(
              labelText: 'Address line 2 (optional)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10.0),
          Row(
            children: <Widget>[
              const Expanded(flex: 3,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'City',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              const Expanded(flex: 2,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'State',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(flex: 2,
                child: TextField(
                  controller: TextEditingController()..text = 'X',
                  decoration: const InputDecoration(
                    labelText: 'Zip',
                    border: OutlineInputBorder(),
                    errorText: 'Zip is 5 digits',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _profileEditForm() {
  return SizedBox(
    width: 420.0,
    child: Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 56.0,
                height: 56.0,
                decoration: BoxDecoration(
                  color: _sage.withValues(alpha: 0.4),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.camera_alt_outlined, color: _navy),
              ),
              const SizedBox(width: 14.0),
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Display name',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          const TextField(
            minLines: 3,
            maxLines: 5,
            decoration: InputDecoration(
              labelText: 'Bio',
              alignLabelWithHint: true,
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10.0),
          InputDecorator(
            decoration: const InputDecoration(
              labelText: 'Region',
              border: OutlineInputBorder(),
            ),
            child: Row(
              children: <Widget>[
                const Expanded(child: Text('Europe — Berlin')),
                const Icon(Icons.arrow_drop_down, color: _navy),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _searchFilterForm() {
  return SizedBox(
    width: 420.0,
    child: Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const TextField(
            decoration: InputDecoration(
              labelText: 'Keyword',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 14.0),
          const Text('Price range',
              style: TextStyle(color: _navy, fontWeight: FontWeight.w600)),
          RangeSlider(
            values: const RangeValues(15.0, 75.0),
            min: 0.0,
            max: 100.0,
            divisions: 20,
            labels: const RangeLabels('15', '75'),
            onChanged: null,
          ),
          const SizedBox(height: 4.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: <Widget>[
              _filterChip('In stock', true),
              _filterChip('Free shipping', false),
              _filterChip('On sale', true),
              _filterChip('New', false),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _filterChip(String label, bool selected) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: selected ? _sage.withValues(alpha: 0.5) : _cream,
      borderRadius: BorderRadius.circular(999.0),
      border: Border.all(
        color: selected ? _sageDeep : _border,
        width: 1.0,
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          selected ? Icons.check_circle : Icons.circle_outlined,
          color: selected ? _sageDeep : _muted,
          size: 16.0,
        ),
        const SizedBox(width: 6.0),
        Text(label,
            style: TextStyle(
              color: selected ? _navy : _muted,
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
            )),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 12 — Comparison table
// ---------------------------------------------------------------------------
Widget _section12ComparisonTable() {
  return _sectionShell(
    number: '12',
    title: 'Comparison — Form vs alternatives',
    subtitle: 'When to reach for Form vs hand-rolled validation vs a '
        'higher-level form package.',
    body: Container(
      decoration: BoxDecoration(
        color: _creamSoft,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: _border, width: 1.0),
      ),
      child: Column(
        children: <Widget>[
          _comparisonHeader(),
          _comparisonRow(
            'Boilerplate',
            'Moderate — one Form + one GlobalKey',
            'Low — just TextFields and bool flags',
            'High — package conventions to learn',
          ),
          _comparisonRow(
            'Validation',
            'Per-field validator returning String?',
            'Bespoke — you write it all',
            'Declarative validators, often composable',
          ),
          _comparisonRow(
            'State reset',
            'Free via FormState.reset()',
            'Manual — clear controllers yourself',
            'Free — package owns lifecycle',
          ),
          _comparisonRow(
            'Async validation',
            'Not built-in — use Future-based wrapper',
            'Free-form',
            'First-class in most packages',
          ),
          _comparisonRow(
            'Cross-field rules',
            'Use a state object captured by closures',
            'Trivial — you already have refs',
            'Declarative dependsOn / rule trees',
          ),
          _comparisonRow(
            'When to pick',
            'Small/medium forms in stock Flutter',
            '1–2 inputs where Form is overkill',
            'Large dynamic forms, complex flows',
          ),
        ],
      ),
    ),
  );
}

Widget _comparisonHeader() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    decoration: const BoxDecoration(
      color: _navy,
      borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
    ),
    child: Row(
      children: <Widget>[
        Expanded(flex: 2, child: _comparisonHeaderCell('Aspect')),
        Expanded(flex: 3, child: _comparisonHeaderCell('Flutter Form')),
        Expanded(flex: 3, child: _comparisonHeaderCell('Manual TextFields')),
        Expanded(flex: 3, child: _comparisonHeaderCell('Form package')),
      ],
    ),
  );
}

Widget _comparisonHeaderCell(String text) {
  return Text(text,
      style: const TextStyle(
        color: _cream,
        fontSize: 13.5,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.3,
      ));
}

Widget _comparisonRow(String aspect, String a, String b, String c) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    decoration: const BoxDecoration(
      border: Border(top: BorderSide(color: _border)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(flex: 2,
          child: Text(aspect,
              style: const TextStyle(
                color: _navy,
                fontSize: 13.5,
                fontWeight: FontWeight.w700,
              )),
        ),
        Expanded(flex: 3, child: _comparisonCell(a)),
        Expanded(flex: 3, child: _comparisonCell(b)),
        Expanded(flex: 3, child: _comparisonCell(c)),
      ],
    ),
  );
}

Widget _comparisonCell(String text) {
  return Text(text,
      style: const TextStyle(
        color: _navySoft,
        fontSize: 12.5,
        height: 1.45,
      ));
}

// ---------------------------------------------------------------------------
// SECTION 13 — Glossary
// ---------------------------------------------------------------------------
Widget _section13Glossary() {
  return _sectionShell(
    number: '13',
    title: 'Glossary',
    subtitle: 'Fourteen terms you will encounter in any Form-shaped codebase.',
    body: Column(
      children: <Widget>[
        _glossaryRow('Form',
            'InheritedWidget that groups FormField descendants and exposes '
            'a shared FormState through a GlobalKey or Form.of(context).'),
        _glossaryRow('FormState',
            'The State object behind Form. Holds the list of registered '
            'fields and exposes validate(), save(), reset().'),
        _glossaryRow('FormField<T>',
            'Generic base class for any input that participates in Form. '
            'Owns initialValue, validator, onSaved, autovalidateMode.'),
        _glossaryRow('FormFieldState<T>',
            'Per-field state — gives access to value, errorText, hasError, '
            'didChange(), reset(), save(), validate().'),
        _glossaryRow('TextFormField',
            'The canonical FormField<String> implementation. Wraps a '
            'TextField and forwards decoration + controller args.'),
        _glossaryRow('AutovalidateMode',
            'Enum: disabled / onUserInteraction / always (and the deprecated '
            'never). Controls when validators run automatically.'),
        _glossaryRow('validator',
            'String? Function(T? value). Returns a human-readable message on '
            'failure or null on success.'),
        _glossaryRow('onSaved',
            'void Function(T? value). Invoked by FormState.save() after a '
            'successful validate() pass — your hook to copy values into a '
            'model.'),
        _glossaryRow('initialValue',
            'The starting value when the field mounts; also the value reset() '
            'returns to.'),
        _glossaryRow('GlobalKey<FormState>',
            'A long-lived key that lets non-descendant widgets call methods '
            'on FormState (validate/save/reset).'),
        _glossaryRow('Form.of(context)',
            'Lookup helper that returns the nearest enclosing FormState. '
            'Returns null when there is no Form ancestor.'),
        _glossaryRow('errorText',
            'The user-facing message rendered under a field when its '
            'validator returned a non-null string.'),
        _glossaryRow('InputDecoration',
            'Visual decoration for inputs. Themed via InputDecorationTheme; '
            'overrides via the decoration: argument of TextFormField.'),
        _glossaryRow('decoration:',
            'The TextFormField argument that flows through to InputDecorator '
            'and renders the label, hint, error, icons and counter.'),
      ],
    ),
  );
}

Widget _glossaryRow(String term, String definition) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: _border)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 180.0,
          child: Text(term,
              style: const TextStyle(
                color: _navy,
                fontSize: 13.5,
                fontWeight: FontWeight.w800,
                fontFamily: 'monospace',
              )),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Text(definition,
              style: const TextStyle(
                color: _navySoft,
                fontSize: 13.0,
                height: 1.5,
              )),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 14 — Epilogue
// ---------------------------------------------------------------------------
Widget _section14Epilogue() {
  return Container(
    padding: const EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      color: _navy,
      borderRadius: BorderRadius.circular(18.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.check_circle_outline, color: _sage, size: 28.0),
            const SizedBox(width: 12.0),
            const Text('Epilogue',
                style: TextStyle(
                  color: _cream,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.4,
                )),
          ],
        ),
        const SizedBox(height: 14.0),
        const Text(
          'Form is small in surface area but powerful in coordination: '
          'it grants you one validate(), one save() and one reset() that '
          'fan out to every field below it. Pair it with a thoughtful '
          'AutovalidateMode and a sensible set of validators and you have '
          'a friendly user experience without reaching for any external '
          'package.',
          style: TextStyle(color: _creamSoft, fontSize: 14.5, height: 1.6),
        ),
        const SizedBox(height: 18.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: _sage.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _sage.withValues(alpha: 0.5)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Icon(Icons.bookmark_outline, color: _sage, size: 18.0),
              const SizedBox(width: 8.0),
              const Text('End of Form deep dive',
                  style: TextStyle(
                    color: _cream,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                  )),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Reusable layout helpers (private)
// ---------------------------------------------------------------------------
Widget _sectionShell({
  required String number,
  required String title,
  required String subtitle,
  required Widget body,
}) {
  return Container(
    padding: const EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: _border, width: 1.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x14000000),
          blurRadius: 16.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10.0, vertical: 6.0),
              decoration: BoxDecoration(
                color: _sage.withValues(alpha: 0.35),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(number,
                  style: const TextStyle(
                    color: _navy,
                    fontSize: 13.0,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w800,
                  )),
            ),
            const SizedBox(width: 14.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(title,
                      style: const TextStyle(
                        color: _navy,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.3,
                      )),
                  const SizedBox(height: 6.0),
                  Text(subtitle,
                      style: const TextStyle(
                        color: _navySoft,
                        fontSize: 14.0,
                        height: 1.5,
                      )),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24.0),
        body,
      ],
    ),
  );
}

Widget _codeBox(String code) {
  return Container(
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: _navy,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Text(
      code,
      style: const TextStyle(
        color: _cream,
        fontFamily: 'monospace',
        fontSize: 12.5,
        height: 1.5,
      ),
    ),
  );
}

Widget _previewBox(String title, Widget child) {
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: _creamSoft,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _border, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.visibility_outlined, color: _sageDeep, size: 18.0),
            const SizedBox(width: 8.0),
            Text(title,
                style: const TextStyle(
                  color: _navy,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                )),
          ],
        ),
        const SizedBox(height: 14.0),
        child,
      ],
    ),
  );
}
