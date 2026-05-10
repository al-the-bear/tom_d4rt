// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, deprecated_member_use
// Visual deep demo: RawKeyEventDataAndroid anatomy, modifier flag bit-fields,
// event source taxonomy, sample event journeys, and migration to KeyEvent /
// HardwareKeyboard.
//
// NOTE: RawKeyEventDataAndroid is part of Flutter's now-legacy raw keyboard
// stack (annotated @Deprecated). New code should consume KeyEvent through
// HardwareKeyboard / KeyboardListener / Focus.onKeyEvent instead. This demo
// renders static cards illustrating each field, the META_*_ON bit constants
// it inspects, and the sibling RawKeyEventData* subclasses on other
// platforms.
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Modifier bit constants — values mirror those in
// android.view.KeyEvent.META_*_ON which RawKeyEventDataAndroid inspects.
// ---------------------------------------------------------------------------
class _Meta {
  static const int shiftOn = 0x00000001; // META_SHIFT_ON
  static const int altOn = 0x00000002; // META_ALT_ON
  static const int symOn = 0x00000004; // META_SYM_ON (function/sym)
  static const int functionOn = 0x00000008; // META_FUNCTION_ON
  static const int altLeftOn = 0x00000010; // META_ALT_LEFT_ON
  static const int altRightOn = 0x00000020; // META_ALT_RIGHT_ON
  static const int shiftLeftOn = 0x00000040; // META_SHIFT_LEFT_ON
  static const int shiftRightOn = 0x00000080; // META_SHIFT_RIGHT_ON
  static const int capsLockOn = 0x00100000; // META_CAPS_LOCK_ON
  static const int numLockOn = 0x00200000; // META_NUM_LOCK_ON
  static const int scrollLockOn = 0x00400000; // META_SCROLL_LOCK_ON
  static const int ctrlOn = 0x00001000; // META_CTRL_ON
  static const int ctrlLeftOn = 0x00002000; // META_CTRL_LEFT_ON
  static const int ctrlRightOn = 0x00004000; // META_CTRL_RIGHT_ON
  static const int metaOn = 0x00010000; // META_META_ON (Windows/Cmd)
  static const int metaLeftOn = 0x00020000; // META_META_LEFT_ON
  static const int metaRightOn = 0x00040000; // META_META_RIGHT_ON
}

// ---------------------------------------------------------------------------
// Event source constants — values mirror android.view.InputDevice.SOURCE_*.
// RawKeyEventDataAndroid surfaces this as `eventSource`.
// ---------------------------------------------------------------------------
class _Source {
  static const int unknown = 0x00000000;
  static const int keyboard = 0x00000101;
  static const int dpad = 0x00000201;
  static const int gamepad = 0x00000401;
  static const int touchscreen = 0x00001002;
  static const int mouse = 0x00002002;
  static const int stylus = 0x00004002;
  static const int trackball = 0x00010004;
  static const int joystick = 0x01000010;
  static const int hdmi = 0x02000001;
}

// ---------------------------------------------------------------------------
// Palette — Android-inspired greens, with deprecation rust accents.
// ---------------------------------------------------------------------------
class _Palette {
  static const Color bg = Color(0xFF071A12);
  static const Color panel = Color(0xFF0E2A1C);
  static const Color panelAlt = Color(0xFF143828);
  static const Color border = Color(0xFF235A3F);
  static const Color green = Color(0xFF3DDC84); // Android signature green
  static const Color greenSoft = Color(0xFF7BF0AC);
  static const Color emerald = Color(0xFF1FB572);
  static const Color teal = Color(0xFF26B8B0);
  static const Color tealSoft = Color(0xFF6BE6DE);
  static const Color amber = Color(0xFFFFC857);
  static const Color rust = Color(0xFFE06A3F); // deprecation accent
  static const Color rustSoft = Color(0xFFFFA277);
  static const Color rose = Color(0xFFFF6F8E);
  static const Color sky = Color(0xFF6BC8FF);
  static const Color violet = Color(0xFFB48BFF);
  static const Color textPrimary = Color(0xFFEAFFF3);
  static const Color textSecondary = Color(0xFFAFD9C2);
  static const Color textMuted = Color(0xFF6E957F);
  static const Color codeBg = Color(0xFF051410);
  static const Color codeKeyword = Color(0xFF3DDC84);
  static const Color codeType = Color(0xFF26B8B0);
  static const Color codeString = Color(0xFFFFC857);
  static const Color codeNumber = Color(0xFFFFA277);
  static const Color codeComment = Color(0xFF6E957F);
}

// ---------------------------------------------------------------------------
// Typography helpers
// ---------------------------------------------------------------------------
class _Type {
  static const TextStyle heroTitle = TextStyle(
    fontSize: 38,
    fontWeight: FontWeight.w800,
    color: _Palette.textPrimary,
    letterSpacing: 1.4,
    height: 1.05,
  );
  static const TextStyle heroSub = TextStyle(
    fontSize: 16,
    color: _Palette.textSecondary,
    fontWeight: FontWeight.w400,
    height: 1.45,
  );
  static const TextStyle sectionTitle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: _Palette.textPrimary,
    letterSpacing: 0.4,
  );
  static const TextStyle sectionLead = TextStyle(
    fontSize: 14,
    color: _Palette.textSecondary,
    height: 1.5,
  );
  static const TextStyle bodyText = TextStyle(
    fontSize: 13,
    color: _Palette.textPrimary,
    height: 1.5,
  );
  static const TextStyle bodyDim = TextStyle(
    fontSize: 13,
    color: _Palette.textSecondary,
    height: 1.5,
  );
  static const TextStyle caption = TextStyle(
    fontSize: 11,
    color: _Palette.textMuted,
    letterSpacing: 0.6,
  );
  static const TextStyle code = TextStyle(
    fontFamily: 'monospace',
    fontSize: 12,
    color: _Palette.textPrimary,
    height: 1.45,
  );
  static const TextStyle codeKeyword = TextStyle(
    fontFamily: 'monospace',
    fontSize: 12,
    color: _Palette.codeKeyword,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle codeType = TextStyle(
    fontFamily: 'monospace',
    fontSize: 12,
    color: _Palette.codeType,
  );
  static const TextStyle codeString = TextStyle(
    fontFamily: 'monospace',
    fontSize: 12,
    color: _Palette.codeString,
  );
  static const TextStyle codeNumber = TextStyle(
    fontFamily: 'monospace',
    fontSize: 12,
    color: _Palette.codeNumber,
  );
  static const TextStyle codeComment = TextStyle(
    fontFamily: 'monospace',
    fontSize: 12,
    color: _Palette.codeComment,
    fontStyle: FontStyle.italic,
  );
}

// ---------------------------------------------------------------------------
// Section frame
// ---------------------------------------------------------------------------
class _SectionFrame extends StatelessWidget {
  final String index;
  final String title;
  final String? lead;
  final Widget child;
  const _SectionFrame({
    required this.index,
    required this.title,
    required this.child,
    this.lead,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 14, horizontal: 22),
      padding: EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: _Palette.panel,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _Palette.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: _Palette.green.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(
                    color: _Palette.green.withValues(alpha: 0.5),
                    width: 1,
                  ),
                ),
                child: Text(
                  index,
                  style: TextStyle(
                    fontSize: 12,
                    color: _Palette.green,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(child: Text(title, style: _Type.sectionTitle)),
            ],
          ),
          if (lead != null) ...[
            SizedBox(height: 10),
            Text(lead!, style: _Type.sectionLead),
          ],
          SizedBox(height: 18),
          child,
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Code block primitives — token-based mini syntax highlighter.
// ---------------------------------------------------------------------------
class _CodeTok {
  final String text;
  final TextStyle style;
  _CodeTok(this.text, [TextStyle? style])
      : style = style ?? _Type.code;
}

class _CodeLine {
  final List<_CodeTok> tokens;
  _CodeLine.tokens(this.tokens);
  _CodeLine.plain(String text) : tokens = [_CodeTok(text)];
  _CodeLine.blank() : tokens = [_CodeTok('')];
}

class _CodeBlock extends StatelessWidget {
  final List<_CodeLine> lines;
  final EdgeInsets padding;
  const _CodeBlock(
    this.lines, {
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: _Palette.codeBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _Palette.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < lines.length; i++)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 28,
                    child: Text(
                      '${i + 1}'.padLeft(2),
                      style: _Type.codeComment.copyWith(fontSize: 11),
                    ),
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: _Type.code,
                        children: [
                          for (final tok in lines[i].tokens)
                            TextSpan(text: tok.text, style: tok.style),
                        ],
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
}

// ---------------------------------------------------------------------------
// SECTION 0 — Deprecation banner
// ---------------------------------------------------------------------------
class _DeprecationBanner extends StatelessWidget {
  const _DeprecationBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(22, 22, 22, 0),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _Palette.rust.withValues(alpha: 0.30),
            _Palette.rust.withValues(alpha: 0.10),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: _Palette.rust.withValues(alpha: 0.65),
          width: 1.4,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _Palette.rust.withValues(alpha: 0.85),
              boxShadow: [
                BoxShadow(
                  color: _Palette.rust.withValues(alpha: 0.5),
                  blurRadius: 18,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Center(
              child: Text(
                '!',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'DEPRECATED  ·  use KeyEvent / HardwareKeyboard',
                  style: TextStyle(
                    fontSize: 12,
                    color: _Palette.rustSoft,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.6,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'RawKeyEventDataAndroid is part of the legacy raw '
                  'keyboard subsystem. The entire RawKeyboard / RawKeyEvent '
                  'family is annotated @Deprecated; new code should '
                  'subscribe to KeyEvent through HardwareKeyboard.instance, '
                  'KeyboardListener, or Focus.onKeyEvent. The legacy API '
                  'still functions during the migration window but is no '
                  'longer evolved.',
                  style: _Type.bodyDim,
                ),
                SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _DeprecChip('@Deprecated since 3.18', _Palette.rust),
                    _DeprecChip('Use KeyEvent', _Palette.green),
                    _DeprecChip('Use HardwareKeyboard', _Palette.teal),
                    _DeprecChip('Migration: hard-deprecation pending',
                        _Palette.rustSoft),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DeprecChip extends StatelessWidget {
  final String label;
  final Color color;
  const _DeprecChip(this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.20),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.6)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 11,
          color: color,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 1 — Hero card
// ---------------------------------------------------------------------------
class _Hero extends StatelessWidget {
  const _Hero();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(22, 16, 22, 8),
      padding: EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _Palette.green.withValues(alpha: 0.30),
            _Palette.teal.withValues(alpha: 0.18),
            _Palette.violet.withValues(alpha: 0.10),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: _Palette.green.withValues(alpha: 0.45),
          width: 1.4,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      _Palette.green,
                      _Palette.emerald,
                      _Palette.teal,
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: _Palette.green.withValues(alpha: 0.55),
                      blurRadius: 30,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'A',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF051410),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('FLUTTER · SERVICES · LEGACY KEYBOARD',
                        style: _Type.caption.copyWith(
                          color: _Palette.greenSoft,
                          letterSpacing: 1.8,
                        )),
                    SizedBox(height: 6),
                    Text('RawKeyEventDataAndroid', style: _Type.heroTitle),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 18),
          Text(
            'The platform-specific subclass of RawKeyEventData carrying '
            'keyboard payloads forwarded from android.view.KeyEvent. It '
            'exposes the Android keyCode, the resolved code point with and '
            'without modifiers, the hardware scanCode, the metaState '
            'bit-field, and identifying details about the source InputDevice '
            '(eventSource, vendorId, productId, deviceId). All of this maps '
            'into Flutter\'s PhysicalKeyboardKey and LogicalKeyboardKey, but '
            'the RawKey* surface is now deprecated — KeyEvent and '
            'HardwareKeyboard are the supported entry points.',
            style: _Type.heroSub,
          ),
          SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _HeroChip('keyCode', _Palette.green),
              _HeroChip('plainCodePoint', _Palette.teal),
              _HeroChip('codePoint', _Palette.tealSoft),
              _HeroChip('scanCode', _Palette.amber),
              _HeroChip('metaState', _Palette.violet),
              _HeroChip('eventSource', _Palette.sky),
              _HeroChip('vendorId / productId', _Palette.rose),
              _HeroChip('deviceId', _Palette.greenSoft),
              _HeroChip('repeatCount', _Palette.emerald),
              _HeroChip('@Deprecated', _Palette.rust),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroChip extends StatelessWidget {
  final String label;
  final Color color;
  const _HeroChip(this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.55)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 12,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 2 — Anatomy diagram of the constructor.
// ---------------------------------------------------------------------------
class _AnatomySection extends StatelessWidget {
  const _AnatomySection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      index: 'SECTION 02',
      title: 'Anatomy of a constructor',
      lead:
          'The named constructor accepts ten parameters, each a slice of '
          'platform-reported keyboard state forwarded from android.view.'
          'KeyEvent and android.view.InputDevice. Most are optional integers '
          'with sensible defaults of zero.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CodeBlock([
            _CodeLine.tokens([
              _CodeTok('const ', _Type.codeKeyword),
              _CodeTok('RawKeyEventDataAndroid', _Type.codeType),
              _CodeTok('({'),
            ]),
            _CodeLine.tokens([
              _CodeTok('  this.flags', _Type.codeKeyword),
              _CodeTok(' = '),
              _CodeTok('0', _Type.codeNumber),
              _CodeTok(','),
            ]),
            _CodeLine.tokens([
              _CodeTok('  this.codePoint', _Type.codeKeyword),
              _CodeTok(' = '),
              _CodeTok('0', _Type.codeNumber),
              _CodeTok(','),
            ]),
            _CodeLine.tokens([
              _CodeTok('  this.plainCodePoint', _Type.codeKeyword),
              _CodeTok(' = '),
              _CodeTok('0', _Type.codeNumber),
              _CodeTok(','),
            ]),
            _CodeLine.tokens([
              _CodeTok('  this.keyCode', _Type.codeKeyword),
              _CodeTok(' = '),
              _CodeTok('0', _Type.codeNumber),
              _CodeTok(','),
            ]),
            _CodeLine.tokens([
              _CodeTok('  this.scanCode', _Type.codeKeyword),
              _CodeTok(' = '),
              _CodeTok('0', _Type.codeNumber),
              _CodeTok(','),
            ]),
            _CodeLine.tokens([
              _CodeTok('  this.metaState', _Type.codeKeyword),
              _CodeTok(' = '),
              _CodeTok('0', _Type.codeNumber),
              _CodeTok(','),
            ]),
            _CodeLine.tokens([
              _CodeTok('  this.eventSource', _Type.codeKeyword),
              _CodeTok(' = '),
              _CodeTok('0', _Type.codeNumber),
              _CodeTok(','),
            ]),
            _CodeLine.tokens([
              _CodeTok('  this.vendorId', _Type.codeKeyword),
              _CodeTok(' = '),
              _CodeTok('0', _Type.codeNumber),
              _CodeTok(','),
            ]),
            _CodeLine.tokens([
              _CodeTok('  this.productId', _Type.codeKeyword),
              _CodeTok(' = '),
              _CodeTok('0', _Type.codeNumber),
              _CodeTok(','),
            ]),
            _CodeLine.tokens([
              _CodeTok('  this.deviceId', _Type.codeKeyword),
              _CodeTok(' = '),
              _CodeTok('0', _Type.codeNumber),
              _CodeTok(','),
            ]),
            _CodeLine.tokens([
              _CodeTok('  this.repeatCount', _Type.codeKeyword),
              _CodeTok(' = '),
              _CodeTok('0', _Type.codeNumber),
              _CodeTok(','),
            ]),
            _CodeLine.plain('});'),
          ]),
          SizedBox(height: 18),
          _AnatomyArrow(
            color: _Palette.green,
            field: 'keyCode',
            description:
                'The Android KeyEvent.getKeyCode() value. A platform-specific '
                'numeric identifier such as KEYCODE_A (29) or KEYCODE_VOLUME_UP '
                '(24). Mapped to a LogicalKeyboardKey via androidKeyCodeMap.',
          ),
          _AnatomyArrow(
            color: _Palette.teal,
            field: 'plainCodePoint',
            description:
                'The Unicode code point produced by the key without applying '
                'any modifier keys (Shift / Alt / Ctrl). Useful for keymap-'
                'agnostic shortcut detection — Ctrl+A always reports plain '
                'code point 0x61 ("a").',
          ),
          _AnatomyArrow(
            color: _Palette.tealSoft,
            field: 'codePoint',
            description:
                'The Unicode code point with all modifiers applied. Shift+a '
                'reports 0x41 ("A"); AltGr combinations report the relevant '
                'composed character. Zero for non-printable keys.',
          ),
          _AnatomyArrow(
            color: _Palette.amber,
            field: 'scanCode',
            description:
                'KeyEvent.getScanCode() — the raw hardware scan code from '
                'the kernel input layer. Linux input event codes such as '
                'KEY_A (30). Mapped to PhysicalKeyboardKey via '
                'androidScanCodeMap.',
          ),
          _AnatomyArrow(
            color: _Palette.violet,
            field: 'metaState',
            description:
                'A bitmask of META_*_ON flags from KeyEvent.getMetaState(). '
                'Combines transient (Shift, Ctrl, Alt, Meta), locking '
                '(CapsLock, NumLock, ScrollLock), and side-specific '
                '(LEFT/RIGHT) bits.',
          ),
          _AnatomyArrow(
            color: _Palette.sky,
            field: 'eventSource',
            description:
                'KeyEvent.getSource() — a bitmask of InputDevice.SOURCE_* '
                'classes. Distinguishes keyboards from gamepads, D-pads, '
                'joysticks, HDMI remotes, and so on.',
          ),
          _AnatomyArrow(
            color: _Palette.rose,
            field: 'vendorId / productId',
            description:
                'Identifiers of the InputDevice that produced the event. '
                'Useful for fingerprinting specific HID devices, e.g., a '
                'particular Bluetooth gamepad model.',
          ),
          _AnatomyArrow(
            color: _Palette.greenSoft,
            field: 'deviceId',
            description:
                'KeyEvent.getDeviceId() — the runtime device id assigned by '
                'the framework. Useful to correlate key down/up events with '
                'a single physical device.',
          ),
          _AnatomyArrow(
            color: _Palette.emerald,
            field: 'repeatCount',
            description:
                'KeyEvent.getRepeatCount() — zero on the first key-down, '
                'incremented while the key is auto-repeating. Always zero '
                'for key-up events.',
          ),
          _AnatomyArrow(
            color: _Palette.rustSoft,
            field: 'flags',
            description:
                'KeyEvent.getFlags() — implementation-private bitmask used '
                'by Flutter\'s framework to track event characteristics '
                '(canceled, long-press, virtual hard key, etc.).',
          ),
        ],
      ),
    );
  }
}

class _AnatomyArrow extends StatelessWidget {
  final Color color;
  final String field;
  final String description;
  const _AnatomyArrow({
    required this.color,
    required this.field,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8,
            height: 8,
            margin: EdgeInsets.only(top: 6, right: 10),
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.6),
                  blurRadius: 6,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
          Container(
            width: 150,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: color.withValues(alpha: 0.45)),
            ),
            child: Text(
              field,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: color,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(description, style: _Type.bodyDim),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 3 — Sample event journeys.
// Four illustrative key presses showing how the same RawKeyEventDataAndroid
// shape carries very different payloads.
// ---------------------------------------------------------------------------
class _EventJourneySection extends StatelessWidget {
  const _EventJourneySection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      index: 'SECTION 03',
      title: 'Sample event journeys',
      lead:
          'Four representative key presses, with the integers that Android '
          'reports and the decoded interpretation Flutter derives.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _JourneyCard(
            title: 'Press the "A" key, no modifiers',
            sequence: 'KEY_A  →  KEYCODE_A  →  RawKeyEventDataAndroid',
            keyLabel: 'A',
            color: _Palette.green,
            fields: [
              _JourneyField('keyCode', '29', '0x0000001D · KEYCODE_A'),
              _JourneyField('plainCodePoint', '97', '0x61 · "a"'),
              _JourneyField('codePoint', '97', '0x61 · "a"'),
              _JourneyField('scanCode', '30', '0x1E · KEY_A (linux input)'),
              _JourneyField('metaState', '0', 'no modifiers'),
              _JourneyField('eventSource', '0x101', 'SOURCE_KEYBOARD'),
              _JourneyField('repeatCount', '0', 'first press'),
            ],
            decoded: 'logicalKey: LogicalKeyboardKey.keyA  ·  '
                'physicalKey: PhysicalKeyboardKey.keyA  ·  '
                'character: "a"',
          ),
          SizedBox(height: 14),
          _JourneyCard(
            title: 'Press Shift+A',
            sequence: 'KEY_LEFTSHIFT held  →  KEY_A  →  Android dispatches',
            keyLabel: 'A',
            color: _Palette.amber,
            fields: [
              _JourneyField('keyCode', '29', '0x0000001D · KEYCODE_A'),
              _JourneyField('plainCodePoint', '97', '0x61 · "a"'),
              _JourneyField(
                  'codePoint', '65', '0x41 · "A" (shifted)'),
              _JourneyField('scanCode', '30', '0x1E · KEY_A'),
              _JourneyField(
                  'metaState',
                  '0x41',
                  'META_SHIFT_ON | META_SHIFT_LEFT_ON'),
              _JourneyField('eventSource', '0x101', 'SOURCE_KEYBOARD'),
              _JourneyField('repeatCount', '0', 'first press'),
            ],
            decoded:
                'logicalKey: LogicalKeyboardKey.keyA  ·  '
                'character: "A"  ·  isShiftPressed: true',
          ),
          SizedBox(height: 14),
          _JourneyCard(
            title: 'Press Ctrl+C (copy)',
            sequence: 'KEY_LEFTCTRL held  →  KEY_C  →  Android dispatches',
            keyLabel: 'C',
            color: _Palette.violet,
            fields: [
              _JourneyField('keyCode', '31', '0x0000001F · KEYCODE_C'),
              _JourneyField('plainCodePoint', '99', '0x63 · "c"'),
              _JourneyField('codePoint', '0',
                  'no character: control modifier suppresses output'),
              _JourneyField('scanCode', '46', '0x2E · KEY_C'),
              _JourneyField('metaState', '0x3000',
                  'META_CTRL_ON | META_CTRL_LEFT_ON'),
              _JourneyField('eventSource', '0x101', 'SOURCE_KEYBOARD'),
              _JourneyField('repeatCount', '0', 'first press'),
            ],
            decoded:
                'logicalKey: LogicalKeyboardKey.keyC  ·  '
                'isControlPressed: true  ·  shortcut Ctrl+C',
          ),
          SizedBox(height: 14),
          _JourneyCard(
            title: 'Press Volume Up (TV remote)',
            sequence:
                'IR remote  →  HDMI-CEC  →  KEYCODE_VOLUME_UP',
            keyLabel: '+',
            color: _Palette.sky,
            fields: [
              _JourneyField(
                  'keyCode', '24', '0x00000018 · KEYCODE_VOLUME_UP'),
              _JourneyField('plainCodePoint', '0', 'non-printable'),
              _JourneyField('codePoint', '0', 'non-printable'),
              _JourneyField('scanCode', '115', '0x73 · KEY_VOLUMEUP'),
              _JourneyField('metaState', '0', 'no modifiers'),
              _JourneyField(
                  'eventSource', '0x02000001', 'SOURCE_HDMI'),
              _JourneyField('vendorId', '0x1949', 'Amazon'),
              _JourneyField('productId', '0x0419', 'Fire TV remote'),
              _JourneyField('repeatCount', '0', 'first press'),
            ],
            decoded:
                'logicalKey: LogicalKeyboardKey.audioVolumeUp  ·  '
                'physicalKey: PhysicalKeyboardKey.audioVolumeUp',
          ),
        ],
      ),
    );
  }
}

class _JourneyField {
  final String name;
  final String value;
  final String note;
  const _JourneyField(this.name, this.value, this.note);
}

class _JourneyCard extends StatelessWidget {
  final String title;
  final String sequence;
  final String keyLabel;
  final Color color;
  final List<_JourneyField> fields;
  final String decoded;
  const _JourneyCard({
    required this.title,
    required this.sequence,
    required this.keyLabel,
    required this.color,
    required this.fields,
    required this.decoded,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _Palette.panelAlt,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.55), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.20),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: color.withValues(alpha: 0.7), width: 1.4),
                  boxShadow: [
                    BoxShadow(
                      color: color.withValues(alpha: 0.45),
                      blurRadius: 14,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    keyLabel,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: color,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: TextStyle(
                          fontSize: 16,
                          color: _Palette.textPrimary,
                          fontWeight: FontWeight.w700,
                        )),
                    SizedBox(height: 4),
                    Text(sequence,
                        style: _Type.code.copyWith(
                            color: _Palette.textMuted, fontSize: 11)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 14),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _Palette.codeBg,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _Palette.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final f in fields) _journeyRow(f, color),
              ],
            ),
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: color.withValues(alpha: 0.45)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.arrow_forward, color: color, size: 16),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    decoded,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      color: _Palette.textPrimary,
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

  Widget _journeyRow(_JourneyField f, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(f.name, style: _Type.codeKeyword),
          ),
          SizedBox(
            width: 80,
            child: Text(f.value, style: _Type.codeNumber),
          ),
          Expanded(
            child: Text(f.note, style: _Type.codeComment),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 4 — Modifier flag bit-field visualization.
// Render metaState as a 32-bit binary, with the active META_*_ON bits
// highlighted and labelled.
// ---------------------------------------------------------------------------
class _ModifierBitsSection extends StatelessWidget {
  const _ModifierBitsSection();

  @override
  Widget build(BuildContext context) {
    // Sample metaState: Shift+CapsLock+NumLock with side info.
    final int sample = _Meta.shiftOn |
        _Meta.shiftLeftOn |
        _Meta.capsLockOn |
        _Meta.numLockOn;
    return _SectionFrame(
      index: 'SECTION 04',
      title: 'metaState · the modifier bit-field',
      lead:
          'metaState is a single 32-bit integer assembled from many '
          'META_*_ON flags. Flutter\'s isModifierPressed(...) helpers test '
          'individual bits. Below is a sample state showing left-Shift held '
          'while CapsLock and NumLock are locked on.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _bitGrid(sample),
          SizedBox(height: 18),
          _flagLegend(),
          SizedBox(height: 18),
          _CodeBlock([
            _CodeLine.tokens([
              _CodeTok('// Test individual bits.', _Type.codeComment),
            ]),
            _CodeLine.tokens([
              _CodeTok('bool ', _Type.codeKeyword),
              _CodeTok('shift '),
              _CodeTok('= '),
              _CodeTok('(metaState & '),
              _CodeTok('0x01', _Type.codeNumber),
              _CodeTok(') != '),
              _CodeTok('0', _Type.codeNumber),
              _CodeTok(';'),
            ]),
            _CodeLine.tokens([
              _CodeTok('bool ', _Type.codeKeyword),
              _CodeTok('ctrl  '),
              _CodeTok('= '),
              _CodeTok('(metaState & '),
              _CodeTok('0x1000', _Type.codeNumber),
              _CodeTok(') != '),
              _CodeTok('0', _Type.codeNumber),
              _CodeTok(';'),
            ]),
            _CodeLine.tokens([
              _CodeTok('bool ', _Type.codeKeyword),
              _CodeTok('caps  '),
              _CodeTok('= '),
              _CodeTok('(metaState & '),
              _CodeTok('0x100000', _Type.codeNumber),
              _CodeTok(') != '),
              _CodeTok('0', _Type.codeNumber),
              _CodeTok(';'),
            ]),
            _CodeLine.blank(),
            _CodeLine.tokens([
              _CodeTok('// Or, idiomatically:', _Type.codeComment),
            ]),
            _CodeLine.tokens([
              _CodeTok('event.isShiftPressed', _Type.codeKeyword),
              _CodeTok(';'),
            ]),
            _CodeLine.tokens([
              _CodeTok('event.isControlPressed', _Type.codeKeyword),
              _CodeTok(';'),
            ]),
            _CodeLine.tokens([
              _CodeTok('event.isAltPressed', _Type.codeKeyword),
              _CodeTok(';'),
            ]),
            _CodeLine.tokens([
              _CodeTok('event.isMetaPressed', _Type.codeKeyword),
              _CodeTok(';'),
            ]),
          ]),
        ],
      ),
    );
  }

  Widget _bitGrid(int sample) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _Palette.codeBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _Palette.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '0x${sample.toRadixString(16).padLeft(8, '0').toUpperCase()}'
            '   (decimal ${sample})',
            style: _Type.codeNumber.copyWith(fontSize: 14),
          ),
          SizedBox(height: 10),
          Wrap(
            spacing: 4,
            runSpacing: 4,
            children: [
              for (int bit = 31; bit >= 0; bit--)
                _bitCell(bit, ((sample >> bit) & 1) == 1),
            ],
          ),
        ],
      ),
    );
  }

  Widget _bitCell(int bit, bool on) {
    return Container(
      width: 22,
      height: 28,
      decoration: BoxDecoration(
        color: on
            ? _Palette.green.withValues(alpha: 0.45)
            : _Palette.panelAlt,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: on
              ? _Palette.green.withValues(alpha: 0.85)
              : _Palette.border,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            on ? '1' : '0',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: on ? _Palette.textPrimary : _Palette.textMuted,
            ),
          ),
          Text(
            '$bit',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 8,
              color: _Palette.textMuted,
            ),
          ),
        ],
      ),
    );
  }

  Widget _flagLegend() {
    final flags = <List<dynamic>>[
      ['META_SHIFT_ON', _Meta.shiftOn, _Palette.green, 'either Shift held'],
      ['META_SHIFT_LEFT_ON', _Meta.shiftLeftOn, _Palette.greenSoft,
          'left Shift held'],
      ['META_SHIFT_RIGHT_ON', _Meta.shiftRightOn, _Palette.greenSoft,
          'right Shift held'],
      ['META_ALT_ON', _Meta.altOn, _Palette.amber, 'either Alt held'],
      ['META_ALT_LEFT_ON', _Meta.altLeftOn, _Palette.amber, 'left Alt held'],
      ['META_ALT_RIGHT_ON', _Meta.altRightOn, _Palette.amber,
          'right Alt held'],
      ['META_CTRL_ON', _Meta.ctrlOn, _Palette.violet, 'either Ctrl held'],
      ['META_CTRL_LEFT_ON', _Meta.ctrlLeftOn, _Palette.violet,
          'left Ctrl held'],
      ['META_CTRL_RIGHT_ON', _Meta.ctrlRightOn, _Palette.violet,
          'right Ctrl held'],
      ['META_META_ON', _Meta.metaOn, _Palette.sky,
          'either Meta (Cmd/Win) held'],
      ['META_META_LEFT_ON', _Meta.metaLeftOn, _Palette.sky,
          'left Meta held'],
      ['META_META_RIGHT_ON', _Meta.metaRightOn, _Palette.sky,
          'right Meta held'],
      ['META_FUNCTION_ON', _Meta.functionOn, _Palette.rustSoft,
          'Fn (laptop) held'],
      ['META_SYM_ON', _Meta.symOn, _Palette.rustSoft, 'Sym key held'],
      ['META_CAPS_LOCK_ON', _Meta.capsLockOn, _Palette.rose,
          'CapsLock latched'],
      ['META_NUM_LOCK_ON', _Meta.numLockOn, _Palette.rose,
          'NumLock latched'],
      ['META_SCROLL_LOCK_ON', _Meta.scrollLockOn, _Palette.rose,
          'ScrollLock latched'],
    ];
    return Wrap(
      spacing: 10,
      runSpacing: 8,
      children: [
        for (final f in flags)
          _legendChip(
              f[0] as String, f[1] as int, f[2] as Color, f[3] as String),
      ],
    );
  }

  Widget _legendChip(String name, int value, Color color, String note) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            name,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(width: 8),
          Text(
            '0x${value.toRadixString(16).toUpperCase()}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: _Palette.textMuted,
            ),
          ),
          SizedBox(width: 8),
          Text(
            note,
            style: TextStyle(
              fontSize: 11,
              color: _Palette.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 5 — Sibling subclasses comparison.
// ---------------------------------------------------------------------------
class _SiblingsSection extends StatelessWidget {
  const _SiblingsSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      index: 'SECTION 05',
      title: 'Sibling RawKeyEventData subclasses',
      lead:
          'RawKeyEventDataAndroid is one of seven platform-specific '
          'subclasses. Each maps the same conceptual event from the '
          'underlying OS into Flutter\'s shared logical/physical key types. '
          'All seven are deprecated in favour of KeyEvent.',
      child: Column(
        children: [
          _SiblingRow(
            platform: 'Android',
            primaryFields: 'keyCode · scanCode · metaState · eventSource',
            color: _Palette.green,
            blurb:
                'This file. Wraps android.view.KeyEvent + InputDevice. The '
                'richest payload of the seven, including vendor / product '
                'id and event source classification.',
            highlight: true,
          ),
          _SiblingRow(
            platform: 'iOS',
            primaryFields: 'keyCode · charactersIgnoringModifiers · '
                'modifiers',
            color: _Palette.sky,
            blurb:
                'Wraps UIKey from UIKit. Carries character strings rather '
                'than code points; modifiers is a bitmask of '
                'UIKeyModifierFlag values.',
          ),
          _SiblingRow(
            platform: 'macOS',
            primaryFields: 'keyCode · characters · '
                'charactersIgnoringModifiers · modifiers',
            color: _Palette.violet,
            blurb:
                'Wraps NSEvent. Distinct keyCode space (USB HID-derived). '
                'Modifiers map to NSEventModifierFlags. Function key '
                'detection differs from iOS.',
          ),
          _SiblingRow(
            platform: 'Linux',
            primaryFields: 'toolkit · keyCode · scanCode · unicodeScalarValues '
                '· modifiers',
            color: _Palette.amber,
            blurb:
                'Wraps the toolkit-reported event (GTK / GLFW / Qt). '
                'Includes a discriminator for the toolkit so the framework '
                'can pick the right keymap.',
          ),
          _SiblingRow(
            platform: 'Web',
            primaryFields: 'code · key · location · metaState',
            color: _Palette.rose,
            blurb:
                'Wraps the DOM KeyboardEvent. code is a string identifier '
                '("KeyA"); key is the produced character. metaState is a '
                'Flutter-side composite for cross-platform compat.',
          ),
          _SiblingRow(
            platform: 'Windows',
            primaryFields: 'keyCode · scanCode · characterCodePoint · '
                'modifiers',
            color: _Palette.tealSoft,
            blurb:
                'Wraps WM_KEYDOWN / WM_KEYUP / WM_CHAR. Keymap is the Win32 '
                'virtual-key space; modifiers tracks GetKeyState bits for '
                'Ctrl / Shift / Alt.',
          ),
          _SiblingRow(
            platform: 'Fuchsia',
            primaryFields: 'hidUsage · codePoint · modifiers',
            color: _Palette.greenSoft,
            blurb:
                'The simplest of the bunch — three integers from the '
                'Fuchsia input pipeline. hidUsage is a USB HID usage code.',
          ),
        ],
      ),
    );
  }
}

class _SiblingRow extends StatelessWidget {
  final String platform;
  final String primaryFields;
  final Color color;
  final String blurb;
  final bool highlight;
  const _SiblingRow({
    required this.platform,
    required this.primaryFields,
    required this.color,
    required this.blurb,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: highlight
            ? color.withValues(alpha: 0.18)
            : _Palette.panelAlt,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: highlight
              ? color.withValues(alpha: 0.7)
              : _Palette.border,
          width: highlight ? 1.4 : 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.22),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: color.withValues(alpha: 0.6)),
            ),
            child: Center(
              child: Text(
                platform,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: color,
                  letterSpacing: 0.6,
                ),
              ),
            ),
          ),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'RawKeyEventData$platform',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13,
                    color: _Palette.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4),
                Text(primaryFields,
                    style: _Type.codeKeyword.copyWith(fontSize: 11)),
                SizedBox(height: 8),
                Text(blurb, style: _Type.bodyDim),
              ],
            ),
          ),
          if (highlight)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.30),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'THIS DEMO',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: color,
                  letterSpacing: 1.2,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 6 — Event source enum cards.
// ---------------------------------------------------------------------------
class _EventSourceSection extends StatelessWidget {
  const _EventSourceSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      index: 'SECTION 06',
      title: 'eventSource · InputDevice.SOURCE_*',
      lead:
          'eventSource is a bitmask classifying the device that generated '
          'the event. Multiple bits can be set: a Fire TV remote reports '
          'SOURCE_DPAD | SOURCE_KEYBOARD | SOURCE_HDMI. Below are the '
          'classes Flutter maps for keyboard and remote-style events.',
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [
          _SourceCard('SOURCE_KEYBOARD', _Source.keyboard, _Palette.green,
              'Standard physical or soft keyboards', Icons.keyboard),
          _SourceCard('SOURCE_DPAD', _Source.dpad, _Palette.amber,
              'D-pad on remotes / handhelds', Icons.gamepad),
          _SourceCard('SOURCE_GAMEPAD', _Source.gamepad, _Palette.violet,
              'Gamepad buttons (A / B / X / Y)', Icons.sports_esports),
          _SourceCard('SOURCE_JOYSTICK', _Source.joystick, _Palette.sky,
              'Analog stick events', Icons.gamepad_outlined),
          _SourceCard('SOURCE_HDMI', _Source.hdmi, _Palette.rose,
              'HDMI-CEC remote (Android TV)', Icons.tv),
          _SourceCard('SOURCE_MOUSE', _Source.mouse, _Palette.tealSoft,
              'Mouse buttons reported as keys', Icons.mouse),
          _SourceCard('SOURCE_TOUCHSCREEN', _Source.touchscreen,
              _Palette.teal, 'Soft keys on touchscreen IMEs',
              Icons.touch_app),
          _SourceCard('SOURCE_TRACKBALL', _Source.trackball,
              _Palette.greenSoft, 'Trackball / scroll-wheel keys',
              Icons.adjust),
          _SourceCard('SOURCE_UNKNOWN', _Source.unknown, _Palette.textMuted,
              'No InputDevice info available', Icons.help_outline),
        ],
      ),
    );
  }
}

class _SourceCard extends StatelessWidget {
  final String name;
  final int value;
  final Color color;
  final String description;
  final IconData icon;
  const _SourceCard(
      this.name, this.value, this.color, this.description, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _Palette.panelAlt,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    color: color,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            '0x${value.toRadixString(16).padLeft(8, '0').toUpperCase()}',
            style: _Type.codeNumber,
          ),
          SizedBox(height: 8),
          Text(description, style: _Type.bodyDim.copyWith(fontSize: 12)),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 7 — keyDown lookup flow.
// ---------------------------------------------------------------------------
class _KeyDownFlowSection extends StatelessWidget {
  const _KeyDownFlowSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      index: 'SECTION 07',
      title: 'From keyCode to LogicalKeyboardKey',
      lead:
          'When a key-down event arrives, RawKeyEventDataAndroid resolves '
          'logicalKey by consulting two lookup tables and a fallback. The '
          'flow below shows the priority order.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _flowStep(
            n: '1',
            color: _Palette.green,
            title: 'kAndroidNumPadMap',
            body:
                'If keyCode falls inside the numpad range and NumLock is on, '
                'pick the numpad-specific logical key (NumPad0..NumPad9, '
                'NumpadAdd, NumpadEnter, …).',
          ),
          _flowArrow(),
          _flowStep(
            n: '2',
            color: _Palette.teal,
            title: 'kAndroidToLogicalKey',
            body:
                'Otherwise, look up the keyCode in the platform-specific '
                'mapping table generated from Chromium\'s key-codes data. '
                'Returns logical keys such as keyA, audioVolumeUp, '
                'mediaPlayPause.',
          ),
          _flowArrow(),
          _flowStep(
            n: '3',
            color: _Palette.amber,
            title: 'codePoint fallback',
            body:
                'If the keyCode is unmapped but the event has a printable '
                'codePoint, synthesize a Unicode-plane logical key using '
                'LogicalKeyboardKey.fromKeyCode((codePoint | androidPlane)).',
          ),
          _flowArrow(),
          _flowStep(
            n: '4',
            color: _Palette.rose,
            title: 'undefined',
            body:
                'No keyCode, no codePoint → LogicalKeyboardKey(0). Apps '
                'should treat this as "key not understood".',
          ),
          SizedBox(height: 14),
          _CodeBlock([
            _CodeLine.tokens([
              _CodeTok('// Approximate framework logic.', _Type.codeComment),
            ]),
            _CodeLine.tokens([
              _CodeTok('LogicalKeyboardKey ', _Type.codeType),
              _CodeTok('get '),
              _CodeTok('logicalKey', _Type.codeKeyword),
              _CodeTok(' {'),
            ]),
            _CodeLine.tokens([
              _CodeTok('  if', _Type.codeKeyword),
              _CodeTok(' (kAndroidNumPadMap.containsKey(keyCode)) {'),
            ]),
            _CodeLine.tokens([
              _CodeTok('    return ', _Type.codeKeyword),
              _CodeTok('kAndroidNumPadMap[keyCode]!;'),
            ]),
            _CodeLine.plain('  }'),
            _CodeLine.tokens([
              _CodeTok('  final ', _Type.codeKeyword),
              _CodeTok('mapped '),
              _CodeTok('= kAndroidToLogicalKey[keyCode];'),
            ]),
            _CodeLine.tokens([
              _CodeTok('  if', _Type.codeKeyword),
              _CodeTok(' (mapped != null) '),
              _CodeTok('return ', _Type.codeKeyword),
              _CodeTok('mapped;'),
            ]),
            _CodeLine.tokens([
              _CodeTok('  if', _Type.codeKeyword),
              _CodeTok(' (codePoint != '),
              _CodeTok('0', _Type.codeNumber),
              _CodeTok(') {'),
            ]),
            _CodeLine.tokens([
              _CodeTok('    return ', _Type.codeKeyword),
              _CodeTok('LogicalKeyboardKey('),
            ]),
            _CodeLine.tokens([
              _CodeTok('        codePoint | LogicalKeyboardKey.androidPlane'),
            ]),
            _CodeLine.plain('    );'),
            _CodeLine.plain('  }'),
            _CodeLine.tokens([
              _CodeTok('  return ', _Type.codeKeyword),
              _CodeTok('LogicalKeyboardKey('),
              _CodeTok('0', _Type.codeNumber),
              _CodeTok(');'),
            ]),
            _CodeLine.plain('}'),
          ]),
        ],
      ),
    );
  }

  Widget _flowStep({
    required String n,
    required Color color,
    required String title,
    required String body,
  }) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _Palette.panelAlt,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.55)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.22),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: color.withValues(alpha: 0.7)),
            ),
            child: Center(
              child: Text(
                n,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 16,
                  color: color,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: _Type.codeKeyword.copyWith(fontSize: 14)),
                SizedBox(height: 6),
                Text(body, style: _Type.bodyDim),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _flowArrow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 18),
      child: Row(
        children: [
          SizedBox(width: 12),
          Container(width: 2, height: 16, color: _Palette.border),
          SizedBox(width: 8),
          Icon(Icons.arrow_downward,
              color: _Palette.textMuted, size: 14),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 8 — Migration card with side-by-side code.
// ---------------------------------------------------------------------------
class _MigrationSection extends StatelessWidget {
  const _MigrationSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      index: 'SECTION 08',
      title: 'Migration · RawKeyEvent → KeyEvent',
      lead:
          'The legacy raw API (RawKeyboard.instance, RawKeyboardListener, '
          'event.data as RawKeyEventDataAndroid) is replaced by the new '
          'HardwareKeyboard / KeyEvent API. The two paths can run side by '
          'side during the transition, but new code should use only the '
          'new API.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _MigrationColumn(
                  label: 'BEFORE  ·  legacy',
                  color: _Palette.rust,
                  lines: [
                    _CodeLine.tokens([
                      _CodeTok('RawKeyboardListener', _Type.codeType),
                      _CodeTok('('),
                    ]),
                    _CodeLine.tokens([
                      _CodeTok('  focusNode: ', _Type.codeKeyword),
                      _CodeTok('node,'),
                    ]),
                    _CodeLine.tokens([
                      _CodeTok('  onKey: ', _Type.codeKeyword),
                      _CodeTok('(RawKeyEvent e) {'),
                    ]),
                    _CodeLine.tokens([
                      _CodeTok('    if', _Type.codeKeyword),
                      _CodeTok(' (e is RawKeyDownEvent) {'),
                    ]),
                    _CodeLine.tokens([
                      _CodeTok('      final data ', _Type.codeKeyword),
                      _CodeTok('= e.data '),
                      _CodeTok('as ', _Type.codeKeyword),
                      _CodeTok('RawKeyEventDataAndroid;', _Type.codeType),
                    ]),
                    _CodeLine.tokens([
                      _CodeTok('      print(data.keyCode);'),
                    ]),
                    _CodeLine.tokens([
                      _CodeTok('      print(data.metaState);'),
                    ]),
                    _CodeLine.plain('    }'),
                    _CodeLine.plain('  },'),
                    _CodeLine.tokens([
                      _CodeTok('  child: ', _Type.codeKeyword),
                      _CodeTok('child,'),
                    ]),
                    _CodeLine.plain(');'),
                  ],
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: _MigrationColumn(
                  label: 'AFTER  ·  KeyEvent',
                  color: _Palette.green,
                  lines: [
                    _CodeLine.tokens([
                      _CodeTok('KeyboardListener', _Type.codeType),
                      _CodeTok('('),
                    ]),
                    _CodeLine.tokens([
                      _CodeTok('  focusNode: ', _Type.codeKeyword),
                      _CodeTok('node,'),
                    ]),
                    _CodeLine.tokens([
                      _CodeTok('  onKeyEvent: ', _Type.codeKeyword),
                      _CodeTok('(KeyEvent e) {'),
                    ]),
                    _CodeLine.tokens([
                      _CodeTok('    if', _Type.codeKeyword),
                      _CodeTok(' (e is KeyDownEvent) {'),
                    ]),
                    _CodeLine.tokens([
                      _CodeTok('      print(e.logicalKey);'),
                    ]),
                    _CodeLine.tokens([
                      _CodeTok('      print(e.physicalKey);'),
                    ]),
                    _CodeLine.tokens([
                      _CodeTok('      print(HardwareKeyboard'),
                    ]),
                    _CodeLine.tokens([
                      _CodeTok('          .instance.isShiftPressed);'),
                    ]),
                    _CodeLine.plain('    }'),
                    _CodeLine.plain('  },'),
                    _CodeLine.tokens([
                      _CodeTok('  child: ', _Type.codeKeyword),
                      _CodeTok('child,'),
                    ]),
                    _CodeLine.plain(');'),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 18),
          _MigrationMappingTable(),
        ],
      ),
    );
  }
}

class _MigrationColumn extends StatelessWidget {
  final String label;
  final Color color;
  final List<_CodeLine> lines;
  const _MigrationColumn({
    required this.label,
    required this.color,
    required this.lines,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.20),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: color.withValues(alpha: 0.6)),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: color,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
        ),
        SizedBox(height: 8),
        _CodeBlock(lines, padding: EdgeInsets.all(12)),
      ],
    );
  }
}

class _MigrationMappingTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final rows = <List<String>>[
      ['RawKeyEventDataAndroid.keyCode',
          'KeyEvent.logicalKey  (already mapped)'],
      ['RawKeyEventDataAndroid.scanCode',
          'KeyEvent.physicalKey  (already mapped)'],
      ['data.metaState bit tests',
          'HardwareKeyboard.instance.isShiftPressed, …'],
      ['data.codePoint',
          'KeyEvent.character'],
      ['data.repeatCount > 0',
          'event is KeyRepeatEvent'],
      ['RawKeyDownEvent / RawKeyUpEvent',
          'KeyDownEvent / KeyUpEvent'],
      ['RawKeyboard.instance.addListener',
          'HardwareKeyboard.instance.addHandler'],
      ['RawKeyboardListener',
          'KeyboardListener'],
      ['Focus(onKey: ...)',
          'Focus(onKeyEvent: ...)'],
    ];
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _Palette.panelAlt,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _Palette.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text('LEGACY',
                    style: _Type.caption.copyWith(
                        color: _Palette.rust, fontWeight: FontWeight.w800)),
              ),
              Icon(Icons.arrow_forward,
                  color: _Palette.textMuted, size: 14),
              SizedBox(width: 6),
              Expanded(
                child: Text('MODERN',
                    style: _Type.caption.copyWith(
                        color: _Palette.green,
                        fontWeight: FontWeight.w800)),
              ),
            ],
          ),
          SizedBox(height: 10),
          for (final r in rows)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(r[0],
                        style: _Type.code.copyWith(
                            color: _Palette.rustSoft, fontSize: 11)),
                  ),
                  Icon(Icons.arrow_right_alt,
                      color: _Palette.textMuted, size: 14),
                  SizedBox(width: 6),
                  Expanded(
                    child: Text(r[1],
                        style: _Type.code.copyWith(
                            color: _Palette.greenSoft, fontSize: 11)),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 9 — Pitfalls.
// ---------------------------------------------------------------------------
class _PitfallsSection extends StatelessWidget {
  const _PitfallsSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      index: 'SECTION 09',
      title: 'Pitfalls and gotchas',
      lead:
          'A short tour of the most common mistakes when reading '
          'RawKeyEventDataAndroid directly. Most are solved automatically by '
          'KeyEvent — yet another reason to migrate.',
      child: Column(
        children: [
          _Pitfall(
            color: _Palette.rust,
            title: 'Trusting codePoint for shortcuts',
            body:
                'codePoint is post-modifier. Ctrl+A reports codePoint = 0; '
                'Shift+a reports codePoint = "A". Always use plainCodePoint '
                'for shortcut detection — or, better, use logicalKey.',
          ),
          _Pitfall(
            color: _Palette.amber,
            title: 'Confusing keyCode with scanCode',
            body:
                'keyCode is logical (Android keymap), scanCode is physical '
                '(linux input layer). Two keyboards with different layouts '
                'can produce different keyCodes for the same scanCode.',
          ),
          _Pitfall(
            color: _Palette.violet,
            title: 'Locking modifier latching',
            body:
                'CapsLock / NumLock / ScrollLock bits stay on across events '
                'until pressed again. They reflect lock state, not whether '
                'the key is currently held down.',
          ),
          _Pitfall(
            color: _Palette.sky,
            title: 'eventSource bitmask is a set',
            body:
                'Do not use == to compare eventSource against a single '
                'SOURCE_* value. Use bitmask AND. A Fire TV remote reports '
                'three classes simultaneously.',
          ),
          _Pitfall(
            color: _Palette.rose,
            title: 'repeatCount on key-up',
            body:
                'repeatCount is always 0 on key-up events, even if the key '
                'was being auto-repeated. Track repeats off the key-down '
                'stream.',
          ),
          _Pitfall(
            color: _Palette.tealSoft,
            title: 'Casting blindly',
            body:
                '`event.data as RawKeyEventDataAndroid` will throw if the '
                'event came from the iOS or Web platform during multi-'
                'platform debugging. Always check `Platform.isAndroid` or '
                'use pattern matching.',
          ),
          _Pitfall(
            color: _Palette.emerald,
            title: 'Stale modifier flags',
            body:
                'metaState reflects the platform-reported state at the '
                'moment the key was dispatched. It does not include any '
                'modifiers held down by software IMEs that were not '
                'flushed.',
          ),
          _Pitfall(
            color: _Palette.greenSoft,
            title: 'Vendor / product id absence',
            body:
                'vendorId and productId are 0 for many built-in keyboards '
                'and emulators. Do not rely on them as a primary device '
                'discriminator.',
          ),
        ],
      ),
    );
  }
}

class _Pitfall extends StatelessWidget {
  final Color color;
  final String title;
  final String body;
  const _Pitfall({
    required this.color,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: _Palette.panelAlt,
        borderRadius: BorderRadius.circular(10),
        border: Border(
          left: BorderSide(color: color, width: 4),
          top: BorderSide(color: _Palette.border, width: 1),
          right: BorderSide(color: _Palette.border, width: 1),
          bottom: BorderSide(color: _Palette.border, width: 1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.error_outline, color: color, size: 18),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    color: _Palette.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4),
                Text(body, style: _Type.bodyDim),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 10 — Inheritance ladder.
// ---------------------------------------------------------------------------
class _InheritanceSection extends StatelessWidget {
  const _InheritanceSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      index: 'SECTION 10',
      title: 'Inheritance chain',
      lead:
          'RawKeyEventDataAndroid sits inside Flutter\'s class hierarchy. '
          'Knowing the chain helps when reading framework code or stack '
          'traces.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ladderRung('Object', _Palette.textMuted,
              'The root of every Dart class.'),
          _ladderConnector(),
          _ladderRung('Diagnosticable', _Palette.sky,
              'Provides debugFillProperties so framework events can render '
              'nicely in DevTools.'),
          _ladderConnector(),
          _ladderRung('RawKeyEventData', _Palette.violet,
              'Abstract base for platform-specific event payloads. Defines '
              'logicalKey, physicalKey, isModifierPressed, keyLabel.'),
          _ladderConnector(),
          _ladderRung('RawKeyEventDataAndroid', _Palette.green,
              'This class. Adds Android-specific fields and overrides '
              'logicalKey / physicalKey to walk the kAndroid* lookup '
              'tables.',
              highlight: true),
        ],
      ),
    );
  }

  Widget _ladderRung(String name, Color color, String desc,
      {bool highlight = false}) {
    return Container(
      padding: EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: highlight
            ? color.withValues(alpha: 0.18)
            : _Palette.panelAlt,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: highlight
              ? color.withValues(alpha: 0.7)
              : _Palette.border,
          width: highlight ? 1.4 : 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.22),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              name,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: color,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(desc, style: _Type.bodyDim),
          ),
        ],
      ),
    );
  }

  Widget _ladderConnector() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 30),
      child: Column(
        children: [
          Container(width: 2, height: 12, color: _Palette.border),
          Icon(Icons.arrow_drop_down,
              color: _Palette.textMuted, size: 18),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 11 — Footer.
// ---------------------------------------------------------------------------
class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(22, 14, 22, 26),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _Palette.panel,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _Palette.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [
                    _Palette.green,
                    _Palette.teal,
                  ]),
                ),
                child: Center(
                  child: Text(
                    'A',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF051410),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Text(
                'RawKeyEventDataAndroid · visual deep demo',
                style: TextStyle(
                  fontSize: 13,
                  color: _Palette.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            'Hand-authored static demo for D4rt AST regression testing. '
            'Renders entirely from compile-time data; no controllers, no '
            'futures, no streams. The class under documentation is part of '
            'package:flutter/services.dart and is currently @Deprecated — '
            'consume KeyEvent through HardwareKeyboard for new code.',
            style: _Type.bodyDim,
          ),
          SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _footerBadge('Flutter', _Palette.green),
              _footerBadge('services.dart', _Palette.teal),
              _footerBadge('legacy raw keyboard', _Palette.rust),
              _footerBadge('static analyser-clean', _Palette.amber),
            ],
          ),
        ],
      ),
    );
  }

  Widget _footerBadge(String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.55)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 11,
          color: color,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Root scaffold + entry point.
// ---------------------------------------------------------------------------
class _Demo extends StatelessWidget {
  const _Demo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _Palette.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _DeprecationBanner(),
              _Hero(),
              _AnatomySection(),
              _EventJourneySection(),
              _ModifierBitsSection(),
              _SiblingsSection(),
              _EventSourceSection(),
              _KeyDownFlowSection(),
              _MigrationSection(),
              _PitfallsSection(),
              _InheritanceSection(),
              _Footer(),
            ],
          ),
        ),
      ),
    );
  }
}

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'RawKeyEventDataAndroid · deep demo',
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: _Palette.bg,
      colorScheme: ColorScheme.dark(
        surface: _Palette.bg,
        primary: _Palette.green,
        secondary: _Palette.teal,
      ),
    ),
    home: _Demo(),
  );
}
