// Deep demo of RestorableListenable<T extends Listenable?> from
// package:flutter/widgets.dart.
//
// RestorableListenable is the abstract glue between Flutter's state
// restoration subsystem and any object implementing the Listenable
// contract (ChangeNotifier, ValueNotifier, TextEditingController, etc).
// The base class is rarely subclassed directly by application code.
// Instead, users overwhelmingly encounter it through its canonical
// concrete implementation: RestorableTextEditingController, which
// wraps a TextEditingController and restores its text across a
// process restart.
//
// What makes RestorableListenable special (compared to, say,
// RestorableInt or RestorableBool) is that it does not merely
// snapshot a value — it also manages the listener registration
// lifecycle around a live Listenable. When the RestorableProperty
// is registered via registerForRestoration, the base class
// automatically attaches listeners and, when the property is
// disposed, it detaches them. Users do not wire add/removeListener
// manually; the property owns that handshake.
//
// This file demonstrates the concept with a rich Contact Form
// autosave hub: four RestorableTextEditingController fields plus
// a RestorableInt revision counter that increments every time any
// of the listenables fire. The result is a long-form, visually
// rich teaching file that exercises real RestorableListenable
// behaviour under the d4rt AST harness.

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Palette constants
// ---------------------------------------------------------------------------
//
// A warm amber + slate palette is used throughout so this demo is visually
// distinct from sibling restorable_* demos which tend to use teal, indigo
// or forest green. Amber signals "engaged / saving", slate is the calm
// background canvas for textual data.

const Color _amberPrimary = Color(0xFFF5A524);
const Color _amberDeep = Color(0xFFC77E10);
const Color _amberSoft = Color(0xFFFFE7B8);
const Color _slate900 = Color(0xFF0F172A);
const Color _slate700 = Color(0xFF334155);
const Color _slate500 = Color(0xFF64748B);
const Color _slate300 = Color(0xFFCBD5E1);
const Color _slate100 = Color(0xFFF1F5F9);
const Color _slate50 = Color(0xFFF8FAFC);
const Color _successGreen = Color(0xFF15803D);
const Color _successSoft = Color(0xFFDCFCE7);

// Upper bounds used by the character counter chips; the max values
// themselves are arbitrary — they exist so the chip visually transitions
// as the user types.
const int _maxName = 60;
const int _maxEmail = 80;
const int _maxPhone = 20;
const int _maxMessage = 400;

// ---------------------------------------------------------------------------
// Harness entry point
// ---------------------------------------------------------------------------
//
// The d4rt AST harness invokes `build(BuildContext context)` directly.
// There is no main() and no runApp() — the surrounding harness wraps
// the returned Widget into its own testing scaffold.

dynamic build(BuildContext context) {
  debugPrint('=== RestorableListenable Deep Demo (Contact Form Autosave) ===');
  debugPrint('[demo] Constructing MaterialApp root.');
  return MaterialApp(
    title: 'RestorableListenable Demo',
    debugShowCheckedModeBanner: false,
    restorationScopeId: 'restorable_listenable_root',
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _amberPrimary,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: _slate50,
      textTheme: const TextTheme(
        headlineSmall: TextStyle(
          fontWeight: FontWeight.w700,
          color: _slate900,
        ),
        titleMedium: TextStyle(
          fontWeight: FontWeight.w600,
          color: _slate700,
        ),
        bodyMedium: TextStyle(
          color: _slate700,
        ),
      ),
    ),
    home: const ContactFormDemo(),
  );
}

// ---------------------------------------------------------------------------
// ContactFormDemo — the star of the show
// ---------------------------------------------------------------------------
//
// The state object uses RestorationMixin and owns four
// RestorableTextEditingController instances. Each one is a concrete
// RestorableListenable: the listener handshake around the underlying
// TextEditingController is managed by the RestorableProperty lifecycle.

class ContactFormDemo extends StatefulWidget {
  const ContactFormDemo({super.key});

  @override
  State<ContactFormDemo> createState() => _ContactFormDemoState();
}

class _ContactFormDemoState extends State<ContactFormDemo>
    with RestorationMixin {
  // RestorableTextEditingController is the canonical concrete
  // implementation of RestorableListenable. Each instance holds a
  // TextEditingController and, when registered, arranges for
  // add/removeListener calls on the controller without our
  // intervention.
  final RestorableTextEditingController _fullName =
      RestorableTextEditingController();
  final RestorableTextEditingController _emailAddress =
      RestorableTextEditingController();
  final RestorableTextEditingController _phoneNumber =
      RestorableTextEditingController();
  final RestorableTextEditingController _message =
      RestorableTextEditingController();

  // RestorableInt is a plain primitive RestorableProperty; it is NOT
  // a RestorableListenable itself. It is used here to illustrate that
  // the _Listenable_ nature is what makes the Text controllers special.
  final RestorableInt _revisionCount = RestorableInt(0);

  // Focus nodes live outside the RestorationMixin contract; they are
  // plain in-memory state. They demonstrate that RestorableListenable
  // coexists happily with non-restored Listenables.
  final FocusNode _nameFocus = FocusNode(debugLabel: 'name');
  final FocusNode _emailFocus = FocusNode(debugLabel: 'email');
  final FocusNode _phoneFocus = FocusNode(debugLabel: 'phone');
  final FocusNode _messageFocus = FocusNode(debugLabel: 'message');

  // Toggled on every listener fire to animate the autosave indicator.
  bool _pulse = false;

  @override
  String? get restorationId => 'contact_form_demo';

  @override
  void initState() {
    super.initState();
    debugPrint('[demo] initState: attaching text listeners.');
    // Attach the onChange listener to the underlying TextEditingController.
    // The RestorableTextEditingController does NOT fire itself on text
    // change — we are listening on the *wrapped* Listenable. That is
    // exactly what RestorableListenable is designed to expose.
    _fullName.value.addListener(_onAnyTextChange);
    _emailAddress.value.addListener(_onAnyTextChange);
    _phoneNumber.value.addListener(_onAnyTextChange);
    _message.value.addListener(_onAnyTextChange);

    debugPrint('[demo] initState: attaching focus listeners.');
    _nameFocus.addListener(_onFocusShift);
    _emailFocus.addListener(_onFocusShift);
    _phoneFocus.addListener(_onFocusShift);
    _messageFocus.addListener(_onFocusShift);
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    debugPrint('[demo] restoreState: registering four text controllers '
        'and one int; initialRestore=$initialRestore.');
    // Each registerForRestoration call hands the property a unique
    // restoration ID. The first time a given ID is seen by the framework,
    // RestorableTextEditingController.createDefaultValue() is used to
    // populate the controller. On a subsequent restore, the previously
    // persisted String is deserialised via fromPrimitives().
    registerForRestoration(_fullName, 'field_full_name');
    registerForRestoration(_emailAddress, 'field_email_address');
    registerForRestoration(_phoneNumber, 'field_phone_number');
    registerForRestoration(_message, 'field_message_body');
    registerForRestoration(_revisionCount, 'counter_revision');
  }

  @override
  void dispose() {
    debugPrint('[demo] dispose: detaching listeners and disposing '
        'controllers + focus nodes.');
    // Detach the listeners we attached in initState. The
    // RestorableTextEditingController itself will dispose the wrapped
    // TextEditingController when we call .dispose() on it, but we still
    // own the add/removeListener pair we created manually.
    _fullName.value.removeListener(_onAnyTextChange);
    _emailAddress.value.removeListener(_onAnyTextChange);
    _phoneNumber.value.removeListener(_onAnyTextChange);
    _message.value.removeListener(_onAnyTextChange);

    _nameFocus.removeListener(_onFocusShift);
    _emailFocus.removeListener(_onFocusShift);
    _phoneFocus.removeListener(_onFocusShift);
    _messageFocus.removeListener(_onFocusShift);

    _fullName.dispose();
    _emailAddress.dispose();
    _phoneNumber.dispose();
    _message.dispose();
    _revisionCount.dispose();

    _nameFocus.dispose();
    _emailFocus.dispose();
    _phoneFocus.dispose();
    _messageFocus.dispose();

    super.dispose();
  }

  // ---------------------------------------------------------------------
  // Listener callbacks
  // ---------------------------------------------------------------------

  // Fires whenever ANY of the four wrapped TextEditingControllers emit.
  // This is the teaching moment: a single method demonstrates how the
  // underlying Listenable signals drive UI state. The revision counter
  // is itself RestorableInt, so the tick survives a process restart.
  void _onAnyTextChange() {
    if (!mounted) return;
    setState(() {
      _revisionCount.value = _revisionCount.value + 1;
      _pulse = !_pulse;
    });
  }

  // Focus shifts just drive visual halo state; they do not bump the
  // revision counter because focus changes are not "content changes".
  void _onFocusShift() {
    if (!mounted) return;
    setState(() {
      _pulse = !_pulse;
    });
  }

  // ---------------------------------------------------------------------
  // Derived validation helpers
  // ---------------------------------------------------------------------

  bool get _nameHasValue => _fullName.value.text.trim().isNotEmpty;
  bool get _emailHasAt => _emailAddress.value.text.contains('@');
  bool get _phoneIsDigitsOnly {
    final String trimmed = _phoneNumber.value.text.trim();
    if (trimmed.isEmpty) return false;
    for (int i = 0; i < trimmed.length; i++) {
      final int code = trimmed.codeUnitAt(i);
      final bool isDigit = code >= 0x30 && code <= 0x39;
      final bool isAllowedSep = code == 0x20 || code == 0x2B || code == 0x2D;
      if (!isDigit && !isAllowedSep) return false;
    }
    return true;
  }

  bool get _phoneMeetsMinLength =>
      _phoneNumber.value.text.replaceAll(RegExp(r'\D'), '').length >= 7;

  bool get _messageHasValue => _message.value.text.trim().isNotEmpty;

  int get _messageWordCount {
    final String trimmed = _message.value.text.trim();
    if (trimmed.isEmpty) return 0;
    return trimmed.split(RegExp(r'\s+')).length;
  }

  bool get _messageWithinLimit => _messageWordCount <= 80;

  // ---------------------------------------------------------------------
  // Section 1 — Hero autosave card
  // ---------------------------------------------------------------------

  Widget _buildHeroAutosaveCard() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[_amberSoft, Color(0xFFFFF3D6)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _amberDeep.withValues(alpha: 0.18),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Animated pulsing dot — toggles size on every listener fire.
          AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            width: _pulse ? 22 : 14,
            height: _pulse ? 22 : 14,
            decoration: BoxDecoration(
              color: _amberPrimary,
              shape: BoxShape.circle,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: _amberPrimary.withValues(alpha: 0.55),
                  blurRadius: _pulse ? 18 : 6,
                  spreadRadius: _pulse ? 2 : 0,
                ),
              ],
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Autosave engaged',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: _slate900,
                    letterSpacing: -0.4,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'RestorableTextEditingController wires listener '
                  'registration automatically. Every keystroke below '
                  'flows through RestorableListenable.',
                  style: TextStyle(
                    fontSize: 13,
                    color: _slate700.withValues(alpha: 0.9),
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          _buildRevisionBadge(),
        ],
      ),
    );
  }

  Widget _buildRevisionBadge() {
    // A separate helper renders the big rev number; this keeps the
    // hero card's tree shallow.
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        color: _slate900,
        borderRadius: BorderRadius.circular(16),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _slate900.withValues(alpha: 0.25),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Text(
            'REV',
            style: TextStyle(
              fontSize: 10,
              color: _amberPrimary,
              fontWeight: FontWeight.w700,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            '${_revisionCount.value}',
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              height: 1.0,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------
  // Section 2 — Four-field form card
  // ---------------------------------------------------------------------

  Widget _buildFormCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _slate300, width: 1),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _slate900.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildSectionHeader(
            title: 'Contact fields',
            subtitle: 'Four RestorableTextEditingController instances, '
                'each a live RestorableListenable.',
          ),
          const SizedBox(height: 18),
          _buildFieldRow(
            label: 'Full name',
            hint: 'e.g. Ada Lovelace',
            controller: _fullName.value,
            focusNode: _nameFocus,
            maxChars: _maxName,
            icon: Icons.person_outline,
          ),
          const SizedBox(height: 14),
          _buildFieldRow(
            label: 'Email address',
            hint: 'name@example.com',
            controller: _emailAddress.value,
            focusNode: _emailFocus,
            maxChars: _maxEmail,
            icon: Icons.alternate_email,
          ),
          const SizedBox(height: 14),
          _buildFieldRow(
            label: 'Phone number',
            hint: '+1 555 010 1234',
            controller: _phoneNumber.value,
            focusNode: _phoneFocus,
            maxChars: _maxPhone,
            icon: Icons.phone_outlined,
          ),
          const SizedBox(height: 14),
          _buildFieldRow(
            label: 'Message',
            hint: 'Anything you would like to share...',
            controller: _message.value,
            focusNode: _messageFocus,
            maxChars: _maxMessage,
            icon: Icons.chat_bubble_outline,
            multiline: true,
          ),
        ],
      ),
    );
  }

  Widget _buildFieldRow({
    required String label,
    required String hint,
    required TextEditingController controller,
    required FocusNode focusNode,
    required int maxChars,
    required IconData icon,
    bool multiline = false,
  }) {
    final bool hasFocus = focusNode.hasFocus;
    final bool isFilled = controller.text.isNotEmpty;
    final int len = controller.text.length;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Focus indicator strip — coloured left border that brightens
        // when the field owns keyboard focus. This is pure FocusNode
        // state; it is unrelated to restoration.
        AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: 4,
          height: multiline ? 96 : 56,
          margin: const EdgeInsets.only(top: 4),
          decoration: BoxDecoration(
            color: hasFocus ? _amberPrimary : _slate300,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(icon, size: 16, color: _slate500),
                  const SizedBox(width: 6),
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.4,
                      color: _slate700,
                    ),
                  ),
                  const SizedBox(width: 10),
                  _buildFilledDot(isFilled),
                ],
              ),
              const SizedBox(height: 6),
              TextField(
                controller: controller,
                focusNode: focusNode,
                maxLines: multiline ? 4 : 1,
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: TextStyle(
                    color: _slate500.withValues(alpha: 0.7),
                  ),
                  filled: true,
                  fillColor: _slate50,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: _slate300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: _slate300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: _amberPrimary,
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              _buildCounterChip(len: len, max: maxChars),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilledDot(bool filled) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: filled ? _successGreen : _slate300,
      ),
    );
  }

  Widget _buildCounterChip({required int len, required int max}) {
    final double ratio = max == 0 ? 0 : (len / max).clamp(0.0, 1.0);
    // The chip transitions from slate to amber to deep amber as
    // the user fills the field. It is a tiny teaching device for how
    // derived state can hang off a Listenable's notifications.
    Color bg;
    Color fg;
    if (ratio < 0.4) {
      bg = _slate100;
      fg = _slate700;
    } else if (ratio < 0.85) {
      bg = _amberSoft;
      fg = _amberDeep;
    } else {
      bg = _amberPrimary.withValues(alpha: 0.22);
      fg = _amberDeep;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: fg.withValues(alpha: 0.25)),
      ),
      child: Text(
        '$len / $max',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: fg,
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------
  // Section 3 — Live preview card
  // ---------------------------------------------------------------------

  Widget _buildPreviewCard() {
    // LayoutBuilder lets us reflow the preview when the harness runs
    // in a narrow surface. Below ~420 logical pixels we stack the
    // monogram above the text; otherwise we place it to the left.
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final bool narrow = constraints.maxWidth < 420;
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: _slate900.withValues(alpha: 0.08),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildPreviewGradientHeader(),
              Padding(
                padding: const EdgeInsets.all(20),
                child: narrow
                    ? _buildPreviewNarrow()
                    : _buildPreviewWide(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPreviewGradientHeader() {
    return Container(
      height: 56,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: <Color>[_amberPrimary, _amberDeep],
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.centerLeft,
      child: const Text(
        'LIVE PREVIEW',
        style: TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.w800,
          letterSpacing: 3.0,
        ),
      ),
    );
  }

  Widget _buildPreviewWide() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildMonogramCircle(),
        const SizedBox(width: 20),
        Expanded(child: _buildPreviewTextColumn()),
      ],
    );
  }

  Widget _buildPreviewNarrow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildMonogramCircle(),
        const SizedBox(height: 14),
        _buildPreviewTextColumn(),
      ],
    );
  }

  Widget _buildMonogramCircle() {
    final String raw = _fullName.value.text.trim();
    final String letter = raw.isEmpty
        ? '?'
        : raw.substring(0, 1).toUpperCase();
    return Container(
      width: 76,
      height: 76,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[_slate700, _slate900],
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _slate900.withValues(alpha: 0.25),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Text(
        letter,
        style: const TextStyle(
          color: _amberPrimary,
          fontSize: 36,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _buildPreviewTextColumn() {
    final String name = _fullName.value.text.trim();
    final String email = _emailAddress.value.text.trim();
    final String phone = _phoneNumber.value.text.trim();
    final String message = _message.value.text.trim();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          name.isEmpty ? 'Your name' : name,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: name.isEmpty ? _slate300 : _slate900,
            letterSpacing: -0.4,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          email.isEmpty ? 'you@example.com' : email,
          style: TextStyle(
            fontSize: 14,
            color: email.isEmpty ? _slate300 : _amberDeep,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          phone.isEmpty ? '+country phone' : phone,
          style: TextStyle(
            fontSize: 13,
            color: phone.isEmpty ? _slate300 : _slate700,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _slate50,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _slate100),
          ),
          child: Text(
            message.isEmpty
                ? 'Message preview will appear here as you type.'
                : message,
            style: TextStyle(
              fontSize: 13,
              fontStyle: FontStyle.italic,
              color: message.isEmpty ? _slate500 : _slate700,
              height: 1.45,
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------
  // Section 4 — Validation hint chip row
  // ---------------------------------------------------------------------

  Widget _buildValidationRow() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _slate300, width: 1),
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildSectionHeader(
            title: 'Live validation',
            subtitle: 'Each chip recomputes on every RestorableListenable '
                'notification — no manual wiring required.',
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              _buildValidationChip(
                label: 'name required',
                ok: _nameHasValue,
              ),
              _buildValidationChip(
                label: 'email has @',
                ok: _emailHasAt,
              ),
              _buildValidationChip(
                label: 'phone digits only',
                ok: _phoneIsDigitsOnly,
              ),
              _buildValidationChip(
                label: 'phone min length',
                ok: _phoneMeetsMinLength,
              ),
              _buildValidationChip(
                label: 'message not empty',
                ok: _messageHasValue,
              ),
              _buildValidationChip(
                label: 'word count within 80',
                ok: _messageWithinLimit,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildValidationChip({required String label, required bool ok}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: ok ? _successSoft : _slate100,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: ok ? _successGreen.withValues(alpha: 0.4) : _slate300,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            ok ? Icons.check_circle : Icons.remove_circle_outline,
            size: 14,
            color: ok ? _successGreen : _slate500,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: ok ? _successGreen : _slate700,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------
  // Section 5 — Listener lifecycle teaching panel
  // ---------------------------------------------------------------------

  Widget _buildTeachingPanel() {
    return Container(
      decoration: BoxDecoration(
        color: _slate100,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _slate300),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildSectionHeader(
            title: 'How RestorableListenable works',
            subtitle: 'Three concerns bundled into one property class.',
          ),
          const SizedBox(height: 16),
          _buildTeachingTable(),
          const SizedBox(height: 18),
          _buildCodeSnippetBox(),
          const SizedBox(height: 14),
          _buildTeachingFooter(),
        ],
      ),
    );
  }

  Widget _buildTeachingTable() {
    return Table(
      columnWidths: const <int, TableColumnWidth>{
        0: IntrinsicColumnWidth(),
        1: FlexColumnWidth(),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      children: <TableRow>[
        _buildTeachingRow(
          'Wraps',
          'A live Listenable (for RestorableTextEditingController, a '
              'TextEditingController). The Restorable* property owns '
              'lifecycle of that object.',
        ),
        _buildTeachingRow(
          'createDefaultValue',
          'Called the first time the property is registered with no '
              'prior bucket entry. Returns a fresh TextEditingController '
              'with empty text.',
        ),
        _buildTeachingRow(
          'fromPrimitives',
          'Called when a previously serialised String is available. '
              'Returns a TextEditingController seeded with that text so '
              'the user sees their draft restored.',
        ),
        _buildTeachingRow(
          'toPrimitives',
          'Called to serialise current state. For text controllers the '
              'primitive is simply the current text String.',
        ),
        _buildTeachingRow(
          'Listener attach',
          'Happens automatically when registerForRestoration is called '
              'inside restoreState. The base class invokes '
              'addListener on the inner Listenable.',
        ),
        _buildTeachingRow(
          'Listener detach',
          'Happens automatically when the property is disposed — '
              'either through dispose() on the property or when the '
              'State object is torn down.',
        ),
      ],
    );
  }

  TableRow _buildTeachingRow(String key, String body) {
    return TableRow(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 6,
            vertical: 8,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: _slate900,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              key,
              style: const TextStyle(
                color: _amberPrimary,
                fontWeight: FontWeight.w700,
                fontSize: 11,
                letterSpacing: 0.6,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 8,
          ),
          child: Text(
            body,
            style: const TextStyle(
              fontSize: 13,
              color: _slate700,
              height: 1.45,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCodeSnippetBox() {
    // The "snippet" is plain Text inside a dark box. It is not compiled
    // here — it is a teaching artefact showing the canonical pattern.
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _slate900,
        borderRadius: BorderRadius.circular(12),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _slate900.withValues(alpha: 0.25),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Text(
        '// Canonical registration pattern.\n'
        'final RestorableTextEditingController _name =\n'
        '    RestorableTextEditingController();\n'
        '\n'
        '@override\n'
        'void restoreState(RestorationBucket? old, bool initial) {\n'
        '  registerForRestoration(_name, \'field_name\');\n'
        '}\n'
        '\n'
        '@override\n'
        'void initState() {\n'
        '  super.initState();\n'
        '  _name.value.addListener(_onChanged);\n'
        '}\n'
        '\n'
        '@override\n'
        'void dispose() {\n'
        '  _name.value.removeListener(_onChanged);\n'
        '  _name.dispose();\n'
        '  super.dispose();\n'
        '}',
        style: TextStyle(
          color: _amberSoft,
          fontFamily: 'monospace',
          fontSize: 12,
          height: 1.5,
        ),
      ),
    );
  }

  Widget _buildTeachingFooter() {
    return Row(
      children: <Widget>[
        const Icon(Icons.info_outline, size: 16, color: _slate500),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            'Remember: the Listenable you get from .value is the SAME '
            'instance across restoration. Bind your TextField to it '
            'once and the framework handles the rest.',
            style: TextStyle(
              fontSize: 12,
              color: _slate700.withValues(alpha: 0.9),
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------
  // Shared section header
  // ---------------------------------------------------------------------

  Widget _buildSectionHeader({
    required String title,
    required String subtitle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w800,
            color: _slate900,
            letterSpacing: -0.2,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 12,
            color: _slate500,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: <Widget>[
          const Expanded(
            child: Divider(color: _slate300, thickness: 1),
          ),
          const SizedBox(width: 12),
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: _amberPrimary,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Divider(color: _slate300, thickness: 1),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------
  // Top-level app scaffold
  // ---------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _slate900,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'RestorableListenable',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            letterSpacing: -0.3,
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: _amberPrimary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: _amberPrimary.withValues(alpha: 0.6),
                  ),
                ),
                child: Text(
                  'rev ${_revisionCount.value}',
                  style: const TextStyle(
                    color: _amberPrimary,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: <Widget>[
            _buildHeroAutosaveCard(),
            _buildDivider(),
            _buildFormCard(),
            _buildDivider(),
            _buildPreviewCard(),
            _buildDivider(),
            _buildValidationRow(),
            _buildDivider(),
            _buildTeachingPanel(),
            const SizedBox(height: 24),
            _buildFooterCredit(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildFooterCredit() {
    // A quiet closing note, dark on pale, to end the demo.
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: _slate100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: <Widget>[
          const Icon(
            Icons.bookmark_border,
            size: 16,
            color: _slate500,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Demo backed by four RestorableTextEditingController '
              'instances and one RestorableInt counter. Attach a '
              'listener, trust the property to detach it.',
              style: TextStyle(
                fontSize: 12,
                color: _slate700.withValues(alpha: 0.95),
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
