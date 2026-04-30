// ignore_for_file: avoid_print
// D4rt deep demo: SensitiveContentService — the service that marks
// content as sensitive (passwords, financial data, personal information)
// so the system can protect it from screenshots, screen recordings, etc.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── Slate / Graphite palette ───
  const Color slate = Color(0xFF475569);
  const Color graphite = Color(0xFF94A3B8);
  const Color deepSlate = Color(0xFF334155);
  const Color paleGraphite = Color(0xFFF1F5F9);
  const Color charcoal = Color(0xFF64748B);
  const Color silver = Color(0xFFCBD5E1);
  const Color obsidian = Color(0xFF1E293B);
  const Color onyx = Color(0xFF0F172A);
  const Color ash = Color(0xFFE2E8F0);
  const Color pewter = Color(0xFF94A3B8);

  print('[sn] ===== SENSITIVE CONTENT SERVICE DEEP DEMO =====');

  // ─── Local helpers ───

  Widget snBanner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [onyx, deepSlate],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: onyx.withValues(alpha: 0.35),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: slate,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: graphite, width: 1.5),
            ),
            child: Center(
              child: Text(number,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3)),
          ),
        ],
      ),
    );
  }

  Widget snNote(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: paleGraphite,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: silver),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 13,
              color: onyx.withValues(alpha: 0.9),
              height: 1.5)),
    );
  }

  Widget snCard(String heading, Widget content) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: silver.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: onyx.withValues(alpha: 0.06),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: slate.withValues(alpha: 0.06),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Text(heading,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: onyx)),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: content,
          ),
        ],
      ),
    );
  }

  Widget snRow(List<String> cells, {bool isHeader = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 4),
      decoration: BoxDecoration(
        color: isHeader ? slate.withValues(alpha: 0.06) : Colors.transparent,
        border: Border(
          bottom: BorderSide(color: silver.withValues(alpha: 0.3)),
        ),
      ),
      child: Row(
        children: cells.map((c) {
          return Expanded(
            child: Text(c,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                    color: isHeader ? onyx : deepSlate)),
          );
        }).toList(),
      ),
    );
  }

  Widget snFlow(List<String> steps) {
    List<Widget> items = [];
    for (int i = 0; i < steps.length; i++) {
      items.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: (i % 2 == 0) ? onyx : deepSlate,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(steps[i],
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w600)),
        ),
      );
      if (i < steps.length - 1) {
        items.add(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Icon(Icons.arrow_forward, size: 12, color: slate),
        ));
      }
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: items),
    );
  }

  // ━━━━━━ SECTION 1: What is SensitiveContentService? ━━━━━━
  print('[sn-01] Section 1: What is SensitiveContentService?');

  Widget section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      snBanner('01', 'What Is SensitiveContentService?'),
      snNote(
        'SensitiveContentService is a platform service that allows apps to '
        'mark UI regions as containing sensitive data. The system can then '
        'prevent screenshots, screen recordings, and screen sharing from '
        'capturing those regions — displaying blank or redacted areas instead.',
      ),
      snCard(
        'Service Purpose',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            snFlow(['Mark region', 'Platform notified', 'Screenshot taken',
                'Region redacted', 'Data protected']),
            const SizedBox(height: 10),
            _snProtectionBadge('Screenshot', 'Redacted in captures', Icons.screenshot, onyx),
            _snProtectionBadge('Recording', 'Hidden in screen recordings', Icons.videocam, deepSlate),
            _snProtectionBadge('Sharing', 'Obscured in screen share', Icons.screen_share, slate),
            _snProtectionBadge('Preview', 'Hidden in task switcher', Icons.view_carousel, charcoal),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 2: Platform support ━━━━━━
  print('[sn-02] Section 2: Platform support');

  Widget section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      snBanner('02', 'Platform Support'),
      snNote(
        'Sensitive content protection varies by platform. Android uses '
        'FLAG_SECURE on windows. iOS has screen recording detection. '
        'macOS and web have limited support. The service abstracts these '
        'differences behind a unified API.',
      ),
      snCard(
        'Platform Matrix',
        Column(
          children: [
            snRow(['Platform', 'Mechanism', 'Granularity'], isHeader: true),
            snRow(['Android', 'FLAG_SECURE', 'Window-level']),
            snRow(['iOS', 'UIScreen.isCaptured', 'Detection only']),
            snRow(['macOS', 'NSWindow level', 'Window-level']),
            snRow(['Web', 'CSS user-select', 'Limited']),
            snRow(['Linux', 'None built-in', 'N/A']),
            snRow(['Windows', 'SetWindowDisplayAffinity', 'Window-level']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 3: Content classification ━━━━━━
  print('[sn-03] Section 3: Content classification');

  Widget section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      snBanner('03', 'Content Classification'),
      snNote(
        'Sensitive content typically includes: passwords and PINs, financial '
        'data (account numbers, balances), personal information (SSN, IDs), '
        'medical records, authentication tokens, and encryption keys. The '
        'app developers decide what to mark as sensitive.',
      ),
      snCard(
        'Sensitivity Categories',
        Column(
          children: [
            snRow(['Category', 'Examples', 'Risk Level'], isHeader: true),
            snRow(['Authentication', 'Passwords, PINs', 'Critical']),
            snRow(['Financial', 'Account numbers, CVV', 'Critical']),
            snRow(['Personal', 'SSN, passport', 'High']),
            snRow(['Medical', 'Health records', 'High']),
            snRow(['Tokens', 'API keys, OAuth', 'Critical']),
            snRow(['Private', 'Messages, notes', 'Medium']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 4: Android FLAG_SECURE ━━━━━━
  print('[sn-04] Section 4: FLAG_SECURE');

  Widget section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      snBanner('04', 'Android FLAG_SECURE'),
      snNote(
        'On Android, FLAG_SECURE prevents the window from appearing in '
        'screenshots, screen recordings, and the Recent Apps preview. The '
        'content appears as a black rectangle. This is the most reliable '
        'protection mechanism available.',
      ),
      snCard(
        'FLAG_SECURE Behavior',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _snBehaviorItem('Screenshots', 'Black screen or error toast', onyx),
            _snBehaviorItem('Screen recording', 'Black frames for this window', deepSlate),
            _snBehaviorItem('Recent apps', 'White/blank preview', slate),
            _snBehaviorItem('Cast/mirror', 'Black or blocked', charcoal),
            _snBehaviorItem('Scrcpy/ADB', 'Black screen (most cases)', obsidian),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 5: iOS screen capture detection ━━━━━━
  print('[sn-05] Section 5: iOS capture detection');

  Widget section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      snBanner('05', 'iOS Screen Capture Detection'),
      snNote(
        'iOS doesn\'t block screenshots like Android. Instead, it notifies '
        'the app when a screenshot or screen recording happens via '
        'UIScreen.isCaptured. The app can then hide sensitive fields, show '
        'a warning, or log the event.',
      ),
      snCard(
        'iOS Detection API',
        Column(
          children: [
            snRow(['Event', 'API', 'App Response'], isHeader: true),
            snRow(['Screenshot', 'UIApplication notification', 'After the fact']),
            snRow(['Recording start', 'isCaptured = true', 'Can hide content']),
            snRow(['Recording stop', 'isCaptured = false', 'Can restore']),
            snRow(['AirPlay', 'isCaptured = true', 'Can hide content']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 6: Flutter implementation ━━━━━━
  print('[sn-06] Section 6: Flutter implementation');

  Widget section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      snBanner('06', 'Flutter Implementation'),
      snNote(
        'Flutter integrates sensitive content via platform channels. '
        'The service sends messages to native code which sets the appropriate '
        'flags. On Android this modifies the Activity window flags. On iOS '
        'it registers capture state observers.',
      ),
      snCard(
        'Implementation Layers',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            snFlow(['Flutter API', 'Platform channel', 'Native code',
                'System flags', 'OS enforcement']),
            const SizedBox(height: 10),
            snRow(['Layer', 'Component', 'Responsibility'], isHeader: true),
            snRow(['1', 'SensitiveContentService', 'Flutter-side API']),
            snRow(['2', 'MethodChannel', 'Cross-platform bridge']),
            snRow(['3', 'Activity/ViewController', 'Native flag setter']),
            snRow(['4', 'OS compositor', 'Enforce redaction']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 7: Window-level vs view-level ━━━━━━
  print('[sn-07] Section 7: Granularity');

  Widget section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      snBanner('07', 'Window vs View Granularity'),
      snNote(
        'Most platform mechanisms work at the window level — the entire '
        'window is protected or not. There is no standard way to protect '
        'only a specific widget. Workarounds: use separate windows, or '
        'overlay-hide sensitive views when capture is detected.',
      ),
      snCard(
        'Granularity Comparison',
        Column(
          children: [
            snRow(['Approach', 'Scope', 'Complexity'], isHeader: true),
            snRow(['FLAG_SECURE', 'Entire window', 'Simple']),
            snRow(['Overlay hide', 'Targeted widgets', 'Moderate']),
            snRow(['Separate window', 'Isolated content', 'Complex']),
            snRow(['CSS user-select', 'DOM element', 'Web only']),
            snRow(['Capture callback', 'App-managed', 'Moderate']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 8: Lifecycle management ━━━━━━
  print('[sn-08] Section 8: Lifecycle');

  Widget section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      snBanner('08', 'Lifecycle Management'),
      snNote(
        'Sensitive protection should be enabled when sensitive UI is visible '
        'and disabled when it\'s not. Leaving FLAG_SECURE on permanently '
        'blocks all screenshots, even non-sensitive screens. Use route '
        'observers to toggle protection per page.',
      ),
      snCard(
        'Lifecycle Pattern',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _snLifecycleItem(Icons.login, 'Login page shown', 'Enable protection', onyx),
            _snLifecycleItem(Icons.visibility, 'Password visible', 'Protection active', deepSlate),
            _snLifecycleItem(Icons.check, 'Auth complete', 'Disable protection', slate),
            _snLifecycleItem(Icons.home, 'Home screen', 'No protection needed', charcoal),
            _snLifecycleItem(Icons.payment, 'Payment page', 'Re-enable protection', obsidian),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 9: Text field protection ━━━━━━
  print('[sn-09] Section 9: Text fields');

  Widget section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      snBanner('09', 'Text Field Protection'),
      snNote(
        'Password fields already use obscureText which hides the text '
        'visually. SensitiveContentService adds screenshot protection on top. '
        'For non-password sensitive fields (SSN, account numbers), you may '
        'want both obscureText and screen capture protection.',
      ),
      snCard(
        'Field Protection Levels',
        Column(
          children: [
            snRow(['Field Type', 'obscureText', 'Screenshot Block'], isHeader: true),
            snRow(['Password', 'Yes (dots)', 'Recommended']),
            snRow(['PIN', 'Usually yes', 'Recommended']),
            snRow(['SSN', 'Optional', 'Recommended']),
            snRow(['Account #', 'Optional', 'Recommended']),
            snRow(['Email', 'No', 'Per policy']),
            snRow(['Name', 'No', 'Usually no']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 10: Screen recording ━━━━━━
  print('[sn-10] Section 10: Screen recording');

  Widget section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      snBanner('10', 'Screen Recording Handling'),
      snNote(
        'Screen recording is a continuous threat unlike one-time screenshots. '
        'iOS sends isCaptured updates in real-time — you can hide fields '
        'while recording. Android FLAG_SECURE blocks recording entirely. '
        'Consider user experience: don\'t block normal usage.',
      ),
      snCard(
        'Recording Response Strategies',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _snStrategyCard('Block', 'Prevent recording entirely', Icons.block, onyx),
            _snStrategyCard('Hide', 'Replace sensitive fields with placeholders', Icons.visibility_off, deepSlate),
            _snStrategyCard('Warn', 'Show warning overlay during recording', Icons.warning, slate),
            _snStrategyCard('Log', 'Record the event for audit', Icons.description, charcoal),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 11: Task switcher preview ━━━━━━
  print('[sn-11] Section 11: Task switcher');

  Widget section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      snBanner('11', 'Task Switcher Preview'),
      snNote(
        'When the user opens the task switcher (Recent Apps on Android, App '
        'Switcher on iOS), a preview thumbnail is shown. This thumbnail can '
        'reveal sensitive data. FLAG_SECURE on Android blanks it. iOS apps '
        'can detect lifecycle changes and overlay a blur.',
      ),
      snCard(
        'Task Switcher Protection',
        Column(
          children: [
            snRow(['Platform', 'Method', 'Effect'], isHeader: true),
            snRow(['Android', 'FLAG_SECURE', 'White/blank preview']),
            snRow(['iOS', 'willResignActive blur', 'Blurred or hidden']),
            snRow(['macOS', 'Mission Control', 'Window visible (no API)']),
            snRow(['Web', 'Alt-Tab', 'Browser controls this']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 12: DRM integration ━━━━━━
  print('[sn-12] Section 12: DRM');

  Widget section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      snBanner('12', 'DRM & Content Protection'),
      snNote(
        'Sensitive content protection overlaps with DRM use cases. Video '
        'streaming apps use similar flags to prevent recording of licensed '
        'content. SurfaceView with FLAG_SECURE on Android prevents capture '
        'of DRM content. HDCP handles external displays.',
      ),
      snCard(
        'DRM Comparison',
        Column(
          children: [
            snRow(['Feature', 'Sensitive Data', 'DRM Content'], isHeader: true),
            snRow(['Goal', 'Privacy', 'Copyright']),
            snRow(['Mechanism', 'FLAG_SECURE', 'HDCP + FLAG_SECURE']),
            snRow(['Scope', 'App screens', 'Media playback']),
            snRow(['Enforcement', 'OS-level', 'Hardware + OS']),
            snRow(['User consent', 'Implicit', 'License terms']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 13: Compliance considerations ━━━━━━
  print('[sn-13] Section 13: Compliance');

  Widget section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      snBanner('13', 'Compliance & Regulation'),
      snNote(
        'Regulations like GDPR, HIPAA, PCI DSS, and SOC 2 may require '
        'screenshot protection for certain data types. Financial apps '
        'handling card data must consider PCI DSS. Healthcare apps must '
        'protect PHI under HIPAA.',
      ),
      snCard(
        'Compliance Matrix',
        Column(
          children: [
            snRow(['Regulation', 'Data Type', 'Screenshot Rule'], isHeader: true),
            snRow(['PCI DSS', 'Card data', 'Must mask/protect']),
            snRow(['HIPAA', 'Health records', 'Reasonable safeguards']),
            snRow(['GDPR', 'Personal data', 'Technical measures']),
            snRow(['SOC 2', 'Any sensitive', 'Access controls']),
            snRow(['FERPA', 'Student records', 'Protect from disclosure']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 14: User experience ━━━━━━
  print('[sn-14] Section 14: UX considerations');

  Widget section14 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      snBanner('14', 'User Experience'),
      snNote(
        'Blocking screenshots can frustrate users who want to save information '
        'for their own use. Balance security with usability: allow copying '
        'non-sensitive text, provide export/share for safe data, and explain '
        'why screenshot blocking is active.',
      ),
      snCard(
        'UX Best Practices',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _snUxItem('Explain', 'Tell users why screenshots are blocked', Icons.info_outline, onyx),
            _snUxItem('Scope', 'Only protect truly sensitive screens', Icons.security, deepSlate),
            _snUxItem('Alternative', 'Offer safe export/share options', Icons.share, slate),
            _snUxItem('Temporary', 'Lift protection after data changes', Icons.timer, charcoal),
            _snUxItem('Feedback', 'Show visual indicator when active', Icons.shield, obsidian),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 15: Testing strategies ━━━━━━
  print('[sn-15] Section 15: Testing');

  Widget section15 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      snBanner('15', 'Testing Strategies'),
      snNote(
        'Testing screenshot protection requires real devices — emulators may '
        'behave differently. Use ADB screencap to test Android FLAG_SECURE. '
        'On iOS, start a screen recording while on the protected screen. '
        'Automated tests can verify the platform channel calls.',
      ),
      snCard(
        'Test Checklist',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _snCheckItem('Verify FLAG_SECURE set via ADB screencap → black image', onyx),
            _snCheckItem('Test screen recording shows blank frames', deepSlate),
            _snCheckItem('Check task switcher preview is blanked', slate),
            _snCheckItem('Verify protection toggles per route', charcoal),
            _snCheckItem('Test on real device, not just emulator', obsidian),
            _snCheckItem('Verify platform channel calls in unit tests', pewter),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 16: Summary dashboard ━━━━━━
  print('[sn-16] Section 16: Summary dashboard');

  Widget section16 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      snBanner('16', 'Summary Dashboard'),
      snCard(
        'SensitiveContentService — Complete',
        Column(
          children: [
            snRow(['Topic', 'Section', 'Key Insight'], isHeader: true),
            snRow(['What', 'S01', 'Mark & redact sensitive regions']),
            snRow(['Platforms', 'S02', 'FLAG_SECURE / isCaptured']),
            snRow(['Classification', 'S03', 'Auth, financial, personal, medical']),
            snRow(['Android', 'S04', 'FLAG_SECURE blocks captures']),
            snRow(['iOS', 'S05', 'Detection via isCaptured']),
            snRow(['Flutter', 'S06', 'Platform channel to native flags']),
            snRow(['Granularity', 'S07', 'Window-level (mostly)']),
            snRow(['Lifecycle', 'S08', 'Toggle per route/page']),
            snRow(['Text fields', 'S09', 'obscureText + capture block']),
            snRow(['Recording', 'S10', 'Block / hide / warn / log']),
            snRow(['Task switcher', 'S11', 'Blanked preview']),
            snRow(['DRM', 'S12', 'Overlapping mechanisms']),
            snRow(['Compliance', 'S13', 'PCI DSS, HIPAA, GDPR']),
            snRow(['UX', 'S14', 'Scope, explain, alternatives']),
            snRow(['Testing', 'S15', 'Real device, ADB screencap']),
          ],
        ),
      ),
      snCard(
        'Slate / Graphite Theme',
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _snColorSwatch('Slate', slate),
            _snColorSwatch('Graphite', graphite),
            _snColorSwatch('Charcoal', charcoal),
            _snColorSwatch('Obsidian', obsidian),
            _snColorSwatch('Onyx', onyx),
          ],
        ),
      ),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [onyx, deepSlate],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            const Text('SensitiveContentService — Complete',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(
              'Content protection in Flutter: from FLAG_SECURE and capture '
              'detection through lifecycle management, compliance requirements, '
              'DRM overlap, and user experience considerations.',
              style: TextStyle(color: paleGraphite, fontSize: 12, height: 1.4),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ],
  );

  print('[sn] palette: $pewter, $ash, $silver, $paleGraphite');
  print('[sn] ===== ALL 16 SECTIONS BUILT =====');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: const Text('SensitiveContentService — Data Protection'),
        backgroundColor: onyx,
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFF8FAFC),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            section1, section2, section3, section4,
            section5, section6, section7, section8,
            section9, section10, section11, section12,
            section13, section14, section15, section16,
          ],
        ),
      ),
    ),
  );
}

// ═══════════════════════════════════════════════════
// Top-level helpers
// ═══════════════════════════════════════════════════

Widget _snProtectionBadge(String label, String desc, IconData icon, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 5),
    child: Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 8),
        SizedBox(
          width: 80,
          child: Text(label,
              style: TextStyle(
                  fontSize: 11, fontWeight: FontWeight.bold, color: color)),
        ),
        Expanded(
          child: Text(desc,
              style: TextStyle(fontSize: 10, color: color.withValues(alpha: 0.8))),
        ),
      ],
    ),
  );
}

Widget _snBehaviorItem(String scenario, String behavior, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 5),
    child: Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 100,
          child: Text(scenario,
              style: TextStyle(
                  fontSize: 10, fontWeight: FontWeight.w600, color: color)),
        ),
        Expanded(
          child: Text(behavior,
              style: TextStyle(fontSize: 10, color: color.withValues(alpha: 0.7))),
        ),
      ],
    ),
  );
}

Widget _snLifecycleItem(IconData icon, String event, String action, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 6),
        Expanded(
          flex: 2,
          child: Text(event,
              style: TextStyle(
                  fontSize: 10, fontWeight: FontWeight.w600, color: color)),
        ),
        Expanded(
          flex: 2,
          child: Text(action,
              style: TextStyle(fontSize: 10, color: color.withValues(alpha: 0.7))),
        ),
      ],
    ),
  );
}

Widget _snStrategyCard(String name, String desc, IconData icon, Color color) {
  return Container(
    margin: const EdgeInsets.only(bottom: 6),
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withValues(alpha: 0.15)),
    ),
    child: Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 8),
        SizedBox(
          width: 50,
          child: Text(name,
              style: TextStyle(
                  fontSize: 10, fontWeight: FontWeight.bold, color: color)),
        ),
        Expanded(
          child: Text(desc,
              style: TextStyle(fontSize: 9, color: color.withValues(alpha: 0.8))),
        ),
      ],
    ),
  );
}

Widget _snUxItem(String label, String desc, IconData icon, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 5),
    child: Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 8),
        SizedBox(
          width: 70,
          child: Text(label,
              style: TextStyle(
                  fontSize: 10, fontWeight: FontWeight.bold, color: color)),
        ),
        Expanded(
          child: Text(desc,
              style: TextStyle(fontSize: 10, color: color.withValues(alpha: 0.8))),
        ),
      ],
    ),
  );
}

Widget _snCheckItem(String text, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      children: [
        Icon(Icons.check_circle_outline, size: 14, color: color),
        const SizedBox(width: 6),
        Expanded(
          child: Text(text,
              style: TextStyle(fontSize: 10, color: color)),
        ),
      ],
    ),
  );
}

Widget _snColorSwatch(String name, Color color) {
  return Column(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      ),
      const SizedBox(height: 3),
      Text(name, style: const TextStyle(fontSize: 8)),
    ],
  );
}
