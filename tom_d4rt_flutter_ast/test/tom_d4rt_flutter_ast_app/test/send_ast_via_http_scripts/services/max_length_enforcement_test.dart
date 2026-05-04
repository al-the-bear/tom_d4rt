// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable
// D4rt test script: Tests MaxLengthEnforcement enum from package:flutter/services.dart
// Deep Demo: Visual demonstration of how MaxLengthEnforcement governs the
// interaction between TextField.maxLength, IME composition, and the
// transformation of raw user keystrokes into the field's effective text.
//
// This test renders an instructional page that explains, with mocked input
// progressions, how each enforcement value behaves at the boundary of the
// configured length. There is no interaction; all "animation" is provided by
// AlwaysStoppedAnimation<double> with Duration.zero so the script can be
// executed by the d4rt-flutter-ast harness without a real ticker.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// =============================================================================
// Top-level visual constants. We pre-build a small palette so the gradients
// and shadows below stay visually consistent across sections. The palette is
// intentionally aligned with the semantic meaning of each enum value:
//   - none             -> grey  (silent, transparent)
//   - enforced         -> red   (hard stop, blocks at limit)
//   - truncateAfter... -> amber (soft, defers until composition ends)
// =============================================================================
const Color _kNoneColor = Color(0xFF607D8B); // blue-grey 500
const Color _kEnforcedColor = Color(0xFFE53935); // red 600
const Color _kTruncateColor = Color(0xFFFB8C00); // orange 600
const Color _kAccent = Color(0xFF3949AB); // indigo 600
const Color _kInkDark = Color(0xFF212121);
const Color _kInkSoft = Color(0xFF616161);

// The motion stand-in used for any progress indicator on the page. Because
// d4rt's flutter-ast harness does not run a real Ticker, we lock motion to a
// static value via AlwaysStoppedAnimation and Duration.zero.
final AlwaysStoppedAnimation<double> _kStaticMotion =
    AlwaysStoppedAnimation<double>(1.0);
const Duration _kInstantDuration = Duration.zero;

dynamic build(BuildContext context) {
  print('MaxLengthEnforcement Deep Demo executing');
  print('Static motion locked at ${_kStaticMotion.value}, '
      'duration=${_kInstantDuration.inMilliseconds}ms');

  // Enumerate enum values so that downstream sections can rely on a stable
  // ordering. We also log the index so that a regression in d4rt's enum
  // bridge (index drift, ordering changes) shows up in the script trail.
  for (final v in MaxLengthEnforcement.values) {
    print(' value=${v.name} index=${v.index} toString=$v');
  }
  print('total values: ${MaxLengthEnforcement.values.length}');

  // ==========================================================================
  // SECTION 1: HERO HEADER
  // --------------------------------------------------------------------------
  // The hero panel anchors the page and tells the reader, in one glance, what
  // the demo is about: an enum that controls how a TextField's maxLength
  // truncates text, especially during IME composition.
  // ==========================================================================
  print('=== Section 1: Hero header ===');
  final Widget heroHeader = Container(
    padding: EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_kAccent, Color(0xFF8E24AA)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: _kAccent.withValues(alpha: 0.45),
          blurRadius: 16.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.text_fields, size: 40.0, color: Colors.white),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MaxLengthEnforcement',
                    style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'package:flutter/services.dart',
                    style: TextStyle(
                      fontSize: 13.0,
                      fontFamily: 'monospace',
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Text(
          'Three-valued enum that controls how TextField.maxLength is '
          'enforced relative to the text the user is currently composing '
          'with the input method editor (IME). It is the difference between '
          'no limit, hard truncation on every keystroke, and a soft policy '
          'that waits until composition completes before trimming.',
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.white,
            height: 1.4,
          ),
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            _kHeroChip('enum'),
            _kHeroChip('3 values'),
            _kHeroChip('TextField.maxLengthEnforcement'),
            _kHeroChip('IME-aware'),
          ],
        ),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 2: ANATOMY / ENUM SIGNATURE
  // --------------------------------------------------------------------------
  // A code-block style panel that shows the enum's signature, the closest
  // approximation to what you'd see in the SDK source. Helpful for readers
  // jumping in cold.
  // ==========================================================================
  print('=== Section 2: Anatomy ===');
  final Widget anatomy = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF263238), Color(0xFF37474F)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.30),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.architecture, color: Colors.cyanAccent, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Enum Signature',
              style: TextStyle(
                color: Colors.cyanAccent,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        _kCodeLine('// from package:flutter/services.dart', Colors.grey),
        _kCodeLine('enum MaxLengthEnforcement {', Color(0xFF80DEEA)),
        _kCodeLine('  none,                           // 0', Color(0xFFB0BEC5)),
        _kCodeLine('  enforced,                       // 1', Color(0xFFFFAB91)),
        _kCodeLine('  truncateAfterCompositionEnds,   // 2', Color(0xFFFFE082)),
        _kCodeLine('}', Color(0xFF80DEEA)),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFF1B1B1B),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'Configured on a TextField via:\n'
            '  TextField(maxLength: 10, maxLengthEnforcement: ...)\n\n'
            'Or globally on a Form-wide policy by leaving '
            'maxLengthEnforcement: null and letting the platform default '
            '(MaxLengthEnforcement.enforced on most platforms, or '
            'truncateAfterCompositionEnds on platforms with sticky composers).',
            style: TextStyle(
              color: Color(0xFFCFD8DC),
              fontSize: 12.0,
              fontFamily: 'monospace',
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 3: PER-VALUE CARDS
  // --------------------------------------------------------------------------
  // For each of the three enum values we show a bold card that names it,
  // describes its policy, and lists the operational consequences. We also
  // dump enum metadata (name, index) so the trail clearly shows the runtime
  // identity.
  // ==========================================================================
  print('=== Section 3: Per-value cards ===');
  final List<_EnumValueSpec> specs = [
    _EnumValueSpec(
      value: MaxLengthEnforcement.none,
      icon: Icons.do_not_disturb_off,
      color: _kNoneColor,
      summary: 'No enforcement at all.',
      headline: 'Free typing',
      bullets: [
        'maxLength is purely decorative (it still drives the counter UI).',
        'Both raw and composing text are passed through unchanged.',
        'Users can paste, type, and compose past the limit indefinitely.',
        'Useful when you want a soft hint counter without blocking input.',
      ],
    ),
    _EnumValueSpec(
      value: MaxLengthEnforcement.enforced,
      icon: Icons.block,
      color: _kEnforcedColor,
      summary: 'Hard limit, truncated on every keystroke.',
      headline: 'Hard cap',
      bullets: [
        'Each TextEditingValue update is immediately clamped to maxLength.',
        'Composition past the boundary is rejected, character by character.',
        'Best for ASCII fields with no IME composition (PIN, code, ID).',
        'May feel hostile with CJK / emoji input methods.',
      ],
    ),
    _EnumValueSpec(
      value: MaxLengthEnforcement.truncateAfterCompositionEnds,
      icon: Icons.schedule,
      color: _kTruncateColor,
      summary: 'Allow composition past the limit; truncate when it commits.',
      headline: 'Composition-aware',
      bullets: [
        'Composing text is allowed to overflow temporarily.',
        'When composition ends (commit), the value is truncated to maxLength.',
        'Designed for IME-heavy languages and emoji selection panels.',
        'The recommended default when maxLength is meaningful but you do '
            'not want to interrupt the IME mid-word.',
      ],
    ),
  ];

  final List<Widget> valueCards = <Widget>[];
  for (final spec in specs) {
    print('value-card: ${spec.value.name} index=${spec.value.index}');
    valueCards.add(_buildValueCard(spec));
  }

  // ==========================================================================
  // SECTION 4: MOCK INPUT PROGRESSION AT THE BOUNDARY
  // --------------------------------------------------------------------------
  // The most instructive part of the page. We simulate, frame by frame, what
  // happens when the user types and composes around a maxLength boundary.
  // We do NOT call into the real text input plugin; we only model the
  // resulting TextEditingValue using TextRange to show composing intent.
  // ==========================================================================
  print('=== Section 4: Mock input progression ===');
  const int kLimit = 5;

  // Step list shared by all three enum demos: a stream of intents the user
  // performs at a CJK-style IME (composing then committing).
  final List<_InputIntent> intents = [
    _InputIntent(label: 'type "h"', raw: 'h', composing: TextRange.empty),
    _InputIntent(label: 'type "he"', raw: 'he', composing: TextRange.empty),
    _InputIntent(label: 'type "hel"', raw: 'hel', composing: TextRange.empty),
    _InputIntent(label: 'type "hell"', raw: 'hell', composing: TextRange.empty),
    _InputIntent(
      label: 'type "hello"',
      raw: 'hello',
      composing: TextRange.empty,
    ),
    _InputIntent(
      label: 'IME start "hello[w]"',
      raw: 'hellow',
      composing: TextRange(start: 5, end: 6),
    ),
    _InputIntent(
      label: 'IME extend "hello[wo]"',
      raw: 'hellowo',
      composing: TextRange(start: 5, end: 7),
    ),
    _InputIntent(
      label: 'IME extend "hello[wor]"',
      raw: 'hellowor',
      composing: TextRange(start: 5, end: 8),
    ),
    _InputIntent(
      label: 'IME commit "helloworld"',
      raw: 'helloworld',
      composing: TextRange.empty,
    ),
  ];

  final Widget mockProgression = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFF3E5F5), Color(0xFFE8EAF6)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _kAccent.withValues(alpha: 0.30), width: 1.2),
      boxShadow: [
        BoxShadow(
          color: _kAccent.withValues(alpha: 0.15),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mock TextField input — maxLength: $kLimit',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: _kAccent,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'A reader-friendly walkthrough of nine TextEditingValue updates as '
          'the user types five plain characters, opens an IME composition, '
          'extends it past the limit, then commits. Each enum value reacts '
          'differently. "Effective" is what the framework would surface as '
          'the field\'s text after enforcement is applied.',
          style: TextStyle(fontSize: 12.5, color: _kInkSoft, height: 1.45),
        ),
        SizedBox(height: 14.0),
        // Header row that names the columns
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.black12),
          ),
          child: Row(
            children: [
              _kProgressHeader('Step', 110.0, _kAccent),
              _kProgressHeader('Raw input', 130.0, _kInkDark),
              _kProgressHeader('none', 110.0, _kNoneColor),
              _kProgressHeader('enforced', 110.0, _kEnforcedColor),
              _kProgressHeader('truncateAfterEnds', 150.0, _kTruncateColor),
            ],
          ),
        ),
        SizedBox(height: 6.0),
        for (final intent in intents)
          _buildProgressionRow(intent, kLimit),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.black12),
          ),
          child: Text(
            'Notice how "enforced" cuts the IME composition mid-character at '
            'index 5, while "truncateAfterCompositionEnds" lets the user '
            'finish picking a candidate, then snaps the field back to "hello" '
            'on commit — the same final value, but a much friendlier path '
            'through the input method.',
            style: TextStyle(
              fontSize: 12.0,
              color: _kInkDark,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 5: COMPARISON MATRIX
  // --------------------------------------------------------------------------
  // A side-by-side grid summarising the consequences along several axes.
  // ==========================================================================
  print('=== Section 5: Comparison matrix ===');
  final List<_MatrixRow> matrixRows = [
    _MatrixRow(
      axis: 'Allows typing past limit',
      none: true,
      enforced: false,
      truncate: true, // temporarily, during composition
    ),
    _MatrixRow(
      axis: 'Truncates final value',
      none: false,
      enforced: true,
      truncate: true,
    ),
    _MatrixRow(
      axis: 'Interrupts IME composition',
      none: false,
      enforced: true,
      truncate: false,
    ),
    _MatrixRow(
      axis: 'Counter widget shows over-limit',
      none: true,
      enforced: false,
      truncate: true,
    ),
    _MatrixRow(
      axis: 'Recommended for PIN / code',
      none: false,
      enforced: true,
      truncate: false,
    ),
    _MatrixRow(
      axis: 'Recommended for CJK / emoji',
      none: false,
      enforced: false,
      truncate: true,
    ),
    _MatrixRow(
      axis: 'Stable index across SDK versions',
      none: true,
      enforced: true,
      truncate: true,
    ),
  ];
  final Widget matrix = _buildMatrix(matrixRows);

  // ==========================================================================
  // SECTION 6: IME COMPOSITION FLOW DIAGRAM
  // --------------------------------------------------------------------------
  // ASCII-style boxes connected with arrows, illustrating the lifecycle of a
  // composing region. We highlight the two decision points where each enum
  // value chooses a different branch.
  // ==========================================================================
  print('=== Section 6: IME composition flow diagram ===');
  final Widget flowDiagram = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFE0F7FA), Color(0xFFE8F5E9)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Colors.teal.withValues(alpha: 0.22),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'IME Composition Lifecycle',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.teal.shade900,
          ),
        ),
        SizedBox(height: 12.0),
        Text(
          'A user typing a Chinese, Japanese, Korean, or emoji candidate '
          'never produces a single TextEditingValue. They produce a stream '
          'of values whose composing range mutates while the candidate is '
          'still tentative. The enum decides what happens at each arrow.',
          style: TextStyle(
            fontSize: 12.5,
            color: Colors.teal.shade900,
            height: 1.45,
          ),
        ),
        SizedBox(height: 16.0),
        _buildFlowStage(
          number: '1',
          title: 'IME OPEN',
          subtitle: 'composing TextRange becomes non-empty',
          decision: 'enforced -> may already block if base+composing > limit',
          color: Colors.cyan.shade700,
        ),
        _kFlowArrow(),
        _buildFlowStage(
          number: '2',
          title: 'IME EXTEND',
          subtitle: 'each keystroke grows composing.end',
          decision: 'enforced -> truncates each frame  '
              '|  none -> passes through  '
              '|  truncate... -> defers',
          color: Colors.teal.shade600,
        ),
        _kFlowArrow(),
        _buildFlowStage(
          number: '3',
          title: 'IME COMMIT',
          subtitle: 'composing collapses to TextRange.empty',
          decision: 'truncate... -> NOW truncates to maxLength  '
              '|  enforced -> already truncated  '
              '|  none -> still untouched',
          color: Colors.green.shade700,
        ),
        _kFlowArrow(),
        _buildFlowStage(
          number: '4',
          title: 'STEADY STATE',
          subtitle: 'TextEditingValue is fully committed',
          decision: 'final length: '
              'none = unbounded, '
              'enforced = ≤ maxLength, '
              'truncate... = ≤ maxLength',
          color: Colors.indigo.shade600,
        ),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 7: RECIPES
  // --------------------------------------------------------------------------
  // Practical, copy-pasteable patterns for choosing an enum value in a
  // real TextField. We render them as syntax-highlighted code blocks.
  // ==========================================================================
  print('=== Section 7: Recipes ===');
  final Widget recipes = Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFFFF8E1), Color(0xFFFFFDE7)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.amber.shade300, width: 1.2),
      boxShadow: [
        BoxShadow(
          color: Colors.amber.withValues(alpha: 0.20),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.menu_book, color: Colors.amber.shade800, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Recipes',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.amber.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        _kRecipeBlock(
          title: 'PIN code (numeric, hard cap)',
          rationale: 'No IME, no surrogate pairs — safe to clamp aggressively.',
          code: 'TextField(\n'
              '  maxLength: 6,\n'
              '  keyboardType: TextInputType.number,\n'
              '  maxLengthEnforcement: MaxLengthEnforcement.enforced,\n'
              '  inputFormatters: [\n'
              '    FilteringTextInputFormatter.digitsOnly,\n'
              '  ],\n'
              ')',
          color: _kEnforcedColor,
        ),
        SizedBox(height: 10.0),
        _kRecipeBlock(
          title: 'Display name (CJK / emoji friendly)',
          rationale: 'Allow IME composition past the limit; trim on commit.',
          code: 'TextField(\n'
              '  maxLength: 24,\n'
              '  maxLengthEnforcement:\n'
              '      MaxLengthEnforcement.truncateAfterCompositionEnds,\n'
              ')',
          color: _kTruncateColor,
        ),
        SizedBox(height: 10.0),
        _kRecipeBlock(
          title: 'Soft counter (advisory only)',
          rationale: 'maxLength is a hint to the counter, not a constraint.',
          code: 'TextField(\n'
              '  maxLength: 280,\n'
              '  maxLengthEnforcement: MaxLengthEnforcement.none,\n'
              '  decoration: InputDecoration(\n'
              '    counterText: "soft limit — see how long you want to be",\n'
              '  ),\n'
              ')',
          color: _kNoneColor,
        ),
        SizedBox(height: 10.0),
        _kRecipeBlock(
          title: 'Platform default',
          rationale: 'Pass null to delegate to the SDK\'s per-platform default.',
          code: 'TextField(\n'
              '  maxLength: 16,\n'
              '  maxLengthEnforcement: null, // SDK picks the right one\n'
              ')',
          color: _kAccent,
        ),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 8: PITFALLS
  // --------------------------------------------------------------------------
  // Things that surprise developers: composition ranges, surrogate pairs,
  // grapheme clusters, paste, and the difference between "characters" and
  // "code units".
  // ==========================================================================
  print('=== Section 8: Pitfalls ===');
  final List<_Pitfall> pitfalls = [
    _Pitfall(
      icon: Icons.warning_amber,
      title: 'maxLength counts code units, not graphemes',
      body: 'A user-perceived character such as 👨‍👩‍👧 (family) is 5 code '
          'points joined by ZWJ, encoded as 11 UTF-16 code units. With '
          'maxLength: 10 and enforced, the family emoji can never be typed.',
      color: _kEnforcedColor,
    ),
    _Pitfall(
      icon: Icons.surround_sound,
      title: 'Surrogate pairs may be split mid-character',
      body: 'On platforms that count UTF-16 units, an "enforced" cut can land '
          'between a high and low surrogate, leaving an invalid string. Prefer '
          'truncateAfterCompositionEnds for emoji-heavy fields.',
      color: _kTruncateColor,
    ),
    _Pitfall(
      icon: Icons.translate,
      title: 'Composition range is invisible but observable',
      body: 'TextEditingValue.composing is a TextRange; its emptiness '
          '(start == end == -1 or 0..0) controls whether '
          'truncateAfterCompositionEnds defers. Inspect it during testing.',
      color: _kAccent,
    ),
    _Pitfall(
      icon: Icons.content_paste,
      title: 'Paste is treated like a non-composing edit',
      body: 'Pasting bypasses IME composition, so '
          'truncateAfterCompositionEnds clips on paste exactly like enforced. '
          'Listen for onChanged if you need a paste-specific UX.',
      color: _kNoneColor,
    ),
    _Pitfall(
      icon: Icons.smart_toy,
      title: 'Autofill / hardware keyboards may skip composition',
      body: 'Autofilled values arrive in one frame with empty composing. '
          'Treat enforcement as a function of the resulting TextEditingValue, '
          'not the input source.',
      color: Colors.deepPurple,
    ),
  ];
  final Widget pitfallSection = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      for (final p in pitfalls) _buildPitfallTile(p),
    ],
  );

  // ==========================================================================
  // SECTION 9: ASCII FOOTER
  // --------------------------------------------------------------------------
  // A monospace decorative footer that summarises the script's intent in a
  // text-art block. Useful for trail readers who scroll the rendered tree.
  // ==========================================================================
  print('=== Section 9: ASCII footer ===');
  final Widget footer = Container(
    margin: EdgeInsets.only(top: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF1A1A1A), Color(0xFF263238)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.40),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '+--------------------------------------------------------------+\n'
          '|     M A X   L E N G T H   E N F O R C E M E N T   D E M O    |\n'
          '+--------------------------------------------------------------+\n'
          '|  none           : type freely, counter is decorative          |\n'
          '|  enforced       : every keystroke clamped at maxLength        |\n'
          '|  truncateAfter… : composition runs free, commit clamps        |\n'
          '+--------------------------------------------------------------+\n'
          '|   raw |  IME     | enforced | truncate… |   final            |\n'
          '|   1-5 |  off     |   ok     |   ok      |   ≤ maxLength      |\n'
          '|   6   |  open    |  block   |   pass    |   diverge          |\n'
          '|   7+  |  extend  |  block   |   pass    |   diverge          |\n'
          '|   *   |  commit  |  block   |   clamp   |   converge         |\n'
          '+--------------------------------------------------------------+\n',
          style: TextStyle(
            color: Color(0xFFB2EBF2),
            fontFamily: 'monospace',
            fontSize: 11.0,
            height: 1.25,
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          'Generated by tom_d4rt_flutter_ast — visual demo of '
          'MaxLengthEnforcement.values=${MaxLengthEnforcement.values.length} '
          '(none=${MaxLengthEnforcement.none.index}, '
          'enforced=${MaxLengthEnforcement.enforced.index}, '
          'truncateAfterCompositionEnds=${MaxLengthEnforcement.truncateAfterCompositionEnds.index}).',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 11.0,
          ),
        ),
      ],
    ),
  );

  print('MaxLengthEnforcement Deep Demo completed successfully');

  // ==========================================================================
  // FINAL ASSEMBLY
  // --------------------------------------------------------------------------
  // Wrap everything in a MaterialApp -> Scaffold -> SingleChildScrollView so
  // the page is renderable as a top-level demo and the scroll content
  // includes a generous bottom padding for the ASCII footer.
  // ==========================================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'MaxLengthEnforcement Deep Demo',
    home: Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            heroHeader,
            SizedBox(height: 28.0),
            _kSectionTitle('1. Anatomy & enum signature'),
            anatomy,
            SizedBox(height: 28.0),
            _kSectionTitle('2. Per-value cards'),
            for (final card in valueCards) ...[
              card,
              SizedBox(height: 12.0),
            ],
            SizedBox(height: 16.0),
            _kSectionTitle('3. Mock TextField input progression'),
            mockProgression,
            SizedBox(height: 28.0),
            _kSectionTitle('4. Comparison matrix'),
            matrix,
            SizedBox(height: 28.0),
            _kSectionTitle('5. IME composition flow'),
            flowDiagram,
            SizedBox(height: 28.0),
            _kSectionTitle('6. Recipes'),
            recipes,
            SizedBox(height: 28.0),
            _kSectionTitle('7. Pitfalls'),
            pitfallSection,
            SizedBox(height: 28.0),
            _kSectionTitle('8. ASCII reference'),
            footer,
            SizedBox(height: 32.0),
          ],
        ),
      ),
    ),
  );
}

// =============================================================================
// Data model classes — kept tiny and intent-revealing rather than feature-rich.
// =============================================================================

class _EnumValueSpec {
  final MaxLengthEnforcement value;
  final IconData icon;
  final Color color;
  final String summary;
  final String headline;
  final List<String> bullets;
  _EnumValueSpec({
    required this.value,
    required this.icon,
    required this.color,
    required this.summary,
    required this.headline,
    required this.bullets,
  });
}

class _InputIntent {
  final String label;
  final String raw;
  final TextRange composing;
  _InputIntent({
    required this.label,
    required this.raw,
    required this.composing,
  });

  bool get isComposing => composing.isValid && !composing.isCollapsed;
}

class _MatrixRow {
  final String axis;
  final bool none;
  final bool enforced;
  final bool truncate;
  _MatrixRow({
    required this.axis,
    required this.none,
    required this.enforced,
    required this.truncate,
  });
}

class _Pitfall {
  final IconData icon;
  final String title;
  final String body;
  final Color color;
  _Pitfall({
    required this.icon,
    required this.title,
    required this.body,
    required this.color,
  });
}

// =============================================================================
// Pure helper builders. We pass them as top-level functions instead of methods
// so the script can be evaluated in d4rt without instantiating a State class.
// =============================================================================

Widget _kHeroChip(String label) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: Colors.white54),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: Colors.white,
        fontSize: 11.0,
        fontFamily: 'monospace',
      ),
    ),
  );
}

Widget _kSectionTitle(String text) {
  return Padding(
    padding: EdgeInsets.only(left: 4.0, bottom: 10.0, top: 4.0),
    child: Row(
      children: [
        Container(
          width: 6.0,
          height: 22.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_kAccent, Color(0xFF7E57C2)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 19.0,
              fontWeight: FontWeight.bold,
              color: _kInkDark,
              letterSpacing: 0.2,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _kCodeLine(String text, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 1.0),
    child: Text(
      text,
      style: TextStyle(
        color: color,
        fontFamily: 'monospace',
        fontSize: 12.5,
        height: 1.4,
      ),
    ),
  );
}

Widget _buildValueCard(_EnumValueSpec spec) {
  return Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          spec.color.withValues(alpha: 0.10),
          spec.color.withValues(alpha: 0.22),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: spec.color, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: spec.color.withValues(alpha: 0.25),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: spec.color,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: spec.color.withValues(alpha: 0.35),
                    blurRadius: 6.0,
                    offset: Offset(0.0, 3.0),
                  ),
                ],
              ),
              child: Icon(spec.icon, color: Colors.white, size: 22.0),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MaxLengthEnforcement.${spec.value.name}',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13.5,
                      color: spec.color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'index ${spec.value.index} • ${spec.headline}',
                    style: TextStyle(
                      fontSize: 11.5,
                      color: _kInkSoft,
                    ),
                  ),
                ],
              ),
            ),
            // Tiny progress bar locked to AlwaysStoppedAnimation<double> to
            // visually echo the demo's static motion stand-in.
            SizedBox(
              width: 60.0,
              child: LinearProgressIndicator(
                value: _kStaticMotion.value,
                backgroundColor: Colors.white,
                valueColor: AlwaysStoppedAnimation<Color>(spec.color),
                minHeight: 6.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Text(
          spec.summary,
          style: TextStyle(
            fontSize: 14.0,
            color: _kInkDark,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 10.0),
        for (final b in spec.bullets)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 3.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.chevron_right, color: spec.color, size: 18.0),
                SizedBox(width: 4.0),
                Expanded(
                  child: Text(
                    b,
                    style: TextStyle(
                      fontSize: 12.5,
                      color: _kInkDark,
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

Widget _kProgressHeader(String text, double width, Color color) {
  return SizedBox(
    width: width,
    child: Text(
      text,
      style: TextStyle(
        fontSize: 11.5,
        fontWeight: FontWeight.bold,
        color: color,
      ),
      textAlign: TextAlign.left,
    ),
  );
}

// Apply the three enforcement policies to a single intent, returning the
// "effective" value the framework would surface. The simulation is purposely
// simplified — we focus on the boundary behaviour, not the full TextInput
// pipeline.
String _applyNone(String raw, int limit) => raw;

String _applyEnforced(String raw, int limit) {
  if (raw.length <= limit) return raw;
  return raw.substring(0, limit);
}

String _applyTruncateAfter(String raw, int limit, _InputIntent intent) {
  if (raw.length <= limit) return raw;
  // While composing, allow overflow so the IME candidate can be picked.
  if (intent.isComposing) return raw;
  // On commit (composing empty) we clamp.
  return raw.substring(0, limit);
}

Widget _buildProgressionRow(_InputIntent intent, int limit) {
  final String none = _applyNone(intent.raw, limit);
  final String enforced = _applyEnforced(intent.raw, limit);
  final String truncate = _applyTruncateAfter(intent.raw, limit, intent);
  print('progression "${intent.label}" raw="${intent.raw}" '
      'composing=${intent.composing} -> '
      'none="$none" enforced="$enforced" truncate="$truncate"');

  return Container(
    margin: EdgeInsets.only(top: 4.0),
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: intent.isComposing
          ? Colors.amber.withValues(alpha: 0.10)
          : Colors.white,
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(
        color: intent.isComposing
            ? Colors.amber.shade400
            : Colors.black12,
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 110.0,
          child: Text(
            intent.label,
            style: TextStyle(fontSize: 11.0, color: _kInkDark),
          ),
        ),
        SizedBox(
          width: 130.0,
          child: _kInputBubble(
            text: intent.raw,
            composing: intent.composing,
            color: _kInkDark,
            limit: limit,
          ),
        ),
        SizedBox(
          width: 110.0,
          child: _kEffectiveBubble(
            text: none,
            color: _kNoneColor,
            limit: limit,
          ),
        ),
        SizedBox(
          width: 110.0,
          child: _kEffectiveBubble(
            text: enforced,
            color: _kEnforcedColor,
            limit: limit,
          ),
        ),
        SizedBox(
          width: 150.0,
          child: _kEffectiveBubble(
            text: truncate,
            color: _kTruncateColor,
            limit: limit,
          ),
        ),
      ],
    ),
  );
}

Widget _kInputBubble({
  required String text,
  required TextRange composing,
  required Color color,
  required int limit,
}) {
  final bool composingActive = composing.isValid && !composing.isCollapsed;
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(
        color: composingActive ? Colors.amber.shade600 : Colors.black26,
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.5,
            color: text.length > limit ? _kEnforcedColor : color,
            decoration: composingActive ? TextDecoration.underline : null,
            decorationStyle: TextDecorationStyle.dashed,
            decorationColor: Colors.amber.shade700,
          ),
        ),
        if (composingActive) ...[
          SizedBox(width: 6.0),
          Icon(Icons.keyboard, size: 12.0, color: Colors.amber.shade700),
        ],
      ],
    ),
  );
}

Widget _kEffectiveBubble({
  required String text,
  required Color color,
  required int limit,
}) {
  final bool over = text.length > limit;
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.10),
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: color.withValues(alpha: 0.55)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: color,
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(width: 6.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 1.0),
          decoration: BoxDecoration(
            color: over ? _kEnforcedColor : color.withValues(alpha: 0.30),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            '${text.length}',
            style: TextStyle(
              fontSize: 9.5,
              color: over ? Colors.white : color,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildMatrix(List<_MatrixRow> rows) {
  return Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, Color(0xFFF5F5F5)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.black12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        // Header
        Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
          decoration: BoxDecoration(
            color: _kAccent.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 220.0,
                child: Text(
                  'Axis',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _kAccent,
                    fontSize: 12.5,
                  ),
                ),
              ),
              _kMatrixHeaderCell('none', _kNoneColor),
              _kMatrixHeaderCell('enforced', _kEnforcedColor),
              _kMatrixHeaderCell('truncateAfter…', _kTruncateColor),
            ],
          ),
        ),
        SizedBox(height: 4.0),
        for (int i = 0; i < rows.length; i++)
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            decoration: BoxDecoration(
              color: i.isEven
                  ? Colors.white
                  : Colors.indigo.withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 220.0,
                  child: Text(
                    rows[i].axis,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: _kInkDark,
                    ),
                  ),
                ),
                _kMatrixBoolCell(rows[i].none),
                _kMatrixBoolCell(rows[i].enforced),
                _kMatrixBoolCell(rows[i].truncate),
              ],
            ),
          ),
      ],
    ),
  );
}

Widget _kMatrixHeaderCell(String label, Color color) {
  return Expanded(
    child: Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.18),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11.5,
            fontFamily: 'monospace',
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}

Widget _kMatrixBoolCell(bool value) {
  return Expanded(
    child: Center(
      child: Container(
        width: 28.0,
        height: 28.0,
        decoration: BoxDecoration(
          color: value
              ? Colors.green.withValues(alpha: 0.15)
              : Colors.red.withValues(alpha: 0.10),
          shape: BoxShape.circle,
          border: Border.all(
            color: value ? Colors.green : Colors.red.shade300,
            width: 1.2,
          ),
        ),
        child: Icon(
          value ? Icons.check : Icons.close,
          size: 16.0,
          color: value ? Colors.green : Colors.red.shade400,
        ),
      ),
    ),
  );
}

Widget _kFlowArrow() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Center(
      child: Icon(
        Icons.arrow_downward,
        color: Colors.teal.shade400,
        size: 22.0,
      ),
    ),
  );
}

Widget _buildFlowStage({
  required String number,
  required String title,
  required String subtitle,
  required String decision,
  required Color color,
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 2.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.50), width: 1.2),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.18),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 30.0,
          height: 30.0,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.35),
                blurRadius: 4.0,
                offset: Offset(0.0, 2.0),
              ),
            ],
          ),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
              ),
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
                  fontWeight: FontWeight.bold,
                  fontSize: 13.5,
                  color: color,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12.0,
                  color: _kInkSoft,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 6.0),
              Container(
                padding: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  decision,
                  style: TextStyle(
                    fontSize: 11.5,
                    fontFamily: 'monospace',
                    color: _kInkDark,
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

Widget _kRecipeBlock({
  required String title,
  required String rationale,
  required String code,
  required Color color,
}) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.40), width: 1.2),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.10),
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
              height: 8.0,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: color,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Text(
          rationale,
          style: TextStyle(
            fontSize: 11.5,
            color: _kInkSoft,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFF263238),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: Color(0xFFE0F7FA),
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildPitfallTile(_Pitfall p) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          p.color.withValues(alpha: 0.05),
          p.color.withValues(alpha: 0.15),
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: p.color.withValues(alpha: 0.50), width: 1.2),
      boxShadow: [
        BoxShadow(
          color: p.color.withValues(alpha: 0.18),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: p.color,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(p.icon, color: Colors.white, size: 20.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                p.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.5,
                  color: p.color,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                p.body,
                style: TextStyle(
                  fontSize: 12.0,
                  color: _kInkDark,
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
