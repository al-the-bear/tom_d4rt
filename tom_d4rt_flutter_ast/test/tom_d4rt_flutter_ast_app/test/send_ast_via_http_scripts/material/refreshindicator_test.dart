// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: deep visual demo of RefreshIndicator.
import 'package:flutter/material.dart';

// onRefresh callback that just returns a completed Future.
// In d4rt-driven tests pull-to-refresh is never actually invoked, so an
// empty async body is sufficient to satisfy the Future<void> signature.
Future<void> _noOpRefresh() async {
  // Empty — d4rt will not actually invoke pull-to-refresh in tests.
}

// ---------------------------------------------------------------------------
// Color palette helpers for richly decorated cards.
// ---------------------------------------------------------------------------
const Color _seedTeal = Color(0xFF008B8B);
const Color _seedIndigo = Color(0xFF3F51B5);
const Color _seedAmber = Color(0xFFFFA000);
const Color _seedRose = Color(0xFFE91E63);
const Color _seedSlate = Color(0xFF455A64);
const Color _seedEmerald = Color(0xFF1B5E20);
const Color _seedViolet = Color(0xFF6A1B9A);
const Color _seedCopper = Color(0xFFB87333);

// ---------------------------------------------------------------------------
// Build header card explaining a tab's configuration.
// ---------------------------------------------------------------------------
Widget _headerCard({
  required String title,
  required String subtitle,
  required List<String> bullets,
  required Color seed,
  required IconData icon,
}) {
  return Container(
    margin: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          seed.withOpacity(0.92),
          seed.withOpacity(0.62),
          Colors.white,
        ],
        stops: const <double>[0.0, 0.55, 1.0],
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: seed.withOpacity(0.30),
          blurRadius: 14.0,
          offset: const Offset(0.0, 6.0),
        ),
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 2.0,
          offset: const Offset(0.0, 1.0),
        ),
      ],
      border: Border.all(color: seed.withOpacity(0.35), width: 1.0),
    ),
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.85),
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: seed.withOpacity(0.40),
                    blurRadius: 6.0,
                    offset: const Offset(0.0, 2.0),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(10.0),
              child: Icon(icon, color: seed, size: 28.0),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.white.withOpacity(0.92),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 10.0,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.78),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              for (int i = 0; i < bullets.length; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.chevron_right, size: 16.0, color: seed),
                      const SizedBox(width: 4.0),
                      Expanded(
                        child: Text(
                          bullets[i],
                          style: const TextStyle(
                            fontSize: 12.5,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
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
// Compact parameter chip used inside the parameter row.
// ---------------------------------------------------------------------------
Widget _paramChip(String label, String value, Color color) {
  return Container(
    margin: const EdgeInsets.only(right: 6.0, top: 4.0),
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: color.withOpacity(0.10),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withOpacity(0.50), width: 1.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 11.0,
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 11.0,
            color: Colors.black87,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Build a fancy ListTile with leading avatar gradient and trailing icon.
// ---------------------------------------------------------------------------
Widget _fancyTile({
  required IconData leadingIcon,
  required String title,
  required String subtitle,
  required Color seed,
  String? trailingText,
  IconData? trailingIcon,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: seed.withOpacity(0.10),
          blurRadius: 6.0,
          offset: const Offset(0.0, 2.0),
        ),
      ],
      border: Border.all(color: seed.withOpacity(0.18), width: 1.0),
    ),
    child: ListTile(
      leading: Container(
        width: 42.0,
        height: 42.0,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[seed, seed.withOpacity(0.55)],
          ),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: seed.withOpacity(0.45),
              blurRadius: 4.0,
              offset: const Offset(0.0, 2.0),
            ),
          ],
        ),
        child: Icon(leadingIcon, color: Colors.white, size: 22.0),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14.0),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontSize: 12.0, color: Colors.black54),
      ),
      trailing: trailingText != null
          ? Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 3.0,
              ),
              decoration: BoxDecoration(
                color: seed.withOpacity(0.12),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                trailingText,
                style: TextStyle(
                  fontSize: 11.0,
                  color: seed,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          : (trailingIcon != null
              ? Icon(trailingIcon, color: seed, size: 20.0)
              : null),
    ),
  );
}

// ---------------------------------------------------------------------------
// Tab 1 — Default RefreshIndicator with simple ListView.
// ---------------------------------------------------------------------------
Widget _buildDefaultTab() {
  return Column(
    children: <Widget>[
      _headerCard(
        title: 'Default RefreshIndicator',
        subtitle: 'No custom parameters — pure Material defaults',
        bullets: const <String>[
          'onRefresh: required Future<void> callback',
          'Default color: theme primary, default background: theme surface',
          'Default strokeWidth: 2.5 logical pixels',
          'Default displacement: 40.0, edgeOffset: 0.0',
          'triggerMode defaults to RefreshIndicatorTriggerMode.onEdge',
        ],
        seed: _seedTeal,
        icon: Icons.refresh,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          children: <Widget>[
            _paramChip('onRefresh', '_noOpRefresh', _seedTeal),
            _paramChip('triggerMode', 'onEdge', _seedTeal),
          ],
        ),
      ),
      const SizedBox(height: 6.0),
      Expanded(
        child: RefreshIndicator(
          onRefresh: _noOpRefresh,
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            children: <Widget>[
              _fancyTile(
                leadingIcon: Icons.inbox_outlined,
                title: 'Inbox digest',
                subtitle: '12 new conversations since 09:42',
                seed: _seedTeal,
                trailingText: 'NEW',
              ),
              _fancyTile(
                leadingIcon: Icons.email_outlined,
                title: 'Marketing newsletter',
                subtitle: 'Weekly product update — 4 articles',
                seed: _seedIndigo,
                trailingIcon: Icons.chevron_right,
              ),
              _fancyTile(
                leadingIcon: Icons.security,
                title: 'Security alert',
                subtitle: 'Sign-in from a new device · macOS · Berlin',
                seed: _seedRose,
                trailingText: '!',
              ),
              _fancyTile(
                leadingIcon: Icons.calendar_today,
                title: 'Calendar reminder',
                subtitle: 'Sprint review tomorrow at 10:00',
                seed: _seedAmber,
                trailingIcon: Icons.notifications_active_outlined,
              ),
              _fancyTile(
                leadingIcon: Icons.cloud_done_outlined,
                title: 'Backup completed',
                subtitle: 'Daily snapshot · 2.7 GB · 38 minutes',
                seed: _seedEmerald,
                trailingText: 'OK',
              ),
              _fancyTile(
                leadingIcon: Icons.bug_report_outlined,
                title: 'Issue #4827',
                subtitle: 'RefreshIndicator does not show on tablets',
                seed: _seedSlate,
                trailingIcon: Icons.chevron_right,
              ),
              _fancyTile(
                leadingIcon: Icons.shopping_bag_outlined,
                title: 'Order shipped',
                subtitle: 'Tracking number 1Z999AA10123456784',
                seed: _seedViolet,
                trailingText: 'SHIPPED',
              ),
              _fancyTile(
                leadingIcon: Icons.star_border,
                title: 'New star on repository',
                subtitle: 'd4rt-flutter-ast just hit 1.2k stars',
                seed: _seedCopper,
                trailingText: '+1',
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Tab 2 — Color and background combinations.
// ---------------------------------------------------------------------------
Widget _buildColorsTab() {
  return Column(
    children: <Widget>[
      _headerCard(
        title: 'Color & Background',
        subtitle: 'color + backgroundColor combine for brand styling',
        bullets: const <String>[
          'color: spinner stroke color (defaults to theme primary)',
          'backgroundColor: surface behind the spinner (defaults to theme surface)',
          'Use semantic brand colors so the indicator matches the app',
          'High-contrast pairs help dark-mode and accessibility users',
          'Avoid color/background pairs that violate WCAG contrast guidelines',
        ],
        seed: _seedRose,
        icon: Icons.palette,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Wrap(
          children: <Widget>[
            _paramChip('color', 'Colors.white', _seedRose),
            _paramChip('backgroundColor', 'Colors.deepPurple', _seedRose),
          ],
        ),
      ),
      const SizedBox(height: 6.0),
      Expanded(
        child: RefreshIndicator(
          onRefresh: _noOpRefresh,
          color: Colors.white,
          backgroundColor: Colors.deepPurple,
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            children: <Widget>[
              _gradientBanner(
                title: 'Branded spinner',
                subtitle: 'White stroke on deep-purple disk',
                colors: const <Color>[
                  Color(0xFF673AB7),
                  Color(0xFFB39DDB),
                ],
                icon: Icons.palette_outlined,
              ),
              _fancyTile(
                leadingIcon: Icons.color_lens,
                title: 'Brand-aligned chrome',
                subtitle: 'Spinner picks up our identity colors',
                seed: _seedRose,
                trailingText: 'BRAND',
              ),
              _fancyTile(
                leadingIcon: Icons.contrast,
                title: 'WCAG AA contrast',
                subtitle: 'Foreground/background ratio above 4.5:1',
                seed: _seedSlate,
                trailingText: 'AA',
              ),
              _fancyTile(
                leadingIcon: Icons.dark_mode,
                title: 'Dark theme variant',
                subtitle: 'Background brightens slightly on dark surfaces',
                seed: _seedIndigo,
                trailingIcon: Icons.chevron_right,
              ),
              _fancyTile(
                leadingIcon: Icons.light_mode,
                title: 'Light theme variant',
                subtitle: 'Background tinted from primaryContainer',
                seed: _seedAmber,
                trailingIcon: Icons.chevron_right,
              ),
              _fancyTile(
                leadingIcon: Icons.accessibility_new,
                title: 'Accessibility check',
                subtitle: 'Color is not the only way to convey state',
                seed: _seedEmerald,
                trailingText: 'A11Y',
              ),
              _fancyTile(
                leadingIcon: Icons.format_color_fill,
                title: 'Custom themed background',
                subtitle: 'Use ColorScheme.surfaceContainerHighest for M3',
                seed: _seedViolet,
                trailingIcon: Icons.chevron_right,
              ),
              _fancyTile(
                leadingIcon: Icons.brush,
                title: 'Designer hand-off',
                subtitle: 'Document indicator tokens in the design system',
                seed: _seedCopper,
                trailingText: 'DOCS',
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Gradient banner used inside list views to add visual variety.
// ---------------------------------------------------------------------------
Widget _gradientBanner({
  required String title,
  required String subtitle,
  required List<Color> colors,
  required IconData icon,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    height: 88.0,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: colors,
      ),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: colors.first.withOpacity(0.40),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    padding: const EdgeInsets.all(14.0),
    child: Row(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.30),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Icon(icon, color: Colors.white, size: 26.0),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.95),
                  fontSize: 12.0,
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
// Tab 3 — RefreshIndicator.adaptive (iOS-style on iOS, Material elsewhere).
// ---------------------------------------------------------------------------
Widget _buildAdaptiveTab() {
  return Column(
    children: <Widget>[
      _headerCard(
        title: 'RefreshIndicator.adaptive',
        subtitle: 'Picks platform-appropriate indicator at runtime',
        bullets: const <String>[
          'iOS / macOS: renders a Cupertino-style activity indicator',
          'Android / Linux / Windows: renders standard Material spinner',
          'Provides a single API for cross-platform pull-to-refresh',
          'All Material parameters are accepted but ignored on iOS',
          'Use it for cross-platform apps that want native feel',
        ],
        seed: _seedAmber,
        icon: Icons.devices_other,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Wrap(
          children: <Widget>[
            _paramChip('factory', '.adaptive', _seedAmber),
            _paramChip('color', 'Colors.orange', _seedAmber),
            _paramChip('backgroundColor', 'Colors.white', _seedAmber),
          ],
        ),
      ),
      const SizedBox(height: 6.0),
      Expanded(
        child: RefreshIndicator.adaptive(
          onRefresh: _noOpRefresh,
          color: Colors.orange,
          backgroundColor: Colors.white,
          child: GridView.count(
            crossAxisCount: 2,
            padding: const EdgeInsets.all(10.0),
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 1.05,
            children: <Widget>[
              _platformTile(
                title: 'Android',
                detail: 'Material spinner',
                colors: const <Color>[
                  Color(0xFF1B5E20),
                  Color(0xFFA5D6A7),
                ],
                icon: Icons.android,
              ),
              _platformTile(
                title: 'iOS',
                detail: 'Cupertino activity',
                colors: const <Color>[
                  Color(0xFF455A64),
                  Color(0xFFB0BEC5),
                ],
                icon: Icons.phone_iphone,
              ),
              _platformTile(
                title: 'macOS',
                detail: 'Cupertino activity',
                colors: const <Color>[
                  Color(0xFF37474F),
                  Color(0xFF90A4AE),
                ],
                icon: Icons.laptop_mac,
              ),
              _platformTile(
                title: 'Windows',
                detail: 'Material spinner',
                colors: const <Color>[
                  Color(0xFF0D47A1),
                  Color(0xFF82B1FF),
                ],
                icon: Icons.laptop_windows,
              ),
              _platformTile(
                title: 'Linux',
                detail: 'Material spinner',
                colors: const <Color>[
                  Color(0xFFBF360C),
                  Color(0xFFFFAB91),
                ],
                icon: Icons.computer,
              ),
              _platformTile(
                title: 'Web',
                detail: 'Material spinner',
                colors: const <Color>[
                  Color(0xFF4527A0),
                  Color(0xFFB39DDB),
                ],
                icon: Icons.public,
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Decorative platform tile for the adaptive grid.
// ---------------------------------------------------------------------------
Widget _platformTile({
  required String title,
  required String detail,
  required List<Color> colors,
  required IconData icon,
}) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: colors,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: colors.first.withOpacity(0.45),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
        BoxShadow(
          color: Colors.black.withOpacity(0.06),
          blurRadius: 2.0,
          offset: const Offset(0.0, 1.0),
        ),
      ],
    ),
    padding: const EdgeInsets.all(14.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.25),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Icon(icon, color: Colors.white, size: 28.0),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 2.0),
            Text(
              detail,
              style: TextStyle(
                color: Colors.white.withOpacity(0.92),
                fontSize: 12.0,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Tab 4 — Displacement and edgeOffset variations.
// ---------------------------------------------------------------------------
Widget _buildDisplacementTab() {
  return Column(
    children: <Widget>[
      _headerCard(
        title: 'Displacement & edgeOffset',
        subtitle: 'Vertical positioning of the spinner during pull',
        bullets: const <String>[
          'displacement: distance from the top edge to the spinner',
          'edgeOffset: shifts the trigger origin (useful below an AppBar)',
          'Default displacement: 40.0 logical pixels',
          'Default edgeOffset: 0.0 — spinner appears flush against top',
          'Higher values are common when scrollables sit below sticky chrome',
        ],
        seed: _seedIndigo,
        icon: Icons.height,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Wrap(
          children: <Widget>[
            _paramChip('displacement', '80.0', _seedIndigo),
            _paramChip('edgeOffset', '24.0', _seedIndigo),
          ],
        ),
      ),
      const SizedBox(height: 6.0),
      Expanded(
        child: RefreshIndicator(
          onRefresh: _noOpRefresh,
          displacement: 80.0,
          edgeOffset: 24.0,
          color: Colors.white,
          backgroundColor: Colors.indigo,
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            children: <Widget>[
              _gradientBanner(
                title: 'Lifted spinner',
                subtitle: 'Drops below the AppBar by edgeOffset 24.0',
                colors: const <Color>[
                  Color(0xFF1A237E),
                  Color(0xFF7986CB),
                ],
                icon: Icons.unfold_more,
              ),
              _fancyTile(
                leadingIcon: Icons.format_align_center,
                title: 'Displacement = 80',
                subtitle: 'Spinner rests 80px below the trigger origin',
                seed: _seedIndigo,
                trailingText: '80',
              ),
              _fancyTile(
                leadingIcon: Icons.vertical_align_top,
                title: 'edgeOffset = 24',
                subtitle: 'Trigger origin shifts down — fits sticky AppBar',
                seed: _seedSlate,
                trailingText: '24',
              ),
              _fancyTile(
                leadingIcon: Icons.layers,
                title: 'Layered chrome',
                subtitle: 'Combine with SliverAppBar.pinned for parallax',
                seed: _seedTeal,
                trailingIcon: Icons.chevron_right,
              ),
              _fancyTile(
                leadingIcon: Icons.swap_vert,
                title: 'Animation interplay',
                subtitle: 'Larger displacement gives a softer pull feel',
                seed: _seedAmber,
                trailingIcon: Icons.chevron_right,
              ),
              _fancyTile(
                leadingIcon: Icons.straighten,
                title: 'Measure with ruler',
                subtitle: 'Designers should validate against the comp',
                seed: _seedRose,
                trailingText: 'QA',
              ),
              _fancyTile(
                leadingIcon: Icons.rule,
                title: 'Recommended ranges',
                subtitle: 'displacement 40-80, edgeOffset 0-32',
                seed: _seedEmerald,
                trailingText: 'TIP',
              ),
              _fancyTile(
                leadingIcon: Icons.tune,
                title: 'Fine tuning',
                subtitle: 'Adjust per-screen if chrome height varies',
                seed: _seedCopper,
                trailingIcon: Icons.chevron_right,
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Tab 5 — strokeWidth and triggerMode variations.
// ---------------------------------------------------------------------------
Widget _buildStrokeAndEdgeTab() {
  return Column(
    children: <Widget>[
      _headerCard(
        title: 'strokeWidth & triggerMode',
        subtitle: 'Visual weight of the spinner & where pulls register',
        bullets: const <String>[
          'strokeWidth: thickness of the spinner ring (default 2.5)',
          'triggerMode.onEdge: only a pull from the top edge fires onRefresh',
          'triggerMode.anywhere: pulls from any scroll offset trigger',
          'Anywhere is useful when content is short or above-fold context matters',
          'OnEdge is the conventional Material behaviour for long lists',
        ],
        seed: _seedEmerald,
        icon: Icons.linear_scale,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Wrap(
          children: <Widget>[
            _paramChip('strokeWidth', '4.0', _seedEmerald),
            _paramChip('triggerMode', 'anywhere', _seedEmerald),
            _paramChip('semanticsLabel', 'Reload feed', _seedEmerald),
            _paramChip('semanticsValue', '50%', _seedEmerald),
          ],
        ),
      ),
      const SizedBox(height: 6.0),
      Expanded(
        child: RefreshIndicator(
          onRefresh: _noOpRefresh,
          strokeWidth: 4.0,
          triggerMode: RefreshIndicatorTriggerMode.anywhere,
          color: Colors.white,
          backgroundColor: Colors.green.shade700,
          semanticsLabel: 'Reload feed',
          semanticsValue: '50%',
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            children: <Widget>[
              _gradientBanner(
                title: 'Thicker stroke',
                subtitle: '4.0 logical pixels — heavier visual weight',
                colors: const <Color>[
                  Color(0xFF1B5E20),
                  Color(0xFF81C784),
                ],
                icon: Icons.line_weight,
              ),
              _decisionRow(
                leftLabel: 'onEdge',
                leftSubtitle: 'Long lists, traditional pull',
                rightLabel: 'anywhere',
                rightSubtitle: 'Short content, dashboards',
                leftColor: _seedTeal,
                rightColor: _seedAmber,
              ),
              _fancyTile(
                leadingIcon: Icons.format_paint,
                title: 'strokeWidth 4.0',
                subtitle: 'Spinner ring is more prominent',
                seed: _seedEmerald,
                trailingText: '4.0',
              ),
              _fancyTile(
                leadingIcon: Icons.touch_app,
                title: 'triggerMode.anywhere',
                subtitle: 'Works on dashboards with little content',
                seed: _seedTeal,
                trailingText: 'ANY',
              ),
              _fancyTile(
                leadingIcon: Icons.accessibility,
                title: 'semanticsLabel / Value',
                subtitle: 'Spoken context for screen readers',
                seed: _seedRose,
                trailingIcon: Icons.record_voice_over_outlined,
              ),
              _fancyTile(
                leadingIcon: Icons.style,
                title: 'Heavy weight',
                subtitle: 'Higher stroke fits bold dashboards',
                seed: _seedCopper,
                trailingIcon: Icons.chevron_right,
              ),
              _fancyTile(
                leadingIcon: Icons.fitness_center,
                title: 'Pull resistance',
                subtitle: 'Wider stroke perceived as more "physical"',
                seed: _seedSlate,
                trailingIcon: Icons.chevron_right,
              ),
              _fancyTile(
                leadingIcon: Icons.spellcheck,
                title: 'Semantics value uses %',
                subtitle: 'Voice-over reads "Reload feed, 50 percent"',
                seed: _seedViolet,
                trailingText: '50%',
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Decision row used to compare two approaches side-by-side.
// ---------------------------------------------------------------------------
Widget _decisionRow({
  required String leftLabel,
  required String leftSubtitle,
  required String rightLabel,
  required String rightSubtitle,
  required Color leftColor,
  required Color rightColor,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withOpacity(0.06),
          blurRadius: 6.0,
          offset: const Offset(0.0, 2.0),
        ),
      ],
      border: Border.all(color: Colors.black12, width: 1.0),
    ),
    child: Row(
      children: <Widget>[
        Expanded(
          child: _decisionCell(
            label: leftLabel,
            subtitle: leftSubtitle,
            color: leftColor,
            icon: Icons.swipe_down,
          ),
        ),
        Container(
          width: 1.0,
          height: 60.0,
          color: Colors.black12,
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
        ),
        Expanded(
          child: _decisionCell(
            label: rightLabel,
            subtitle: rightSubtitle,
            color: rightColor,
            icon: Icons.touch_app,
          ),
        ),
      ],
    ),
  );
}

Widget _decisionCell({
  required String label,
  required String subtitle,
  required Color color,
  required IconData icon,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Row(
        children: <Widget>[
          Icon(icon, color: color, size: 18.0),
          const SizedBox(width: 6.0),
          Text(
            label,
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
      const SizedBox(height: 4.0),
      Text(
        subtitle,
        style: const TextStyle(fontSize: 11.5, color: Colors.black87),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Tab 6 — RefreshIndicator wrapping a CustomScrollView with slivers.
// ---------------------------------------------------------------------------
Widget _buildCustomScrollViewTab() {
  return Column(
    children: <Widget>[
      _headerCard(
        title: 'CustomScrollView with Slivers',
        subtitle: 'RefreshIndicator wrapping a sliver-based viewport',
        bullets: const <String>[
          'Works with CustomScrollView when slivers fill the viewport',
          'Combine with SliverAppBar for parallax-style headers',
          'Use SliverList + SliverGrid for varied sections',
          'edgeOffset is especially useful below a pinned SliverAppBar',
          'notificationPredicate filters which scroll notifications trigger',
        ],
        seed: _seedViolet,
        icon: Icons.view_in_ar,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Wrap(
          children: <Widget>[
            _paramChip('child', 'CustomScrollView', _seedViolet),
            _paramChip('slivers', 'SliverList + SliverGrid', _seedViolet),
            _paramChip('edgeOffset', '0.0', _seedViolet),
          ],
        ),
      ),
      const SizedBox(height: 6.0),
      Expanded(
        child: RefreshIndicator(
          onRefresh: _noOpRefresh,
          color: Colors.white,
          backgroundColor: Colors.purple,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: _gradientBanner(
                  title: 'Sliver-based feed',
                  subtitle: 'A SliverList followed by a SliverGrid',
                  colors: const <Color>[
                    Color(0xFF4A148C),
                    Color(0xFFCE93D8),
                  ],
                  icon: Icons.dashboard,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 4.0),
                  child: Text(
                    'Recent activity',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w800,
                      color: Colors.purple.shade900,
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(<Widget>[
                  _fancyTile(
                    leadingIcon: Icons.history_edu,
                    title: 'Spec updated',
                    subtitle: 'tom_specs/refreshindicator.md (3 edits)',
                    seed: _seedViolet,
                    trailingText: 'SPEC',
                  ),
                  _fancyTile(
                    leadingIcon: Icons.commit,
                    title: 'Commit landed',
                    subtitle: 'a4e1f9 — refreshindicator deep demo',
                    seed: _seedTeal,
                    trailingIcon: Icons.chevron_right,
                  ),
                  _fancyTile(
                    leadingIcon: Icons.cloud_sync,
                    title: 'Sync complete',
                    subtitle: '32 files synced from origin/main',
                    seed: _seedEmerald,
                    trailingText: 'OK',
                  ),
                  _fancyTile(
                    leadingIcon: Icons.assessment,
                    title: 'Coverage report',
                    subtitle: '78.4% line coverage (+0.6 since last build)',
                    seed: _seedAmber,
                    trailingText: '78%',
                  ),
                ]),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(14.0, 12.0, 14.0, 4.0),
                  child: Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w800,
                      color: Colors.purple.shade900,
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(10.0, 4.0, 10.0, 12.0),
                sliver: SliverGrid(
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 1.4,
                  ),
                  delegate: SliverChildListDelegate(<Widget>[
                    _categoryCard(
                      title: 'Network',
                      detail: 'API and websockets',
                      colors: const <Color>[
                        Color(0xFF1A237E),
                        Color(0xFF7986CB),
                      ],
                      icon: Icons.wifi,
                    ),
                    _categoryCard(
                      title: 'Storage',
                      detail: 'Disk and cache',
                      colors: const <Color>[
                        Color(0xFF1B5E20),
                        Color(0xFF81C784),
                      ],
                      icon: Icons.sd_storage,
                    ),
                    _categoryCard(
                      title: 'Identity',
                      detail: 'Auth and SSO',
                      colors: const <Color>[
                        Color(0xFF6A1B9A),
                        Color(0xFFCE93D8),
                      ],
                      icon: Icons.fingerprint,
                    ),
                    _categoryCard(
                      title: 'Telemetry',
                      detail: 'Logs and traces',
                      colors: const <Color>[
                        Color(0xFFBF360C),
                        Color(0xFFFFAB91),
                      ],
                      icon: Icons.monitor_heart,
                    ),
                  ]),
                ),
              ),
              SliverToBoxAdapter(child: _comparisonCard()),
              SliverToBoxAdapter(child: _triggerModeDecisionCard()),
              SliverToBoxAdapter(
                child: SizedBox(height: 24.0),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Category card used inside the sliver grid.
// ---------------------------------------------------------------------------
Widget _categoryCard({
  required String title,
  required String detail,
  required List<Color> colors,
  required IconData icon,
}) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: colors,
      ),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: colors.first.withOpacity(0.40),
          blurRadius: 8.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    padding: const EdgeInsets.all(12.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(7.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.25),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(icon, color: Colors.white, size: 24.0),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14.5,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 1.0),
            Text(
              detail,
              style: TextStyle(
                color: Colors.white.withOpacity(0.92),
                fontSize: 11.5,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Comparison card: RefreshIndicator vs CupertinoSliverRefreshControl.
// ---------------------------------------------------------------------------
Widget _comparisonCard() {
  return Container(
    margin: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 4.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withOpacity(0.06),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
      border: Border.all(color: Colors.black12, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: <Color>[
                    Color(0xFF00897B),
                    Color(0xFF80CBC4),
                  ],
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Icon(
                Icons.compare_arrows,
                color: Colors.white,
                size: 22.0,
              ),
            ),
            const SizedBox(width: 10.0),
            const Expanded(
              child: Text(
                'RefreshIndicator vs CupertinoSliverRefreshControl',
                style: TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        _comparisonRow(
          leftHeader: 'RefreshIndicator',
          leftBody:
              'Material spinner. Wraps any scrollable. Easiest API. Good cross-platform default.',
          rightHeader: 'CupertinoSliverRefreshControl',
          rightBody:
              'iOS-native look. Sliver-based — must live inside a CustomScrollView. Best for iOS-only apps.',
        ),
        const SizedBox(height: 8.0),
        _comparisonRow(
          leftHeader: 'When to pick it',
          leftBody:
              'Default for cross-platform Flutter apps. Use .adaptive for partial native fit.',
          rightHeader: 'When to pick it',
          rightBody:
              'iOS-only apps or when slivers are mandatory and exact iOS feel is required.',
        ),
      ],
    ),
  );
}

Widget _comparisonRow({
  required String leftHeader,
  required String leftBody,
  required String rightHeader,
  required String rightBody,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.teal.withOpacity(0.08),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.teal.withOpacity(0.30),
              width: 1.0,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                leftHeader,
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                leftBody,
                style: const TextStyle(fontSize: 11.5, color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(width: 8.0),
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.deepOrange.withOpacity(0.08),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.deepOrange.withOpacity(0.30),
              width: 1.0,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                rightHeader,
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: Colors.deepOrange,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                rightBody,
                style: const TextStyle(fontSize: 11.5, color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// "When to use which trigger mode" decision card.
// ---------------------------------------------------------------------------
Widget _triggerModeDecisionCard() {
  return Container(
    margin: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 4.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Color(0xFFFFF3E0),
          Color(0xFFFFE0B2),
        ],
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.orange.withOpacity(0.25),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
      border: Border.all(color: Colors.orange.shade300, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.alt_route, color: Colors.deepOrange, size: 22.0),
            const SizedBox(width: 8.0),
            Text(
              'When to use which trigger mode',
              style: TextStyle(
                fontSize: 14.5,
                fontWeight: FontWeight.w800,
                color: Colors.deepOrange.shade700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        _decisionBullet(
          icon: Icons.swipe_down,
          color: Colors.brown,
          title: 'onEdge (default)',
          body:
              'Best for long lists. Pull only triggers when the list is already at the top edge.',
        ),
        _decisionBullet(
          icon: Icons.touch_app,
          color: Colors.deepPurple,
          title: 'anywhere',
          body:
              'Best for short content / dashboards. Pull triggers from any scroll offset, even mid-list.',
        ),
        _decisionBullet(
          icon: Icons.warning_amber_outlined,
          color: Colors.red,
          title: 'Avoid combining',
          body:
              'Do not mix anywhere with a tall list — users may trigger refresh by accident.',
        ),
        _decisionBullet(
          icon: Icons.lightbulb_outline,
          color: Colors.amber,
          title: 'Tip',
          body:
              'Use ScrollController metrics if you need finer-grained pull control beyond triggerMode.',
        ),
      ],
    ),
  );
}

Widget _decisionBullet({
  required IconData icon,
  required Color color,
  required String title,
  required String body,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: color.withOpacity(0.18),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(icon, color: color, size: 18.0),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                body,
                style: const TextStyle(
                  fontSize: 11.5,
                  color: Colors.black87,
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
// build entrypoint — required by the d4rt-driven test harness.
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  return MaterialApp(
    title: 'RefreshIndicator Demo',
    theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
    home: DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('RefreshIndicator Showcase'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: <Widget>[
              Tab(text: 'Default'),
              Tab(text: 'Colors'),
              Tab(text: 'Adaptive'),
              Tab(text: 'Displacement'),
              Tab(text: 'Stroke / Edge'),
              Tab(text: 'In CustomScrollView'),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            _buildDefaultTab(),
            _buildColorsTab(),
            _buildAdaptiveTab(),
            _buildDisplacementTab(),
            _buildStrokeAndEdgeTab(),
            _buildCustomScrollViewTab(),
          ],
        ),
      ),
    ),
  );
}
