// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: BlockSemantics deep demo
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Palette
// ---------------------------------------------------------------------------
const Color _kInk = Color(0xFF0E2230);
const Color _kInkSoft = Color(0xFF3F5366);
const Color _kSurface = Color(0xFFF4F8FB);
const Color _kCard = Color(0xFFFFFFFF);
const Color _kBorder = Color(0xFFD3DEE7);
const Color _kAccent = Color(0xFF1565C0);
const Color _kAccentDark = Color(0xFF0D3D7A);
const Color _kSuccess = Color(0xFF2E7D32);
const Color _kWarn = Color(0xFFEF6C00);
const Color _kDanger = Color(0xFFC62828);
const Color _kViolet = Color(0xFF6A1B9A);
const Color _kTeal = Color(0xFF00838F);
const Color _kMuted = Color(0xFF90A4AE);

// ---------------------------------------------------------------------------
// Shared helpers — no state, no controllers, no mutable closures.
// ---------------------------------------------------------------------------
Widget _gap(double h) => SizedBox(height: h);
Widget _hgap(double w) => SizedBox(width: w);

Widget _sectionTitle(String label, IconData icon, Color color) {
  return Row(
    children: [
      Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withValues(alpha: 0.85), color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.35),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
      _hgap(12),
      Expanded(
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: _kInk,
            letterSpacing: 0.2,
          ),
        ),
      ),
    ],
  );
}

Widget _card({
  required Widget child,
  EdgeInsets padding = const EdgeInsets.all(16),
  Color color = _kCard,
  Color border = _kBorder,
}) {
  return Container(
    padding: padding,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: border),
      boxShadow: const [
        BoxShadow(
          color: Color(0x14000000),
          blurRadius: 10,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: child,
  );
}

Widget _chip(String label, IconData icon, Color color) {
  return Container(
    margin: const EdgeInsets.only(right: 8, bottom: 8),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.10),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: color.withValues(alpha: 0.40)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 14),
        _hgap(6),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}

Widget _kvRow(String key, String value, IconData icon, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color.withValues(alpha: 0.30)),
          ),
          child: Icon(icon, color: color, size: 16),
        ),
        _hgap(12),
        SizedBox(
          width: 110,
          child: Text(
            key,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: _kInk,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              color: _kInkSoft,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _codeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFF0E2230), Color(0xFF14324A)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          color: Color(0x33000000),
          blurRadius: 12,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Text(
      code,
      style: const TextStyle(
        fontFamily: 'monospace',
        fontSize: 12,
        height: 1.55,
        color: Color(0xFFE8F1FA),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 1 — Hero header
// ---------------------------------------------------------------------------
Widget _heroHeader() {
  return Container(
    padding: const EdgeInsets.all(22),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFF0D3D7A), Color(0xFF1976D2), Color(0xFF42A5F5)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
          color: Color(0x33000000),
          blurRadius: 18,
          offset: Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.45),
                  width: 1.2,
                ),
              ),
              child: const Icon(
                Icons.accessibility_new,
                color: Colors.white,
                size: 30,
              ),
            ),
            _hgap(14),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'BlockSemantics',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.4,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Hide previously painted semantics from screen readers.',
                    style: TextStyle(
                      color: Color(0xFFE3F2FD),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.20),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.50),
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.layers, color: Colors.white, size: 14),
                  SizedBox(width: 6),
                  Text(
                    'overlay-friendly',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        _gap(16),
        const Text(
          'Why semantics ordering matters',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
        ),
        _gap(6),
        const Text(
          'When a screen reader walks the semantics tree, it visits nodes in '
          'paint order. A modal overlay typically paints LAST, but the items '
          'beneath it remain in the tree and would be announced too. '
          'BlockSemantics tells the walker to drop everything painted before '
          'it — so the overlay is the only thing announced.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.5,
            height: 1.5,
          ),
        ),
        _gap(14),
        Wrap(
          children: [
            _chip('a11y', Icons.accessibility, Colors.white),
            _chip('semantics tree', Icons.account_tree, Colors.white),
            _chip('paint order', Icons.format_paint, Colors.white),
            _chip('modal overlay', Icons.layers, Colors.white),
            _chip('screen reader', Icons.record_voice_over, Colors.white),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 2 — Conceptual diagram (background → boundary → overlay)
// ---------------------------------------------------------------------------
Widget _diagramBox({
  required String label,
  required String sub,
  required Color color,
  required IconData icon,
  bool dashed = false,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.10),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: color.withValues(alpha: dashed ? 0.85 : 0.40),
        width: dashed ? 2 : 1,
        style: dashed ? BorderStyle.solid : BorderStyle.solid,
      ),
    ),
    child: Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.white, size: 18),
        ),
        _hgap(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                sub,
                style: const TextStyle(
                  color: _kInkSoft,
                  fontSize: 11.5,
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

Widget _conceptualDiagram() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Conceptual diagram',
          Icons.account_tree,
          _kAccent,
        ),
        _gap(10),
        const Text(
          'The semantics walker traverses children in paint order. When it '
          'meets a BlockSemantics node, it drops everything that came before, '
          'as if those nodes were never in the tree.',
          style: TextStyle(fontSize: 13, color: _kInkSoft, height: 1.5),
        ),
        _gap(14),
        _diagramBox(
          label: 'Background page',
          sub: 'Form fields, list items, buttons painted first.',
          color: _kMuted,
          icon: Icons.layers_outlined,
        ),
        _diagramBox(
          label: 'BlockSemantics boundary',
          sub: 'Everything painted earlier is excluded from the a11y tree.',
          color: _kDanger,
          icon: Icons.block,
          dashed: true,
        ),
        _diagramBox(
          label: 'Modal overlay',
          sub: 'Card painted on top — the only branch the reader sees.',
          color: _kAccent,
          icon: Icons.layers,
        ),
        _gap(14),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kAccent.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _kAccent.withValues(alpha: 0.25)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.lightbulb, size: 18, color: _kAccent),
              _hgap(10),
              const Expanded(
                child: Text(
                  'Mental model: BlockSemantics behaves like a "fresh start" '
                  'marker. Anything before it = invisible to a11y. Anything '
                  'after (or inside) = visible.',
                  style: TextStyle(
                    fontSize: 12,
                    color: _kInk,
                    height: 1.5,
                  ),
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
// Section 3 — Mock screen-reader narration cards
// ---------------------------------------------------------------------------
Widget _narrationItem({
  required String text,
  required bool announced,
}) {
  final Color c = announced ? _kSuccess : _kDanger;
  final IconData icon = announced ? Icons.check_circle : Icons.cancel;
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: c),
        _hgap(8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: announced ? _kInk : _kMuted,
              decoration:
                  announced ? TextDecoration.none : TextDecoration.lineThrough,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _narrationCard({
  required String title,
  required String subtitle,
  required IconData icon,
  required Color accent,
  required List<Widget> entries,
}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _kCard,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: accent.withValues(alpha: 0.35)),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.12),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 18, color: accent),
            ),
            _hgap(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: _kInk,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 11,
                      color: _kInkSoft,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        _gap(10),
        const Divider(height: 1, color: _kBorder),
        _gap(8),
        ...entries,
      ],
    ),
  );
}

Widget _narrationSection() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Mock screen-reader narration',
          Icons.record_voice_over,
          _kViolet,
        ),
        _gap(10),
        const Text(
          'These cards simulate what a screen reader would announce in two '
          'identical UIs — only the use of BlockSemantics differs.',
          style: TextStyle(fontSize: 13, color: _kInkSoft, height: 1.5),
        ),
        _gap(14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _narrationCard(
                title: 'Without BlockSemantics',
                subtitle: 'Everything is announced.',
                icon: Icons.warning_amber,
                accent: _kWarn,
                entries: [
                  _narrationItem(
                    text: 'Background: "Email field, edit text"',
                    announced: true,
                  ),
                  _narrationItem(
                    text: 'Background: "Password field, edit text"',
                    announced: true,
                  ),
                  _narrationItem(
                    text: 'Background: "Submit button"',
                    announced: true,
                  ),
                  _narrationItem(
                    text: 'Modal: "Are you sure you want to leave?"',
                    announced: true,
                  ),
                  _narrationItem(
                    text: 'Modal: "Cancel button"',
                    announced: true,
                  ),
                  _narrationItem(
                    text: 'Modal: "Discard button"',
                    announced: true,
                  ),
                ],
              ),
            ),
            _hgap(12),
            Expanded(
              child: _narrationCard(
                title: 'With BlockSemantics',
                subtitle: 'Only the modal is announced.',
                icon: Icons.verified,
                accent: _kSuccess,
                entries: [
                  _narrationItem(
                    text: 'Background: "Email field"',
                    announced: false,
                  ),
                  _narrationItem(
                    text: 'Background: "Password field"',
                    announced: false,
                  ),
                  _narrationItem(
                    text: 'Background: "Submit button"',
                    announced: false,
                  ),
                  _narrationItem(
                    text: 'Modal: "Are you sure you want to leave?"',
                    announced: true,
                  ),
                  _narrationItem(
                    text: 'Modal: "Cancel button"',
                    announced: true,
                  ),
                  _narrationItem(
                    text: 'Modal: "Discard button"',
                    announced: true,
                  ),
                ],
              ),
            ),
          ],
        ),
        _gap(12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kSuccess.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _kSuccess.withValues(alpha: 0.30)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Icon(Icons.tips_and_updates, size: 18, color: _kSuccess),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Notice the strikethrough on the right column. The widgets '
                  'are still painted on screen — they are only hidden from '
                  'assistive technology. Sighted users see them dimmed by '
                  'the modal\'s scrim.',
                  style: TextStyle(
                    fontSize: 12,
                    color: _kInk,
                    height: 1.5,
                  ),
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
// Section 4 — Layered Stack demo
// ---------------------------------------------------------------------------
Widget _backgroundFakeForm() {
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFFEFF4F8), Color(0xFFE2EBF1)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(Icons.email_outlined, size: 16, color: _kInkSoft),
            SizedBox(width: 8),
            Text(
              'Email',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: _kInk,
              ),
            ),
          ],
        ),
        _gap(6),
        Container(
          height: 32,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _kBorder),
          ),
          child: const Text(
            'user@example.com',
            style: TextStyle(fontSize: 12, color: _kInkSoft),
          ),
        ),
        _gap(12),
        Row(
          children: const [
            Icon(Icons.lock_outline, size: 16, color: _kInkSoft),
            SizedBox(width: 8),
            Text(
              'Password',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: _kInk,
              ),
            ),
          ],
        ),
        _gap(6),
        Container(
          height: 32,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _kBorder),
          ),
          child: const Text(
            '••••••••••',
            style: TextStyle(fontSize: 12, color: _kInkSoft),
          ),
        ),
        _gap(14),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [_kAccent, _kAccentDark],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: _kAccent.withValues(alpha: 0.30),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Text(
                  'Sign in',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 12.5,
                  ),
                ),
              ),
            ),
            _hgap(10),
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: _kMuted.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _kBorder),
              ),
              child: const Icon(
                Icons.help_outline,
                size: 18,
                color: _kInkSoft,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _modalOverlayCard() {
  return Container(
    width: 260,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFFFFFFFF), Color(0xFFF1F7FD)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: const [
        BoxShadow(
          color: Color(0x33000000),
          blurRadius: 16,
          offset: Offset(0, 8),
        ),
      ],
      border: Border.all(color: _kBorder),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: const [
            Icon(Icons.warning_amber, size: 20, color: _kWarn),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Discard changes?',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: _kInk,
                ),
              ),
            ),
          ],
        ),
        _gap(8),
        const Text(
          'You have unsaved edits. If you leave now, they will be lost.',
          style: TextStyle(fontSize: 12, color: _kInkSoft, height: 1.4),
        ),
        _gap(14),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: _kMuted.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _kBorder),
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 12,
                  color: _kInkSoft,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            _hgap(10),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFD32F2F), Color(0xFFB71C1C)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x44C62828),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: const Text(
                'Discard',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _stackDemo() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Layered Stack demo',
          Icons.layers,
          _kTeal,
        ),
        _gap(10),
        const Text(
          'A Stack with two layers: the busy background, and a centered '
          'modal wrapped in BlockSemantics. The mock below visualizes the '
          'effect — note the dashed boundary marking the semantic cutoff.',
          style: TextStyle(fontSize: 13, color: _kInkSoft, height: 1.5),
        ),
        _gap(14),
        Container(
          height: 320,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _kBorder),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(13),
            child: Stack(
              children: [
                // Background: dimmed underneath the overlay
                Positioned.fill(
                  child: Container(
                    color: const Color(0xFFF7FAFC),
                    padding: const EdgeInsets.all(16),
                    child: _backgroundFakeForm(),
                  ),
                ),
                // Scrim
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withValues(alpha: 0.35),
                  ),
                ),
                // Boundary indicator (dashed-style)
                Positioned(
                  left: 12,
                  right: 12,
                  top: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _kDanger.withValues(alpha: 0.85),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x33C62828),
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.block, size: 14, color: Colors.white),
                        SizedBox(width: 6),
                        Text(
                          'BlockSemantics — earlier siblings hidden',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Overlay
                Center(child: _modalOverlayCard()),
              ],
            ),
          ),
        ),
        _gap(12),
        Wrap(
          children: [
            _chip('Stack', Icons.layers, _kAccent),
            _chip('scrim', Icons.opacity, _kInkSoft),
            _chip('BlockSemantics', Icons.block, _kDanger),
            _chip('Center child', Icons.center_focus_strong, _kSuccess),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 5 — Excluded vs Blocked vs Merged
// ---------------------------------------------------------------------------
Widget _comparisonTile({
  required String title,
  required String tagline,
  required Color color,
  required IconData icon,
  required List<String> bullets,
  required String visualTag,
}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _kCard,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: color.withValues(alpha: 0.40)),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.10),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color.withValues(alpha: 0.85), color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.white, size: 18),
        ),
        _gap(10),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
        _gap(2),
        Text(
          tagline,
          style: const TextStyle(
            fontSize: 11,
            color: _kInkSoft,
            height: 1.4,
          ),
        ),
        _gap(10),
        ...bullets.map(
          (b) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 5,
                  height: 5,
                  margin: const EdgeInsets.only(top: 6, right: 8),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                Expanded(
                  child: Text(
                    b,
                    style: const TextStyle(
                      fontSize: 11.5,
                      color: _kInk,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        _gap(8),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: color.withValues(alpha: 0.40)),
          ),
          child: Text(
            visualTag,
            style: TextStyle(
              fontSize: 10,
              color: color,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _comparisonSection() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Exclude vs Block vs Merge',
          Icons.compare_arrows,
          _kWarn,
        ),
        _gap(10),
        const Text(
          'Three sibling concepts in the semantics API. They are easy to '
          'confuse — here is how they differ.',
          style: TextStyle(fontSize: 13, color: _kInkSoft, height: 1.5),
        ),
        _gap(14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _comparisonTile(
                title: 'ExcludeSemantics',
                tagline: 'Hide this subtree from a11y.',
                color: _kViolet,
                icon: Icons.visibility_off,
                bullets: const [
                  'Drops the entire descendant subtree.',
                  'Use for purely decorative content.',
                  'Local to the subtree it wraps.',
                ],
                visualTag: 'subtree → gone',
              ),
            ),
            _hgap(10),
            Expanded(
              child: _comparisonTile(
                title: 'BlockSemantics',
                tagline: 'Hide PREVIOUS siblings.',
                color: _kDanger,
                icon: Icons.block,
                bullets: const [
                  'Drops nodes painted before it.',
                  'Use when an overlay must mask others.',
                  'Effect is on the surrounding context.',
                ],
                visualTag: 'siblings ↺ gone',
              ),
            ),
            _hgap(10),
            Expanded(
              child: _comparisonTile(
                title: 'MergeSemantics',
                tagline: 'Combine into one node.',
                color: _kSuccess,
                icon: Icons.merge_type,
                bullets: const [
                  'Flattens descendants into one node.',
                  'Use for icon+label pairs.',
                  'Helps single-swipe a11y reading.',
                ],
                visualTag: 'subtree ⤵ one node',
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 6 — API surface
// ---------------------------------------------------------------------------
Widget _apiSection() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'API surface',
          Icons.code,
          _kAccentDark,
        ),
        _gap(10),
        _kvRow(
          'blocking',
          'Whether this node should drop semantic information from earlier '
              'siblings. Defaults to true. Set false to disable temporarily '
              'without removing the widget.',
          Icons.toggle_on,
          _kAccent,
        ),
        _kvRow(
          'child',
          'The widget below this node in the tree. Its semantics are '
              'preserved and not affected by the block.',
          Icons.account_tree,
          _kSuccess,
        ),
        _kvRow(
          'key',
          'Inherited from Widget. Useful for testing identity across '
              'rebuilds.',
          Icons.vpn_key,
          _kViolet,
        ),
        _gap(14),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kAccent.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _kAccent.withValues(alpha: 0.25)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Icon(Icons.info_outline, size: 18, color: _kAccent),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Wording note: "blocks" here means "semantically hides '
                  'previous siblings". It does NOT block input, gestures, or '
                  'painting. Use ModalBarrier or AbsorbPointer for those.',
                  style: TextStyle(
                    fontSize: 12,
                    color: _kInk,
                    height: 1.5,
                  ),
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
// Section 7 — Common use cases
// ---------------------------------------------------------------------------
Widget _useCaseTile({
  required String title,
  required String body,
  required IconData icon,
  required Color color,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.05),
          color.withValues(alpha: 0.12),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withValues(alpha: 0.30)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.30),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        _hgap(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: _kInk,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                body,
                style: const TextStyle(
                  fontSize: 12,
                  color: _kInkSoft,
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _useCaseSection() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Common use cases',
          Icons.task_alt,
          _kSuccess,
        ),
        _gap(10),
        _useCaseTile(
          title: 'Modal dialogs',
          body: 'Wrap the dialog content so the page underneath is not '
              'announced while the dialog is open.',
          icon: Icons.crop_din,
          color: _kAccent,
        ),
        _useCaseTile(
          title: 'Drawer overlays',
          body: 'When a navigation drawer slides over the page, block the '
              'page semantics so the focus stays on drawer items.',
          icon: Icons.menu_open,
          color: _kTeal,
        ),
        _useCaseTile(
          title: 'Route transitions',
          body: 'During a hero animation or fade-through, the previous '
              'route\'s semantics can leak. BlockSemantics keeps the new '
              'route announced first.',
          icon: Icons.swap_horiz,
          color: _kViolet,
        ),
        _useCaseTile(
          title: 'Tooltips & popovers',
          body: 'A tooltip rendered above busy content can obscure semantics '
              'until the user dismisses it.',
          icon: Icons.tips_and_updates,
          color: _kWarn,
        ),
        _useCaseTile(
          title: 'Bottom sheets',
          body: 'Modal bottom sheets in particular benefit from blocking — '
              'screen-reader users should hear sheet content, not the list '
              'behind it.',
          icon: Icons.vertical_align_bottom,
          color: _kSuccess,
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 8 — Pitfalls
// ---------------------------------------------------------------------------
Widget _pitfallTile({
  required String title,
  required String body,
  required Color color,
  required IconData icon,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.07),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withValues(alpha: 0.40)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 20),
        _hgap(10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: color,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                body,
                style: const TextStyle(
                  fontSize: 12,
                  color: _kInk,
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _pitfallSection() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Pitfalls',
          Icons.warning_amber,
          _kDanger,
        ),
        _gap(10),
        _pitfallTile(
          title: 'Scope is local',
          body: 'BlockSemantics only affects siblings inside the same paint '
              'subtree. Placing it deeply inside a small Column will not '
              'block the entire app — only the nodes painted before it in '
              'that Column.',
          color: _kDanger,
          icon: Icons.crop_free,
        ),
        _pitfallTile(
          title: 'Confusion with Visibility',
          body: 'Visibility(maintainSemantics: false) hides a SUBTREE from '
              'a11y. BlockSemantics hides EARLIER siblings. Different axes '
              'of "hiding".',
          color: _kWarn,
          icon: Icons.visibility_off,
        ),
        _pitfallTile(
          title: 'Not a substitute for ModalBarrier',
          body: 'BlockSemantics affects only the semantics tree. To prevent '
              'taps on the underlying UI, use ModalBarrier or '
              'AbsorbPointer.',
          color: _kViolet,
          icon: Icons.block,
        ),
        _pitfallTile(
          title: 'Stacking inside Slivers',
          body: 'Inside CustomScrollView, "earlier siblings" follow paint '
              'order across slivers. Visualizing this is tricky — prefer to '
              'wrap the overlay at the Stack root.',
          color: _kAccent,
          icon: Icons.list_alt,
        ),
        _pitfallTile(
          title: 'Forgotten on dismiss',
          body: 'If you keep BlockSemantics in the tree after the overlay is '
              'closed (e.g. via opacity 0), the page underneath stays muted '
              'for assistive tech. Toggle blocking=false or remove the '
              'widget.',
          color: _kTeal,
          icon: Icons.history,
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 9 — Code-style snippet
// ---------------------------------------------------------------------------
Widget _codeSection() {
  const String snippet = '''Stack(
  children: [
    // 1. Underlying page (forms, lists, buttons).
    PageContent(),

    // 2. Scrim painted on top, dimming the page.
    Positioned.fill(
      child: ColoredBox(color: Colors.black54),
    ),

    // 3. Overlay wrapped in BlockSemantics so the
    //    page semantics are hidden while the modal
    //    is presented.
    Center(
      child: BlockSemantics(
        // blocking: true is the default
        child: Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(16),
          child: ConfirmDialog(
            title: 'Discard changes?',
            onCancel: () { /* close */ },
            onConfirm: () { /* discard */ },
          ),
        ),
      ),
    ),
  ],
)''';

  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Code-style snippet',
          Icons.terminal,
          _kInk,
        ),
        _gap(10),
        const Text(
          'Typical pattern: Stack with three children — page, scrim, and the '
          'overlay wrapped in BlockSemantics.',
          style: TextStyle(fontSize: 13, color: _kInkSoft, height: 1.5),
        ),
        _gap(12),
        _codeBlock(snippet),
        _gap(12),
        Wrap(
          children: [
            _chip('Stack', Icons.layers, _kAccent),
            _chip('Positioned.fill', Icons.crop_free, _kInkSoft),
            _chip('ColoredBox scrim', Icons.opacity, _kMuted),
            _chip('BlockSemantics', Icons.block, _kDanger),
            _chip('Material', Icons.crop_din, _kSuccess),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 10 — See also
// ---------------------------------------------------------------------------
Widget _seeAlsoTile({
  required String name,
  required String description,
  required IconData icon,
  required Color color,
}) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.white,
          color.withValues(alpha: 0.06),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withValues(alpha: 0.30)),
      boxShadow: const [
        BoxShadow(
          color: Color(0x0F000000),
          blurRadius: 6,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 18),
            ),
            _hgap(10),
            Expanded(
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: _kInk,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ),
        _gap(8),
        Text(
          description,
          style: const TextStyle(
            fontSize: 11.5,
            color: _kInkSoft,
            height: 1.45,
          ),
        ),
      ],
    ),
  );
}

Widget _seeAlsoSection() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'See also',
          Icons.menu_book,
          _kAccent,
        ),
        _gap(12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _seeAlsoTile(
                name: 'Semantics',
                description: 'Annotate any subtree with explicit a11y '
                    'properties such as label, hint, and role.',
                icon: Icons.assignment,
                color: _kAccent,
              ),
            ),
            _hgap(10),
            Expanded(
              child: _seeAlsoTile(
                name: 'MergeSemantics',
                description: 'Merge a subtree of nodes into a single node. '
                    'Useful for icon + label compositions.',
                icon: Icons.merge_type,
                color: _kSuccess,
              ),
            ),
          ],
        ),
        _gap(10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _seeAlsoTile(
                name: 'ExcludeSemantics',
                description: 'Drop a subtree from the a11y tree entirely — '
                    'good for purely decorative graphics.',
                icon: Icons.visibility_off,
                color: _kViolet,
              ),
            ),
            _hgap(10),
            Expanded(
              child: _seeAlsoTile(
                name: 'RouteAware',
                description: 'Lifecycle hook used together with BlockSemantics '
                    'when overlays are tied to navigation events.',
                icon: Icons.alt_route,
                color: _kTeal,
              ),
            ),
          ],
        ),
        _gap(10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _seeAlsoTile(
                name: 'ModalBarrier',
                description: 'Pairs naturally with BlockSemantics: barrier '
                    'absorbs taps; BlockSemantics hides a11y.',
                icon: Icons.shield,
                color: _kDanger,
              ),
            ),
            _hgap(10),
            Expanded(
              child: _seeAlsoTile(
                name: 'FocusTraversalGroup',
                description: 'Constrain keyboard focus to the overlay so '
                    'tabbing matches the announced order.',
                icon: Icons.keyboard_tab,
                color: _kWarn,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Bonus footer — a quick summary banner
// ---------------------------------------------------------------------------
Widget _summaryFooter() {
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFF0E2230), Color(0xFF1565C0)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18),
      boxShadow: const [
        BoxShadow(
          color: Color(0x33000000),
          blurRadius: 14,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(Icons.flag, color: Colors.white, size: 20),
            SizedBox(width: 10),
            Text(
              'Summary',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        _gap(10),
        const Text(
          'BlockSemantics is the smallest, sharpest tool to keep an overlay\'s '
          'announcement free from the noise of the page beneath. Pair it '
          'with ModalBarrier for input, with FocusTraversalGroup for '
          'keyboard navigation, and you have a fully accessible modal.',
          style: TextStyle(
            color: Color(0xFFE3F2FD),
            fontSize: 12.5,
            height: 1.55,
          ),
        ),
        _gap(14),
        Wrap(
          children: [
            _chip('a11y first', Icons.accessibility_new, Colors.white),
            _chip('modal-aware', Icons.layers, Colors.white),
            _chip('paint order', Icons.format_paint, Colors.white),
            _chip('blocking', Icons.block, Colors.white),
            _chip('hands-off render', Icons.visibility, Colors.white),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Entry point
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  return Theme(
    data: ThemeData(
      useMaterial3: true,
      colorSchemeSeed: _kAccent,
      scaffoldBackgroundColor: _kSurface,
    ),
    child: Scaffold(
      backgroundColor: _kSurface,
      appBar: AppBar(
        title: const Text('BlockSemantics — deep demo'),
        backgroundColor: _kAccentDark,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _heroHeader(),
            _gap(18),
            _conceptualDiagram(),
            _gap(18),
            _narrationSection(),
            _gap(18),
            _stackDemo(),
            _gap(18),
            _comparisonSection(),
            _gap(18),
            _apiSection(),
            _gap(18),
            _useCaseSection(),
            _gap(18),
            _pitfallSection(),
            _gap(18),
            _codeSection(),
            _gap(18),
            _seeAlsoSection(),
            _gap(18),
            _summaryFooter(),
            _gap(24),
          ],
        ),
      ),
    ),
  );
}
