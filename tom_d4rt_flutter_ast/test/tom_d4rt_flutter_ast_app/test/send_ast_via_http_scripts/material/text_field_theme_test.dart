// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

// =============================================================================
// Visual demo: InputDecorationTheme & TextSelectionThemeData
// -----------------------------------------------------------------------------
// This script exercises the analyzer-free D4rt Flutter interpreter by walking
// the reader through every important corner of text-field theming. Each
// section pairs a small living example with a paragraph of text explaining
// why the demonstrated property matters. Read top-to-bottom; the sections get
// progressively more "real-world" until the global Theme override at the end.
// =============================================================================

dynamic build(BuildContext context) {
  return Container(
    color: const Color(0xFFF3F5F8),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildPageHeader(),
          const SizedBox(height: 32),
          _buildSection1Anatomy(),
          const SizedBox(height: 40),
          _buildSection2BorderFamily(),
          const SizedBox(height: 40),
          _buildSection3FilledFields(),
          const SizedBox(height: 40),
          _buildSection4FloatingLabel(),
          const SizedBox(height: 40),
          _buildSection5ErrorStates(),
          const SizedBox(height: 40),
          _buildSection6DenseVsComfortable(),
          const SizedBox(height: 40),
          _buildSection7PrefixSuffix(),
          const SizedBox(height: 40),
          _buildSection8HelperCounter(),
          const SizedBox(height: 40),
          _buildSection9GlobalTheme(),
          const SizedBox(height: 40),
          _buildSection10SelectionTheme(),
          const SizedBox(height: 40),
          _buildPageFooter(),
        ],
      ),
    ),
  );
}

// -----------------------------------------------------------------------------
// Page header and footer
// -----------------------------------------------------------------------------

Widget _buildPageHeader() {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFF1A237E), Color(0xFF3949AB)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Text(
          'InputDecorationTheme — Visual Walkthrough',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Ten sections, hand-authored, demonstrating how Material text fields '
          'pick up their look from a global theme — and how thoughtful theming '
          'collapses dozens of per-field overrides into a single declaration.',
          style: TextStyle(color: Colors.white70, fontSize: 14, height: 1.4),
        ),
      ],
    ),
  );
}

Widget _buildPageFooter() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.grey.shade200,
      borderRadius: BorderRadius.circular(8),
    ),
    child: const Text(
      'End of demo. Every section above is independently readable; the global '
      'theme section near the end is the punchline — it shows how one '
      'InputDecorationTheme replaces the per-field overrides used in earlier '
      'sections.',
      style: TextStyle(
        fontSize: 13,
        fontStyle: FontStyle.italic,
        color: Colors.black54,
      ),
      textAlign: TextAlign.center,
    ),
  );
}

// -----------------------------------------------------------------------------
// Shared section chrome
// -----------------------------------------------------------------------------

Widget _buildSectionTitle(String number, String title, String subtitle) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 36,
              height: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFF3949AB),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                number,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A237E),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.only(left: 48),
          child: Text(
            subtitle,
            style: const TextStyle(fontSize: 13, color: Colors.black54),
          ),
        ),
      ],
    ),
  );
}

Widget _buildExplain(String body) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 12),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFFEDE7F6),
      borderRadius: BorderRadius.circular(6),
      border: const Border(
        left: BorderSide(color: Color(0xFF673AB7), width: 4),
      ),
    ),
    child: Text(
      body,
      style: const TextStyle(fontSize: 13, height: 1.45, color: Colors.black87),
    ),
  );
}

Widget _buildCard({required Widget child}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: child,
  );
}

Widget _buildCaption(String text) {
  return Padding(
    padding: const EdgeInsets.only(top: 6),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 11,
        color: Colors.black54,
        fontStyle: FontStyle.italic,
      ),
    ),
  );
}

// =============================================================================
// SECTION 1 — Anatomy of an InputDecoration
// =============================================================================

Widget _buildSection1Anatomy() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _buildSectionTitle(
        '1',
        'Anatomy of an InputDecoration',
        'A guided tour of every visible part of a single decorated field.',
      ),
      _buildExplain(
        'An InputDecoration wraps a TextField with a recognisable set of '
        'visual slots: a label that floats, a hint that fades, helper or '
        'error text below, optional prefix and suffix slots, and a border '
        'surrounding the whole thing. The diagram below labels each slot so '
        'that the rest of this walkthrough has a shared vocabulary.',
      ),
      _buildCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildAnatomyDiagram(),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Display name',
                hintText: 'How should we greet you?',
                helperText: 'Visible whenever no error is set',
                prefixIcon: Icon(Icons.person_outline),
                suffixIcon: Icon(Icons.check_circle_outline),
                counterText: '0 / 30',
                border: OutlineInputBorder(),
              ),
            ),
            _buildCaption(
              'Every label, hint, helper and counter shown here is themable '
              'from InputDecorationTheme.',
            ),
          ],
        ),
      ),
      _buildExplain(
        'Notice how each slot can be filled independently. The label appears '
        'inside the border when empty and floats above when typing begins. '
        'helperText, counterText and errorText share the same row beneath the '
        'field — errorText replaces helperText when present.',
      ),
    ],
  );
}

Widget _buildAnatomyDiagram() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFFFFF8E1),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: const Color(0xFFFFB300)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Diagram — labelled parts',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 8),
        _diagramRow('labelText', 'Floating tag, sits in the border when empty'),
        _diagramRow('hintText', 'Placeholder inside the field, fades on focus'),
        _diagramRow('helperText', 'Subtle line under the field, advisory copy'),
        _diagramRow('errorText', 'Replaces helperText, painted in error colour'),
        _diagramRow('prefix / prefixIcon', 'Leading widget inside the border'),
        _diagramRow('suffix / suffixIcon', 'Trailing widget inside the border'),
        _diagramRow('counterText', 'Right-aligned counter under the field'),
        _diagramRow('border', 'The outline drawn around the whole decoration'),
      ],
    ),
  );
}

Widget _diagramRow(String label, String desc) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 140,
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: Color(0xFFE65100),
            ),
          ),
        ),
        Expanded(
          child: Text(
            desc,
            style: const TextStyle(fontSize: 12, color: Colors.black87),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 2 — Border family
// =============================================================================

Widget _buildSection2BorderFamily() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _buildSectionTitle(
        '2',
        'Border family: outline, underline, none',
        'Four fields side-by-side comparing every common border style.',
      ),
      _buildExplain(
        'A border is more than decoration — it communicates affordance. The '
        'thicker the line, the more it feels like a "container" to type into. '
        'A bare underline (Material baseline) is visually quieter than a full '
        'outline, while InputBorder.none yields a field that blends into the '
        'surrounding layout, useful for inline edit affordances.',
      ),
      _buildCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Comparison',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(child: _borderSample('OutlineInputBorder', _outlineField())),
                const SizedBox(width: 12),
                Expanded(child: _borderSample('OutlineInputBorder (rounded)', _outlineRoundedField())),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(child: _borderSample('UnderlineInputBorder', _underlineField())),
                const SizedBox(width: 12),
                Expanded(child: _borderSample('InputBorder.none', _borderlessField())),
              ],
            ),
          ],
        ),
      ),
      _buildExplain(
        'OutlineInputBorder is the most explicit affordance, suited for forms '
        'that read as a stack of clearly-bounded fields. UnderlineInputBorder '
        'is lighter and works well in dense data screens. InputBorder.none '
        'pairs with filled or pill-shaped fields where the affordance comes '
        'from fill colour rather than line work.',
      ),
    ],
  );
}

Widget _borderSample(String title, Widget child) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        title,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 6),
      child,
    ],
  );
}

Widget _outlineField() {
  return const TextField(
    decoration: InputDecoration(
      labelText: 'Email',
      border: OutlineInputBorder(),
    ),
  );
}

Widget _outlineRoundedField() {
  return TextField(
    decoration: InputDecoration(
      labelText: 'Email',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    ),
  );
}

Widget _underlineField() {
  return const TextField(
    decoration: InputDecoration(
      labelText: 'Email',
      border: UnderlineInputBorder(),
    ),
  );
}

Widget _borderlessField() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(6),
    ),
    child: const TextField(
      decoration: InputDecoration(
        labelText: 'Email',
        border: InputBorder.none,
      ),
    ),
  );
}

// =============================================================================
// SECTION 3 — Filled fields
// =============================================================================

Widget _buildSection3FilledFields() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _buildSectionTitle(
        '3',
        'Filled fields',
        'filled: true with different fillColors, bordered and underlined.',
      ),
      _buildExplain(
        'Setting filled to true and providing a fillColor flips the visual '
        'metaphor: the field becomes a soft tile rather than a thin outline. '
        'This is especially common in dense forms and on dark surfaces, '
        'because the fill provides instant contrast against the background.',
      ),
      _buildCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _filledRow(
              'Neutral fill + underline',
              const Color(0xFFF1F3F5),
              const UnderlineInputBorder(),
            ),
            const SizedBox(height: 14),
            _filledRow(
              'Soft blue fill + outline',
              const Color(0xFFE3F2FD),
              OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
            const SizedBox(height: 14),
            _filledRow(
              'Warm cream fill + rounded outline',
              const Color(0xFFFFF8E1),
              OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            ),
            const SizedBox(height: 14),
            _filledRow(
              'Mint fill + InputBorder.none',
              const Color(0xFFE0F2F1),
              InputBorder.none,
            ),
          ],
        ),
      ),
      _buildExplain(
        'When you remove the border entirely, the fill carries the entire '
        'affordance. Pair InputBorder.none with a fillColor that has enough '
        'contrast against the surrounding canvas — otherwise users will not '
        'recognise the area as interactive.',
      ),
    ],
  );
}

Widget _filledRow(String label, Color fill, InputBorder border) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      SizedBox(
        width: 200,
        child: Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: TextField(
          decoration: InputDecoration(
            labelText: 'Search',
            hintText: 'Type a query',
            filled: true,
            fillColor: fill,
            border: border,
            enabledBorder: border,
          ),
        ),
      ),
    ],
  );
}

// =============================================================================
// SECTION 4 — Floating label behaviour
// =============================================================================

Widget _buildSection4FloatingLabel() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _buildSectionTitle(
        '4',
        'Floating label behaviour',
        'never / auto / always — labels in empty and prefilled states.',
      ),
      _buildExplain(
        'FloatingLabelBehavior controls whether the label sits inside the '
        'field, floats above it, or never floats at all. The default (auto) '
        'mimics classic Material: inside when empty, floated once content '
        'exists. always is great for accessibility because the label remains '
        'visible even after the user starts typing. never is rare but useful '
        'when you only want a placeholder-style hint.',
      ),
      _buildCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Empty (no initialValue)',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(child: _floatingSample('never', FloatingLabelBehavior.never, null)),
                const SizedBox(width: 12),
                Expanded(child: _floatingSample('auto', FloatingLabelBehavior.auto, null)),
                const SizedBox(width: 12),
                Expanded(child: _floatingSample('always', FloatingLabelBehavior.always, null)),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Prefilled (initialValue = "Ada Lovelace")',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(child: _floatingSample('never', FloatingLabelBehavior.never, 'Ada Lovelace')),
                const SizedBox(width: 12),
                Expanded(child: _floatingSample('auto', FloatingLabelBehavior.auto, 'Ada Lovelace')),
                const SizedBox(width: 12),
                Expanded(child: _floatingSample('always', FloatingLabelBehavior.always, 'Ada Lovelace')),
              ],
            ),
          ],
        ),
      ),
      _buildExplain(
        'Compare the same FloatingLabelBehavior across the empty and '
        'prefilled rows. With never, the label disappears once content '
        'arrives — confusing for screen readers. With always, the label is '
        'persistently visible above the value, the most defensible default '
        'for forms that mix many similar fields.',
      ),
      _buildCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'floatingLabelStyle — recoloured floating label',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 8),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Project',
                labelStyle: TextStyle(color: Colors.black54),
                floatingLabelStyle: TextStyle(
                  color: Color(0xFF1B5E20),
                  fontWeight: FontWeight.bold,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: OutlineInputBorder(),
              ),
            ),
            _buildCaption(
              'labelStyle controls the resting label; floatingLabelStyle is '
              'applied once the label floats. The two styles can diverge in '
              'colour, weight or size.',
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _floatingSample(String name, FloatingLabelBehavior behavior, String? prefill) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        '.$name',
        style: const TextStyle(
          fontSize: 11,
          fontFamily: 'monospace',
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 4),
      if (prefill == null)
        TextField(
          decoration: InputDecoration(
            labelText: 'Full name',
            floatingLabelBehavior: behavior,
            border: const OutlineInputBorder(),
          ),
        )
      else
        TextFormField(
          initialValue: prefill,
          decoration: InputDecoration(
            labelText: 'Full name',
            floatingLabelBehavior: behavior,
            border: const OutlineInputBorder(),
          ),
        ),
    ],
  );
}

// =============================================================================
// SECTION 5 — Error states
// =============================================================================

Widget _buildSection5ErrorStates() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _buildSectionTitle(
        '5',
        'Error states',
        'Fields rendered with errorText to show errorBorder + errorStyle.',
      ),
      _buildExplain(
        'Validation feedback is one of the most theme-able parts of a form. '
        'Setting errorText flips the field to its error palette: errorBorder '
        'replaces the regular border, errorStyle is applied to the message '
        'beneath the field, and the floating label inherits the error '
        'colour. Themed errors keep validation looking consistent everywhere.',
      ),
      _buildCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                errorText: 'Please enter a valid email address',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                errorText: 'Must be at least 8 characters',
                errorStyle: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFB71C1C),
                ),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Confirm password',
                errorText: 'This is a longer multi-line error message that '
                    'will wrap to demonstrate errorMaxLines and how the field '
                    'expands its baseline to accommodate it.',
                errorMaxLines: 3,
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      _buildExplain(
        'errorMaxLines lets long messages wrap instead of being clipped. '
        'Without it, only the first line is shown, which is a common cause '
        'of mysterious form failures where users see a truncated explanation.',
      ),
    ],
  );
}

// =============================================================================
// SECTION 6 — Dense vs comfortable
// =============================================================================

Widget _buildSection6DenseVsComfortable() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _buildSectionTitle(
        '6',
        'Dense vs comfortable',
        'isDense and contentPadding variants — vertical rhythm in a form.',
      ),
      _buildExplain(
        'isDense compresses the field vertically. contentPadding gives finer '
        'control over the gap between text and border. Dense fields are ideal '
        'for tables and admin screens; comfortable fields are friendlier on '
        'mobile where touch targets must remain large.',
      ),
      _buildCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _paddingSample(
              'isDense: false (default)',
              const InputDecoration(
                labelText: 'Comfortable',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 14),
            _paddingSample(
              'isDense: true',
              const InputDecoration(
                labelText: 'Dense',
                isDense: true,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 14),
            _paddingSample(
              'contentPadding: EdgeInsets.all(20)',
              const InputDecoration(
                labelText: 'Roomy',
                contentPadding: EdgeInsets.all(20),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 14),
            _paddingSample(
              'contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4)',
              const InputDecoration(
                labelText: 'Ultra dense',
                contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      _buildExplain(
        'Notice how the vertical rhythm of the column changes as the padding '
        'shrinks. A consistent rhythm is more important than any single '
        'choice — the global theme section later applies one contentPadding '
        'to a whole column at once.',
      ),
    ],
  );
}

Widget _paddingSample(String title, InputDecoration decoration) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          fontFamily: 'monospace',
        ),
      ),
      const SizedBox(height: 4),
      TextField(decoration: decoration),
    ],
  );
}

// =============================================================================
// SECTION 7 — Prefix and suffix
// =============================================================================

Widget _buildSection7PrefixSuffix() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _buildSectionTitle(
        '7',
        'Prefix and suffix',
        'Icons, text, and suffixIcons used in real forms.',
      ),
      _buildExplain(
        'Prefix and suffix slots hold helpers that travel with the field. '
        'They are theme-aware: prefixIconColor and suffixIconColor in the '
        'InputDecorationTheme apply globally, so you do not have to recolour '
        'every leading icon when changing brand palettes.',
      ),
      _buildCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const TextField(
              decoration: InputDecoration(
                labelText: 'Username',
                prefixIcon: Icon(Icons.person_outline),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 14),
            const TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Price',
                prefixText: '\$ ',
                suffixText: 'USD',
                helperText: 'Enter amount in US dollars',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 14),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock_outline),
                suffixIcon: Icon(Icons.visibility_off_outlined),
                helperText: 'At least 8 characters, mix letters and numbers',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 14),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Web address',
                prefixText: 'https://',
                suffixIcon: Icon(Icons.open_in_new),
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      _buildExplain(
        'Use prefixText/suffixText for short string adornments such as units '
        'or protocols. Reserve prefixIcon/suffixIcon for actionable affordances '
        'like a clear button, password visibility toggle or external link.',
      ),
    ],
  );
}

// =============================================================================
// SECTION 8 — Helper and counter
// =============================================================================

Widget _buildSection8HelperCounter() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _buildSectionTitle(
        '8',
        'Helper and counter',
        'helperText for guidance, counterText to override the auto counter.',
      ),
      _buildExplain(
        'helperText sits beneath the field and is replaced by errorText when '
        'present. counterText overrides the automatic character counter that '
        'appears when maxLength is set. Together they let you tune the '
        'amount of supplemental information beneath every field.',
      ),
      _buildCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const TextField(
              maxLength: 80,
              decoration: InputDecoration(
                labelText: 'Bio',
                helperText: 'A short sentence about yourself',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 14),
            const TextField(
              maxLength: 80,
              decoration: InputDecoration(
                labelText: 'Bio with custom counter',
                helperText: 'A short sentence about yourself',
                counterText: 'characters remaining: 80',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 14),
            const TextField(
              maxLength: 80,
              decoration: InputDecoration(
                labelText: 'Bio with counter hidden',
                helperText: 'A short sentence about yourself',
                counterText: '',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 14),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Wrapped helper',
                helperText: 'This helper text spans more than one line to '
                    'demonstrate helperMaxLines. Provide enough room for the '
                    'guidance you actually need to give.',
                helperMaxLines: 3,
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      _buildExplain(
        'Setting counterText to an empty string hides the automatic counter '
        'entirely — handy when you want maxLength enforcement without the '
        'distracting "0/80" indicator. helperMaxLines lets long guidance '
        'wrap legibly.',
      ),
    ],
  );
}

// =============================================================================
// SECTION 9 — Global theme override
// =============================================================================

Widget _buildSection9GlobalTheme() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _buildSectionTitle(
        '9',
        'Global InputDecorationTheme',
        'The same un-themed column rendered before and after a Theme.',
      ),
      _buildExplain(
        'This is the punchline of the whole walkthrough. The column below '
        'declares four bare TextFields with no decoration overrides. On the '
        'left they fall back to Material defaults. On the right the exact '
        'same widgets are wrapped in a Theme that supplies a custom '
        'InputDecorationTheme — every field inherits the colours, padding '
        'and borders without any per-field code.',
      ),
      _buildCard(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Text(
                    'Before — no theme override',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 10),
                  _untheamedFormColumn(),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Text(
                    'After — global InputDecorationTheme',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 10),
                  Theme(
                    data: ThemeData(
                      inputDecorationTheme: _brandInputDecorationTheme(),
                    ),
                    child: _untheamedFormColumn(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      _buildExplain(
        'The "after" column did not change a single field declaration — it '
        'only changed the theme above them. This is the value proposition '
        'of InputDecorationTheme: write your form once, restyle it forever. '
        'Use it for brand palette swaps, dark-mode adaptations and '
        'compact/comfortable density toggles without touching form code.',
      ),
      _buildCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Recipe for the InputDecorationTheme used above',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 8),
            _recipeRow('filled', 'true'),
            _recipeRow('fillColor', 'Color(0xFFEDE7F6)'),
            _recipeRow('contentPadding', 'EdgeInsets.symmetric(horizontal: 14, vertical: 14)'),
            _recipeRow('labelStyle', 'TextStyle(color: Colors.black54)'),
            _recipeRow('floatingLabelStyle', 'TextStyle(color: Color(0xFF512DA8), fontWeight: bold)'),
            _recipeRow('border (rest)', 'OutlineInputBorder(radius: 12)'),
            _recipeRow('enabledBorder', 'OutlineInputBorder(B7B0D8) radius 12'),
            _recipeRow('focusedBorder', 'OutlineInputBorder(512DA8, w2) radius 12'),
          ],
        ),
      ),
    ],
  );
}

Widget _untheamedFormColumn() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      const TextField(decoration: InputDecoration(labelText: 'First name')),
      const SizedBox(height: 10),
      const TextField(decoration: InputDecoration(labelText: 'Last name')),
      const SizedBox(height: 10),
      const TextField(decoration: InputDecoration(labelText: 'Email')),
      const SizedBox(height: 10),
      const TextField(decoration: InputDecoration(labelText: 'Phone')),
    ],
  );
}

InputDecorationTheme _brandInputDecorationTheme() {
  return InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFFEDE7F6),
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
    labelStyle: const TextStyle(color: Colors.black54),
    floatingLabelStyle: const TextStyle(
      color: Color(0xFF512DA8),
      fontWeight: FontWeight.bold,
    ),
    helperStyle: const TextStyle(color: Colors.black45, fontSize: 12),
    errorStyle: const TextStyle(color: Color(0xFFB71C1C), fontSize: 12),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFFB7B0D8)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFFB7B0D8)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFF512DA8), width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFFB71C1C)),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFFB71C1C), width: 2),
    ),
  );
}

Widget _recipeRow(String prop, String val) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 160,
          child: Text(
            prop,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: Color(0xFF4527A0),
            ),
          ),
        ),
        Expanded(
          child: Text(
            val,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 10 — TextSelectionThemeData
// =============================================================================

Widget _buildSection10SelectionTheme() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _buildSectionTitle(
        '10',
        'TextSelectionThemeData',
        'cursorColor, selectionColor and selectionHandleColor in context.',
      ),
      _buildExplain(
        'Text selection has its own theme. cursorColor paints the caret, '
        'selectionColor highlights the user range, and selectionHandleColor '
        'paints the draggable lozenges on mobile. The theme below recolours '
        'all three so a brand identity carries into the smallest pixel.',
      ),
      _buildCard(
        child: Theme(
          data: ThemeData(
            textSelectionTheme: const TextSelectionThemeData(
              cursorColor: Color(0xFF00838F),
              selectionColor: Color(0xFFB2EBF2),
              selectionHandleColor: Color(0xFF006064),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                'Try selecting inside this field',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(height: 8),
              TextFormField(
                initialValue:
                    'Long-press or drag to highlight a range. The selection '
                    'fill is teal, the cursor and handles match.',
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Selectable copy',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 14),
              const SelectableText(
                'SelectableText also honours TextSelectionThemeData. '
                'Highlight this string to see the teal selection colour '
                'applied without any per-widget styling.',
                style: TextStyle(fontSize: 14, height: 1.4),
              ),
              const SizedBox(height: 10),
              _buildCaption(
                'cursorColor → caret. selectionColor → highlight fill. '
                'selectionHandleColor → drag lozenges (mobile).',
              ),
            ],
          ),
        ),
      ),
      _buildExplain(
        'Because TextSelectionThemeData lives on ThemeData, it can be scoped '
        'tightly with a Theme widget like above, or set globally on your '
        'MaterialApp\'s ThemeData so every editable field in the entire app '
        'speaks the same selection language.',
      ),
      _buildCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Same field — three different selection palettes',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 10),
            _selectionPaletteSample(
              'Default Material',
              const TextSelectionThemeData(),
            ),
            const SizedBox(height: 12),
            _selectionPaletteSample(
              'Warm coral',
              const TextSelectionThemeData(
                cursorColor: Color(0xFFE64A19),
                selectionColor: Color(0xFFFFCCBC),
                selectionHandleColor: Color(0xFFBF360C),
              ),
            ),
            const SizedBox(height: 12),
            _selectionPaletteSample(
              'Forest green',
              const TextSelectionThemeData(
                cursorColor: Color(0xFF2E7D32),
                selectionColor: Color(0xFFC8E6C9),
                selectionHandleColor: Color(0xFF1B5E20),
              ),
            ),
          ],
        ),
      ),
      _buildExplain(
        'Each row above wraps an identical SelectableText in its own Theme. '
        'Compare them side by side to see how dramatically a coordinated '
        'selection palette changes the perceived warmth of a screen, even '
        'though the underlying text and field layout are identical.',
      ),
    ],
  );
}

Widget _selectionPaletteSample(String label, TextSelectionThemeData data) {
  return Theme(
    data: ThemeData(textSelectionTheme: data),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: 140,
          child: Text(
            label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: SelectableText(
            'Highlight a few words here to see the palette in action.',
            style: TextStyle(fontSize: 13),
          ),
        ),
      ],
    ),
  );
}
