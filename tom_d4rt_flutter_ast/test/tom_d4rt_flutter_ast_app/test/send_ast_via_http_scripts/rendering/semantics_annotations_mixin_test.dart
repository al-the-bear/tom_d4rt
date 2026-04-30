// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

// ============================================================================
// SEMANTICS ANNOTATIONS MIXIN — Deep Demo
// ============================================================================
//
// SemanticsAnnotationsMixin is a mixin applied to RenderObjects that need
// to contribute semantic information to the accessibility tree.  It defines
// the hooks through which a render object declares its labels, hints,
// actions, flags, and other accessibility metadata that gets assembled
// into SemanticsNode instances by the framework's semantics pipeline.
//
// Key responsibilities surfaced by the mixin:
//
//   1. describeSemanticsConfiguration(SemanticsConfiguration config)
//      Called by the framework to let the render object fill a config
//      object with labels, flags, and action handlers.
//
//   2. visitChildrenForSemantics(RenderObjectVisitor visitor)
//      Controls which children participate in semantics collection,
//      enabling a subtree to be pruned or reordered for accessibility.
//
//   3. Semantics-related properties such as `isSemanticBoundary`
//      and `semanticsAnnotator` that control how nodes are merged
//      or kept separate in the final semantics tree.
//
// This demo illustrates how these pieces come together by showing how
// the Semantics widget and its friends surface accessibility metadata
// in a visual, interactive manner.
//
// Color theme : Olive (#827717) / Lime (#C5E1A5)
// Helper prefix: _sa
// ============================================================================

// ---------------------------------------------------------------------------
// Color palette
// ---------------------------------------------------------------------------
const Color _saOlive = Color(0xFF827717);
const Color _saLime = Color(0xFFC5E1A5);
const Color _saDarkOlive = Color(0xFF5C5500);
const Color _saLightLime = Color(0xFFF1F8E9);
const Color _saIvory = Color(0xFFFFFDE7);
const Color _saCharcoal = Color(0xFF263238);
const Color _saTeal = Color(0xFF00796B);
const Color _saAmber = Color(0xFFFFA000);
const Color _saCoral = Color(0xFFD32F2F);
const Color _saSky = Color(0xFF1565C0);
const Color _saGold = Color(0xFFFFD600);
const Color _saPlum = Color(0xFF7B1FA2);

// ---------------------------------------------------------------------------
// Reusable helpers
// ---------------------------------------------------------------------------

Widget _saSectionHeader(String title, {String? subtitle}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [_saOlive, _saDarkOlive],
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (subtitle != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              subtitle,
              style: const TextStyle(color: Color(0xCCFFFFFF), fontSize: 13),
            ),
          ),
      ],
    ),
  );
}

Widget _saInfoCard(String text, {Color borderColor = _saOlive}) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _saIvory,
      borderRadius: BorderRadius.circular(8),
      border: Border(left: BorderSide(color: borderColor, width: 4)),
    ),
    child: Text(
      text,
      style: const TextStyle(fontSize: 13, color: _saCharcoal, height: 1.5),
    ),
  );
}

Widget _saCodeBlock(String code) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: const Color(0xFF37474F),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      code,
      style: const TextStyle(
        fontFamily: 'monospace',
        fontSize: 12,
        color: Color(0xFFB2FF59),
        height: 1.5,
      ),
    ),
  );
}

Widget _saPropertyRow(String property, String value, IconData icon,
    {Color iconColor = _saOlive}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
    child: Row(
      children: [
        Icon(icon, size: 20, color: iconColor),
        const SizedBox(width: 10),
        Expanded(
          flex: 2,
          child: Text(
            property,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: _saCharcoal,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: _saLightLime,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              value,
              style: const TextStyle(fontSize: 12, color: _saDarkOlive),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _saAnnotatedBox({
  required String label,
  required String hint,
  required IconData icon,
  required Color color,
  double width = 140,
  double height = 100,
}) {
  return Semantics(
    label: label,
    hint: hint,
    button: false,
    child: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
          Text(
            hint,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 9,
              color: color.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _saDivider() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    height: 1,
    color: _saLime.withValues(alpha: 0.5),
  );
}

Widget _saBadge(String text, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color, width: 1),
    ),
    child: Text(
      text,
      style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: color),
    ),
  );
}

// ============================================================================
// Main entry
// ============================================================================

dynamic build(BuildContext context) {
  print('--- SemanticsAnnotationsMixin Deep Demo ---');
  print('Demonstrating how render objects contribute semantic annotations.');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ==================================================================
        // SECTION 0 — Title banner
        // ==================================================================
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [_saOlive, _saDarkOlive, Color(0xFF33691E)],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'SemanticsAnnotationsMixin',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'How render objects declare accessibility metadata\n'
                'for the semantics tree in Flutter\'s rendering layer',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.85),
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  _saBadge('Accessibility', _saLime),
                  const SizedBox(width: 8),
                  _saBadge('Render Layer', Colors.white),
                  const SizedBox(width: 8),
                  _saBadge('Mixin', _saGold),
                ],
              ),
            ],
          ),
        ),

        // ==================================================================
        // SECTION 1 — Overview: What the Mixin Provides
        // ==================================================================
        _saSectionHeader('1. What SemanticsAnnotationsMixin Provides',
            subtitle:
                'The bridge between render objects and the accessibility tree'),

        const SizedBox(height: 10),
        _saInfoCard(
          'SemanticsAnnotationsMixin defines the contract through which '
          'render objects expose their accessibility semantics.  Every '
          'RenderObject that needs to participate in the semantics tree '
          'implements this mixin\'s hooks to describe its role, label, '
          'value, hints, and interactive capabilities.\n\n'
          'The framework calls describeSemanticsConfiguration() during the '
          'semantics pass, and the render object fills the provided config '
          'with all the metadata an assistive technology needs.',
        ),

        // Visual: mixin methods overview
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _saLightLime,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _saOlive, width: 2),
          ),
          child: Column(
            children: [
              const Text(
                'Core Hooks of the Mixin',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: _saDarkOlive,
                ),
              ),
              const SizedBox(height: 12),
              _saPropertyRow(
                'describeSemanticsConfiguration()',
                'Fill config with labels, hints, actions, flags',
                Icons.description,
              ),
              _saPropertyRow(
                'visitChildrenForSemantics()',
                'Choose which children appear in semantics',
                Icons.account_tree,
                iconColor: _saTeal,
              ),
              _saPropertyRow(
                'isSemanticBoundary',
                'True → creates its own SemanticsNode',
                Icons.border_all,
                iconColor: _saAmber,
              ),
              _saPropertyRow(
                'semanticsAnnotator',
                'A callback to annotate the node',
                Icons.edit_note,
                iconColor: _saPlum,
              ),
            ],
          ),
        ),

        _saCodeBlock(
          '// Inside a custom RenderBox:\n'
          '@override\n'
          'void describeSemanticsConfiguration(\n'
          '    SemanticsConfiguration config) {\n'
          '  super.describeSemanticsConfiguration(config);\n'
          '  config\n'
          '    ..isSemanticBoundary = true\n'
          '    ..label = \'Submit button\'\n'
          '    ..hint = \'Double tap to submit the form\'\n'
          '    ..onTap = _handleTap;\n'
          '}',
        ),

        _saDivider(),

        // ==================================================================
        // SECTION 2 — The Semantics Widget: Surface-Level Annotations
        // ==================================================================
        _saSectionHeader('2. The Semantics Widget',
            subtitle:
                'The widget-layer interface to SemanticsAnnotationsMixin'),

        const SizedBox(height: 10),
        _saInfoCard(
          'The Semantics widget is the most direct way to add accessibility '
          'annotations.  Under the hood, its RenderSemanticsAnnotations class '
          'uses describeSemanticsConfiguration() to push your labels, hints, '
          'and action handlers into the semantics tree.\n\n'
          'Every Semantics() widget call ultimately drives the mixin\'s hooks.',
          borderColor: _saTeal,
        ),

        // Visual: simple Semantics-wrapped buttons
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(color: Color(0x1A000000), blurRadius: 8, offset: Offset(0, 2)),
            ],
          ),
          child: Column(
            children: [
              const Text(
                'Semantics-Annotated Elements',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: _saCharcoal,
                ),
              ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _saAnnotatedBox(
                    label: 'Play',
                    hint: 'Start playback',
                    icon: Icons.play_arrow,
                    color: _saOlive,
                  ),
                  _saAnnotatedBox(
                    label: 'Pause',
                    hint: 'Pause playback',
                    icon: Icons.pause,
                    color: _saTeal,
                  ),
                  _saAnnotatedBox(
                    label: 'Stop',
                    hint: 'Stop playback',
                    icon: Icons.stop,
                    color: _saCoral,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'Each box is wrapped in Semantics(label:, hint:) —\n'
                'screen readers will announce the label and hint.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 11, color: _saCharcoal),
              ),
            ],
          ),
        ),

        _saCodeBlock(
          'Semantics(\n'
          '  label: \'Play\',\n'
          '  hint: \'Start playback\',\n'
          '  button: true,\n'
          '  child: Icon(Icons.play_arrow),\n'
          ')',
        ),

        _saDivider(),

        // ==================================================================
        // SECTION 3 — Labels, Values, and Hints
        // ==================================================================
        _saSectionHeader('3. Labels, Values, and Hints',
            subtitle: 'The three primary text annotations'),

        const SizedBox(height: 10),
        _saInfoCard(
          'label   — The main accessible name: "Volume slider"\n'
          'value   — The current state: "50%"\n'
          'hint    — Usage guidance: "Swipe left or right to adjust"\n\n'
          'These three strings form the text a screen reader speaks.  '
          'The mixin pushes them via SemanticsConfiguration.label, '
          '.value, and .hint respectively.',
          borderColor: _saAmber,
        ),

        // Visual: three annotated cards showing label/value/hint
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [_saOlive, _saDarkOlive],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Column(
                    children: [
                      Icon(Icons.label, color: _saLime, size: 30),
                      SizedBox(height: 6),
                      Text('label',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13)),
                      SizedBox(height: 4),
                      Text('Identifies the element',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Color(0xCCFFFFFF), fontSize: 10)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [_saTeal, Color(0xFF004D40)],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Column(
                    children: [
                      Icon(Icons.speed, color: Color(0xFFA7FFEB), size: 30),
                      SizedBox(height: 6),
                      Text('value',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13)),
                      SizedBox(height: 4),
                      Text('Current state',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Color(0xCCFFFFFF), fontSize: 10)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [_saAmber, Color(0xFFFF6F00)],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Column(
                    children: [
                      Icon(Icons.lightbulb_outline, color: Color(0xFFFFF9C4), size: 30),
                      SizedBox(height: 6),
                      Text('hint',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13)),
                      SizedBox(height: 4),
                      Text('Usage guidance',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Color(0xCCFFFFFF), fontSize: 10)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // Concrete example: a slider with all three
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _saLightLime,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _saOlive),
          ),
          child: Column(
            children: [
              const Text(
                'Volume Slider Annotations',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: _saDarkOlive,
                ),
              ),
              const SizedBox(height: 10),
              Semantics(
                label: 'Volume',
                value: '75%',
                hint: 'Swipe to adjust volume',
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: _saOlive.withValues(alpha: 0.1),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                            colors: [_saOlive, _saLime],
                          ),
                        ),
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 8),
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Text('75',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: _saOlive)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'label="Volume"  value="75%"  hint="Swipe to adjust volume"',
                style: TextStyle(
                    fontSize: 10, fontFamily: 'monospace', color: _saCharcoal),
              ),
            ],
          ),
        ),

        _saDivider(),

        // ==================================================================
        // SECTION 4 — Semantic Actions
        // ==================================================================
        _saSectionHeader('4. Semantic Actions',
            subtitle: 'onTap, onLongPress, onScrollLeft, and more'),

        const SizedBox(height: 10),
        _saInfoCard(
          'Actions allow assistive technologies to invoke behavior.  Each '
          'action handler is set on SemanticsConfiguration:\n\n'
          '  • onTap — Primary activation\n'
          '  • onLongPress — Long-press gesture\n'
          '  • onScrollLeft / onScrollRight — Horizontal scrolling\n'
          '  • onScrollUp / onScrollDown — Vertical scrolling\n'
          '  • onIncrease / onDecrease — Value adjustments\n'
          '  • onDismiss — Dismissal (back swipe)\n'
          '  • onCopy / onCut / onPaste — Clipboard\n\n'
          'When an action handler is present, the framework automatically '
          'sets the corresponding SemanticsAction flag.',
          borderColor: _saSky,
        ),

        // Visual: Action tiles grid
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(color: Color(0x1A000000), blurRadius: 8, offset: Offset(0, 2)),
            ],
          ),
          child: Column(
            children: [
              const Text('Semantic Action Palette',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: _saCharcoal)),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: [
                  _saActionTile('onTap', Icons.touch_app, _saOlive),
                  _saActionTile('onLongPress', Icons.pan_tool, _saTeal),
                  _saActionTile('onScrollUp', Icons.arrow_upward, _saSky),
                  _saActionTile('onScrollDown', Icons.arrow_downward, _saSky),
                  _saActionTile('onIncrease', Icons.add_circle, _saAmber),
                  _saActionTile('onDecrease', Icons.remove_circle, _saAmber),
                  _saActionTile('onCopy', Icons.content_copy, _saPlum),
                  _saActionTile('onCut', Icons.content_cut, _saPlum),
                  _saActionTile('onPaste', Icons.content_paste, _saPlum),
                  _saActionTile('onDismiss', Icons.close, _saCoral),
                  _saActionTile('onMoveCursorFwd', Icons.arrow_forward, _saGold),
                  _saActionTile('onMoveCursorBack', Icons.arrow_back, _saGold),
                ],
              ),
            ],
          ),
        ),

        // Example action-enabled button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Semantics(
            label: 'Add to cart',
            hint: 'Double tap to add this item',
            button: true,
            onTap: () {
              print('[Semantics] onTap → Add to cart');
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [_saOlive, _saTeal],
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart, color: Colors.white, size: 20),
                  SizedBox(width: 8),
                  Text('Add to Cart',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15)),
                ],
              ),
            ),
          ),
        ),

        _saDivider(),

        // ==================================================================
        // SECTION 5 — Semantic Flags
        // ==================================================================
        _saSectionHeader('5. Semantic Flags',
            subtitle: 'Boolean properties that characterise the node'),

        const SizedBox(height: 10),
        _saInfoCard(
          'Flags tell assistive technologies what kind of element this is:\n\n'
          '  • isButton / isLink / isHeader / isImage\n'
          '  • isTextField / isSlider / isToggled / isChecked\n'
          '  • isReadOnly / isEnabled / isFocusable / isFocused\n'
          '  • hasEnabledState / hasCheckedState / hasToggledState\n'
          '  • isLiveRegion / namesRoute / scopesRoute\n\n'
          'These are set via SemanticsConfiguration properties.  '
          'The mixin ensures these flags are propagated to the '
          'SemanticsNode during the semantics update pass.',
          borderColor: _saPlum,
        ),

        // Visual: flag states
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _saLightLime,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              const Text('Element Type Flags',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: _saDarkOlive)),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _saFlagIndicator('isButton', true, Icons.smart_button),
                  _saFlagIndicator('isHeader', true, Icons.title),
                  _saFlagIndicator('isImage', false, Icons.image),
                  _saFlagIndicator('isLink', false, Icons.link),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _saFlagIndicator('isTextField', false, Icons.text_fields),
                  _saFlagIndicator('isEnabled', true, Icons.check_circle),
                  _saFlagIndicator('isFocused', true, Icons.center_focus_strong),
                  _saFlagIndicator('isSlider', false, Icons.tune),
                ],
              ),
            ],
          ),
        ),

        // Example: Semantics with multiple flags
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _saPlum, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.toggle_on, color: _saPlum, size: 22),
                  SizedBox(width: 8),
                  Text('Toggle Switch with Flags',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: _saCharcoal)),
                ],
              ),
              const SizedBox(height: 10),
              Semantics(
                label: 'Dark mode',
                toggled: true,
                enabled: true,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: _saOlive.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: _saOlive),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Dark Mode',
                          style: TextStyle(fontSize: 13, color: _saCharcoal)),
                      const SizedBox(width: 12),
                      Container(
                        width: 48,
                        height: 26,
                        decoration: BoxDecoration(
                          color: _saOlive,
                          borderRadius: BorderRadius.circular(13),
                        ),
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.all(3),
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'hasToggledState=true, toggled=true, enabled=true',
                style: TextStyle(
                    fontSize: 10, fontFamily: 'monospace', color: _saDarkOlive),
              ),
            ],
          ),
        ),

        _saDivider(),

        // ==================================================================
        // SECTION 6 — Semantic Boundaries & Merging
        // ==================================================================
        _saSectionHeader('6. Semantic Boundaries & Merging',
            subtitle: 'isSemanticBoundary and MergeSemantics'),

        const SizedBox(height: 10),
        _saInfoCard(
          'isSemanticBoundary = true means the render object gets its own '
          'SemanticsNode.  Normally, semantics info from a subtree gets '
          'merged up into the nearest ancestor boundary.\n\n'
          'MergeSemantics forces all of a subtree\'s annotations into a '
          'single SemanticsNode, letting screen readers announce the group '
          'as one coherent unit instead of jumping between parts.\n\n'
          'ExcludeSemantics hides a subtree from accessibility entirely — '
          'useful for decorative content.',
          borderColor: _saCoral,
        ),

        // Visual: merge vs separate
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(color: Color(0x1A000000), blurRadius: 8, offset: Offset(0, 2)),
            ],
          ),
          child: Column(
            children: [
              const Text('Separate vs Merged Semantics',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: _saCharcoal)),
              const SizedBox(height: 16),

              // Separate
              Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: _saCoral.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: _saCoral),
                    ),
                    child: const Center(
                      child: Text('A',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: _saCoral)),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: _saCoral.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: _saCoral),
                    ),
                    child: const Center(
                      child: Text('B',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: _saCoral)),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: _saCoral.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: _saCoral),
                    ),
                    child: const Center(
                      child: Text('C',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: _saCoral)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Separate: 3 nodes → reader stops on each',
                      style: TextStyle(fontSize: 11, color: _saCharcoal),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // Merged
              MergeSemantics(
                child: Row(
                  children: [
                    Container(
                      width: 96,
                      height: 30,
                      decoration: BoxDecoration(
                        color: _saOlive.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: _saOlive),
                      ),
                      child: const Center(
                        child: Text('A + B + C',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: _saOlive)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Merged: 1 node → reader announces group as one',
                        style: TextStyle(fontSize: 11, color: _saCharcoal),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // MergeSemantics example
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _saLightLime,
            borderRadius: BorderRadius.circular(10),
          ),
          child: MergeSemantics(
            child: Column(
              children: [
                const Text(
                  'Product Card (Merged)',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: _saDarkOlive,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Semantics(
                      label: 'Running shoes',
                      image: true,
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: _saOlive,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.directions_run,
                            color: Colors.white, size: 36),
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Ultra Boost X',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: _saCharcoal)),
                          Text('\$179.99',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: _saOlive)),
                          Text('In Stock • Free Shipping',
                              style: TextStyle(fontSize: 11, color: _saTeal)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                const Text(
                  'Reader: "Running shoes, Ultra Boost X, \$179.99, In Stock"',
                  style: TextStyle(
                      fontSize: 10, fontFamily: 'monospace', color: _saDarkOlive),
                ),
              ],
            ),
          ),
        ),

        _saDivider(),

        // ==================================================================
        // SECTION 7 — ExcludeSemantics & BlockSemantics
        // ==================================================================
        _saSectionHeader('7. ExcludeSemantics & BlockSemantics',
            subtitle: 'Hiding decorative or redundant content from accessibility'),

        const SizedBox(height: 10),
        _saInfoCard(
          'ExcludeSemantics(child: ...) removes the child and its entire '
          'subtree from the semantics tree.  This is appropriate for:\n\n'
          '  • Decorative images with no informational value\n'
          '  • Background effects that should be invisible to readers\n'
          '  • Duplicate content already announced by a parent\n\n'
          'BlockSemantics prevents nodes behind this one from contributing '
          'to the tree — useful for modal overlays that should take exclusive '
          'focus.  When a dialog is on screen, BlockSemantics ensures the '
          'dim barrier blocks accessibility traversal to content beneath it.',
        ),

        // Visual: which elements are visible vs hidden
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _saCoral, width: 1),
          ),
          child: Column(
            children: [
              const Text('Accessibility Visibility',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: _saCharcoal)),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _saVisibilityCard('Login Button', true, Icons.login),
                  _saVisibilityCard('Decorative Swirl', false, Icons.gesture),
                  _saVisibilityCard('Help Link', true, Icons.help),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: _saOlive,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text('Visible', style: TextStyle(fontSize: 10)),
                  const SizedBox(width: 16),
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: _saCoral.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text('Excluded', style: TextStyle(fontSize: 10)),
                ],
              ),
            ],
          ),
        ),

        _saCodeBlock(
          '// Decorative background: excluded from semantics\n'
          'ExcludeSemantics(\n'
          '  child: Image.asset(\'bg_pattern.png\'),\n'
          ')\n\n'
          '// Modal overlay: blocks content behind it\n'
          'BlockSemantics(\n'
          '  child: ModalBarrier(color: Colors.black54),\n'
          ')',
        ),

        _saDivider(),

        // ==================================================================
        // SECTION 8 — visitChildrenForSemantics
        // ==================================================================
        _saSectionHeader('8. visitChildrenForSemantics',
            subtitle: 'Controlling which children participate in semantics'),

        const SizedBox(height: 10),
        _saInfoCard(
          'By overriding visitChildrenForSemantics(), a render object can '
          'choose exactly which of its children should contribute to the '
          'semantics tree.  This is critical for:\n\n'
          '  • Clipping invisible overflow content from accessibility\n'
          '  • Reordering children for a more logical reading order\n'
          '  • Hiding off-screen items in a scrolling viewport\n'
          '  • Skipping decorative dividers between list items\n\n'
          'The default implementation visits all children.  Custom render '
          'objects override this to provide fine-grained control.',
          borderColor: _saGold,
        ),

        // Visual: child filter illustration
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _saIvory,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _saGold, width: 2),
          ),
          child: Column(
            children: [
              const Text('Children → Semantics Filter',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: _saDarkOlive)),
              const SizedBox(height: 14),
              Row(
                children: [
                  // All children
                  Expanded(
                    child: Column(
                      children: [
                        const Text('All Children',
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: _saCharcoal)),
                        const SizedBox(height: 8),
                        _saChildBox('Title', _saOlive, true),
                        _saChildBox('Divider', Colors.grey, true),
                        _saChildBox('Content', _saTeal, true),
                        _saChildBox('Decorative', Colors.grey, true),
                        _saChildBox('Button', _saSky, true),
                      ],
                    ),
                  ),
                  // Arrow
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Icon(Icons.arrow_forward, color: _saGold, size: 28),
                        Text('Filter',
                            style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: _saGold)),
                      ],
                    ),
                  ),
                  // Semantic children only
                  Expanded(
                    child: Column(
                      children: [
                        const Text('Semantics Tree',
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: _saCharcoal)),
                        const SizedBox(height: 8),
                        _saChildBox('Title', _saOlive, true),
                        _saChildBox('Content', _saTeal, true),
                        _saChildBox('Button', _saSky, true),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        _saCodeBlock(
          '@override\n'
          'void visitChildrenForSemantics(\n'
          '    RenderObjectVisitor visitor) {\n'
          '  // Only visit semantically meaningful children\n'
          '  if (titleChild != null) visitor(titleChild!);\n'
          '  if (contentChild != null) visitor(contentChild!);\n'
          '  if (actionChild != null) visitor(actionChild!);\n'
          '  // Skip divider + decorative children\n'
          '}',
        ),

        _saDivider(),

        // ==================================================================
        // SECTION 9 — Annotated Region & Custom Semantics
        // ==================================================================
        _saSectionHeader('9. Annotated Regions & Custom Data',
            subtitle:
                'Attaching domain-specific semantics data to the tree'),

        const SizedBox(height: 10),
        _saInfoCard(
          'Beyond the built-in label/hint/action model, the mixin allows '
          'render objects to attach custom semantics data through '
          'SemanticsConfiguration.customSemanticsActions.\n\n'
          'These allow a render object to provide domain-specific actions '
          'that are discoverable by accessibility services.  For example, '
          'a mail app might add "Archive" and "Flag" as custom actions '
          'on an email item.\n\n'
          'CustomSemanticsAction has a label that the assistive technology '
          'announces to the user.  The map of custom actions → callbacks '
          'is set on the SemanticsConfiguration.',
          borderColor: _saSky,
        ),

        // Visual: custom actions showcase
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [_saSky.withValues(alpha: 0.1), _saPlum.withValues(alpha: 0.1)],
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _saSky),
          ),
          child: Column(
            children: [
              const Text('Email Item with Custom Actions',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: _saCharcoal)),
              const SizedBox(height: 14),
              Semantics(
                label: 'Email from John: Meeting tomorrow',
                hint: 'Swipe for actions: Archive, Flag, Reply',
                onTap: () {
                  print('[Semantics] Open email from John');
                },
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                          color: Color(0x1A000000),
                          blurRadius: 6,
                          offset: Offset(0, 2)),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: _saSky,
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: const Center(
                          child: Text('J',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('John Smith',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: _saCharcoal)),
                            Text('Meeting tomorrow at 3pm',
                                style: TextStyle(
                                    fontSize: 12, color: Color(0xFF666666))),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _saActionChip('Archive', Icons.archive, _saOlive),
                          const SizedBox(width: 4),
                          _saActionChip('Flag', Icons.flag, _saAmber),
                          const SizedBox(width: 4),
                          _saActionChip('Reply', Icons.reply, _saSky),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Three CustomSemanticsActions appear in the actions menu',
                style: TextStyle(fontSize: 10, color: _saCharcoal),
              ),
            ],
          ),
        ),

        _saDivider(),

        // ==================================================================
        // SECTION 10 — Semantics Tree Structure
        // ==================================================================
        _saSectionHeader('10. The Assembled Semantics Tree',
            subtitle:
                'How annotations combine into a tree accessible to screen readers'),

        const SizedBox(height: 10),
        _saInfoCard(
          'The framework walks the render tree calling '
          'describeSemanticsConfiguration() on each node.  Nodes that are '
          'semantics boundaries generate their own SemanticsNode.  Non-boundary '
          'annotations merge upward.\n\n'
          'The resulting SemanticsNode tree is then sent to the platform, '
          'where the OS accessibility service (TalkBack on Android, VoiceOver '
          'on iOS) reads it to the user.\n\n'
          'The mixin ensures that every render object in the tree has a '
          'chance to contribute its annotations — labels, hints, actions — '
          'and that the framework can efficiently diff the tree between frames.',
        ),

        // Visual: tree diagram
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: _saLightLime,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _saOlive, width: 2),
          ),
          child: Column(
            children: [
              const Text('Render Tree → Semantics Tree',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: _saDarkOlive)),
              const SizedBox(height: 16),

              // Root
              _saTreeNode('Scaffold', _saOlive, isRoot: true),
              _saTreeConnector(),

              // Row of children
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _saTreeNode('AppBar\n"Settings"', _saTeal),
                  const SizedBox(width: 20),
                  _saTreeNode('Body', _saSky),
                  const SizedBox(width: 20),
                  _saTreeNode('FAB\n"Add item"', _saAmber),
                ],
              ),
              _saTreeConnector(),

              // Deeper
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _saTreeNode('Toggle\n"Dark mode"\ntoggled', _saPlum),
                  const SizedBox(width: 14),
                  _saTreeNode('Slider\n"Volume" 75%', _saOlive),
                  const SizedBox(width: 14),
                  _saTreeNode('Text\n"Welcome back"', _saCoral),
                ],
              ),

              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'Each box is a SemanticsNode.\n'
                  'Annotations flow from render objects via the mixin.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10, color: _saCharcoal),
                ),
              ),
            ],
          ),
        ),

        _saDivider(),

        // ==================================================================
        // SECTION 11 — Live Interactive Examples
        // ==================================================================
        _saSectionHeader('11. Live Annotation Examples',
            subtitle: 'Realistic widgets with full semantic annotations'),

        const SizedBox(height: 10),

        // Example 1: Rating bar
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(color: Color(0x1A000000), blurRadius: 8, offset: Offset(0, 2)),
            ],
          ),
          child: Column(
            children: [
              const Text('Rating Bar',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: _saCharcoal)),
              const SizedBox(height: 10),
              Semantics(
                label: 'Rating',
                value: '4 out of 5 stars',
                hint: 'Swipe up to increase, down to decrease',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    5,
                    (i) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Icon(
                        i < 4 ? Icons.star : Icons.star_border,
                        color: _saGold,
                        size: 32,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'label="Rating"  value="4 out of 5 stars"\n'
                'hint="Swipe up to increase, down to decrease"',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 9, fontFamily: 'monospace', color: _saDarkOlive),
              ),
            ],
          ),
        ),

        // Example 2: Progress bar
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _saLightLime,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              const Text('Download Progress',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: _saDarkOlive)),
              const SizedBox(height: 10),
              Semantics(
                label: 'Download progress',
                value: '67%',
                child: Column(
                  children: [
                    Container(
                      height: 20,
                      decoration: BoxDecoration(
                        color: _saOlive.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: FractionallySizedBox(
                          widthFactor: 0.67,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [_saOlive, _saTeal],
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('32.6 MB / 48.7 MB',
                            style: TextStyle(fontSize: 11, color: _saCharcoal)),
                        Text('67%',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: _saOlive)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Example 3: Checkbox list
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _saPlum, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Task Checklist',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: _saCharcoal)),
              const SizedBox(height: 10),
              _saCheckboxRow('Review design specs', true),
              _saCheckboxRow('Implement dark mode', true),
              _saCheckboxRow('Write unit tests', false),
              _saCheckboxRow('Update documentation', false),
              const SizedBox(height: 8),
              const Text(
                'Each row: checked=true/false, label="Task name"',
                style: TextStyle(
                    fontSize: 9, fontFamily: 'monospace', color: _saDarkOlive),
              ),
            ],
          ),
        ),

        // Example 4: Navigation bar with headings
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _saIvory,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _saOlive),
          ),
          child: Column(
            children: [
              Semantics(
                header: true,
                child: const Text('Settings',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _saDarkOlive)),
              ),
              const SizedBox(height: 14),
              _saSettingsItem('Account', Icons.person, 'Manage your profile'),
              _saSettingsItem(
                  'Notifications', Icons.notifications, 'Alert preferences'),
              _saSettingsItem('Privacy', Icons.lock, 'Data and sharing'),
              _saSettingsItem(
                  'Appearance', Icons.palette, 'Theme and display'),
              _saSettingsItem('About', Icons.info, 'Version and licenses'),
            ],
          ),
        ),

        _saDivider(),

        // ==================================================================
        // SECTION 12 — Summary
        // ==================================================================
        _saSectionHeader('12. Summary',
            subtitle:
                'SemanticsAnnotationsMixin in the grand scheme'),

        const SizedBox(height: 10),
        _saInfoCard(
          'SemanticsAnnotationsMixin is the fundamental piece that makes '
          'Flutter accessible.  Every semantic label, hint, action, and flag '
          'that reaches TalkBack or VoiceOver passes through this mixin\'s '
          'hooks on the render tree.\n\n'
          'Key takeaways:\n'
          '  • describeSemanticsConfiguration() is where the magic happens\n'
          '  • isSemanticBoundary controls node granularity\n'
          '  • visitChildrenForSemantics() prunes the tree\n'
          '  • MergeSemantics / ExcludeSemantics control what reaches the OS\n'
          '  • Custom actions extend the model for domain-specific needs\n\n'
          'Without the mixin, the rendering layer would have no way to '
          'communicate accessibility information to platform services.',
          borderColor: _saOlive,
        ),

        // Closing visual
        Container(
          width: double.infinity,
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [_saOlive, _saDarkOlive, Color(0xFF33691E)],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              const Icon(Icons.accessibility_new, color: _saLime, size: 40),
              const SizedBox(height: 10),
              const Text(
                'Accessibility Starts at the Render Layer',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'SemanticsAnnotationsMixin ensures every visual element\n'
                'can describe itself to assistive technologies.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.85),
                  fontSize: 12,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 30),
      ],
    ),
  );
}

// ==========================================================================
// Additional helper widgets
// ==========================================================================

Widget _saActionTile(String label, IconData icon, Color color) {
  return Container(
    width: 95,
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.4)),
    ),
    child: Column(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: color),
        ),
      ],
    ),
  );
}

Widget _saFlagIndicator(String label, bool isSet, IconData icon) {
  return Column(
    children: [
      Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: isSet ? _saOlive : Colors.grey.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Icon(icon, color: isSet ? Colors.white : Colors.grey, size: 22),
      ),
      const SizedBox(height: 4),
      Text(label,
          style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w600,
              color: isSet ? _saOlive : Colors.grey)),
      Text(isSet ? 'true' : 'false',
          style: TextStyle(
              fontSize: 8,
              color: isSet ? _saDarkOlive : Colors.grey)),
    ],
  );
}

Widget _saVisibilityCard(String label, bool visible, IconData icon) {
  return Container(
    width: 100,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: visible ? _saOlive.withValues(alpha: 0.1) : _saCoral.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: visible ? _saOlive : _saCoral.withValues(alpha: 0.3),
      ),
    ),
    child: Column(
      children: [
        Icon(icon,
            color: visible ? _saOlive : _saCoral.withValues(alpha: 0.4), size: 24),
        const SizedBox(height: 4),
        Text(label,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w600,
                color: visible ? _saOlive : _saCoral.withValues(alpha: 0.5))),
        Text(visible ? 'Visible' : 'Excluded',
            style: TextStyle(
                fontSize: 8,
                color: visible ? _saDarkOlive : _saCoral.withValues(alpha: 0.5))),
      ],
    ),
  );
}

Widget _saChildBox(String label, Color color, bool isSmall) {
  return Container(
    width: 100,
    height: 26,
    margin: const EdgeInsets.symmetric(vertical: 2),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: color, width: 1),
    ),
    child: Center(
      child: Text(label,
          style: TextStyle(
              fontSize: 9, fontWeight: FontWeight.w600, color: color)),
    ),
  );
}

Widget _saTreeNode(String label, Color color, {bool isRoot = false}) {
  return Container(
    width: isRoot ? 120 : 90,
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(isRoot ? 12 : 8),
      border: Border.all(color: color, width: isRoot ? 2 : 1),
    ),
    child: Text(
      label,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: isRoot ? 11 : 9,
        fontWeight: FontWeight.w600,
        color: color,
      ),
    ),
  );
}

Widget _saTreeConnector() {
  return Container(
    width: 2,
    height: 16,
    color: _saOlive.withValues(alpha: 0.4),
  );
}

Widget _saActionChip(String label, IconData icon, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: color),
        const SizedBox(width: 3),
        Text(label,
            style: TextStyle(fontSize: 8, fontWeight: FontWeight.w600, color: color)),
      ],
    ),
  );
}

Widget _saCheckboxRow(String task, bool checked) {
  return Semantics(
    label: task,
    checked: checked,
    enabled: true,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: checked ? _saOlive : Colors.transparent,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                  color: checked ? _saOlive : Colors.grey, width: 2),
            ),
            child: checked
                ? const Icon(Icons.check, color: Colors.white, size: 16)
                : null,
          ),
          const SizedBox(width: 10),
          Text(
            task,
            style: TextStyle(
              fontSize: 13,
              color: _saCharcoal,
              decoration: checked ? TextDecoration.lineThrough : null,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _saSettingsItem(String label, IconData icon, String subtitle) {
  return Semantics(
    label: label,
    hint: subtitle,
    button: true,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: _saOlive.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: _saOlive, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: _saCharcoal)),
                Text(subtitle,
                    style:
                        const TextStyle(fontSize: 11, color: Color(0xFF757575))),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Color(0xFF9E9E9E), size: 20),
        ],
      ),
    ),
  );
}
