// Deep demo of [RestorableStringN] — a nullable restorable string that
// captures the tri-state lifecycle of an optional text field:
//
//   null     => the user has not touched / opted out of this field
//   ''       => the user started the field but left it blank
//   'value'  => the user filled in a real value
//
// This file is deliberately long and hand-authored to showcase the contrast
// with [RestorableString], which collapses `null` into `''` and therefore
// cannot represent the "skipped" case.  The UX is a Feedback Kiosk with a
// mood hero, four form rows, a receipt summary that hides skipped rows,
// a completeness meter, and a teaching grid.
//
// Only `package:flutter/material.dart` is imported.  `debugPrint` is
// re-exported from material, so we do not need to import foundation.

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Palette — cheerful teal + coral + cream.  Avoids slate/indigo because
// sibling demos in this harness already own that register.
// ---------------------------------------------------------------------------

const Color _kCream = Color(0xFFFFF7EC);
const Color _kCreamDeep = Color(0xFFFBE8CF);
const Color _kTeal = Color(0xFF1FA896);
const Color _kTealDeep = Color(0xFF0F766E);
const Color _kCoral = Color(0xFFFF6F5E);
const Color _kCoralDeep = Color(0xFFD94F3E);
const Color _kAmber = Color(0xFFE8A317);
const Color _kGreen = Color(0xFF2E9E5B);
const Color _kGrey = Color(0xFF90897F);
const Color _kInk = Color(0xFF2B2A28);
const Color _kInkSoft = Color(0xFF595754);

// ---------------------------------------------------------------------------
// Entry point expected by the tom_d4rt_flutterm harness.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  debugPrint('=== RestorableStringN Deep Demo — Feedback Kiosk ===');
  debugPrint('Tri-state semantics: null | empty-string | non-empty.');
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'RestorableStringN Feedback Kiosk',
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _kTeal,
        primary: _kTeal,
        secondary: _kCoral,
        surface: _kCream,
      ),
      scaffoldBackgroundColor: _kCream,
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: _kInk, fontSize: 14),
      ),
    ),
    home: const FeedbackKioskDemo(),
  );
}

// ---------------------------------------------------------------------------
// The demo widget.  A [RestorationMixin] is used so that every
// [RestorableStringN] participates in Flutter's state restoration system.
// ---------------------------------------------------------------------------

class FeedbackKioskDemo extends StatefulWidget {
  const FeedbackKioskDemo({super.key});

  @override
  State<FeedbackKioskDemo> createState() => _FeedbackKioskDemoState();
}

class _FeedbackKioskDemoState extends State<FeedbackKioskDemo>
    with RestorationMixin {
  // -------------------------------------------------------------------------
  // Restorable state.
  //
  // Every [RestorableStringN] starts at `null`, meaning the user has not
  // engaged the field at all.  Compare this with a plain [RestorableString]
  // which would start at `''` and could never be distinguished from a
  // started-but-blank field.
  // -------------------------------------------------------------------------

  final RestorableStringN _feedbackText = RestorableStringN(null);
  final RestorableStringN _optionalEmail = RestorableStringN(null);
  final RestorableStringN _suggestionText = RestorableStringN(null);
  final RestorableStringN _optionalName = RestorableStringN(null);
  final RestorableInt _moodRating = RestorableInt(3);

  // -------------------------------------------------------------------------
  // Controllers.  Created in [initState] from the current restorable value.
  //
  // Listener contract: whenever the user types, the controller writes the
  // *literal* `controller.text` back to the restorable — so emptying the
  // field via keyboard yields `''` (started-but-blank), not `null`.  Only
  // the explicit "Skip" action in [_cycleFieldState] sets `.value = null`.
  // -------------------------------------------------------------------------

  late final TextEditingController _feedbackCtrl;
  late final TextEditingController _emailCtrl;
  late final TextEditingController _suggestionCtrl;
  late final TextEditingController _nameCtrl;

  @override
  String get restorationId => 'feedback_kiosk_demo';

  // -------------------------------------------------------------------------
  // Lifecycle: initState / restoreState / dispose.
  // -------------------------------------------------------------------------

  @override
  void initState() {
    super.initState();
    // Defaults match the RestorableStringN(null) initial values declared above
    // (which collapse to '' via `?? ''`). We use literals here because reading
    // RestorableProperty.value before registerForRestoration runs in
    // restoreState would assert on `isRegistered` in plain Flutter as well.
    _feedbackCtrl = TextEditingController()..addListener(_onFeedbackChanged);
    _emailCtrl = TextEditingController()..addListener(_onEmailChanged);
    _suggestionCtrl = TextEditingController()..addListener(_onSuggestionChanged);
    _nameCtrl = TextEditingController()..addListener(_onNameChanged);
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_feedbackText, 'feedback_text');
    registerForRestoration(_optionalEmail, 'optional_email');
    registerForRestoration(_suggestionText, 'suggestion_text');
    registerForRestoration(_optionalName, 'optional_name');
    registerForRestoration(_moodRating, 'mood_rating');

    // After restoration, controllers must mirror whatever value was hydrated.
    _syncControllerFrom(_feedbackText, _feedbackCtrl, _onFeedbackChanged);
    _syncControllerFrom(_optionalEmail, _emailCtrl, _onEmailChanged);
    _syncControllerFrom(_suggestionText, _suggestionCtrl, _onSuggestionChanged);
    _syncControllerFrom(_optionalName, _nameCtrl, _onNameChanged);
  }

  void _syncControllerFrom(
    RestorableStringN restorable,
    TextEditingController controller,
    VoidCallback listener,
  ) {
    // Temporarily detach to avoid the listener fighting us during restore.
    controller
      ..removeListener(listener)
      ..text = restorable.value ?? ''
      ..addListener(listener);
  }

  @override
  void dispose() {
    // Controllers carry listeners that touch the restorables, so dispose them
    // first.  Then the restorables themselves.  Then super.
    _feedbackCtrl
      ..removeListener(_onFeedbackChanged)
      ..dispose();
    _emailCtrl
      ..removeListener(_onEmailChanged)
      ..dispose();
    _suggestionCtrl
      ..removeListener(_onSuggestionChanged)
      ..dispose();
    _nameCtrl
      ..removeListener(_onNameChanged)
      ..dispose();
    _feedbackText.dispose();
    _optionalEmail.dispose();
    _suggestionText.dispose();
    _optionalName.dispose();
    _moodRating.dispose();
    super.dispose();
  }

  // -------------------------------------------------------------------------
  // Listeners — each writes the literal controller text back, so typing then
  // deleting yields `''`, not `null`.
  // -------------------------------------------------------------------------

  void _onFeedbackChanged() {
    if (_feedbackText.value != _feedbackCtrl.text) {
      setState(() {
        _feedbackText.value = _feedbackCtrl.text;
      });
    }
  }

  void _onEmailChanged() {
    if (_optionalEmail.value != _emailCtrl.text) {
      setState(() {
        _optionalEmail.value = _emailCtrl.text;
      });
    }
  }

  void _onSuggestionChanged() {
    if (_suggestionText.value != _suggestionCtrl.text) {
      setState(() {
        _suggestionText.value = _suggestionCtrl.text;
      });
    }
  }

  void _onNameChanged() {
    if (_optionalName.value != _nameCtrl.text) {
      setState(() {
        _optionalName.value = _nameCtrl.text;
      });
    }
  }

  // -------------------------------------------------------------------------
  // Tri-state cycle for the Skip / Start / Clear button.
  //
  //   null  -> ''             (Start)
  //   ''    -> exampleValue   (Fill with sample)
  //   value -> null           (Skip / opt-out)
  // -------------------------------------------------------------------------

  void _cycleFieldState({
    required RestorableStringN restorable,
    required TextEditingController controller,
    required VoidCallback listener,
    required String sampleValue,
    required String label,
  }) {
    final String? before = restorable.value;
    final String? next;
    if (before == null) {
      next = '';
      debugPrint('[$label] null -> "" (user begins, still blank)');
    } else if (before.isEmpty) {
      next = sampleValue;
      debugPrint('[$label] "" -> "$sampleValue" (user fills with sample)');
    } else {
      next = null;
      debugPrint('[$label] "$before" -> null (user opts out)');
    }
    setState(() {
      restorable.value = next;
      controller
        ..removeListener(listener)
        ..text = next ?? ''
        ..addListener(listener);
    });
  }

  // -------------------------------------------------------------------------
  // State classification used throughout the UI.
  // -------------------------------------------------------------------------

  _FieldTriState _classify(String? value) {
    if (value == null) {
      return _FieldTriState.skipped;
    } else if (value.isEmpty) {
      return _FieldTriState.blank;
    } else {
      return _FieldTriState.filled;
    }
  }

  // -------------------------------------------------------------------------
  // Build.
  // -------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kCream,
      appBar: AppBar(
        backgroundColor: _kTealDeep,
        foregroundColor: _kCream,
        title: const Text('Feedback Kiosk'),
        centerTitle: false,
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 36),
          children: <Widget>[
            _buildMoodHero(),
            const SizedBox(height: 20),
            _buildSectionHeader('1. Your feedback', Icons.chat_bubble_outline),
            const SizedBox(height: 12),
            _buildFormCard(),
            const SizedBox(height: 24),
            _buildSectionHeader(
              '2. What the kiosk will send',
              Icons.receipt_long_outlined,
            ),
            const SizedBox(height: 12),
            _buildReceipt(),
            const SizedBox(height: 24),
            _buildSectionHeader(
              '3. Completeness',
              Icons.assessment_outlined,
            ),
            const SizedBox(height: 12),
            _buildCompletenessMeter(),
            const SizedBox(height: 24),
            _buildSectionHeader(
              '4. Tri-state cheat sheet',
              Icons.school_outlined,
            ),
            const SizedBox(height: 12),
            _buildTriStateGrid(),
            const SizedBox(height: 32),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Section header.
  // -------------------------------------------------------------------------

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: <Widget>[
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: _kTeal.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 20, color: _kTealDeep),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: _kInk,
          ),
        ),
      ],
    );
  }

  // -------------------------------------------------------------------------
  // 1. Mood kiosk hero.
  // -------------------------------------------------------------------------

  Widget _buildMoodHero() {
    final String emoji = _emojiFor(_moodRating.value);
    final String label = _moodLabelFor(_moodRating.value);

    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[_kTeal, _kTealDeep],
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kTealDeep.withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: _kCream.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'KIOSK · ROOM 3',
                  style: TextStyle(
                    color: _kCream,
                    fontSize: 11,
                    letterSpacing: 1.6,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: _kCoral.withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'RestorableStringN',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Text(
            'Share your experience',
            style: TextStyle(
              color: _kCream,
              fontSize: 26,
              fontWeight: FontWeight.w800,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Every field is optional. Skip the ones that do not apply.',
            style: TextStyle(
              color: Color(0xFFE6F7F3),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 18),
          Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 220),
              transitionBuilder: (Widget child, Animation<double> anim) =>
                  ScaleTransition(scale: anim, child: child),
              child: Text(
                emoji,
                key: ValueKey<int>(_moodRating.value),
                style: const TextStyle(
                  fontSize: 80,
                  height: 1.0,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              label,
              style: const TextStyle(
                color: _kCream,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List<Widget>.generate(5, (int i) {
              final bool lit = i < _moodRating.value;
              return IconButton(
                onPressed: () {
                  debugPrint('[moodRating] ${_moodRating.value} -> ${i + 1}');
                  setState(() {
                    _moodRating.value = i + 1;
                  });
                },
                icon: Icon(
                  lit ? Icons.star_rounded : Icons.star_outline_rounded,
                  color: lit ? _kCoral : _kCream.withValues(alpha: 0.6),
                  size: 34,
                ),
                tooltip: '${i + 1}/5',
              );
            }),
          ),
        ],
      ),
    );
  }

  String _emojiFor(int rating) {
    switch (rating) {
      case 1:
        return '\u{1F620}'; // angry
      case 2:
        return '\u{1F61F}'; // worried
      case 3:
        return '\u{1F610}'; // neutral
      case 4:
        return '\u{1F642}'; // slight smile
      case 5:
        return '\u{1F604}'; // happy
      default:
        return '\u{1F610}';
    }
  }

  String _moodLabelFor(int rating) {
    switch (rating) {
      case 1:
        return 'Frustrated';
      case 2:
        return 'Disappointed';
      case 3:
        return 'Neutral';
      case 4:
        return 'Pleasant';
      case 5:
        return 'Delighted';
      default:
        return 'Neutral';
    }
  }

  // -------------------------------------------------------------------------
  // 2. Form card with tri-state pills.
  // -------------------------------------------------------------------------

  Widget _buildFormCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _kCreamDeep, width: 1),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kCreamDeep.withValues(alpha: 0.8),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        children: <Widget>[
          _buildFormField(
            label: 'Primary feedback',
            hint: 'What stood out about your visit?',
            icon: Icons.forum_outlined,
            controller: _feedbackCtrl,
            restorable: _feedbackText,
            listener: _onFeedbackChanged,
            sampleValue: 'The espresso was excellent and the staff kind.',
            maxLines: 3,
          ),
          const Divider(height: 28, color: _kCreamDeep),
          _buildFormField(
            label: 'Email for follow-up',
            hint: 'you@example.com',
            icon: Icons.alternate_email,
            controller: _emailCtrl,
            restorable: _optionalEmail,
            listener: _onEmailChanged,
            sampleValue: 'lina.ortega@example.com',
            maxLines: 1,
          ),
          const Divider(height: 28, color: _kCreamDeep),
          _buildFormField(
            label: 'Suggestions for us',
            hint: 'Anything we could improve?',
            icon: Icons.tips_and_updates_outlined,
            controller: _suggestionCtrl,
            restorable: _suggestionText,
            listener: _onSuggestionChanged,
            sampleValue: 'Add decaf options after 5pm.',
            maxLines: 2,
          ),
          const Divider(height: 28, color: _kCreamDeep),
          _buildFormField(
            label: 'Your name (optional)',
            hint: 'We like knowing who we serve',
            icon: Icons.person_outline,
            controller: _nameCtrl,
            restorable: _optionalName,
            listener: _onNameChanged,
            sampleValue: 'Lina Ortega',
            maxLines: 1,
          ),
        ],
      ),
    );
  }

  Widget _buildFormField({
    required String label,
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    required RestorableStringN restorable,
    required VoidCallback listener,
    required String sampleValue,
    required int maxLines,
  }) {
    final _FieldTriState state = _classify(restorable.value);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(icon, size: 18, color: _kTealDeep),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: _kInk,
                ),
              ),
            ),
            _buildStatusPill(state),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: controller,
                maxLines: maxLines,
                minLines: 1,
                style: const TextStyle(fontSize: 14, color: _kInk),
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: TextStyle(
                    color: _kInkSoft.withValues(alpha: 0.6),
                    fontSize: 13,
                  ),
                  filled: true,
                  fillColor: _kCream.withValues(alpha: 0.6),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: _kCreamDeep),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: _kCreamDeep),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: _kTeal, width: 1.4),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            _buildCycleButton(
              state: state,
              onPressed: () {
                _cycleFieldState(
                  restorable: restorable,
                  controller: controller,
                  listener: listener,
                  sampleValue: sampleValue,
                  label: label,
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          _explanationFor(state),
          style: const TextStyle(
            fontSize: 12,
            color: _kInkSoft,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  String _explanationFor(_FieldTriState state) {
    switch (state) {
      case _FieldTriState.skipped:
        return 'Skipped — the receipt will omit this line entirely (null).';
      case _FieldTriState.blank:
        return 'Started but blank — the receipt marks it as "(left blank)" (\'\').';
      case _FieldTriState.filled:
        return 'Filled — the receipt prints the value verbatim.';
    }
  }

  Widget _buildCycleButton({
    required _FieldTriState state,
    required VoidCallback onPressed,
  }) {
    final IconData icon;
    final String tooltip;
    final Color bg;
    switch (state) {
      case _FieldTriState.skipped:
        icon = Icons.play_arrow_rounded;
        tooltip = 'Start';
        bg = _kGrey.withValues(alpha: 0.18);
        break;
      case _FieldTriState.blank:
        icon = Icons.auto_fix_high_rounded;
        tooltip = 'Fill with sample';
        bg = _kAmber.withValues(alpha: 0.22);
        break;
      case _FieldTriState.filled:
        icon = Icons.block_rounded;
        tooltip = 'Skip (null)';
        bg = _kCoral.withValues(alpha: 0.22);
        break;
    }
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 20, color: _kInk),
        ),
      ),
    );
  }

  Widget _buildStatusPill(_FieldTriState state) {
    final String text;
    final Color fg;
    final Color bg;
    final IconData icon;
    switch (state) {
      case _FieldTriState.skipped:
        text = 'skipped';
        fg = _kGrey;
        bg = _kGrey.withValues(alpha: 0.16);
        icon = Icons.do_not_disturb_on_outlined;
        break;
      case _FieldTriState.blank:
        text = 'blank';
        fg = _kAmber;
        bg = _kAmber.withValues(alpha: 0.16);
        icon = Icons.hourglass_empty_rounded;
        break;
      case _FieldTriState.filled:
        text = 'filled';
        fg = _kGreen;
        bg = _kGreen.withValues(alpha: 0.16);
        icon = Icons.check_circle_outline;
        break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 14, color: fg),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: fg,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // 3. Receipt summary — only shows rows for non-null fields.
  // -------------------------------------------------------------------------

  Widget _buildReceipt() {
    final List<_ReceiptRow> rows = <_ReceiptRow>[];
    void addRow(String label, String? value) {
      if (value == null) {
        return; // null means opt-out — omit entirely.
      }
      rows.add(_ReceiptRow(label: label, value: value));
    }

    addRow('feedback', _feedbackText.value);
    addRow('email', _optionalEmail.value);
    addRow('suggestion', _suggestionText.value);
    addRow('name', _optionalName.value);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kCreamDeep),
      ),
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text(
            '--- FEEDBACK KIOSK ---',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
              color: _kInk,
              fontSize: 13,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'room 3 · kiosk-04 · mood ${_moodRating.value}/5',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'monospace',
              color: _kInkSoft,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 14),
          if (rows.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.inbox_outlined,
                    size: 40,
                    color: _kGrey.withValues(alpha: 0.7),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'All fields skipped — nothing to send.',
                    style: TextStyle(color: _kInkSoft, fontSize: 13),
                  ),
                ],
              ),
            )
          else
            Column(
              children: <Widget>[
                for (int i = 0; i < rows.length; i++) ...<Widget>[
                  _buildReceiptLine(rows[i]),
                  if (i < rows.length - 1)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Container(
                        height: 1,
                        color: _kCreamDeep.withValues(alpha: 0.8),
                      ),
                    ),
                ],
              ],
            ),
          const SizedBox(height: 14),
          _buildDashedTearLine(),
          const SizedBox(height: 8),
          Text(
            '${rows.length} of 4 rows · '
            '${_countFilled()} filled · '
            '${_countBlank()} blank · '
            '${_countSkipped()} skipped',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'monospace',
              color: _kInkSoft,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReceiptLine(_ReceiptRow row) {
    final bool blank = row.value.isEmpty;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 92,
          child: Text(
            row.label.toUpperCase(),
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: _kTealDeep,
              letterSpacing: 1.1,
            ),
          ),
        ),
        Expanded(
          child: Text(
            blank ? '(left blank)' : row.value,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 13,
              color: blank ? _kAmber : _kInk,
              fontStyle: blank ? FontStyle.italic : FontStyle.normal,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDashedTearLine() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        const double dashWidth = 6;
        const double dashSpace = 4;
        final int dashCount =
            (constraints.maxWidth / (dashWidth + dashSpace)).floor();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List<Widget>.generate(dashCount, (int i) {
            return SizedBox(
              width: dashWidth,
              height: 1,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: _kInkSoft.withValues(alpha: 0.6),
                ),
              ),
            );
          }),
        );
      },
    );
  }

  int _countFilled() {
    int n = 0;
    for (final String? v in <String?>[
      _feedbackText.value,
      _optionalEmail.value,
      _suggestionText.value,
      _optionalName.value,
    ]) {
      if (v != null && v.isNotEmpty) {
        n++;
      }
    }
    return n;
  }

  int _countBlank() {
    int n = 0;
    for (final String? v in <String?>[
      _feedbackText.value,
      _optionalEmail.value,
      _suggestionText.value,
      _optionalName.value,
    ]) {
      if (v != null && v.isEmpty) {
        n++;
      }
    }
    return n;
  }

  int _countSkipped() {
    int n = 0;
    for (final String? v in <String?>[
      _feedbackText.value,
      _optionalEmail.value,
      _suggestionText.value,
      _optionalName.value,
    ]) {
      if (v == null) {
        n++;
      }
    }
    return n;
  }

  int _countNonNull() => 4 - _countSkipped();

  // -------------------------------------------------------------------------
  // 4. Completeness meter — three thresholds.
  // -------------------------------------------------------------------------

  Widget _buildCompletenessMeter() {
    final int filled = _countFilled();
    final int nonNull = _countNonNull();

    final bool t1AtLeastOneFilled = filled >= 1;
    final bool t2AllFilled = filled == 4;
    final bool t3AllNonNull = nonNull == 4;

    // The bar fill combines filled (solid) + blank (hatched).
    final double filledFrac = filled / 4.0;
    final double nonNullFrac = nonNull / 4.0;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kCreamDeep),
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                'Completeness',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: _kInk,
                  fontSize: 15,
                ),
              ),
              Text(
                '$filled of 4 filled · $nonNull of 4 engaged',
                style: const TextStyle(color: _kInkSoft, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 12),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints c) {
              final double w = c.maxWidth;
              return Stack(
                children: <Widget>[
                  // Background track.
                  Container(
                    height: 18,
                    decoration: BoxDecoration(
                      color: _kCreamDeep,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  // Non-null band (amber) — includes blanks.
                  Container(
                    height: 18,
                    width: w * nonNullFrac,
                    decoration: BoxDecoration(
                      color: _kAmber.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  // Filled band (teal) — strictly non-empty.
                  Container(
                    height: 18,
                    width: w * filledFrac,
                    decoration: BoxDecoration(
                      color: _kTeal,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  // Threshold ticks at 1/4, 4/4.
                  Positioned(
                    left: (w * 0.25) - 1,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      width: 2,
                      color: _kCream,
                    ),
                  ),
                  Positioned(
                    left: (w * 1.0) - 2,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      width: 2,
                      color: _kCream,
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 16),
          _buildThreshold(
            active: t1AtLeastOneFilled,
            title: 'At least one filled',
            subtitle: 'You have given us something concrete.',
            color: _kTeal,
          ),
          const SizedBox(height: 10),
          _buildThreshold(
            active: t2AllFilled,
            title: 'All four filled',
            subtitle: 'Rich feedback — thank you!',
            color: _kTealDeep,
          ),
          const SizedBox(height: 10),
          _buildThreshold(
            active: t3AllNonNull,
            title: 'All four engaged (no opt-outs)',
            subtitle:
                'Even blanks count here — you considered every field.',
            color: _kCoralDeep,
          ),
          const SizedBox(height: 12),
          Text(
            _completenessNarrative(filled, nonNull),
            style: const TextStyle(
              color: _kInk,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  String _completenessNarrative(int filled, int nonNull) {
    if (filled == 0 && nonNull == 0) {
      return 'No fields shared yet — every input is still null.';
    }
    if (filled == 0 && nonNull > 0) {
      return '$nonNull of 4 fields opened but left blank.';
    }
    if (filled == 4) {
      return 'All 4 fields shared — the receipt is complete.';
    }
    return '$filled of 4 fields shared '
        '(${nonNull - filled} opened but blank, ${4 - nonNull} skipped).';
  }

  Widget _buildThreshold({
    required bool active,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            color: active ? color : _kCreamDeep,
            shape: BoxShape.circle,
          ),
          child: Icon(
            active ? Icons.check_rounded : Icons.circle_outlined,
            size: 16,
            color: active ? Colors.white : _kInkSoft,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: active ? _kInk : _kInkSoft,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: _kInkSoft,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // -------------------------------------------------------------------------
  // 5. Tri-state teaching grid.
  // -------------------------------------------------------------------------

  Widget _buildTriStateGrid() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kCreamDeep),
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'null vs "" vs "value"',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: _kInk,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Three distinct meanings only RestorableStringN can preserve.',
            style: TextStyle(fontSize: 12, color: _kInkSoft),
          ),
          const SizedBox(height: 14),
          Table(
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(),
              1: FlexColumnWidth(),
              2: FlexColumnWidth(),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.top,
            children: <TableRow>[
              TableRow(
                children: <Widget>[
                  _buildTriStateCell(
                    icon: Icons.do_not_disturb_on_outlined,
                    iconColor: _kGrey,
                    literal: 'null',
                    literalColor: _kGrey,
                    semantic: 'Opted out',
                    example: 'User skipped — no signal, not even interest.',
                    bg: _kGrey.withValues(alpha: 0.08),
                  ),
                  _buildTriStateCell(
                    icon: Icons.hourglass_empty_rounded,
                    iconColor: _kAmber,
                    literal: '\'\'',
                    literalColor: _kAmber,
                    semantic: 'Started & blank',
                    example: 'User opened the field but typed nothing.',
                    bg: _kAmber.withValues(alpha: 0.10),
                  ),
                  _buildTriStateCell(
                    icon: Icons.check_circle_outline,
                    iconColor: _kGreen,
                    literal: '\'value\'',
                    literalColor: _kGreen,
                    semantic: 'Provided',
                    example: 'User wrote real feedback we can act on.',
                    bg: _kGreen.withValues(alpha: 0.08),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _kCoral.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _kCoral.withValues(alpha: 0.35)),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.info_outline, size: 18, color: _kCoralDeep),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'RestorableString cannot represent the "skipped" case — '
                    'its value type is non-nullable String, so an untouched '
                    'field is indistinguishable from an emptied one. When '
                    'opt-out matters (surveys, profiles, preferences), reach '
                    'for RestorableStringN.',
                    style: TextStyle(
                      fontSize: 12.5,
                      color: _kInk,
                      height: 1.4,
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

  Widget _buildTriStateCell({
    required IconData icon,
    required Color iconColor,
    required String literal,
    required Color literalColor,
    required String semantic,
    required String example,
    required Color bg,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: iconColor, size: 22),
          const SizedBox(height: 8),
          Text(
            literal,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: literalColor,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            semantic,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: _kInk,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            example,
            style: const TextStyle(
              fontSize: 11.5,
              color: _kInkSoft,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Footer.
  // -------------------------------------------------------------------------

  Widget _buildFooter() {
    return Column(
      children: <Widget>[
        Container(
          height: 1,
          color: _kCreamDeep,
        ),
        const SizedBox(height: 12),
        const Text(
          'Built with RestorableStringN · feedback_kiosk_demo',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: _kInkSoft,
            fontSize: 11,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Supporting types.
// ---------------------------------------------------------------------------

enum _FieldTriState { skipped, blank, filled }

class _ReceiptRow {
  const _ReceiptRow({required this.label, required this.value});
  final String label;
  final String value;
}
