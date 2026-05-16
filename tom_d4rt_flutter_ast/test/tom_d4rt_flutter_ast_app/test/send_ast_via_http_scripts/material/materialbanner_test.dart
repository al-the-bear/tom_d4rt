// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

// =============================================================================
// MaterialBanner — Deep Visual Demo
// =============================================================================
//
// A MaterialBanner is a persistent, non-modal informational surface that sits
// at the top of the content area and stays visible until the user takes an
// action (or until the app dismisses it). It is one of three sibling
// notification primitives in the Material spec:
//
//   * SnackBar       — transient, bottom-anchored, auto-dismissing
//   * Dialog         — modal, blocks interaction with the underlying page
//   * MaterialBanner — persistent, inline, requires explicit user action
//
// In normal Flutter app code a MaterialBanner is dispatched through
// `ScaffoldMessenger.showMaterialBanner(...)`. In this demo we deliberately
// render MaterialBanner *as a widget* (direct composition inside Cards) so we
// can show all of its visual variants side-by-side on a single scrollable
// page. This is the right shape for an analyzer-free interpreter test that
// exercises every constructor parameter without needing animation timing,
// state, or controllers.
//
// Sections (top to bottom):
//   1.  Header and anatomy
//   2.  Minimal banner (content + single action)
//   3.  Two-action banner (primary / secondary visual emphasis)
//   4.  Three actions + forceActionsBelow overflow demo
//   5.  Leading icon variants — Info / Warning / Error / Success / Update
//   6.  Rich content (multi-line + inline link-like Text)
//   7.  Theme overrides (materialBannerTheme cascading)
//   8.  Real-world catalog (8 contextual banners)
//   9.  Padding and dividerColor showcase
//   10. Banner vs SnackBar vs Dialog visual comparison
//   11. Edge cases — single no-op action, very long content, custom leading
//
// =============================================================================

dynamic build(BuildContext context) {
  print('MaterialBanner deep visual demo — building tree');
  return Container(
    color: const Color(0xFFF1F3F6),
    child: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildHeader(),
          const SizedBox(height: 24.0),
          _buildAnatomy(),
          const SizedBox(height: 32.0),
          _buildMinimalSection(),
          const SizedBox(height: 32.0),
          _buildTwoActionSection(),
          const SizedBox(height: 32.0),
          _buildOverflowSection(),
          const SizedBox(height: 32.0),
          _buildLeadingIconVariantsSection(),
          const SizedBox(height: 32.0),
          _buildRichContentSection(),
          const SizedBox(height: 32.0),
          _buildThemeOverrideSection(context),
          const SizedBox(height: 32.0),
          _buildRealWorldCatalogSection(),
          const SizedBox(height: 32.0),
          _buildPaddingAndDividerSection(),
          const SizedBox(height: 32.0),
          _buildBannerVsSnackbarVsDialogSection(),
          const SizedBox(height: 32.0),
          _buildEdgeCasesSection(),
          const SizedBox(height: 48.0),
          _buildFooter(),
        ],
      ),
    ),
  );
}

// -----------------------------------------------------------------------------
// Shared visual helpers
// -----------------------------------------------------------------------------

Widget _sectionTitle(String index, String title, String subtitle) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 36.0,
              height: 36.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFF1F2937),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                index,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 14.0,
                ),
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF111827),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        Padding(
          padding: const EdgeInsets.only(left: 48.0),
          child: Text(
            subtitle,
            style: const TextStyle(
              fontSize: 13.0,
              color: Color(0xFF4B5563),
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _explanation(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 13.0,
        color: Color(0xFF374151),
        height: 1.5,
      ),
    ),
  );
}

Widget _bannerCard({required Widget banner, required String caption}) {
  return Card(
    elevation: 1.5,
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
      side: const BorderSide(color: Color(0xFFE5E7EB)),
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          color: const Color(0xFFF9FAFB),
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 6.0,
          ),
          child: Text(
            caption,
            style: const TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.4,
              color: Color(0xFF6B7280),
            ),
          ),
        ),
        banner,
      ],
    ),
  );
}

Widget _tag(String label, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
    decoration: BoxDecoration(
      color: color.withOpacity(0.12),
      borderRadius: BorderRadius.circular(999.0),
      border: Border.all(color: color.withOpacity(0.4)),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 11.0,
        fontWeight: FontWeight.w600,
        color: color,
      ),
    ),
  );
}

// -----------------------------------------------------------------------------
// 1. Header / anatomy
// -----------------------------------------------------------------------------

Widget _buildHeader() {
  return Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFF1F2937), Color(0xFF374151)],
      ),
      borderRadius: BorderRadius.circular(14.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Icon(
                Icons.flag,
                color: Colors.white,
                size: 22.0,
              ),
            ),
            const SizedBox(width: 12.0),
            const Expanded(
              child: Text(
                'MaterialBanner',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        const Text(
          'Persistent top-of-page informational surface — requires explicit user action to dismiss.',
          style: TextStyle(
            color: Color(0xFFD1D5DB),
            fontSize: 13.5,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            _tag('persistent', const Color(0xFF60A5FA)),
            _tag('non-modal', const Color(0xFF34D399)),
            _tag('top-anchored', const Color(0xFFFBBF24)),
            _tag('requires action', const Color(0xFFF87171)),
          ],
        ),
      ],
    ),
  );
}

Widget _buildAnatomy() {
  return Card(
    elevation: 2.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle(
            '1',
            'Anatomy',
            'Every MaterialBanner is made of four optional parts: a leading slot (often an icon), the content slot (the message), the actions slot (one or more buttons), and a thin divider drawn at the bottom of the banner.',
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFFFFBEB),
              border: Border.all(color: const Color(0xFFF59E0B)),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _anatomyBox('leading', const Color(0xFF8B5CF6), 60.0),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: _anatomyBox(
                          'content',
                          const Color(0xFF2563EB),
                          120.0,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      _anatomyBox('actions', const Color(0xFFDC2626), 80.0),
                    ],
                  ),
                ),
                Container(
                  height: 2.0,
                  color: const Color(0xFF059669),
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 8.0,
                        height: 8.0,
                        decoration: const BoxDecoration(
                          color: Color(0xFF059669),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6.0),
                      const Text(
                        'divider',
                        style: TextStyle(
                          fontSize: 11.0,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF059669),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          _explanation(
            'Visual key — purple: leading icon slot; blue: content slot (text or any widget); red: actions slot (TextButtons); green: divider line drawn beneath the banner.',
          ),
        ],
      ),
    ),
  );
}

Widget _anatomyBox(String label, Color color, double width) {
  return Container(
    width: width,
    height: 56.0,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: color.withOpacity(0.12),
      border: Border.all(color: color, width: 1.5),
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.w700,
        color: color,
      ),
    ),
  );
}

// -----------------------------------------------------------------------------
// 2. Minimal banner
// -----------------------------------------------------------------------------

Widget _buildMinimalSection() {
  final MaterialBanner banner = MaterialBanner(
    content: const Text(
      'Your profile picture was successfully updated.',
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          print('Minimal banner — DISMISS pressed');
        },
        child: const Text('DISMISS'),
      ),
    ],
  );
  return Card(
    elevation: 2.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle(
            '2',
            'Minimal banner',
            'The smallest meaningful MaterialBanner: a content message and one action. No leading slot, no theming overrides — this is what most banners reduce to.',
          ),
          _bannerCard(
            banner: banner,
            caption: 'CONTENT + 1 ACTION',
          ),
          _explanation(
            'Use the minimal shape when the message is short, the action is obvious, and visual chrome would be noise. The single TextButton sits flush right; the divider underneath keeps the banner cleanly separated from page content below.',
          ),
        ],
      ),
    ),
  );
}

// -----------------------------------------------------------------------------
// 3. Two-action banner — primary / secondary
// -----------------------------------------------------------------------------

Widget _buildTwoActionSection() {
  final MaterialBanner banner = MaterialBanner(
    leading: const Icon(Icons.cloud_upload, color: Color(0xFF2563EB)),
    content: const Text(
      'You have 3 unsynced changes. Sync them now or keep working offline.',
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          print('Two-action banner — LATER (secondary)');
        },
        child: const Text(
          'LATER',
          style: TextStyle(color: Color(0xFF6B7280)),
        ),
      ),
      TextButton(
        onPressed: () {
          print('Two-action banner — SYNC NOW (primary)');
        },
        style: TextButton.styleFrom(
          backgroundColor: const Color(0xFF2563EB),
          foregroundColor: Colors.white,
        ),
        child: const Text('SYNC NOW'),
      ),
    ],
  );
  return Card(
    elevation: 2.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle(
            '3',
            'Two actions — primary and secondary',
            'When a banner offers a choice, the right-most TextButton is conventionally the primary (encouraged) action and the one to its left is the secondary (defer or cancel) action.',
          ),
          _bannerCard(
            banner: banner,
            caption: 'LEADING ICON + 2 ACTIONS, RIGHT IS PRIMARY',
          ),
          _explanation(
            'Visual emphasis here is achieved by styling the primary TextButton with a filled background — Material spec actually places primary action on the right for banners (opposite of dialogs in some platforms). Use stronger color contrast to draw the eye to the recommended path.',
          ),
        ],
      ),
    ),
  );
}

// -----------------------------------------------------------------------------
// 4. Three actions / forceActionsBelow overflow
// -----------------------------------------------------------------------------

Widget _buildOverflowSection() {
  final MaterialBanner inlineBanner = MaterialBanner(
    leading: const Icon(Icons.shuffle, color: Color(0xFF9333EA)),
    content: const Text(
      'Three actions inline — only works on wide layouts.',
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          print('inline — option A');
        },
        child: const Text('OPTION A'),
      ),
      TextButton(
        onPressed: () {
          print('inline — option B');
        },
        child: const Text('OPTION B'),
      ),
      TextButton(
        onPressed: () {
          print('inline — option C');
        },
        child: const Text('OPTION C'),
      ),
    ],
  );
  final MaterialBanner forcedBelow = MaterialBanner(
    leading: const Icon(Icons.warning_amber, color: Color(0xFFD97706)),
    content: const Text(
      'You are about to delete 12 items. This cannot be undone — please choose how you want to proceed.',
    ),
    forceActionsBelow: true,
    overflowAlignment: OverflowBarAlignment.end,
    actions: <Widget>[
      TextButton(
        onPressed: () {
          print('forced — CANCEL');
        },
        child: const Text('CANCEL'),
      ),
      TextButton(
        onPressed: () {
          print('forced — REVIEW');
        },
        child: const Text('REVIEW'),
      ),
      TextButton(
        onPressed: () {
          print('forced — DELETE');
        },
        style: TextButton.styleFrom(foregroundColor: Colors.red),
        child: const Text('DELETE'),
      ),
    ],
  );
  final MaterialBanner forcedStart = MaterialBanner(
    leading: const Icon(Icons.tune, color: Color(0xFF0EA5E9)),
    content: const Text(
      'overflowAlignment: OverflowBarAlignment.start — actions hug the leading edge when wrapped.',
    ),
    forceActionsBelow: true,
    overflowAlignment: OverflowBarAlignment.start,
    actions: <Widget>[
      TextButton(
        onPressed: () {
          print('start aligned — A');
        },
        child: const Text('ACTION A'),
      ),
      TextButton(
        onPressed: () {
          print('start aligned — B');
        },
        child: const Text('ACTION B'),
      ),
      TextButton(
        onPressed: () {
          print('start aligned — C');
        },
        child: const Text('ACTION C'),
      ),
    ],
  );
  return Card(
    elevation: 2.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle(
            '4',
            'Three actions — overflow handling',
            'Once you have more than two actions, MaterialBanner needs help laying them out. The forceActionsBelow flag wraps the action row to a new line beneath the content; overflowAlignment controls which edge the wrapped row hugs.',
          ),
          _bannerCard(
            banner: inlineBanner,
            caption: 'NO FORCE — actions stay inline, may wrap awkwardly on narrow screens',
          ),
          _bannerCard(
            banner: forcedBelow,
            caption: 'forceActionsBelow: true, overflowAlignment: end',
          ),
          _bannerCard(
            banner: forcedStart,
            caption: 'forceActionsBelow: true, overflowAlignment: start',
          ),
          _explanation(
            'Rule of thumb: if you have three or more actions, set forceActionsBelow: true and pick an overflowAlignment that mirrors your locale reading direction. Avoid putting more than three actions on a banner — at that point users are probably better served by a dialog or a settings sheet.',
          ),
        ],
      ),
    ),
  );
}

// -----------------------------------------------------------------------------
// 5. Leading icon variants — Info / Warning / Error / Success / Update
// -----------------------------------------------------------------------------

Widget _buildLeadingIconVariantsSection() {
  return Card(
    elevation: 2.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle(
            '5',
            'Leading icon variants',
            'A leading icon carries 80% of the recognition load — users learn to scan banners by their icon color before reading. Below: a canonical five-icon system covering the most common banner classifications.',
          ),
          _bannerCard(
            banner: _iconVariantBanner(
              icon: Icons.info_outline,
              color: const Color(0xFF2563EB),
              tintBg: const Color(0xFFEFF6FF),
              text: 'Daylight saving time begins this Sunday — your clock will move forward one hour automatically.',
              action: 'GOT IT',
            ),
            caption: 'INFO — blue, tells the user something neutral',
          ),
          _explanation(
            'Info banners use blue + Icons.info_outline. They never block, never warn, and rarely demand a decision — a single GOT IT or DISMISS is enough.',
          ),
          _bannerCard(
            banner: _iconVariantBanner(
              icon: Icons.warning_amber_outlined,
              color: const Color(0xFFD97706),
              tintBg: const Color(0xFFFFFBEB),
              text: 'Your subscription expires in 5 days. Renew now to keep access to cloud sync and premium features.',
              action: 'RENEW',
            ),
            caption: 'WARNING — amber, something is degrading and the user should act',
          ),
          _explanation(
            'Warnings use amber + Icons.warning_amber_outlined. The amber tone is alarming enough to catch the eye but not so red that users feel scolded for ignoring it.',
          ),
          _bannerCard(
            banner: _iconVariantBanner(
              icon: Icons.error_outline,
              color: const Color(0xFFDC2626),
              tintBg: const Color(0xFFFEF2F2),
              text: 'Sync failed — your last 3 edits could not be saved to the cloud. Retry or work offline.',
              action: 'RETRY',
            ),
            caption: 'ERROR — red, something is broken and needs a fix',
          ),
          _explanation(
            'Error banners use red + Icons.error_outline and almost always offer a concrete recovery action. Avoid red for things the user did wrong intentionally — red is for the system having a problem.',
          ),
          _bannerCard(
            banner: _iconVariantBanner(
              icon: Icons.check_circle_outline,
              color: const Color(0xFF059669),
              tintBg: const Color(0xFFECFDF5),
              text: 'Your account has been verified — all premium features are now unlocked across this device.',
              action: 'GREAT',
            ),
            caption: 'SUCCESS — green, confirms a milestone',
          ),
          _explanation(
            'Success banners are the rarest of the five — most successful outcomes are better communicated through a brief SnackBar. Reserve a green banner for milestone confirmations that the user genuinely wants to dwell on.',
          ),
          _bannerCard(
            banner: _iconVariantBanner(
              icon: Icons.system_update_alt,
              color: const Color(0xFF7C3AED),
              tintBg: const Color(0xFFF5F3FF),
              text: 'Version 4.2.0 is available — includes performance improvements and the new collaborative editor.',
              action: 'UPDATE',
            ),
            caption: 'UPDATE — violet, announces something new is available',
          ),
          _explanation(
            'Update banners use violet + Icons.system_update_alt. The distinct color separates them from warnings — an available update is not a problem, it is an opportunity, and the visual tone should reflect that.',
          ),
        ],
      ),
    ),
  );
}

MaterialBanner _iconVariantBanner({
  required IconData icon,
  required Color color,
  required Color tintBg,
  required String text,
  required String action,
}) {
  return MaterialBanner(
    backgroundColor: tintBg,
    leading: Icon(icon, color: color),
    content: Text(
      text,
      style: TextStyle(color: color.withOpacity(0.95), height: 1.4),
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          print('icon variant — $action pressed');
        },
        style: TextButton.styleFrom(foregroundColor: color),
        child: Text(action),
      ),
    ],
  );
}

// -----------------------------------------------------------------------------
// 6. Rich content — multi-line + inline link-like Text
// -----------------------------------------------------------------------------

Widget _buildRichContentSection() {
  final MaterialBanner banner = MaterialBanner(
    leading: const Icon(
      Icons.privacy_tip_outlined,
      color: Color(0xFF0F766E),
    ),
    backgroundColor: const Color(0xFFF0FDFA),
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Text(
          'Privacy policy update',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w700,
            color: Color(0xFF0F766E),
          ),
        ),
        const SizedBox(height: 4.0),
        const Text(
          'We have revised how analytics data is collected and shared. The change affects all users starting June 1.',
          style: TextStyle(
            fontSize: 13.0,
            color: Color(0xFF134E4A),
            height: 1.4,
          ),
        ),
        const SizedBox(height: 6.0),
        Row(
          children: <Widget>[
            const Text(
              'Read the full ',
              style: TextStyle(fontSize: 12.5, color: Color(0xFF134E4A)),
            ),
            GestureDetector(
              onTap: () {
                print('rich content — privacy policy link tapped');
              },
              child: const Text(
                'privacy policy',
                style: TextStyle(
                  fontSize: 12.5,
                  color: Color(0xFF0F766E),
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Text(
              ' for details.',
              style: TextStyle(fontSize: 12.5, color: Color(0xFF134E4A)),
            ),
          ],
        ),
      ],
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          print('privacy banner — DECLINE');
        },
        child: const Text(
          'DECLINE',
          style: TextStyle(color: Color(0xFF6B7280)),
        ),
      ),
      TextButton(
        onPressed: () {
          print('privacy banner — ACCEPT');
        },
        style: TextButton.styleFrom(foregroundColor: const Color(0xFF0F766E)),
        child: const Text('ACCEPT'),
      ),
    ],
  );
  return Card(
    elevation: 2.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle(
            '6',
            'Rich content',
            'The content slot accepts any widget — most often a Column of Text widgets plus an inline link. Use a bold first line as a title, then explanatory copy underneath, then an inline GestureDetector-wrapped Text for a clickable link.',
          ),
          _bannerCard(
            banner: banner,
            caption: 'TITLE + BODY + INLINE LINK + 2 ACTIONS',
          ),
          _explanation(
            'Note how the content widget controls its own vertical rhythm with SizedBox spacers — the banner does not vertically center the content when it is multi-line, so the structure feels like a small card-within-a-card. This pattern is the workhorse of consent and legal banners.',
          ),
        ],
      ),
    ),
  );
}

// -----------------------------------------------------------------------------
// 7. Theme overrides — materialBannerTheme cascading
// -----------------------------------------------------------------------------

Widget _buildThemeOverrideSection(BuildContext context) {
  final ThemeData baseTheme = Theme.of(context);
  final ThemeData themedDark = baseTheme.copyWith(
    bannerTheme: const MaterialBannerThemeData(
      backgroundColor: Color(0xFF111827),
      contentTextStyle: TextStyle(
        color: Color(0xFFE5E7EB),
        fontSize: 14.0,
        height: 1.4,
      ),
      dividerColor: Color(0xFF374151),
      elevation: 0.0,
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
      leadingPadding: EdgeInsets.only(right: 16.0),
    ),
  );
  final ThemeData themedAccent = baseTheme.copyWith(
    bannerTheme: const MaterialBannerThemeData(
      backgroundColor: Color(0xFFFEF3C7),
      contentTextStyle: TextStyle(
        color: Color(0xFF78350F),
        fontSize: 14.0,
        fontStyle: FontStyle.italic,
        height: 1.4,
      ),
      dividerColor: Color(0xFFD97706),
      surfaceTintColor: Color(0xFFF59E0B),
      elevation: 2.0,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
    ),
  );
  final MaterialBanner darkBanner = MaterialBanner(
    leading: const Icon(Icons.dark_mode, color: Color(0xFF9CA3AF)),
    content: const Text(
      'This banner inherits its dark color scheme from the wrapping Theme — no per-banner overrides.',
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          print('themed dark — OK pressed');
        },
        style: TextButton.styleFrom(foregroundColor: const Color(0xFF60A5FA)),
        child: const Text('OK'),
      ),
    ],
  );
  final MaterialBanner accentBanner = MaterialBanner(
    leading: const Icon(Icons.bookmark, color: Color(0xFFD97706)),
    content: const Text(
      'This banner inherits an amber accent scheme — including italic content text and a thicker, colored divider.',
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          print('themed amber — SAVED');
        },
        style: TextButton.styleFrom(foregroundColor: const Color(0xFF78350F)),
        child: const Text('SAVED'),
      ),
    ],
  );
  return Card(
    elevation: 2.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle(
            '7',
            'Theme overrides',
            'Wrap a banner in a Theme and override materialBannerTheme to cascade backgroundColor, contentTextStyle, dividerColor, surfaceTintColor, elevation, padding, and leadingPadding to every MaterialBanner inside it — no per-instance configuration required.',
          ),
          _bannerCard(
            banner: Theme(data: themedDark, child: darkBanner),
            caption: 'WRAPPED IN Theme(materialBannerTheme: dark)',
          ),
          _explanation(
            'The dark-themed wrapper above set backgroundColor to slate-900, contentTextStyle to a near-white color, and dividerColor to a muted gray. The banner itself takes no styling parameters — everything is inherited.',
          ),
          _bannerCard(
            banner: Theme(data: themedAccent, child: accentBanner),
            caption: 'WRAPPED IN Theme(materialBannerTheme: amber accent)',
          ),
          _explanation(
            'The amber-themed wrapper demonstrates that contentTextStyle from the theme includes fontStyle (italic here) — it is a full TextStyle and not just a color. surfaceTintColor blends with backgroundColor as part of Material 3 elevation tinting.',
          ),
        ],
      ),
    ),
  );
}

// -----------------------------------------------------------------------------
// 8. Real-world catalog — 8 contextual banners
// -----------------------------------------------------------------------------

Widget _buildRealWorldCatalogSection() {
  return Card(
    elevation: 2.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle(
            '8',
            'Real-world catalog',
            'Eight banner archetypes drawn from production apps — each with its own visual identity, copy voice, and action shape. Use these as templates rather than copying verbatim.',
          ),
          _bannerCard(
            banner: _cookieConsentBanner(),
            caption: 'COOKIE CONSENT — GDPR / CCPA pattern',
          ),
          _explanation(
            'Cookie consent banners almost always live at the top of the page (legally they must be acknowledged), they accept-or-customize, and they cite the policy. Use slate background with a single primary action and a softer secondary.',
          ),
          _bannerCard(
            banner: _appUpdateBanner(),
            caption: 'APP UPDATE — new version available',
          ),
          _explanation(
            'App update banners use violet + an upward arrow to feel optimistic. The action label is action-oriented (UPDATE NOW) and a LATER opt-out lets the user finish what they were doing.',
          ),
          _bannerCard(
            banner: _networkOfflineBanner(),
            caption: 'NETWORK OFFLINE — degraded state',
          ),
          _explanation(
            'Offline banners stick until reconnection — they cannot really be "dismissed" since the underlying condition persists. The action is RETRY, not OK. Use a muted neutral background to communicate degraded but functional state.',
          ),
          _bannerCard(
            banner: _permissionRequestBanner(),
            caption: 'PERMISSION REQUEST — soft-ask before system dialog',
          ),
          _explanation(
            'Best-practice permission flows soft-ask in-app first via a banner, then trigger the system dialog only after the user opts in. This avoids the dreaded permanent deny that happens when users see the OS dialog without context.',
          ),
          _bannerCard(
            banner: _licenseAcceptanceBanner(),
            caption: 'LICENSE ACCEPTANCE — terms of service',
          ),
          _explanation(
            'License banners use neutral colors, are weighty enough to feel important without being threatening, and never use red. The primary action is the affirmative one (I AGREE) — placing reject as a less-prominent secondary discourages accidental dismissal.',
          ),
          _bannerCard(
            banner: _betaWarningBanner(),
            caption: 'BETA WARNING — pre-release feature',
          ),
          _explanation(
            'Beta warnings adopt a friendly experimental tone — purple-pink with a science or flask icon. The banner should explicitly invite feedback because beta usage is most valuable when paired with reports.',
          ),
          _bannerCard(
            banner: _maintenanceBanner(),
            caption: 'SCHEDULED MAINTENANCE — countdown to downtime',
          ),
          _explanation(
            'Maintenance windows benefit from a precise timestamp and an offer of an alternate channel (status page, support email). The amber-on-amber palette signals "advance notice, not panic."',
          ),
          _bannerCard(
            banner: _featureAnnounceBanner(),
            caption: 'NEW FEATURE — discoverability nudge',
          ),
          _explanation(
            'New feature announcements use teal or cyan, a sparkles icon, and a TRY IT primary action that deep-links into the feature. Resist the urge to throw three actions on these — discovery banners earn their keep through brevity.',
          ),
        ],
      ),
    ),
  );
}

MaterialBanner _cookieConsentBanner() {
  return MaterialBanner(
    backgroundColor: const Color(0xFF1F2937),
    leading: const Icon(Icons.cookie, color: Color(0xFFFBBF24)),
    contentTextStyle: const TextStyle(
      color: Color(0xFFE5E7EB),
      fontSize: 13.0,
      height: 1.4,
    ),
    dividerColor: const Color(0xFF374151),
    content: const Text(
      'We use cookies to personalise content and analyse traffic. By clicking ACCEPT ALL you consent to all categories.',
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          print('cookie — CUSTOMIZE');
        },
        style: TextButton.styleFrom(foregroundColor: const Color(0xFF9CA3AF)),
        child: const Text('CUSTOMIZE'),
      ),
      TextButton(
        onPressed: () {
          print('cookie — ACCEPT ALL');
        },
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFF111827),
          backgroundColor: const Color(0xFFFBBF24),
        ),
        child: const Text('ACCEPT ALL'),
      ),
    ],
  );
}

MaterialBanner _appUpdateBanner() {
  return MaterialBanner(
    backgroundColor: const Color(0xFFF5F3FF),
    leading: const Icon(Icons.arrow_circle_up, color: Color(0xFF7C3AED)),
    contentTextStyle: const TextStyle(
      color: Color(0xFF4C1D95),
      fontSize: 13.5,
      height: 1.4,
    ),
    dividerColor: const Color(0xFFC4B5FD),
    content: const Text(
      'A new version (4.2.0) is available — includes the new collaborative editor and several performance fixes.',
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          print('update — LATER');
        },
        style: TextButton.styleFrom(foregroundColor: const Color(0xFF6B7280)),
        child: const Text('LATER'),
      ),
      TextButton(
        onPressed: () {
          print('update — UPDATE NOW');
        },
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xFF7C3AED),
        ),
        child: const Text('UPDATE NOW'),
      ),
    ],
  );
}

MaterialBanner _networkOfflineBanner() {
  return MaterialBanner(
    backgroundColor: const Color(0xFFF3F4F6),
    leading: const Icon(Icons.cloud_off, color: Color(0xFF6B7280)),
    contentTextStyle: const TextStyle(
      color: Color(0xFF1F2937),
      fontSize: 13.5,
      fontWeight: FontWeight.w500,
      height: 1.4,
    ),
    dividerColor: const Color(0xFF9CA3AF),
    content: const Text(
      'You are offline — changes are saved locally and will sync when the connection is restored.',
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          print('offline — RETRY');
        },
        style: TextButton.styleFrom(foregroundColor: const Color(0xFF1F2937)),
        child: const Text('RETRY'),
      ),
    ],
  );
}

MaterialBanner _permissionRequestBanner() {
  return MaterialBanner(
    backgroundColor: const Color(0xFFEFF6FF),
    leading: const Icon(Icons.notifications_active, color: Color(0xFF2563EB)),
    contentTextStyle: const TextStyle(
      color: Color(0xFF1E3A8A),
      fontSize: 13.5,
      height: 1.4,
    ),
    dividerColor: const Color(0xFF93C5FD),
    content: const Text(
      'Enable notifications to receive alerts when team-mates mention you, comment on your work, or share a document.',
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          print('permission — NOT NOW');
        },
        style: TextButton.styleFrom(foregroundColor: const Color(0xFF6B7280)),
        child: const Text('NOT NOW'),
      ),
      TextButton(
        onPressed: () {
          print('permission — ENABLE');
        },
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xFF2563EB),
        ),
        child: const Text('ENABLE'),
      ),
    ],
  );
}

MaterialBanner _licenseAcceptanceBanner() {
  return MaterialBanner(
    backgroundColor: const Color(0xFFFAFAF9),
    leading: const Icon(Icons.gavel, color: Color(0xFF44403C)),
    contentTextStyle: const TextStyle(
      color: Color(0xFF1C1917),
      fontSize: 13.5,
      height: 1.4,
    ),
    dividerColor: const Color(0xFFA8A29E),
    content: const Text(
      'You must accept the updated End-User Licence Agreement (revised 12 May 2026) to continue using this app.',
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          print('license — VIEW');
        },
        style: TextButton.styleFrom(foregroundColor: const Color(0xFF44403C)),
        child: const Text('VIEW'),
      ),
      TextButton(
        onPressed: () {
          print('license — I AGREE');
        },
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xFF1C1917),
        ),
        child: const Text('I AGREE'),
      ),
    ],
  );
}

MaterialBanner _betaWarningBanner() {
  return MaterialBanner(
    backgroundColor: const Color(0xFFFDF2F8),
    leading: const Icon(Icons.science_outlined, color: Color(0xFFBE185D)),
    contentTextStyle: const TextStyle(
      color: Color(0xFF831843),
      fontSize: 13.5,
      height: 1.4,
    ),
    dividerColor: const Color(0xFFF472B6),
    content: const Text(
      'This is a beta feature — your feedback shapes the final version. Bug reports are especially welcome at this stage.',
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          print('beta — FEEDBACK');
        },
        style: TextButton.styleFrom(foregroundColor: const Color(0xFFBE185D)),
        child: const Text('FEEDBACK'),
      ),
      TextButton(
        onPressed: () {
          print('beta — GOT IT');
        },
        style: TextButton.styleFrom(foregroundColor: const Color(0xFF831843)),
        child: const Text('GOT IT'),
      ),
    ],
  );
}

MaterialBanner _maintenanceBanner() {
  return MaterialBanner(
    backgroundColor: const Color(0xFFFFFBEB),
    leading: const Icon(Icons.build_circle, color: Color(0xFFB45309)),
    contentTextStyle: const TextStyle(
      color: Color(0xFF78350F),
      fontSize: 13.5,
      height: 1.4,
    ),
    dividerColor: const Color(0xFFFCD34D),
    content: const Text(
      'Scheduled maintenance — Sat 18 May 2026, 02:00–03:30 UTC. Sync will be temporarily unavailable during this window.',
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          print('maintenance — STATUS PAGE');
        },
        style: TextButton.styleFrom(foregroundColor: const Color(0xFFB45309)),
        child: const Text('STATUS PAGE'),
      ),
    ],
  );
}

MaterialBanner _featureAnnounceBanner() {
  return MaterialBanner(
    backgroundColor: const Color(0xFFECFEFF),
    leading: const Icon(Icons.auto_awesome, color: Color(0xFF0E7490)),
    contentTextStyle: const TextStyle(
      color: Color(0xFF164E63),
      fontSize: 13.5,
      height: 1.4,
    ),
    dividerColor: const Color(0xFF67E8F9),
    content: const Text(
      'New — you can now mention team-mates in comments with @ to send them a notification.',
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          print('feature — TRY IT');
        },
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xFF0E7490),
        ),
        child: const Text('TRY IT'),
      ),
    ],
  );
}

// -----------------------------------------------------------------------------
// 9. Padding and dividerColor showcase
// -----------------------------------------------------------------------------

Widget _buildPaddingAndDividerSection() {
  final MaterialBanner compact = MaterialBanner(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    leadingPadding: const EdgeInsets.only(right: 8.0),
    leading: const Icon(Icons.compress, color: Color(0xFF6B7280)),
    dividerColor: const Color(0xFFE5E7EB),
    content: const Text('Compact — padding 8x4, divider light gray.'),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          print('compact — OK');
        },
        child: const Text('OK'),
      ),
    ],
  );
  final MaterialBanner standard = MaterialBanner(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
    leadingPadding: const EdgeInsets.only(right: 16.0),
    leading: const Icon(Icons.format_align_center, color: Color(0xFF2563EB)),
    dividerColor: const Color(0xFF60A5FA),
    content: const Text('Standard — padding 16x14, divider Material blue.'),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          print('standard — OK');
        },
        child: const Text('OK'),
      ),
    ],
  );
  final MaterialBanner spacious = MaterialBanner(
    padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 24.0),
    leadingPadding: const EdgeInsets.only(right: 28.0),
    leading: const Icon(Icons.expand, color: Color(0xFF059669)),
    dividerColor: const Color(0xFF10B981),
    content: const Text('Spacious — padding 28x24, divider emerald, ideal for marketing surfaces.'),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          print('spacious — OK');
        },
        child: const Text('OK'),
      ),
    ],
  );
  return Card(
    elevation: 2.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle(
            '9',
            'Padding and dividerColor',
            'Three banners at three densities — compact / standard / spacious — each pairing its padding with a divider color of matching intensity to keep the surface coherent.',
          ),
          _bannerCard(
            banner: compact,
            caption: 'COMPACT — padding 8 / 4, divider near-white',
          ),
          _bannerCard(
            banner: standard,
            caption: 'STANDARD — padding 16 / 14, divider Material blue',
          ),
          _bannerCard(
            banner: spacious,
            caption: 'SPACIOUS — padding 28 / 24, divider emerald',
          ),
          _explanation(
            'Padding affects both the leading-to-content and the content-to-actions horizontal gap, plus the vertical breathing room top and bottom. dividerColor is the bottom hairline drawn under the banner — bump its intensity together with padding to keep visual weight in balance.',
          ),
        ],
      ),
    ),
  );
}

// -----------------------------------------------------------------------------
// 10. Banner vs SnackBar vs Dialog comparison
// -----------------------------------------------------------------------------

Widget _buildBannerVsSnackbarVsDialogSection() {
  return Card(
    elevation: 2.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle(
            '10',
            'Banner vs SnackBar vs Dialog',
            'The three sibling notification primitives have different anchors, dismissal models, and modality. Pick the right one by asking: (1) does this need an answer, (2) can it auto-dismiss, (3) does it block the page underneath.',
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _comparisonColumn(
                  title: 'MaterialBanner',
                  color: const Color(0xFF2563EB),
                  anchor: 'Top of content',
                  modality: 'Non-modal',
                  dismissal: 'Explicit action',
                  preview: const MaterialBanner(
                    backgroundColor: Color(0xFFEFF6FF),
                    leading: Icon(Icons.flag, color: Color(0xFF2563EB)),
                    content: Text('Persistent — waits for user action.'),
                    actions: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Text(
                          'ACT',
                          style: TextStyle(
                            color: Color(0xFF2563EB),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  notes: 'Best for ongoing conditions, consent, multi-action choices.',
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: _comparisonColumn(
                  title: 'SnackBar',
                  color: const Color(0xFF059669),
                  anchor: 'Bottom of screen',
                  modality: 'Non-modal',
                  dismissal: 'Auto-dismiss',
                  preview: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 14.0,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1F2937),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: const Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            'Transient — auto-fades.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.5,
                            ),
                          ),
                        ),
                        Text(
                          'UNDO',
                          style: TextStyle(
                            color: Color(0xFFFBBF24),
                            fontWeight: FontWeight.w700,
                            fontSize: 12.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  notes: 'Best for short confirmations, undoable actions, ephemeral feedback.',
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: _comparisonColumn(
                  title: 'Dialog',
                  color: const Color(0xFFDC2626),
                  anchor: 'Centered overlay',
                  modality: 'Modal',
                  dismissal: 'User choice',
                  preview: Container(
                    margin: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 8.0,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(12.0),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Confirm',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13.0,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          'Modal — blocks page.',
                          style: TextStyle(fontSize: 11.5),
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              'CANCEL',
                              style: TextStyle(
                                color: Color(0xFF6B7280),
                                fontSize: 11.5,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              'OK',
                              style: TextStyle(
                                color: Color(0xFFDC2626),
                                fontSize: 11.5,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  notes: 'Best for irreversible actions and forced decisions before continuing.',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          _explanation(
            'Rule of thumb: SnackBar for "we did it, here is undo if you cared", MaterialBanner for "this condition is ongoing, please choose how to handle it", Dialog for "you must answer this before going further". When in doubt, the least disruptive option is almost always the right one.',
          ),
        ],
      ),
    ),
  );
}

Widget _comparisonColumn({
  required String title,
  required Color color,
  required String anchor,
  required String modality,
  required String dismissal,
  required Widget preview,
  required String notes,
}) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: color.withOpacity(0.05),
      border: Border.all(color: color.withOpacity(0.3)),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        const SizedBox(height: 8.0),
        _comparisonRow('anchor', anchor),
        _comparisonRow('modality', modality),
        _comparisonRow('dismissal', dismissal),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: preview,
        ),
        const SizedBox(height: 10.0),
        Text(
          notes,
          style: const TextStyle(
            fontSize: 11.5,
            color: Color(0xFF374151),
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

Widget _comparisonRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 64.0,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 11.0,
              color: Color(0xFF6B7280),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 11.5,
              color: Color(0xFF111827),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}

// -----------------------------------------------------------------------------
// 11. Edge cases
// -----------------------------------------------------------------------------

Widget _buildEdgeCasesSection() {
  final MaterialBanner emptyish = MaterialBanner(
    leading: const Icon(Icons.do_not_disturb_on_outlined, color: Color(0xFF6B7280)),
    content: const Text(
      'Edge case — at least one action is required, so we render a single no-op DISMISS that simply prints.',
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          print('edge — empty actions no-op');
        },
        style: TextButton.styleFrom(foregroundColor: const Color(0xFF6B7280)),
        child: const Text('DISMISS'),
      ),
    ],
  );
  final MaterialBanner longText = MaterialBanner(
    leading: const Icon(Icons.short_text, color: Color(0xFF1F2937)),
    content: const Text(
      'Edge case — a very long content string that absolutely will wrap across multiple lines on most reasonable display widths. '
      'MaterialBanner does not impose a max width on the content slot, so the text will simply flow until it hits the actions row. '
      'Designers should treat this as a soft cap: keep most banner copy under 140 characters; tabular or technical messages can run longer. '
      'When you really do need this much copy, forceActionsBelow becomes effectively mandatory so that the action buttons get their own row.',
    ),
    forceActionsBelow: true,
    overflowAlignment: OverflowBarAlignment.end,
    actions: <Widget>[
      TextButton(
        onPressed: () {
          print('edge — long content COPY');
        },
        child: const Text('COPY'),
      ),
      TextButton(
        onPressed: () {
          print('edge — long content DISMISS');
        },
        child: const Text('DISMISS'),
      ),
    ],
  );
  final MaterialBanner customLeading = MaterialBanner(
    backgroundColor: const Color(0xFFF8FAFC),
    leading: Container(
      width: 40.0,
      height: 40.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[Color(0xFF6366F1), Color(0xFFA855F7)],
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: const Text(
        'AI',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 14.0,
        ),
      ),
    ),
    content: const Text(
      'Edge case — a fully custom leading widget (gradient badge with text instead of an Icon).',
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          print('edge — custom leading DISMISS');
        },
        child: const Text('DISMISS'),
      ),
    ],
  );
  return Card(
    elevation: 2.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle(
            '11',
            'Edge cases',
            'MaterialBanner has surprisingly few hard rules, but a handful of edge shapes are worth knowing — single no-op action (the actions list must not be empty), runaway content length, and a custom leading widget that is not an Icon.',
          ),
          _bannerCard(
            banner: emptyish,
            caption: 'SINGLE NO-OP ACTION — actions list cannot be empty',
          ),
          _explanation(
            'A MaterialBanner with an empty actions list is illegal — Flutter asserts the list contains at least one widget. When there is genuinely nothing for the user to do, render a single DISMISS button whose onPressed simply prints or otherwise no-ops.',
          ),
          _bannerCard(
            banner: longText,
            caption: 'VERY LONG CONTENT — forceActionsBelow becomes mandatory',
          ),
          _explanation(
            'Long copy can flow but always pair it with forceActionsBelow: true so the action row does not get squashed against the right edge. Even better, ask whether the message really belongs in a banner — extended explanatory copy usually wants a dialog or an inline page section.',
          ),
          _bannerCard(
            banner: customLeading,
            caption: 'CUSTOM LEADING WIDGET — non-Icon (gradient badge)',
          ),
          _explanation(
            'The leading slot is just a Widget — it does not have to be an Icon. Avatars, gradient badges, branded marks, even small images are all fair game. Size to roughly 40x40 to stay in scale with stock leading icons.',
          ),
        ],
      ),
    ),
  );
}

// -----------------------------------------------------------------------------
// Footer
// -----------------------------------------------------------------------------

Widget _buildFooter() {
  return Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: const Color(0xFF111827),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Row(
          children: <Widget>[
            Icon(Icons.check_circle, color: Color(0xFF34D399)),
            SizedBox(width: 8.0),
            Text(
              'Demo complete',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        const Text(
          'MaterialBanner — eleven sections covering anatomy, minimal shape, action emphasis, overflow handling, icon variants, rich content, theming, real-world catalog, density variants, sibling-primitive comparison, and edge cases.',
          style: TextStyle(
            color: Color(0xFFD1D5DB),
            fontSize: 12.5,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            _tag('11 sections', const Color(0xFF60A5FA)),
            _tag('25+ banner instances', const Color(0xFFFBBF24)),
            _tag('analyzer clean', const Color(0xFF34D399)),
          ],
        ),
      ],
    ),
  );
}
