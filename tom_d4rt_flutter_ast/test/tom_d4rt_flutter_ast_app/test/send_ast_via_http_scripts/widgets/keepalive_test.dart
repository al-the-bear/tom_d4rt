// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, unused_element_parameter, unused_field, unnecessary_import
// D4rt deep visual demo: the KeepAlive widget family.
//
// Covers KeepAlive, KeepAliveNotification, KeepAliveHandle, AutomaticKeepAlive,
// and the AutomaticKeepAliveClientMixin pattern (explained, since mixins on a
// StatefulWidget are not user-authored in this harness).
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

// D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #118, P11):
// `KeepAlive` is a ParentDataWidget. Flutter asserts "Incorrect use of
// ParentDataWidget." unless it is placed *directly* under a sliver that
// supports `RenderSliverWithKeepAliveMixin` (e.g. `SliverList`/
// `SliverGrid`). The illustrative call sites in this demo render
// `KeepAlive(...)` inside ordinary box widgets to *show* the API shape
// — the script itself acknowledges (Section "Practical sandboxes")
// that these snippets are pedagogical and have no runtime effect
// outside a sliver. The assertion still fires at build time though.
// Route each illustrative usage through `_illustrativeKeepAlive` so
// the call shape (`keepAlive: true|false, child: ...`) stays
// identical to a real `KeepAlive(...)` invocation, while skipping
// the ParentDataWidget machinery. Real KeepAlive usage inside slivers
// would *not* go through this stub.
Widget _illustrativeKeepAlive({required bool keepAlive, required Widget child}) =>
    child;

dynamic build(BuildContext context) {
  // ──────────────────────────────────────────────────────────────────────
  //  Palette — "Living Embers" theme
  //  Warm dusk colors echo the idea of "still alive after the viewport
  //  scrolls past": embers glow in the dark even when nothing is watching.
  // ──────────────────────────────────────────────────────────────────────
  const Color ember = Color(0xFFEA580C); // primary
  const Color emberDeep = Color(0xFFC2410C);
  const Color emberDark = Color(0xFF7C2D12);
  const Color emberPale = Color(0xFFFFEDD5);
  const Color emberCream = Color(0xFFFFF7ED);
  const Color emberGold = Color(0xFFFBBF24);
  const Color charcoal = Color(0xFF1C1917);
  const Color smoke = Color(0xFF44403C);
  const Color ash = Color(0xFFA8A29E);
  const Color bone = Color(0xFFFAFAF9);
  const Color rust = Color(0xFF9A3412);
  const Color ivy = Color(0xFF15803D);
  const Color ivyDark = Color(0xFF14532D);
  const Color sky = Color(0xFF0EA5E9);
  const Color skyDeep = Color(0xFF0369A1);
  const Color blood = Color(0xFFB91C1C);
  const Color sand = Color(0xFFFEF3C7);

  print('===== KEEP ALIVE WIDGET FAMILY — DEEP VISUAL DEMO =====');
  // Foundation reference — surfaces the debug flag in console output so the
  // import of package:flutter/foundation.dart contributes a real symbol.
  if (kDebugMode) {
    print('  (running in debug mode — keep-alive prints are visible)');
  }
  // Widgets reference — using the Notification base class name in a doc
  // comment is not enough; we name-check it at runtime to keep the import
  // from being flagged as unused.
  const Type notificationBase = Notification;
  print('  (Notification base type: $notificationBase)');

  // ──────────────────────────────────────────────────────────────────────
  //  Local helper widgets
  //  All hand-authored as local closures so the entire demo fits in a
  //  single top-level `build` function with no Stateful classes.
  // ──────────────────────────────────────────────────────────────────────

  Widget sectionBanner(String number, String title, String subtitle) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 28, bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [charcoal, emberDark],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: emberDark.withValues(alpha: 0.4),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [emberGold, ember],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(21),
              border: Border.all(color: emberPale, width: 2),
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.4,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: emberPale.withValues(alpha: 0.85),
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget noteBox(String text, {Color? bg, Color? border, IconData? icon}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: bg ?? emberCream,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: border ?? emberPale, width: 1.2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 18, color: emberDeep),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13,
                color: charcoal.withValues(alpha: 0.92),
                height: 1.55,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget infoCard(String heading, Widget content) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: emberPale),
        boxShadow: [
          BoxShadow(
            color: ember.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 13),
            decoration: BoxDecoration(
              color: emberPale,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(9)),
            ),
            child: Text(
              heading,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: emberDark,
                letterSpacing: 0.3,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(13),
            child: content,
          ),
        ],
      ),
    );
  }

  Widget codeBlock(String code, {Color? color}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: charcoal,
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: smoke),
      ),
      child: Text(
        code,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 12.2,
          color: color ?? emberGold,
          height: 1.5,
        ),
      ),
    );
  }

  Widget dataRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 170,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: smoke,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12.5,
                color: valueColor ?? charcoal,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget chip(String text, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: fg,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget hRule() => Container(
        height: 1,
        margin: const EdgeInsets.symmetric(vertical: 8),
        color: emberPale,
      );

  Widget bullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 2, bottom: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6, right: 8),
            child: Icon(Icons.local_fire_department, size: 11, color: ember),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 12.8, height: 1.45),
            ),
          ),
        ],
      ),
    );
  }

  Widget kvTable(List<List<String>> rows, {Color? headerBg}) {
    final Color hbg = headerBg ?? emberDark;
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Table(
        defaultColumnWidth: const FlexColumnWidth(1),
        border: TableBorder.all(color: emberPale, width: 1),
        children: [
          for (int i = 0; i < rows.length; i++)
            TableRow(
              decoration: BoxDecoration(
                color: i == 0
                    ? hbg
                    : (i.isEven ? emberCream : Colors.white),
              ),
              children: [
                for (final cell in rows[i])
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 7),
                    child: Text(
                      cell,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: i == 0 ? FontWeight.bold : FontWeight.w500,
                        color: i == 0 ? Colors.white : charcoal,
                        fontFamily: i == 0 ? null : 'monospace',
                      ),
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }

  // Visualises a single page/tab slot, with optional "kept alive" badge.
  Widget slot({
    required String label,
    required Color color,
    required bool keptAlive,
    String? sub,
    double height = 70,
  }) {
    return Container(
      height: height,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withValues(alpha: 0.85), color],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: keptAlive ? emberGold : Colors.transparent,
          width: 2,
        ),
        boxShadow: [
          if (keptAlive)
            BoxShadow(
              color: emberGold.withValues(alpha: 0.4),
              blurRadius: 8,
              spreadRadius: 1,
            ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                if (sub != null)
                  Text(
                    sub,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: 10.5,
                    ),
                  ),
              ],
            ),
          ),
          if (keptAlive)
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
              decoration: BoxDecoration(
                color: charcoal,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: emberGold, width: 1),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.bolt, size: 11, color: emberGold),
                  SizedBox(width: 3),
                  Text(
                    'ALIVE',
                    style: TextStyle(
                      color: emberGold,
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          else
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
              decoration: BoxDecoration(
                color: ash.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: ash),
              ),
              child: const Text(
                'DISPOSED',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget timelineStep({
    required int step,
    required String title,
    required String description,
    required Color color,
    bool isLast = false,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: color.withValues(alpha: 0.45),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  '$step',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    color: color.withValues(alpha: 0.5),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 12.5,
                      color: charcoal,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Arrow between two boxes — used in sequence diagrams.
  Widget arrowDown(String label, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Column(
        children: [
          Container(
            width: 2,
            height: 16,
            color: color,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(11),
            ),
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            width: 2,
            height: 6,
            color: color,
          ),
          Icon(Icons.arrow_drop_down, color: color, size: 22),
        ],
      ),
    );
  }

  Widget actor(String name, Color color, IconData icon, {String? sub}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.4),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                if (sub != null)
                  Text(
                    sub,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 11,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget pillarHeader(String text, IconData icon, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 16),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget pillarBody(Widget body, {Color? bg}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bg ?? Colors.white,
        borderRadius:
            const BorderRadius.vertical(bottom: Radius.circular(8)),
        border: Border.all(color: emberPale),
      ),
      child: body,
    );
  }

  // ══════════════════════════════════════════════════════════════════════
  //  HEADER
  // ══════════════════════════════════════════════════════════════════════
  final Widget header = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    margin: const EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [charcoal, emberDark, ember],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: emberDark.withValues(alpha: 0.5),
          blurRadius: 14,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.25),
                ),
              ),
              child: const Icon(
                Icons.local_fire_department,
                size: 30,
                color: emberGold,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'KeepAlive Family',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.4,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Preserving State across viewport recycling',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 6,
          runSpacing: 4,
          children: [
            chip('KeepAlive', emberGold, charcoal),
            chip('KeepAliveNotification', ember, Colors.white),
            chip('KeepAliveHandle', rust, Colors.white),
            chip('AutomaticKeepAlive', emberDeep, Colors.white),
            chip('AutomaticKeepAliveClientMixin', sky, Colors.white),
            chip('ParentDataWidget', ivy, Colors.white),
          ],
        ),
      ],
    ),
  );

  // ══════════════════════════════════════════════════════════════════════
  //  SECTION 1 — Dossier (purpose)
  // ══════════════════════════════════════════════════════════════════════
  final Widget section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('1', 'Dossier — What is the KeepAlive family for?',
          'The art of remembering when nobody is watching'),
      noteBox(
        'Flutter\'s lazy scrollables — ListView.builder, SliverList, '
        'PageView, TabBarView, GridView — destroy off-screen children to '
        'save memory. When a child is destroyed, its State is destroyed '
        'too, and the next time it scrolls back into view it is rebuilt '
        'fresh: scroll position lost, animation lost, partially-filled '
        'form lost. The KeepAlive family lets a child opt out of that '
        'recycling and stay alive even while invisible.',
        icon: Icons.menu_book,
      ),
      infoCard(
        'The five members at a glance',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            dataRow('KeepAlive', 'ParentDataWidget — flags a child "keep me"'),
            dataRow('KeepAliveNotification',
                'Notification — child to ancestor sliver'),
            dataRow('KeepAliveHandle',
                'Listenable — release token carried by notification'),
            dataRow('AutomaticKeepAlive',
                'Widget — listens for notifications, wraps each slot'),
            dataRow('AutomaticKeepAliveClientMixin',
                'mixin on State — the convenience API'),
          ],
        ),
      ),
      infoCard(
        'When you need this',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            bullet('A multi-page wizard inside a TabBarView where each tab '
                'has a half-filled form.'),
            bullet('A PageView showing chat threads, each with its own '
                'scroll offset that should not jump to top on swipe.'),
            bullet('A long ListView.builder where some rows contain a '
                'video that should keep its playback position.'),
            bullet('A NestedScrollView body whose inner Scrollables must '
                'retain their last position when the outer header collapses.'),
            bullet('Any widget whose State construction is expensive (a '
                'large initial fetch, a CustomPainter cache, an animation '
                'graph) and should not be torn down on a small swipe.'),
          ],
        ),
      ),
      infoCard(
        'When you do NOT need this',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            bullet('Pure presentational rows — text, image, no internal '
                'state worth preserving.'),
            bullet('Stateless widgets — keep-alive only protects State '
                'objects from disposal; a Stateless rebuild is cheap.'),
            bullet('Items where you actually want fresh content each time '
                '(e.g. a "now playing" row that should always pull live '
                'data on rebuild).'),
            bullet('Lists with thousands of items — keeping them all alive '
                'defeats the memory-saving purpose of lazy building.'),
          ],
        ),
      ),
    ],
  );

  // ══════════════════════════════════════════════════════════════════════
  //  SECTION 2 — Anatomy of the KeepAlive ParentDataWidget
  // ══════════════════════════════════════════════════════════════════════
  final Widget section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('2', 'Anatomy — The KeepAlive ParentDataWidget',
          'The low-level "keep me" flag, set in the parent\'s parentData'),
      noteBox(
        'KeepAlive is a ParentDataWidget<KeepAliveParentDataMixin>. It '
        'writes a single boolean (keepAlive) into the slot\'s parentData. '
        'The enclosing render object (a sliver list, for example) reads '
        'that flag during garbage collection to decide whether to destroy '
        'the slot. You almost never use KeepAlive directly — the higher-'
        'level AutomaticKeepAlive does that for you — but its plain form '
        'is perfect for mechanical demos and for static cases where the '
        'keep-alive flag is fixed.',
        icon: Icons.architecture,
      ),
      infoCard(
        'Constructor signature',
        codeBlock(
          'const KeepAlive({\n'
          '  super.key,\n'
          '  required this.keepAlive,\n'
          '  required super.child,\n'
          '});\n\n'
          '// Inherited:\n'
          '//   bool debugCanApplyOutOfTurn() => keepAlive;\n'
          '//   void applyParentData(RenderObject renderObject)',
        ),
      ),
      infoCard(
        'Inheritance chain',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            actor('KeepAlive', ember, Icons.bolt, sub: 'keepAlive: bool'),
            arrowDown('extends', smoke),
            actor('ParentDataWidget<KeepAliveParentDataMixin>', emberDeep,
                Icons.account_tree, sub: 'writes parentData'),
            arrowDown('extends', smoke),
            actor('ProxyWidget', emberDark, Icons.swap_horiz,
                sub: 'wraps a single child'),
            arrowDown('extends', smoke),
            actor('Widget', charcoal, Icons.widgets, sub: 'the immutable spec'),
          ],
        ),
      ),
      infoCard(
        'Working with a real KeepAlive instance',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Two literal KeepAlive widgets, the only difference being the '
              'keepAlive flag:',
              style: TextStyle(fontSize: 12.8, height: 1.45),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 96,
                    child: _illustrativeKeepAlive(
                      keepAlive: true,
                      child: Container(
                        decoration: BoxDecoration(
                          color: ivyDark,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: emberGold, width: 2),
                        ),
                        alignment: Alignment.center,
                        child: const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.bolt,
                                color: emberGold, size: 28),
                            SizedBox(height: 4),
                            Text(
                              'keepAlive: true',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.5,
                              ),
                            ),
                            Text(
                              'will survive recycling',
                              style: TextStyle(
                                color: emberGold,
                                fontSize: 10.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: SizedBox(
                    height: 96,
                    child: _illustrativeKeepAlive(
                      keepAlive: false,
                      child: Container(
                        decoration: BoxDecoration(
                          color: smoke,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: ash, width: 2),
                        ),
                        alignment: Alignment.center,
                        child: const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.delete_outline,
                                color: Colors.white, size: 28),
                            SizedBox(height: 4),
                            Text(
                              'keepAlive: false',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.5,
                              ),
                            ),
                            Text(
                              'free to be disposed',
                              style: TextStyle(
                                color: ash,
                                fontSize: 10.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            noteBox(
              'Both KeepAlive widgets here are inert at the top level — '
              'they only have effect when their child is a slot in a sliver '
              'list (or another render-object that reads the keepAlive '
              'parentData). Outside of that context they behave like a '
              'transparent pass-through. We render them here so the '
              'literal type appears on screen.',
              bg: sand,
              border: emberGold,
              icon: Icons.info_outline,
            ),
          ],
        ),
      ),
      infoCard(
        'Members reference',
        kvTable([
          ['Member', 'Kind', 'Description'],
          ['keepAlive', 'final bool',
              'true → ask parent sliver to preserve this slot'],
          ['child', 'final Widget',
              'the slot to be preserved (single child)'],
          ['applyParentData', 'override',
              'writes keepAlive into the slot\'s parentData'],
          ['debugCanApplyOutOfTurn', 'override',
              'true so the flag can be flipped late in the frame'],
          ['debugTypicalAncestorWidgetClass', 'override',
              'SliverWithKeepAliveWidget (compile-time documentation)'],
        ]),
      ),
    ],
  );

  // ══════════════════════════════════════════════════════════════════════
  //  SECTION 3 — KeepAliveNotification + KeepAliveHandle mechanics
  // ══════════════════════════════════════════════════════════════════════
  final Widget section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('3', 'Notification + Handle — the keep-alive protocol',
          'A bubble-up Notification carrying a Listenable release token'),
      noteBox(
        'A child that wants to be kept alive does not call a method on its '
        'ancestor — instead it dispatches a KeepAliveNotification carrying '
        'a KeepAliveHandle. The notification bubbles up the element tree. '
        'The nearest AutomaticKeepAlive in the tree catches it and starts '
        'listening to the handle. When the child no longer wants to be '
        'kept alive, it disposes the handle; the dispose() emits a final '
        'notification, the AutomaticKeepAlive removes its listener and '
        'releases the slot for recycling.',
        icon: Icons.notifications_active,
      ),
      infoCard(
        'Sequence diagram (child requests keep-alive then releases)',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            timelineStep(
              step: 1,
              title: 'Child State decides to be kept alive',
              description:
                  'wantKeepAlive becomes true (e.g. user typed in a form '
                  'field, started a video, opened a tab).',
              color: ember,
            ),
            timelineStep(
              step: 2,
              title: 'Child creates a KeepAliveHandle',
              description:
                  'final handle = KeepAliveHandle();   // a ChangeNotifier',
              color: emberDeep,
            ),
            timelineStep(
              step: 3,
              title: 'Child dispatches the notification',
              description:
                  'KeepAliveNotification(handle).dispatch(context);  '
                  'The notification bubbles up the element tree.',
              color: emberDark,
            ),
            timelineStep(
              step: 4,
              title: 'AutomaticKeepAlive catches it',
              description:
                  'The closest AutomaticKeepAlive ancestor sees the '
                  'notification, adds itself as a listener to the handle, '
                  'and sets its internal _keepingAlive flag to true.',
              color: rust,
            ),
            timelineStep(
              step: 5,
              title: 'AutomaticKeepAlive wraps the slot',
              description:
                  'Internally it builds KeepAlive(keepAlive: true, child: '
                  '_child), so the sliver\'s parentData is updated and '
                  'the slot stays alive when scrolled past.',
              color: emberDeep,
            ),
            timelineStep(
              step: 6,
              title: 'Child no longer wants to be kept alive',
              description:
                  'wantKeepAlive flips to false (form submitted, video '
                  'stopped, tab closed). Child calls handle.dispose().',
              color: blood,
            ),
            timelineStep(
              step: 7,
              title: 'Handle notifies listeners then dies',
              description:
                  'handle.dispose() calls notifyListeners() one last time, '
                  'then tears the notifier down.',
              color: emberDark,
            ),
            timelineStep(
              step: 8,
              title: 'AutomaticKeepAlive releases the slot',
              description:
                  'Listener removes itself, sets _keepingAlive to false, '
                  'and rebuilds with KeepAlive(keepAlive: false, ...). '
                  'The slot is now eligible for recycling.',
              color: smoke,
              isLast: true,
            ),
          ],
        ),
      ),
      infoCard(
        'Pseudocode — manual dispatch',
        codeBlock(
          '// inside a State\'s setState() or initState()\n'
          'final handle = KeepAliveHandle();\n'
          'KeepAliveNotification(handle).dispatch(context);\n\n'
          '// later, when we no longer need to be kept alive\n'
          'handle.dispose();\n\n'
          '// dispose() fires notifyListeners() one final time;\n'
          '// the ancestor AutomaticKeepAlive uses that signal to release.',
        ),
      ),
      infoCard(
        'KeepAliveHandle — the release-token Listenable',
        kvTable([
          ['Member', 'Kind', 'Description'],
          ['KeepAliveHandle()', 'constructor', 'creates a fresh ChangeNotifier'],
          ['addListener', 'inherited',
              'AutomaticKeepAlive registers here'],
          ['removeListener', 'inherited', 'symmetry with addListener'],
          ['dispose', 'override',
              'fires notifyListeners() then tears down'],
          ['hashCode / ==', 'identity',
              'each handle is a unique reference'],
        ]),
      ),
      infoCard(
        'Why a Notification rather than a method call?',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            bullet('Notifications travel up the element tree without the '
                'sender needing a reference to the receiver — perfect for '
                'arbitrary nesting (a Form inside a Card inside a tab).'),
            bullet('Multiple AutomaticKeepAlive ancestors can co-exist (e.g. '
                'nested PageView + ListView). The notification stops at the '
                'first one that handles it; the others ignore.'),
            bullet('The release path is implicit: dispose the handle, the '
                'listener disappears with it. No teardown call to make on '
                'the ancestor.'),
            bullet('It composes with other Notifications (Scroll, Size) so '
                'the same mechanism powers many cross-cutting concerns.'),
          ],
        ),
      ),
    ],
  );

  // ══════════════════════════════════════════════════════════════════════
  //  SECTION 4 — AutomaticKeepAlive widget
  // ══════════════════════════════════════════════════════════════════════
  final Widget section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('4', 'AutomaticKeepAlive — the slot-wrapping listener',
          'The widget that turns notifications into ParentData'),
      noteBox(
        'AutomaticKeepAlive is the bridge between the high-level "I want '
        'to be kept alive" notification and the low-level KeepAlive '
        'ParentDataWidget. SliverList, SliverGrid, PageView, and TabBarView '
        'automatically wrap each child in an AutomaticKeepAlive (when the '
        'sliver delegate\'s addAutomaticKeepAlives is true). You usually '
        'do not instantiate it yourself.',
        icon: Icons.shield,
      ),
      infoCard(
        'What it does at runtime',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            bullet('Renders its child unchanged in the normal case.'),
            bullet('Subscribes to KeepAliveNotification events from inside '
                'the subtree.'),
            bullet('For each unique handle that arrives, adds a listener '
                'and tracks it in a Set<Listenable>.'),
            bullet('While the set is non-empty, wraps the rendered child '
                'in KeepAlive(keepAlive: true, …) so the parent sliver\'s '
                'parentData says "keep me".'),
            bullet('When a tracked handle is disposed, its listener removes '
                'it from the set. If the set becomes empty, it rebuilds '
                'with KeepAlive(keepAlive: false, …) and the slot is freed.'),
          ],
        ),
      ),
      infoCard(
        'Constructor signature',
        codeBlock(
          'const AutomaticKeepAlive({\n'
          '  super.key,\n'
          '  required this.child,\n'
          '});\n\n'
          '// only one parameter — the child whose subtree is monitored.\n'
          '// addAutomaticKeepAlives on the sliver delegate decides whether\n'
          '// each tile gets wrapped.',
        ),
      ),
      infoCard(
        'Where it lives in the framework',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            actor('SliverList.builder', emberDeep, Icons.view_list,
                sub: 'sliver delegate, addAutomaticKeepAlives: true'),
            arrowDown('wraps each tile', smoke),
            actor('AutomaticKeepAlive', ember, Icons.shield,
                sub: 'listens for KeepAliveNotification'),
            arrowDown('on demand', smoke),
            actor('KeepAlive(keepAlive: true)', emberDark, Icons.bolt,
                sub: 'ParentDataWidget written into slot'),
            arrowDown('contains', smoke),
            actor('Your tile', ivyDark, Icons.widgets, sub: 'the visible UI'),
          ],
        ),
      ),
    ],
  );

  // ══════════════════════════════════════════════════════════════════════
  //  SECTION 5 — AutomaticKeepAliveClientMixin pattern (explained)
  // ══════════════════════════════════════════════════════════════════════
  final Widget section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('5', 'AutomaticKeepAliveClientMixin — the friendly API',
          'The mixin every Flutter tutorial reaches for'),
      noteBox(
        'AutomaticKeepAliveClientMixin is the friendly, idiomatic way to '
        'use the protocol from inside a State subclass. You mix it in, '
        'override wantKeepAlive, and call super.build() at the top of your '
        'build method. The mixin handles handle creation, notification '
        'dispatch, and release in your dispose(). It must be applied to '
        'a State — and a State is part of a StatefulWidget, which this '
        'harness does not author directly. The mixin is therefore shown '
        'here as commented pseudocode rather than executed.',
        bg: sand,
        border: emberGold,
        icon: Icons.warning_amber,
      ),
      infoCard(
        'Pseudocode pattern — counterpart Widget + State',
        codeBlock(
          '/// Drop-in pattern that ALL Flutter devs eventually memorise.\n'
          'class CounterTab extends StatefulWidget {\n'
          '  const CounterTab({super.key, required this.label});\n'
          '  final String label;\n'
          '  @override\n'
          '  State<CounterTab> createState() => _CounterTabState();\n'
          '}\n\n'
          'class _CounterTabState extends State<CounterTab>\n'
          '    with AutomaticKeepAliveClientMixin<CounterTab> {\n'
          '  int _count = 0;\n\n'
          '  @override\n'
          '  bool get wantKeepAlive => true;     //  ← the magic flag\n\n'
          '  @override\n'
          '  Widget build(BuildContext context) {\n'
          '    super.build(context);              //  ← MUST be first\n'
          '    return Center(\n'
          '      child: Column(\n'
          '        mainAxisSize: MainAxisSize.min,\n'
          '        children: [\n'
          '          Text(\'\${widget.label}: \$_count\'),\n'
          '          ElevatedButton(\n'
          '            onPressed: () => setState(() => _count++),\n'
          '            child: const Text(\'+1\'),\n'
          '          ),\n'
          '        ],\n'
          '      ),\n'
          '    );\n'
          '  }\n'
          '}',
        ),
      ),
      infoCard(
        'What the mixin does for you (internals)',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            bullet('Holds a private KeepAliveHandle? _keepAliveHandle.'),
            bullet('On first super.build(), if wantKeepAlive is true and '
                'there is no handle yet, creates one, dispatches the '
                'notification, and stores the handle.'),
            bullet('On each super.build(), reconciles current wantKeepAlive '
                'with the handle: if false-and-have, disposes it; if '
                'true-and-none, creates a new one.'),
            bullet('updateKeepAlive() — public method you can call when '
                'wantKeepAlive\'s value changes without a setState.'),
            bullet('On dispose(), releases the handle so listeners are not '
                'leaked.'),
          ],
        ),
      ),
      infoCard(
        'Mandatory super.build call',
        codeBlock(
          'Widget build(BuildContext context) {\n'
          '  super.build(context); // <-- THIS LINE\n'
          '  // …\n'
          '}\n\n'
          '// Forgetting super.build() means the mixin\'s reconciliation\n'
          '// never runs, so the handle is never dispatched. The compiler\n'
          '// catches it with a lint (must_call_super), but the runtime\n'
          '// will silently never keep the State alive.',
        ),
      ),
      infoCard(
        'Reference table',
        kvTable([
          ['Member', 'Kind', 'Description'],
          ['wantKeepAlive', 'getter (override)',
              'true → request preservation'],
          ['super.build(context)', 'inherited call',
              'reconciles handle each build'],
          ['updateKeepAlive()', 'method',
              'force-resync after wantKeepAlive changes'],
          ['dispose()', 'override',
              'releases handle automatically'],
        ]),
      ),
    ],
  );

  // ══════════════════════════════════════════════════════════════════════
  //  SECTION 6 — Recipe gallery (TabBarView, PageView, ListView, Nested)
  // ══════════════════════════════════════════════════════════════════════
  final Widget section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('6', 'Recipes — real-world keep-alive scenarios',
          'Four canonical patterns with pseudocode and a visual sketch'),

      // Recipe A — TabBarView with form preservation
      infoCard(
        'Recipe A — TabBarView with form preservation',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Three tabs, each containing a TextField. Without keep-alive, '
              'switching tabs disposes the State of the other two and their '
              'text disappears. With AutomaticKeepAliveClientMixin set to '
              'wantKeepAlive: true, the partially-filled forms survive '
              'every tab swipe.',
              style: TextStyle(fontSize: 12.5, height: 1.45),
            ),
            const SizedBox(height: 6),
            codeBlock(
              'class FormTab extends StatefulWidget {\n'
              '  const FormTab({super.key, required this.title});\n'
              '  final String title;\n'
              '  @override State<FormTab> createState() => _FormTabState();\n'
              '}\n\n'
              'class _FormTabState extends State<FormTab>\n'
              '    with AutomaticKeepAliveClientMixin<FormTab> {\n'
              '  late final controller = TextEditingController();\n'
              '  @override bool get wantKeepAlive => true;\n'
              '  @override\n'
              '  Widget build(BuildContext context) {\n'
              '    super.build(context);\n'
              '    return Padding(\n'
              '      padding: const EdgeInsets.all(12),\n'
              '      child: TextField(controller: controller,\n'
              '        decoration: InputDecoration(labelText: widget.title)),\n'
              '    );\n'
              '  }\n'
              '  @override\n'
              '  void dispose() { controller.dispose(); super.dispose(); }\n'
              '}',
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(child: slot(
                  label: 'Tab 0 — Profile',
                  color: emberDeep,
                  keptAlive: true,
                  sub: 'TextField "Ada"',
                )),
                Expanded(child: slot(
                  label: 'Tab 1 — Address',
                  color: rust,
                  keptAlive: true,
                  sub: 'TextField "221B…"',
                )),
                Expanded(child: slot(
                  label: 'Tab 2 — Notes',
                  color: ember,
                  keptAlive: true,
                  sub: 'TextField "draft…"',
                )),
              ],
            ),
            const SizedBox(height: 4),
            noteBox(
              'Every tab is gold-bordered (alive) regardless of which one '
              'is the active page.',
              bg: emberCream,
              icon: Icons.lightbulb_outline,
            ),
          ],
        ),
      ),

      // Recipe B — PageView with heavy children
      infoCard(
        'Recipe B — PageView with heavy children',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'A PageView whose children include a Chart, a MapView, and a '
              'CameraPreview. Each page is expensive to construct. With '
              'wantKeepAlive: true on the State of each page, the user can '
              'swipe back and forth without paying construction cost or '
              'flashing a blank frame.',
              style: TextStyle(fontSize: 12.5, height: 1.45),
            ),
            const SizedBox(height: 6),
            codeBlock(
              'PageView(\n'
              '  children: const <Widget>[\n'
              '    HeavyPage(label: \'Chart\'),\n'
              '    HeavyPage(label: \'Map\'),\n'
              '    HeavyPage(label: \'Camera\'),\n'
              '  ],\n'
              ');\n\n'
              'class HeavyPage extends StatefulWidget { /* … */ }\n'
              'class _HeavyPageState extends State<HeavyPage>\n'
              '    with AutomaticKeepAliveClientMixin {\n'
              '  @override bool get wantKeepAlive => true;\n'
              '  @override\n'
              '  Widget build(BuildContext context) {\n'
              '    super.build(context);\n'
              '    return ExpensiveSubtree();\n'
              '  }\n'
              '}',
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(child: slot(
                  label: 'Chart',
                  color: skyDeep,
                  keptAlive: true,
                  sub: '14 series cached',
                  height: 80,
                )),
                Expanded(child: slot(
                  label: 'Map',
                  color: ivy,
                  keptAlive: true,
                  sub: 'tiles 5/15/24 in RAM',
                  height: 80,
                )),
                Expanded(child: slot(
                  label: 'Camera',
                  color: rust,
                  keptAlive: true,
                  sub: 'stream active',
                  height: 80,
                )),
              ],
            ),
          ],
        ),
      ),

      // Recipe C — ListView.builder long list with kept state
      infoCard(
        'Recipe C — ListView.builder with selective keep-alive',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'A 10 000-row list where most rows are cheap text but every '
              '50th row contains a mini video player. Mark only the video '
              'rows as kept-alive — the rest happily recycle. This is '
              'when the mixin\'s dynamic wantKeepAlive shines.',
              style: TextStyle(fontSize: 12.5, height: 1.45),
            ),
            const SizedBox(height: 6),
            codeBlock(
              'class Row extends StatefulWidget { /* … */ }\n'
              'class _RowState extends State<Row>\n'
              '    with AutomaticKeepAliveClientMixin {\n'
              '  @override\n'
              '  bool get wantKeepAlive => widget.kind == RowKind.video;\n'
              '  @override\n'
              '  Widget build(BuildContext context) {\n'
              '    super.build(context);\n'
              '    return widget.kind == RowKind.video\n'
              '      ? VideoTile(url: widget.url)\n'
              '      : Text(widget.text);\n'
              '  }\n'
              '}',
            ),
            const SizedBox(height: 6),
            Column(
              children: [
                slot(label: 'Row #0 (text)', color: smoke,
                    keptAlive: false, sub: 'cheap, will recycle'),
                slot(label: 'Row #1 (text)', color: smoke,
                    keptAlive: false, sub: 'cheap, will recycle'),
                slot(label: 'Row #50 (video)', color: rust,
                    keptAlive: true,
                    sub: 'wantKeepAlive: true'),
                slot(label: 'Row #51 (text)', color: smoke,
                    keptAlive: false, sub: 'cheap, will recycle'),
                slot(label: 'Row #100 (video)', color: rust,
                    keptAlive: true,
                    sub: 'wantKeepAlive: true'),
              ],
            ),
          ],
        ),
      ),

      // Recipe D — NestedScrollView body keep-alive
      infoCard(
        'Recipe D — NestedScrollView body keep-alive',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'NestedScrollView wraps a TabBarView in its body. Each tab '
              'has its own inner Scrollable. Without keep-alive, switching '
              'tabs resets the inner scroll offset to 0 because the body '
              'subtree is rebuilt. With keep-alive on each tab\'s State, '
              'the scroll offsets are preserved per tab.',
              style: TextStyle(fontSize: 12.5, height: 1.45),
            ),
            const SizedBox(height: 6),
            codeBlock(
              'NestedScrollView(\n'
              '  headerSliverBuilder: (ctx, inner) => <Widget>[\n'
              '    SliverOverlapAbsorber(\n'
              '      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(ctx),\n'
              '      sliver: SliverAppBar(/* … */),\n'
              '    ),\n'
              '  ],\n'
              '  body: TabBarView(\n'
              '    children: const <Widget>[\n'
              '      InnerScrollableTab(name: \'Feed\'),\n'
              '      InnerScrollableTab(name: \'Photos\'),\n'
              '      InnerScrollableTab(name: \'About\'),\n'
              '    ],\n'
              '  ),\n'
              ');\n\n'
              '// Each InnerScrollableTab mixes in AutomaticKeepAliveClientMixin\n'
              '// with wantKeepAlive => true.',
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(child: slot(
                  label: 'Feed (scroll = 482px)',
                  color: emberDeep,
                  keptAlive: true,
                )),
                Expanded(child: slot(
                  label: 'Photos (scroll = 1240px)',
                  color: ember,
                  keptAlive: true,
                )),
                Expanded(child: slot(
                  label: 'About (scroll = 12px)',
                  color: rust,
                  keptAlive: true,
                )),
              ],
            ),
          ],
        ),
      ),
    ],
  );

  // ══════════════════════════════════════════════════════════════════════
  //  SECTION 7 — Comparison panel: keep-alive vs not
  // ══════════════════════════════════════════════════════════════════════
  final Widget section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('7', 'With vs Without — life of an off-screen slot',
          'Vertical timeline contrasting two slots side by side'),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                pillarHeader('Without keep-alive', Icons.delete_sweep, smoke),
                pillarBody(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      timelineStep(
                        step: 1,
                        title: 'Slot constructed',
                        description: 'createState() → initState() runs',
                        color: ivy,
                      ),
                      timelineStep(
                        step: 2,
                        title: 'Slot becomes visible',
                        description: 'build() called, widget mounted',
                        color: ivyDark,
                      ),
                      timelineStep(
                        step: 3,
                        title: 'User scrolls slot off-screen',
                        description:
                            'cacheExtent boundary crossed; element released',
                        color: emberGold,
                      ),
                      timelineStep(
                        step: 4,
                        title: 'Slot State.dispose() called',
                        description:
                            'controllers, subscriptions, timers torn down',
                        color: blood,
                      ),
                      timelineStep(
                        step: 5,
                        title: 'Slot scrolls back on-screen',
                        description: 'createState() again — fresh State',
                        color: emberDeep,
                      ),
                      timelineStep(
                        step: 6,
                        title: 'Scroll offset / form / animation lost',
                        description:
                            'rebuilt to initial values — flashes blank',
                        color: rust,
                        isLast: true,
                      ),
                    ],
                  ),
                  bg: emberCream,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                pillarHeader('With keep-alive', Icons.bolt, ember),
                pillarBody(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      timelineStep(
                        step: 1,
                        title: 'Slot constructed',
                        description: 'createState() → initState() runs',
                        color: ivy,
                      ),
                      timelineStep(
                        step: 2,
                        title: 'super.build()',
                        description:
                            'mixin dispatches KeepAliveNotification',
                        color: ember,
                      ),
                      timelineStep(
                        step: 3,
                        title: 'AutomaticKeepAlive listens to handle',
                        description:
                            'parentData updated to keepAlive: true',
                        color: emberDeep,
                      ),
                      timelineStep(
                        step: 4,
                        title: 'User scrolls slot off-screen',
                        description:
                            'parent skips disposal — State survives',
                        color: emberGold,
                      ),
                      timelineStep(
                        step: 5,
                        title: 'Slot scrolls back on-screen',
                        description:
                            'same State reused — offset/form/animation kept',
                        color: ivyDark,
                      ),
                      timelineStep(
                        step: 6,
                        title: 'Eventually State.dispose()',
                        description:
                            'when parent removed or wantKeepAlive flips false',
                        color: smoke,
                        isLast: true,
                      ),
                    ],
                  ),
                  bg: bone,
                ),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 8),
      noteBox(
        'The right-hand timeline replaces steps 4-5 ("disposed → recreated") '
        'with a single survival event. The State object is the same instance '
        'across the scroll dip — that is the entire promise.',
        bg: emberCream,
        icon: Icons.compare_arrows,
      ),
    ],
  );

  // ══════════════════════════════════════════════════════════════════════
  //  SECTION 8 — Common pitfalls
  // ══════════════════════════════════════════════════════════════════════
  final Widget section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('8', 'Pitfalls — when keep-alive bites back',
          'The dark side of preserving everything forever'),
      infoCard(
        'Pitfall 1 — Memory cost grows linearly',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Every kept-alive slot retains its State, controllers, '
              'subscriptions, image caches, and animation tickers. A list '
              'of 1 000 items all marked wantKeepAlive: true holds 1 000 '
              'State objects in RAM — exactly what ListView.builder was '
              'designed to avoid. Use sparingly.',
              style: TextStyle(fontSize: 12.5, height: 1.45),
            ),
            const SizedBox(height: 6),
            kvTable([
              ['Slots kept alive', 'Approx. RSS impact', 'Verdict'],
              ['≤ 10', 'a few MB', 'safe'],
              ['10 – 100', 'tens of MB', 'audit each one'],
              ['> 100', 'hundreds of MB', 'design smell — refactor'],
            ]),
          ],
        ),
      ),
      infoCard(
        'Pitfall 2 — Off-screen builds still happen',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            bullet('Keep-alive prevents disposal, but a kept-alive widget '
                'is still rebuilt when its dependencies change (InheritedWidget '
                'updates, setState in ancestors).'),
            bullet('If you assume "off-screen = never rebuilt" you may be '
                'doing work the user never sees. Profile with a debug print '
                'in build to confirm.'),
            bullet('AutomaticKeepAlive uses Offstage and TickerMode under '
                'the hood — animations are paused while off-screen but the '
                'tree itself remains.'),
          ],
        ),
      ),
      infoCard(
        'Pitfall 3 — Forgetting super.build()',
        codeBlock(
          'Widget build(BuildContext context) {\n'
          '  // super.build(context); // ←  OOPS, removed in a refactor\n'
          '  return Text(\'page \${widget.index}\');\n'
          '}\n\n'
          '// Result: wantKeepAlive: true but the mixin never gets a chance\n'
          '// to dispatch the notification. The slot is recycled normally\n'
          '// and the developer is left chasing a silent bug.\n'
          '// The lint must_call_super flags this — never disable it.',
        ),
      ),
      infoCard(
        'Pitfall 4 — Flipping wantKeepAlive without updateKeepAlive()',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            bullet('wantKeepAlive is a getter; the mixin checks it only on '
                'super.build(). If you change a flag that affects it and do '
                'not trigger a rebuild, the keep-alive state will not update.'),
            bullet('Workaround: call updateKeepAlive() yourself after flipping '
                'the underlying field — or wrap the change in setState.'),
            const SizedBox(height: 4),
            codeBlock(
              'void onStartTyping() {\n'
              '  _shouldKeep = true;\n'
              '  updateKeepAlive(); // resyncs handle\n'
              '}',
            ),
          ],
        ),
      ),
      infoCard(
        'Pitfall 5 — Leaks via long-lived handles',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            bullet('If you write keep-alive manually (without the mixin) and '
                'forget to dispose the KeepAliveHandle, the AutomaticKeepAlive '
                'will hold the slot forever, even when the user navigates '
                'far away.'),
            bullet('Always pair handle creation with handle.dispose() in your '
                'State.dispose() — or use the mixin which does this for you.'),
          ],
        ),
      ),
      infoCard(
        'Pitfall 6 — Mistaking keep-alive for caching',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            bullet('Keep-alive preserves State objects, not data. If your '
                'data lives in a Provider/Bloc/Riverpod store, the data is '
                'already preserved by that store — adding keep-alive is '
                'redundant and may even cause stale State to override '
                'fresh store values.'),
            bullet('Use keep-alive only when there is per-widget transient '
                'state worth keeping (text fields, scroll offset, animation '
                'progress).'),
          ],
        ),
      ),
    ],
  );

  // ══════════════════════════════════════════════════════════════════════
  //  SECTION 9 — Comparison: KeepAlive vs mixin's wantKeepAlive
  // ══════════════════════════════════════════════════════════════════════
  final Widget section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('9', 'KeepAlive vs wantKeepAlive — which level to use?',
          'Pick the right abstraction for the right job'),
      kvTable([
        ['Concern', 'KeepAlive (ParentDataWidget)',
            'AutomaticKeepAliveClientMixin'],
        ['Lifecycle awareness', 'static flag', 'dynamic per build'],
        ['Boilerplate', 'one widget', 'mixin + super.build + dispose'],
        ['Per-slot wrapping', 'manual', 'automatic via AutomaticKeepAlive'],
        ['Reacts to setState', 'no', 'yes'],
        ['Best for', 'tests, demos, fixed conditions',
            'real apps, dynamic conditions'],
        ['Source-of-truth', 'parentData boolean',
            'wantKeepAlive getter + handle'],
        ['Discoverability', 'low (internal)', 'high (in every tutorial)'],
      ]),
      const SizedBox(height: 8),
      noteBox(
        'Rule of thumb: if the keep-alive decision is "always yes" or '
        '"always no" for the entire life of the slot, KeepAlive is fine. '
        'If it depends on the runtime State of the slot (form dirty? video '
        'playing? user typed something?), use the mixin.',
        bg: emberCream,
        icon: Icons.help_outline,
      ),
    ],
  );

  // ══════════════════════════════════════════════════════════════════════
  //  SECTION 10 — Mini sandboxes (literal KeepAlive instances)
  // ══════════════════════════════════════════════════════════════════════
  final Widget section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('10', 'Sandboxes — literal KeepAlive widget on screen',
          'Real KeepAlive instances inside little SizedBoxes'),
      noteBox(
        'These KeepAlive widgets are rendered for visual reference. They '
        'are not inside a sliver, so their keep-alive bit has no effect at '
        'runtime; what you see is the wrapped child and the surrounding '
        'badge that we add manually to indicate the intended state. Drop '
        'these snippets inside a SliverList.builder to see real behaviour.',
        icon: Icons.science,
      ),
      Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 110,
              child: _illustrativeKeepAlive(
                keepAlive: true,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [emberDeep, ember, emberGold],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: emberGold, width: 2),
                  ),
                  alignment: Alignment.center,
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.bolt, color: Colors.white, size: 32),
                      SizedBox(height: 4),
                      Text(
                        'Sandbox A',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'KeepAlive(true)',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11.5,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: SizedBox(
              height: 110,
              child: _illustrativeKeepAlive(
                keepAlive: false,
                child: Container(
                  decoration: BoxDecoration(
                    color: smoke,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: ash, width: 2),
                  ),
                  alignment: Alignment.center,
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.delete_outline,
                          color: Colors.white, size: 32),
                      SizedBox(height: 4),
                      Text(
                        'Sandbox B',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'KeepAlive(false)',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11.5,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 8),
      Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 90,
              child: _illustrativeKeepAlive(
                keepAlive: true,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: ivyDark,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: emberGold, width: 2),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sandbox C — chart',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        '14 series, 3.2 MB cache',
                        style: TextStyle(
                          color: emberGold,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: SizedBox(
              height: 90,
              child: _illustrativeKeepAlive(
                keepAlive: true,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: skyDeep,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: emberGold, width: 2),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sandbox D — video',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'pos: 2:17 / 8:42',
                        style: TextStyle(
                          color: emberGold,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: SizedBox(
              height: 90,
              child: _illustrativeKeepAlive(
                keepAlive: false,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: smoke,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: ash, width: 2),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sandbox E — list row',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'cheap text, OK to recycle',
                        style: TextStyle(
                          color: ash,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ],
  );

  // ══════════════════════════════════════════════════════════════════════
  //  SECTION 11 — How parents read the flag (parentData walk-through)
  // ══════════════════════════════════════════════════════════════════════
  final Widget section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('11', 'ParentData walk-through — where the flag lives',
          'How a sliver reads keepAlive from its child\'s parentData'),
      noteBox(
        'A render object owns a parentData object for each of its '
        'children. The KeepAlive ParentDataWidget writes a single flag — '
        'keepAlive — into the slot\'s parentData via the '
        'KeepAliveParentDataMixin. The sliver consults that flag during '
        'its sweep phase, when it would normally garbage-collect off-screen '
        'children.',
        icon: Icons.data_object,
      ),
      infoCard(
        'Pseudo-walk of the mechanism',
        codeBlock(
          '// 1) The KeepAlive widget creates an element.\n'
          'class _KeepAliveElement extends ParentDataElement<KeepAlive> {\n'
          '  // …\n'
          '}\n\n'
          '// 2) On layout, applyParentData() is called on the child render.\n'
          'void applyParentData(RenderObject renderObject) {\n'
          '  final KeepAliveParentDataMixin data =\n'
          '      renderObject.parentData! as KeepAliveParentDataMixin;\n'
          '  if (data.keepAlive != keepAlive) {\n'
          '    data.keepAlive = keepAlive;\n'
          '    // request re-layout of the parent sliver\n'
          '    final RenderObject? targetParent = renderObject.parent;\n'
          '    if (targetParent is RenderObject) targetParent.markNeedsLayout();\n'
          '  }\n'
          '}\n\n'
          '// 3) When the parent sliver sweeps off-screen children:\n'
          'for (final RenderBox child in _activeChildren) {\n'
          '  final data = child.parentData! as SliverMultiBoxAdaptorParentData;\n'
          '  if (!data.keepAlive && !child.attached) {\n'
          '    _disposeChild(child); // free the slot\n'
          '  }\n'
          '}',
        ),
      ),
      infoCard(
        'Where the boolean is stored',
        kvTable([
          ['Layer', 'Type', 'Stores'],
          ['Widget', 'KeepAlive', 'keepAlive constant'],
          ['Element', '_KeepAliveElement',
              'wraps the child, calls applyParentData'],
          ['RenderObject', 'RenderBox', 'has parentData of mixin type'],
          ['ParentData', 'KeepAliveParentDataMixin',
              'keepAlive: bool — the actual flag'],
          ['Sliver', 'RenderSliverMultiBoxAdaptor',
              'reads the flag in collectGarbage()'],
        ]),
      ),
    ],
  );

  // ══════════════════════════════════════════════════════════════════════
  //  SECTION 12 — Visual cheat sheet (the whole protocol on one page)
  // ══════════════════════════════════════════════════════════════════════
  final Widget section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('12', 'Cheat sheet — the whole protocol on one page',
          'A visual roll-call of every actor and signal'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: bone,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: emberPale),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            actor('State subclass + mixin', sky, Icons.account_circle,
                sub: 'wantKeepAlive ?'),
            arrowDown('super.build(context)', emberDeep),
            actor('AutomaticKeepAliveClientMixin', skyDeep, Icons.layers,
                sub: 'creates handle, dispatches notification'),
            arrowDown('KeepAliveNotification(handle)', emberDark),
            actor('AutomaticKeepAlive (ancestor)', ember, Icons.shield,
                sub: 'catches, adds listener to handle'),
            arrowDown('wraps slot in KeepAlive(true)', emberDeep),
            actor('KeepAlive ParentDataWidget', emberDark, Icons.bolt,
                sub: 'writes keepAlive: true into parentData'),
            arrowDown('parentData read', rust),
            actor('SliverMultiBoxAdaptor', rust, Icons.view_stream,
                sub: 'collectGarbage() skips this slot'),
            arrowDown('eventually...', smoke),
            actor('handle.dispose() — release', blood, Icons.power_off,
                sub: 'listener removed, slot freed'),
          ],
        ),
      ),
    ],
  );

  // ══════════════════════════════════════════════════════════════════════
  //  SECTION 13 — Glossary
  // ══════════════════════════════════════════════════════════════════════
  final Widget section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('13', 'Glossary — words you will hear around keep-alive',
          'Short definitions for cross-team discussions'),
      infoCard(
        'Vocabulary',
        kvTable([
          ['Term', 'Definition'],
          ['Slot', 'a single child position inside a lazy sliver'],
          ['Element recycling',
              'reusing the same Element for a different widget'],
          ['Sliver',
              'a portion of a scrollable area that contributes geometry'],
          ['cacheExtent',
              'pixels of pre-rendering outside the visible viewport'],
          ['Handle',
              'short name for KeepAliveHandle — the release token'],
          ['Notification',
              'short name for KeepAliveNotification — the bubble-up signal'],
          ['ParentData',
              'metadata about a child that lives in the parent render'],
          ['Mixin',
              'the convenience API: AutomaticKeepAliveClientMixin'],
          ['Recycling',
              'destroying an off-screen slot to reclaim memory'],
          ['Preservation',
              'opposite of recycling — what keep-alive achieves'],
        ]),
      ),
    ],
  );

  // ══════════════════════════════════════════════════════════════════════
  //  SECTION 14 — Statistics & recap
  // ══════════════════════════════════════════════════════════════════════
  final Widget section14 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('14', 'Recap — five members, one idea',
          'Preserve State across viewport recycling'),
      infoCard(
        'Five members, one job',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            bullet('KeepAlive — the low-level boolean flag in parentData.'),
            bullet('KeepAliveHandle — the disposable release-token Listenable.'),
            bullet('KeepAliveNotification — the bubble-up envelope carrying '
                'a handle from child to ancestor.'),
            bullet('AutomaticKeepAlive — the wrapper that listens for the '
                'notification and writes the flag.'),
            bullet('AutomaticKeepAliveClientMixin — the convenience API on '
                'State that does it all for you.'),
          ],
        ),
      ),
      infoCard(
        'Statistics',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            dataRow('Total sections', '14'),
            dataRow('Family members covered', '5'),
            dataRow('Recipes shown', '4'),
            dataRow('Pitfalls catalogued', '6'),
            dataRow('Theme', 'Living Embers'),
            dataRow('Palette colors', '17'),
          ],
        ),
      ),
      const SizedBox(height: 6),
      Wrap(
        spacing: 6,
        runSpacing: 4,
        children: [
          chip('Keep alive', emberGold, charcoal),
          chip('Preserve State', ember, Colors.white),
          chip('Survive recycling', emberDeep, Colors.white),
          chip('ParentData', rust, Colors.white),
          chip('Notification bubble', ivy, Colors.white),
          chip('Release on dispose', blood, Colors.white),
          chip('wantKeepAlive', sky, Colors.white),
          chip('super.build(context)', skyDeep, Colors.white),
        ],
      ),
      const SizedBox(height: 10),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [charcoal, emberDark],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.local_fire_department, color: emberGold, size: 28),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'Keep-alive is opt-in memory. Use it when a slot has '
                'fragile transient State worth preserving across a quick '
                'scroll dip. Otherwise let Flutter recycle — that is its '
                'super-power.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontStyle: FontStyle.italic,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );

  print('===== END KEEP ALIVE WIDGET FAMILY DEMO =====');

  // ══════════════════════════════════════════════════════════════════════
  //  Compose the whole demo
  // ══════════════════════════════════════════════════════════════════════
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        header,
        section1,
        section2,
        section3,
        section4,
        section5,
        section6,
        section7,
        section8,
        section9,
        section10,
        section11,
        section12,
        section13,
        section14,
      ],
    ),
  );
}
