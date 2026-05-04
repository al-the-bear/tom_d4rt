// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable
// D4rt deep visual demo: ContentSensitivity from package:flutter/services.dart
//
// This test renders an extensive, instructive single-page tour of the
// ContentSensitivity enum which controls whether the host platform should
// hide the app contents from screen captures, mirroring sessions and
// recent-app thumbnails. The enum is declared in
// `package:flutter/src/services/sensitive_content.dart` and is currently
// only fully wired on Android API 35+ (the platform layer maps the values
// onto the native View.CONTENT_SENSITIVITY_* constants which in turn flip
// FLAG_SECURE during active media projection).
//
// Public enum members verified against the Flutter SDK:
//   * ContentSensitivity.autoSensitive
//   * ContentSensitivity.sensitive
//   * ContentSensitivity.notSensitive
// (plus a private `_unknown` sentinel that is never returned to user code).
//
// The demo intentionally has no animation, no taps, no gestures and no
// asynchronous work: every "motion" is wired through an
// AlwaysStoppedAnimation<double> with Duration.zero so the AST tree is
// deterministic and easy to render in the d4rt screenshot harness.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('ContentSensitivity Deep Demo executing');

  // ============================================================
  // Static-as-rock animation primitives.
  // Every section that hints at motion uses these so the rendered
  // AST is identical from frame to frame.
  // ============================================================
  final AlwaysStoppedAnimation<double> stillFull =
      const AlwaysStoppedAnimation<double>(1.0);
  final AlwaysStoppedAnimation<double> stillHalf =
      const AlwaysStoppedAnimation<double>(0.5);
  final AlwaysStoppedAnimation<double> stillNone =
      const AlwaysStoppedAnimation<double>(0.0);
  final Duration zero = Duration.zero;
  print(
    'Still values: ${stillFull.value}, ${stillHalf.value}, ${stillNone.value}',
  );
  print('Zero duration: ${zero.inMicroseconds}us');

  // ============================================================
  // Enum sanity dump – this also exercises the d4rt bridge so that
  // generator regressions on enum value-listing surface immediately.
  // ============================================================
  print('--- ContentSensitivity enum dump ---');
  for (final ContentSensitivity v in ContentSensitivity.values) {
    print('  index=${v.index}  name=${v.name}  toString=$v');
  }
  print('Total values: ${ContentSensitivity.values.length}');

  // ============================================================
  // SECTION 1 – Hero header
  // ============================================================
  print('=== Section 1: Hero header ===');
  final Widget hero = Container(
    padding: const EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[
          Color(0xFF1A237E),
          Color(0xFF311B92),
          Color(0xFF4A148C),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.indigo.shade900.withValues(alpha: 0.55),
          blurRadius: 24.0,
          spreadRadius: 2.0,
          offset: const Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: Colors.purple.shade900.withValues(alpha: 0.35),
          blurRadius: 8.0,
          offset: const Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(
              Icons.privacy_tip_outlined,
              size: 56.0,
              color: Colors.white,
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    'ContentSensitivity',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Hide the screen from screenshots, recordings and mirrors.',
                    style: TextStyle(fontSize: 14.0, color: Colors.white70),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 18.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.30),
              width: 1.0,
            ),
          ),
          child: Row(
            children: const <Widget>[
              Icon(Icons.android, size: 18.0, color: Colors.white),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Android API 35+ — maps onto View.CONTENT_SENSITIVITY_* '
                  'and toggles FLAG_SECURE during media projection.',
                  style: TextStyle(color: Colors.white, fontSize: 12.0),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2 – Anatomy / enum signature card
  // ============================================================
  print('=== Section 2: Anatomy ===');
  final Widget anatomy = Container(
    margin: const EdgeInsets.symmetric(vertical: 16.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: const Color(0xFF0D1117),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.25),
          blurRadius: 12.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
      border: Border.all(color: Colors.cyan.shade700, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.code, color: Colors.cyan.shade300, size: 20.0),
            const SizedBox(width: 8.0),
            Text(
              'enum signature',
              style: TextStyle(
                color: Colors.cyan.shade300,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        _codeLine(
          '// from package:flutter/services.dart',
          Colors.grey.shade500,
        ),
        _codeLine('enum ContentSensitivity {', Colors.purpleAccent.shade100),
        _codeLine(
          '  autoSensitive,   // index 0 — platform decides',
          Colors.lightBlue.shade200,
        ),
        _codeLine(
          '  sensitive,       // index 1 — always hide',
          Colors.redAccent.shade100,
        ),
        _codeLine(
          '  notSensitive,    // index 2 — never hide',
          Colors.greenAccent.shade100,
        ),
        _codeLine('}', Colors.purpleAccent.shade100),
        const SizedBox(height: 12.0),
        Text(
          'Use it through the SensitiveContent widget. The widget walks up '
          'the tree and the highest priority level wins '
          '(sensitive > autoSensitive > notSensitive).',
          style: TextStyle(
            color: Colors.grey.shade300,
            fontSize: 12.0,
            height: 1.4,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3 – Per-value cards (auto / sensitive / notSensitive)
  // ============================================================
  print('=== Section 3: Per-value cards ===');
  final List<Map<String, dynamic>> valueData = <Map<String, dynamic>>[
    <String, dynamic>{
      'value': ContentSensitivity.autoSensitive,
      'title': 'autoSensitive',
      'tagline': 'Let the platform decide',
      'icon': Icons.auto_awesome,
      'primary': Colors.indigo,
      'accent': Colors.indigoAccent,
      'risk': 0.5,
      'summary':
          'The hosting window is only marked sensitive if some other '
          'SensitiveContent widget elsewhere in the tree is set to '
          'ContentSensitivity.sensitive. On Android < API 35 the platform '
          'falls back to native auto-detection of passwords and 2FA fields.',
    },
    <String, dynamic>{
      'value': ContentSensitivity.sensitive,
      'title': 'sensitive',
      'tagline': 'Always redact during capture',
      'icon': Icons.shield_moon,
      'primary': Colors.red,
      'accent': Colors.redAccent,
      'risk': 1.0,
      'summary':
          'The window is marked sensitive whenever there is an active media '
          'projection session, screen-mirroring cast or system screenshot. '
          'Maps onto FLAG_SECURE under the hood. Use this for OTPs, banking '
          'totals, KYC documents, healthcare data and recovery phrases.',
    },
    <String, dynamic>{
      'value': ContentSensitivity.notSensitive,
      'title': 'notSensitive',
      'tagline': 'Allow capture freely',
      'icon': Icons.visibility,
      'primary': Colors.green,
      'accent': Colors.lightGreen,
      'risk': 0.05,
      'summary':
          'The widget tree contains nothing privacy-sensitive — screenshots '
          'and recordings are allowed. Lowest priority, so it never overrides '
          'a sensitive sibling. Good default for marketing pages, public '
          'feeds and onboarding tutorials.',
    },
  ];

  final List<Widget> valueCards = <Widget>[];
  for (final Map<String, dynamic> data in valueData) {
    final ContentSensitivity v = data['value'] as ContentSensitivity;
    final Color primary = data['primary'] as Color;
    final Color accent = data['accent'] as Color;
    final double risk = data['risk'] as double;
    final String title = data['title'] as String;
    final String tagline = data['tagline'] as String;
    final String summary = data['summary'] as String;
    final IconData icon = data['icon'] as IconData;
    print('Card: $title (index ${v.index}, risk $risk)');

    valueCards.add(
      Container(
        width: 300.0,
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              primary.withValues(alpha: 0.10),
              accent.withValues(alpha: 0.25),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: primary, width: 2.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: primary.withValues(alpha: 0.30),
              blurRadius: 14.0,
              offset: const Offset(0.0, 6.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: primary.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Icon(icon, color: primary, size: 28.0),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: primary,
                        ),
                      ),
                      Text(
                        tagline,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    color: primary.withValues(alpha: 0.20),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Text(
                    'idx ${v.index}',
                    style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold,
                      color: primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            // Risk meter, fed by an AlwaysStoppedAnimation so the visual
            // is deterministic but still goes through the standard
            // animation plumbing.
            Row(
              children: <Widget>[
                Text(
                  'risk',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4.0),
                    child: Container(
                      height: 10.0,
                      color: Colors.grey.shade300,
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: AlwaysStoppedAnimation<double>(risk).value,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: <Color>[primary, accent],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                Text(
                  '${(risk * 100).toStringAsFixed(0)}%',
                  style: TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.bold,
                    color: primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.65),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: primary.withValues(alpha: 0.30),
                  width: 1.0,
                ),
              ),
              child: Text(
                summary,
                style: TextStyle(
                  fontSize: 12.0,
                  height: 1.35,
                  color: Colors.grey.shade900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 4 – Mock app screenshots with redaction overlays
  // ============================================================
  print('=== Section 4: Mock screenshots / redaction overlays ===');
  final Widget screenshotGallery = Wrap(
    alignment: WrapAlignment.center,
    spacing: 12.0,
    runSpacing: 12.0,
    children: <Widget>[
      _mockPhoneScreen(
        label: 'autoSensitive',
        subtitle: 'platform decides',
        accent: Colors.indigo,
        bodyContent: _bankingBody(redacted: false, opacity: stillFull.value),
        overlay: _autoOverlay(opacity: stillHalf.value),
      ),
      _mockPhoneScreen(
        label: 'sensitive',
        subtitle: 'always redact',
        accent: Colors.red,
        bodyContent: _bankingBody(redacted: true, opacity: stillFull.value),
        overlay: _redactOverlay(opacity: stillFull.value),
      ),
      _mockPhoneScreen(
        label: 'notSensitive',
        subtitle: 'fully visible',
        accent: Colors.green,
        bodyContent: _bankingBody(redacted: false, opacity: stillFull.value),
        overlay: _noneOverlay(opacity: stillNone.value),
      ),
    ],
  );

  // ============================================================
  // SECTION 5 – Screen-mirror frame previews
  // ============================================================
  print('=== Section 5: Screen-mirror frames ===');
  final Widget mirrorFrames = Container(
    margin: const EdgeInsets.symmetric(vertical: 16.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Colors.blueGrey.shade900, Colors.black],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.40),
          blurRadius: 16.0,
          offset: const Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.cast, color: Colors.cyanAccent, size: 22.0),
            const SizedBox(width: 8.0),
            Text(
              'What the receiver sees during MediaProjection',
              style: TextStyle(
                color: Colors.cyanAccent.shade100,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Text(
          'A user starts a Google Meet screen share or AirPlay-like cast. '
          'The OS frames each ContentSensitivity differently.',
          style: TextStyle(color: Colors.grey.shade300, fontSize: 12.0),
        ),
        const SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _mirrorTile(
              caption: 'autoSensitive',
              colorA: Colors.indigo.shade400,
              colorB: Colors.indigo.shade900,
              hidden: false,
              detail:
                  'Visible unless any sibling marks the tree as sensitive.',
            ),
            _mirrorTile(
              caption: 'sensitive',
              colorA: Colors.black,
              colorB: Colors.grey.shade800,
              hidden: true,
              detail: 'Frame is fully blacked out by FLAG_SECURE.',
            ),
            _mirrorTile(
              caption: 'notSensitive',
              colorA: Colors.green.shade300,
              colorB: Colors.green.shade800,
              hidden: false,
              detail: 'Rendered identically to the host display.',
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6 – Threat model / decision matrix
  // ============================================================
  print('=== Section 6: Threat model ===');
  final Widget threatModel = Container(
    margin: const EdgeInsets.symmetric(vertical: 16.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Colors.amber.shade50, Colors.orange.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.orange.shade300, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.orange.shade200.withValues(alpha: 0.50),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              Icons.warning_amber_rounded,
              color: Colors.orange.shade900,
              size: 24.0,
            ),
            const SizedBox(width: 8.0),
            Text(
              'Threat Model — what does each level defend against?',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        // Header row
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          decoration: BoxDecoration(
            color: Colors.orange.shade200,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Row(
            children: <Widget>[
              _matrixHead('threat', 160.0),
              _matrixHead('autoSensitive', 110.0),
              _matrixHead('sensitive', 110.0),
              _matrixHead('notSensitive', 110.0),
            ],
          ),
        ),
        _matrixRow(
          'system screenshot',
          <bool>[false, true, false],
          <Color>[Colors.indigo, Colors.red, Colors.green],
        ),
        _matrixRow(
          'screen recording',
          <bool>[false, true, false],
          <Color>[Colors.indigo, Colors.red, Colors.green],
        ),
        _matrixRow(
          'recents thumbnail',
          <bool>[false, true, false],
          <Color>[Colors.indigo, Colors.red, Colors.green],
        ),
        _matrixRow(
          'media projection',
          <bool>[false, true, false],
          <Color>[Colors.indigo, Colors.red, Colors.green],
        ),
        _matrixRow(
          'autofill heuristics',
          <bool>[true, true, false],
          <Color>[Colors.indigo, Colors.red, Colors.green],
        ),
        const SizedBox(height: 12.0),
        Text(
          'A check icon means the level blocks that capture path. '
          'autoSensitive only blocks captures when another sensitive node '
          'is present in the same tree.',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 11.0,
            color: Colors.orange.shade900,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7 – Security badge cards
  // ============================================================
  print('=== Section 7: Security badge cards ===');
  final Widget badgeRow = Wrap(
    alignment: WrapAlignment.center,
    spacing: 12.0,
    runSpacing: 12.0,
    children: <Widget>[
      _badgeCard(
        icon: Icons.account_balance,
        title: 'Banking screen',
        recommended: ContentSensitivity.sensitive,
        rationale: 'Account totals leak net-worth data via screenshots.',
        accent: Colors.red,
      ),
      _badgeCard(
        icon: Icons.password,
        title: 'OTP / 2FA prompt',
        recommended: ContentSensitivity.sensitive,
        rationale: 'Codes are valid for ~30s — never let them be captured.',
        accent: Colors.red,
      ),
      _badgeCard(
        icon: Icons.local_hospital,
        title: 'Patient chart',
        recommended: ContentSensitivity.sensitive,
        rationale: 'PHI is regulated under HIPAA / GDPR special category.',
        accent: Colors.red,
      ),
      _badgeCard(
        icon: Icons.lightbulb,
        title: 'Onboarding tutorial',
        recommended: ContentSensitivity.notSensitive,
        rationale: 'Marketing screens benefit from being shareable.',
        accent: Colors.green,
      ),
      _badgeCard(
        icon: Icons.feed,
        title: 'Public feed',
        recommended: ContentSensitivity.notSensitive,
        rationale: 'Already public on the network — capture is harmless.',
        accent: Colors.green,
      ),
      _badgeCard(
        icon: Icons.dashboard_customize,
        title: 'Mixed dashboard',
        recommended: ContentSensitivity.autoSensitive,
        rationale: 'Lets nested sensitive subtrees promote the whole tree.',
        accent: Colors.indigo,
      ),
    ],
  );

  // ============================================================
  // SECTION 8 – Recipes (SensitiveContent widget patterns)
  // ============================================================
  print('=== Section 8: Recipes ===');
  final Widget recipes = Container(
    margin: const EdgeInsets.symmetric(vertical: 16.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: const Color(0xFF11151C),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.30),
          blurRadius: 14.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.menu_book, color: Colors.cyan.shade300, size: 22.0),
            const SizedBox(width: 8.0),
            Text(
              'Recipes — SensitiveContent in practice',
              style: TextStyle(
                color: Colors.cyan.shade300,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        _recipe(
          'Wrap a 2FA reveal',
          'SensitiveContent(\n'
              '  sensitivity: ContentSensitivity.sensitive,\n'
              '  child: OtpDisplay(code: code),\n'
              ')',
          'The host window flips to FLAG_SECURE while OtpDisplay is mounted.',
          Colors.redAccent.shade100,
        ),
        const SizedBox(height: 12.0),
        _recipe(
          'Marketing modal opt-out',
          'SensitiveContent(\n'
              '  sensitivity: ContentSensitivity.notSensitive,\n'
              '  child: AnnouncementBanner(),\n'
              ')',
          'Explicitly opts the subtree out — useful when a parent is auto.',
          Colors.greenAccent.shade100,
        ),
        const SizedBox(height: 12.0),
        _recipe(
          'Conditional sensitivity',
          'SensitiveContent(\n'
              '  sensitivity: showBalance\n'
              '      ? ContentSensitivity.sensitive\n'
              '      : ContentSensitivity.autoSensitive,\n'
              '  child: BalanceCard(),\n'
              ')',
          'Toggle protection when the balance toggle is revealed.',
          Colors.lightBlueAccent.shade100,
        ),
        const SizedBox(height: 12.0),
        _recipe(
          'Querying the level imperatively',
          'final svc = SensitiveContentService();\n'
              'final level = await svc.getContentSensitivity();\n'
              'if (level == ContentSensitivity.sensitive) { ... }',
          'Used by analytics or debug overlays — never on hot paths.',
          Colors.amberAccent.shade100,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9 – Pitfalls
  // ============================================================
  print('=== Section 9: Pitfalls ===');
  final Widget pitfalls = Container(
    margin: const EdgeInsets.symmetric(vertical: 16.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Colors.red.shade50, Colors.pink.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.red.shade300, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.red.shade200.withValues(alpha: 0.40),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.dangerous, color: Colors.red.shade700, size: 22.0),
            const SizedBox(width: 8.0),
            Text(
              'Pitfalls & footguns',
              style: TextStyle(
                color: Colors.red.shade900,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        _pitfall(
          'Android-only API',
          'On iOS, web and desktop, ContentSensitivity is a no-op. Use '
              'platform-specific guards (UIScreen.isCaptured, secureField, '
              'etc.) on those targets.',
        ),
        _pitfall(
          'Requires API 35+',
          'Older Android versions only honour the autofill auto-detection '
              'for native View hierarchies — Flutter views do not benefit. '
              'Test SensitiveContentService.isSupported() first.',
        ),
        _pitfall(
          'Window-level granularity',
          'FLAG_SECURE applies to the whole window. A single sensitive '
              'subtree blacks out the entire screen during projection — '
              'design accordingly.',
        ),
        _pitfall(
          'Priority is fixed',
          'sensitive > autoSensitive > notSensitive. You cannot demote a '
              'subtree below an ancestor that is already sensitive.',
        ),
        _pitfall(
          'Hot reload state',
          'Flipping the level during dev requires the widget to rebuild — '
              'a hot reload that preserves state may keep the previous '
              'window flag until the next setSensitivity call.',
        ),
        _pitfall(
          'Recents thumbnails',
          'Even after the user backgrounds the app, the recents preview is '
              'driven by the last frame; if it was sensitive when paused, '
              'the OS will replace the thumbnail with a placeholder.',
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 10 – ASCII footer
  // ============================================================
  print('=== Section 10: ASCII footer ===');
  final Widget asciiFooter = Container(
    margin: const EdgeInsets.symmetric(vertical: 16.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Colors.black, Colors.blueGrey.shade900],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.cyanAccent.withValues(alpha: 0.18),
          blurRadius: 12.0,
          spreadRadius: 1.0,
          offset: const Offset(0.0, 0.0),
        ),
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.40),
          blurRadius: 16.0,
          offset: const Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '+----------------------------------------------------+\n'
          '| ContentSensitivity                                 |\n'
          '|----------------------------------------------------|\n'
          '|  autoSensitive  -> [ ?  ] platform-driven          |\n'
          '|  sensitive      -> [ XX ] always redacted          |\n'
          '|  notSensitive   -> [    ] always visible           |\n'
          '+----------------------------------------------------+\n'
          '   priority:  sensitive > autoSensitive > notSensitive\n'
          '   wraps:     SensitiveContent(sensitivity: ..., child: ...)\n'
          '   target:    Android API 35+   (FLAG_SECURE)\n',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12.0,
            height: 1.4,
            color: Colors.greenAccent.shade100,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          '// generated by tom_d4rt_flutter_ast / content_sensitivity_test',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 10.0,
            color: Colors.cyan.shade200,
          ),
        ),
      ],
    ),
  );

  print('ContentSensitivity Deep Demo: building final tree');

  // ============================================================
  // Final composition
  // ============================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'ContentSensitivity Deep Demo',
    theme: ThemeData(primarySwatch: Colors.indigo),
    home: Scaffold(
      backgroundColor: const Color(0xFFF6F6FB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              hero,
              const SizedBox(height: 16.0),
              _sectionHeader('1. Anatomy', Icons.text_snippet),
              anatomy,
              _sectionHeader('2. Per-value cards', Icons.style),
              const SizedBox(height: 8.0),
              Wrap(
                alignment: WrapAlignment.center,
                children: valueCards,
              ),
              const SizedBox(height: 16.0),
              _sectionHeader('3. Mock screenshots', Icons.smartphone),
              const SizedBox(height: 8.0),
              screenshotGallery,
              const SizedBox(height: 16.0),
              _sectionHeader('4. Screen mirror', Icons.cast),
              mirrorFrames,
              _sectionHeader('5. Threat model', Icons.shield),
              threatModel,
              _sectionHeader('6. Security badges', Icons.verified_user),
              const SizedBox(height: 8.0),
              badgeRow,
              const SizedBox(height: 16.0),
              _sectionHeader('7. Recipes', Icons.menu_book),
              recipes,
              _sectionHeader('8. Pitfalls', Icons.report_problem),
              pitfalls,
              _sectionHeader('9. Summary', Icons.terminal),
              asciiFooter,
              const SizedBox(height: 24.0),
            ],
          ),
        ),
      ),
    ),
  );
}

// ============================================================
// Helpers (top-level so the build() body stays readable).
// ============================================================

Widget _sectionHeader(String label, IconData icon) {
  return Padding(
    padding: const EdgeInsets.only(top: 12.0, bottom: 4.0),
    child: Row(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[Colors.indigo.shade400, Colors.purple.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.indigo.shade200.withValues(alpha: 0.45),
                blurRadius: 6.0,
                offset: const Offset(0.0, 3.0),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 18.0),
        ),
        const SizedBox(width: 12.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade900,
          ),
        ),
      ],
    ),
  );
}

Widget _codeLine(String text, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 1.0),
    child: Text(
      text,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 12.0,
        color: color,
        height: 1.5,
      ),
    ),
  );
}

Widget _mockPhoneScreen({
  required String label,
  required String subtitle,
  required Color accent,
  required Widget bodyContent,
  required Widget overlay,
}) {
  return Container(
    width: 220.0,
    height: 380.0,
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Colors.grey.shade800, Colors.black],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(28.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.35),
          blurRadius: 14.0,
          offset: const Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      children: <Widget>[
        // notch
        Container(
          width: 60.0,
          height: 6.0,
          margin: const EdgeInsets.only(top: 4.0, bottom: 6.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade700,
            borderRadius: BorderRadius.circular(3.0),
          ),
        ),
        // screen
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Stack(
              children: <Widget>[
                Positioned.fill(child: bodyContent),
                Positioned.fill(child: overlay),
                Positioned(
                  left: 8.0,
                  top: 8.0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                    decoration: BoxDecoration(
                      color: accent.withValues(alpha: 0.85),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Text(
                      label,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 8.0,
                  bottom: 8.0,
                  right: 8.0,
                  child: Container(
                    padding: const EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.55),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Text(
                      subtitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 6.0),
      ],
    ),
  );
}

Widget _bankingBody({required bool redacted, required double opacity}) {
  return Opacity(
    opacity: opacity,
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[Colors.white, Colors.indigo.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 28.0),
          Text(
            'Hello, Alex',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Colors.indigo.shade900,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            'Total balance',
            style: TextStyle(fontSize: 10.0, color: Colors.grey.shade700),
          ),
          const SizedBox(height: 4.0),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 6.0,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[Colors.indigo.shade400, Colors.indigo.shade700],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              redacted ? '\$ ●●●●●●●' : '\$ 12 432.18',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          for (int i = 0; i < 3; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 6.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 22.0,
                    height: 22.0,
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade100,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Icon(
                      Icons.payments,
                      size: 14.0,
                      color: Colors.indigo.shade700,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Container(
                      height: 8.0,
                      decoration: BoxDecoration(
                        color: redacted
                            ? Colors.grey.shade400
                            : Colors.indigo.shade100,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Container(
                    width: 30.0,
                    height: 8.0,
                    decoration: BoxDecoration(
                      color: redacted
                          ? Colors.grey.shade500
                          : Colors.indigo.shade300,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    ),
  );
}

Widget _autoOverlay({required double opacity}) {
  return IgnorePointer(
    child: Opacity(
      opacity: opacity,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Colors.indigo.withValues(alpha: 0.05),
              Colors.indigo.withValues(alpha: 0.20),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        alignment: Alignment.bottomRight,
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: Colors.indigo.shade700,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: const Text(
            'auto',
            style: TextStyle(
              color: Colors.white,
              fontSize: 9.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
  );
}

Widget _redactOverlay({required double opacity}) {
  return IgnorePointer(
    child: Opacity(
      opacity: opacity,
      child: Container(
        color: Colors.black.withValues(alpha: 0.92),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.shield_moon,
              color: Colors.red.shade300,
              size: 36.0,
            ),
            const SizedBox(height: 6.0),
            Text(
              'CONTENT HIDDEN',
              style: TextStyle(
                color: Colors.red.shade200,
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.4,
              ),
            ),
            const SizedBox(height: 2.0),
            Text(
              'FLAG_SECURE active',
              style: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 9.0,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _noneOverlay({required double opacity}) {
  return IgnorePointer(
    child: Opacity(
      opacity: opacity,
      child: const SizedBox.shrink(),
    ),
  );
}

Widget _mirrorTile({
  required String caption,
  required Color colorA,
  required Color colorB,
  required bool hidden,
  required String detail,
}) {
  return Column(
    children: <Widget>[
      Container(
        width: 110.0,
        height: 70.0,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[colorA, colorB],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: hidden ? Colors.red.shade400 : Colors.white24,
            width: 1.5,
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.35),
              blurRadius: 6.0,
              offset: const Offset(0.0, 3.0),
            ),
          ],
        ),
        child: Center(
          child: hidden
              ? const Icon(Icons.block, color: Colors.white70, size: 22.0)
              : Container(
                  width: 60.0,
                  height: 30.0,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.40),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
        ),
      ),
      const SizedBox(height: 6.0),
      Text(
        caption,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 2.0),
      SizedBox(
        width: 130.0,
        child: Text(
          detail,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey.shade400,
            fontSize: 9.0,
            height: 1.3,
          ),
        ),
      ),
    ],
  );
}

Widget _matrixHead(String text, double width) {
  return SizedBox(
    width: width,
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 11.0,
        color: Colors.orange.shade900,
      ),
    ),
  );
}

Widget _matrixRow(String label, List<bool> values, List<Color> colors) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: Colors.orange.shade200, width: 0.6),
      ),
    ),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 160.0,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11.0,
              color: Colors.grey.shade900,
            ),
          ),
        ),
        for (int i = 0; i < values.length; i++)
          SizedBox(
            width: 110.0,
            child: Center(
              child: Icon(
                values[i] ? Icons.check_circle : Icons.cancel,
                color: values[i] ? colors[i] : Colors.grey.shade400,
                size: 18.0,
              ),
            ),
          ),
      ],
    ),
  );
}

Widget _badgeCard({
  required IconData icon,
  required String title,
  required ContentSensitivity recommended,
  required String rationale,
  required Color accent,
}) {
  return Container(
    width: 220.0,
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          accent.withValues(alpha: 0.10),
          accent.withValues(alpha: 0.25),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: accent.withValues(alpha: 0.50), width: 1.2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withValues(alpha: 0.25),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.20),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Icon(icon, color: accent, size: 18.0),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: accent,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.20),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            'use ${recommended.name}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
              color: accent,
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          rationale,
          style: TextStyle(
            fontSize: 11.0,
            height: 1.35,
            color: Colors.grey.shade900,
          ),
        ),
      ],
    ),
  );
}

Widget _recipe(String title, String code, String prose, Color codeColor) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: codeColor.withValues(alpha: 0.40), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            color: codeColor,
            fontWeight: FontWeight.bold,
            fontSize: 13.0,
          ),
        ),
        const SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: codeColor,
              height: 1.4,
            ),
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          prose,
          style: TextStyle(
            color: Colors.grey.shade400,
            fontSize: 11.0,
            fontStyle: FontStyle.italic,
            height: 1.35,
          ),
        ),
      ],
    ),
  );
}

Widget _pitfall(String title, String body) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 4.0, right: 8.0),
          width: 8.0,
          height: 8.0,
          decoration: BoxDecoration(
            color: Colors.red.shade400,
            shape: BoxShape.circle,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: Colors.red.shade900,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                body,
                style: TextStyle(
                  fontSize: 12.0,
                  height: 1.35,
                  color: Colors.grey.shade900,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
