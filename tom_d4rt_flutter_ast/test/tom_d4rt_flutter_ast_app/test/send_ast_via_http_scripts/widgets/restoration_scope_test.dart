// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// =====================================================================
// RestorationScope / RootRestorationScope / RestorableValue family demo
// ---------------------------------------------------------------------
// Palette: "Tidepool" — deep teal, warm coral, sand, ink, mist, kelp.
// Sections:
//   1. Hero header with palette badges
//   2. Why state restoration (Android process death pitch)
//   3. RestorationScope tree schematic
//   4. Gallery of Restorable* types (cards)
//   5. Lifecycle timeline (pause -> serialize -> kill -> relaunch -> restore)
//   6. Code-card showing RestorationMixin pattern (string only)
//   7. RestorationBucket conceptual diagram
//   8. Comparison table RestorableValue vs ValueNotifier vs ChangeNotifier
//   9. Reference of all Restorable* classes
//  10. Edge cases (null restorationId, conflicting ids, scope nesting)
//  11. Footer
// =====================================================================

// ---------------- Tidepool palette ----------------
const Color kTidepoolDeep = Color(0xFF0F3D3E);
const Color kTidepoolTeal = Color(0xFF2A6F76);
const Color kTidepoolCoral = Color(0xFFE0654A);
const Color kTidepoolSand = Color(0xFFF3E0BE);
const Color kTidepoolInk = Color(0xFF14202B);
const Color kTidepoolMist = Color(0xFFE9F1F2);
const Color kTidepoolKelp = Color(0xFF2F5233);
const Color kTidepoolDriftwood = Color(0xFF8C6A4A);
const Color kTidepoolFoam = Color(0xFFFFF7E8);
const Color kTidepoolStorm = Color(0xFF4A5D6B);
const Color kTidepoolAlgae = Color(0xFF7BA05B);
const Color kTidepoolShell = Color(0xFFFFE3D8);

// ---------------- Section title widget ----------------
Widget sectionTitle(String number, String title, String subtitle) {
  return Container(
    margin: const EdgeInsets.only(top: 36.0, bottom: 18.0),
    padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 18.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[kTidepoolDeep, kTidepoolTeal],
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kTidepoolInk.withValues(alpha: 0.25),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 56.0,
          height: 56.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: kTidepoolCoral,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: kTidepoolInk.withValues(alpha: 0.30),
                blurRadius: 6.0,
                offset: const Offset(0.0, 2.0),
              ),
            ],
          ),
          child: Text(
            number,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 22.0,
            ),
          ),
        ),
        const SizedBox(width: 18.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 22.0,
                  letterSpacing: 0.4,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                subtitle,
                style: TextStyle(
                  color: kTidepoolSand.withValues(alpha: 0.92),
                  fontWeight: FontWeight.w400,
                  fontSize: 13.0,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------- Palette badge ----------------
Widget paletteBadge(String label, Color color, String hex) {
  return Container(
    width: 130.0,
    margin: const EdgeInsets.only(right: 10.0, bottom: 10.0),
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: kTidepoolMist, width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kTidepoolInk.withValues(alpha: 0.07),
          blurRadius: 4.0,
          offset: const Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 38.0,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6.0),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 12.0,
            color: kTidepoolInk,
          ),
        ),
        const SizedBox(height: 2.0),
        Text(
          hex,
          style: TextStyle(
            fontSize: 10.0,
            color: kTidepoolStorm.withValues(alpha: 0.85),
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

// ---------------- Hero header ----------------
Widget buildHero() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 36.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          kTidepoolDeep,
          kTidepoolTeal,
          kTidepoolKelp,
        ],
        stops: <double>[0.0, 0.55, 1.0],
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kTidepoolInk.withValues(alpha: 0.30),
          blurRadius: 16.0,
          offset: const Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 72.0,
              height: 72.0,
              decoration: BoxDecoration(
                color: kTidepoolCoral,
                borderRadius: BorderRadius.circular(18.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: kTidepoolInk.withValues(alpha: 0.4),
                    blurRadius: 8.0,
                    offset: const Offset(0.0, 3.0),
                  ),
                ],
              ),
              child: const Icon(
                Icons.restore,
                color: Colors.white,
                size: 38.0,
              ),
            ),
            const SizedBox(width: 18.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text(
                    'RestorationScope',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36.0,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.6,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'State restoration across process death',
                    style: TextStyle(
                      color: kTidepoolSand.withValues(alpha: 0.92),
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 6.0),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 4.0,
                    ),
                    decoration: BoxDecoration(
                      color: kTidepoolFoam.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(
                        color: kTidepoolSand.withValues(alpha: 0.55),
                      ),
                    ),
                    child: const Text(
                      'palette: Tidepool',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.0,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 22.0),
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: kTidepoolFoam.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: kTidepoolSand.withValues(alpha: 0.30),
            ),
          ),
          child: const Text(
            'Flutter\'s state restoration framework lets your widget tree '
            'survive Android process death and iOS app suspension. The '
            'RestorationScope acts as a namespace boundary, the '
            'RootRestorationScope sits at the top of the app, and '
            'Restorable* values plug individual pieces of state into a '
            'persistent bucket managed by the platform.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              height: 1.55,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(height: 20.0),
        Wrap(
          children: <Widget>[
            paletteBadge('Deep', kTidepoolDeep, '#0F3D3E'),
            paletteBadge('Teal', kTidepoolTeal, '#2A6F76'),
            paletteBadge('Coral', kTidepoolCoral, '#E0654A'),
            paletteBadge('Sand', kTidepoolSand, '#F3E0BE'),
            paletteBadge('Mist', kTidepoolMist, '#E9F1F2'),
            paletteBadge('Kelp', kTidepoolKelp, '#2F5233'),
            paletteBadge('Drift', kTidepoolDriftwood, '#8C6A4A'),
            paletteBadge('Foam', kTidepoolFoam, '#FFF7E8'),
            paletteBadge('Storm', kTidepoolStorm, '#4A5D6B'),
            paletteBadge('Algae', kTidepoolAlgae, '#7BA05B'),
            paletteBadge('Shell', kTidepoolShell, '#FFE3D8'),
            paletteBadge('Ink', kTidepoolInk, '#14202B'),
          ],
        ),
      ],
    ),
  );
}

// ---------------- Why pitch card ----------------
Widget pitchBullet(IconData icon, String title, String body, Color accent) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: kTidepoolMist, width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kTidepoolInk.withValues(alpha: 0.06),
          blurRadius: 5.0,
          offset: const Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 42.0,
          height: 42.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: accent.withValues(alpha: 0.40)),
          ),
          child: Icon(icon, color: accent, size: 22.0),
        ),
        const SizedBox(width: 14.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 15.0,
                  color: kTidepoolInk,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                body,
                style: TextStyle(
                  fontSize: 13.0,
                  height: 1.45,
                  color: kTidepoolStorm.withValues(alpha: 0.95),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildPitch() {
  return Container(
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: kTidepoolMist,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: kTidepoolTeal.withValues(alpha: 0.20)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 14.0,
            vertical: 10.0,
          ),
          decoration: BoxDecoration(
            color: kTidepoolCoral,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const Text(
            'SCENARIO: Android low-memory process death',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 13.0,
              letterSpacing: 0.4,
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        const Text(
          'Your user is filling out a long form, then takes a phone call '
          'or switches to maps. Android decides your app is the next '
          'candidate for eviction and kills the process. When the user '
          'taps your icon again the OS reports "you were here" and '
          'expects to find their cursor exactly where they left it. '
          'Without restoration, every input field, scroll position, and '
          'navigator route is gone.',
          style: TextStyle(
            fontSize: 13.5,
            height: 1.55,
            color: kTidepoolInk,
          ),
        ),
        const SizedBox(height: 16.0),
        pitchBullet(
          Icons.memory,
          'Process death is silent',
          'Unlike orientation changes, the process is killed without a '
          'lifecycle warning. Only the OS-managed restoration bucket '
          'survives.',
          kTidepoolCoral,
        ),
        pitchBullet(
          Icons.account_tree,
          'Tree-shaped restoration data',
          'Each RestorationScope owns a bucket; child scopes own '
          'sub-buckets. The shape mirrors your widget tree so each '
          'state piece can find its slot.',
          kTidepoolTeal,
        ),
        pitchBullet(
          Icons.fingerprint,
          'Stable IDs are mandatory',
          'A scope or value must have a non-null restorationId for the '
          'platform to know where to write its bytes. A null id quietly '
          'disables restoration for that subtree.',
          kTidepoolKelp,
        ),
        pitchBullet(
          Icons.shield_outlined,
          'Only primitives travel',
          'Buckets store StandardMessageCodec-compatible values: '
          'numbers, strings, bools, lists, maps. Complex objects must '
          'be serialized to and from these primitives.',
          kTidepoolDriftwood,
        ),
      ],
    ),
  );
}

// ---------------- Tree schematic ----------------
Widget treeNode(
  String label,
  String id,
  Color color,
  double indent, {
  bool isRoot = false,
  bool isLeaf = false,
}) {
  return Padding(
    padding: EdgeInsets.only(left: indent, top: 4.0, bottom: 4.0),
    child: Row(
      children: <Widget>[
        Container(
          width: 10.0,
          height: 10.0,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8.0),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 8.0,
          ),
          decoration: BoxDecoration(
            color: isLeaf ? Colors.white : color.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: color.withValues(alpha: isRoot ? 1.0 : 0.55),
              width: isRoot ? 2.0 : 1.0,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: isLeaf ? kTidepoolInk : color,
                  fontSize: 13.0,
                ),
              ),
              const SizedBox(width: 8.0),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6.0,
                  vertical: 2.0,
                ),
                decoration: BoxDecoration(
                  color: kTidepoolInk.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  id,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.0,
                    color: kTidepoolInk,
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

Widget buildTreeSchematic() {
  return Container(
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: kTidepoolTeal.withValues(alpha: 0.20)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kTidepoolInk.withValues(alpha: 0.05),
          blurRadius: 6.0,
          offset: const Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'A typical RestorationScope tree',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 16.0,
            color: kTidepoolInk,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          'Each node owns a bucket; child buckets are keyed by '
          'restorationId.',
          style: TextStyle(
            fontSize: 12.5,
            height: 1.45,
            color: kTidepoolStorm.withValues(alpha: 0.95),
          ),
        ),
        const SizedBox(height: 14.0),
        treeNode(
          'RootRestorationScope',
          'app',
          kTidepoolDeep,
          0.0,
          isRoot: true,
        ),
        treeNode(
          'RestorationScope',
          'home',
          kTidepoolTeal,
          24.0,
        ),
        treeNode(
          'RestorableTextEditingController',
          'name',
          kTidepoolCoral,
          48.0,
          isLeaf: true,
        ),
        treeNode(
          'RestorableInt',
          'tab_index',
          kTidepoolCoral,
          48.0,
          isLeaf: true,
        ),
        treeNode(
          'RestorableBool',
          'expanded',
          kTidepoolCoral,
          48.0,
          isLeaf: true,
        ),
        treeNode(
          'RestorationScope',
          'detail',
          kTidepoolTeal,
          24.0,
        ),
        treeNode(
          'RestorableEnum',
          'sort_mode',
          kTidepoolCoral,
          48.0,
          isLeaf: true,
        ),
        treeNode(
          'RestorableDateTime',
          'last_seen',
          kTidepoolCoral,
          48.0,
          isLeaf: true,
        ),
        treeNode(
          'RestorationScope',
          'editor',
          kTidepoolTeal,
          48.0,
        ),
        treeNode(
          'RestorableString',
          'draft',
          kTidepoolCoral,
          72.0,
          isLeaf: true,
        ),
        treeNode(
          'RestorableDouble',
          'zoom',
          kTidepoolCoral,
          72.0,
          isLeaf: true,
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: kTidepoolMist,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const Text(
            'Read this as a path: app/home/name, app/home/detail/editor/draft. '
            'Those exact strings are how the platform finds bytes after a '
            'cold relaunch.',
            style: TextStyle(
              fontSize: 12.0,
              color: kTidepoolInk,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------- Restorable type card ----------------
Widget restorableCard({
  required String type,
  required String initial,
  required String use,
  required IconData icon,
  required Color accent,
}) {
  return Container(
    width: 290.0,
    margin: const EdgeInsets.only(right: 12.0, bottom: 12.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: accent.withValues(alpha: 0.55), width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kTidepoolInk.withValues(alpha: 0.06),
          blurRadius: 5.0,
          offset: const Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 38.0,
              height: 38.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(icon, color: accent, size: 20.0),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                type,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 14.0,
                  color: kTidepoolInk,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 6.0,
          ),
          width: double.infinity,
          decoration: BoxDecoration(
            color: kTidepoolMist,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'INITIAL',
                style: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.w700,
                  color: kTidepoolStorm.withValues(alpha: 0.85),
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                initial,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  color: kTidepoolInk,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        Text(
          use,
          style: TextStyle(
            fontSize: 12.0,
            height: 1.45,
            color: kTidepoolStorm.withValues(alpha: 0.95),
          ),
        ),
      ],
    ),
  );
}

Widget buildRestorableGallery() {
  // Try-create concrete instances; never use the result, just demonstrate
  // that the constructors exist and fold any throw into the demo log.
  String log = 'instances created: ';
  try {
    final RestorableInt v = RestorableInt(0);
    log = '$log RestorableInt(${v.value})';
  } catch (e) {
    log = '$log RestorableInt(skip)';
  }
  try {
    final RestorableDouble v = RestorableDouble(0.0);
    log = '$log, RestorableDouble(${v.value})';
  } catch (e) {
    log = '$log, RestorableDouble(skip)';
  }
  try {
    final RestorableString v = RestorableString('');
    log = '$log, RestorableString("${v.value}")';
  } catch (e) {
    log = '$log, RestorableString(skip)';
  }
  try {
    final RestorableBool v = RestorableBool(false);
    log = '$log, RestorableBool(${v.value})';
  } catch (e) {
    log = '$log, RestorableBool(skip)';
  }
  try {
    final RestorableNum<num> v = RestorableNum<num>(0);
    log = '$log, RestorableNum(${v.value})';
  } catch (e) {
    log = '$log, RestorableNum(skip)';
  }
  try {
    final RestorableNumN<num> v = RestorableNumN<num>(0);
    log = '$log, RestorableNumN(${v.value})';
  } catch (e) {
    log = '$log, RestorableNumN(skip)';
  }
  try {
    final RestorableDateTime v = RestorableDateTime(
      DateTime.fromMillisecondsSinceEpoch(0),
    );
    log = '$log, RestorableDateTime(${v.value.toIso8601String()})';
  } catch (e) {
    log = '$log, RestorableDateTime(skip)';
  }

  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: kTidepoolFoam,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: kTidepoolDriftwood.withValues(alpha: 0.30)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Concrete Restorable* value types',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 16.0,
            color: kTidepoolInk,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          'Use these directly — never subclass RestorableValue<T> in this '
          'demo runtime.',
          style: TextStyle(
            fontSize: 12.5,
            height: 1.45,
            color: kTidepoolStorm.withValues(alpha: 0.95),
          ),
        ),
        const SizedBox(height: 14.0),
        Wrap(
          children: <Widget>[
            restorableCard(
              type: 'RestorableInt',
              initial: '0',
              use: 'Counters, indexes, page numbers — anything that maps '
                  'to a single int.',
              icon: Icons.looks_one,
              accent: kTidepoolTeal,
            ),
            restorableCard(
              type: 'RestorableDouble',
              initial: '0.0',
              use: 'Sliders, zoom factors, scroll offsets, animation '
                  'positions saved as a double.',
              icon: Icons.linear_scale,
              accent: kTidepoolCoral,
            ),
            restorableCard(
              type: 'RestorableString',
              initial: '""',
              use: 'Search queries, filter strings, draft titles, any '
                  'short non-controller text.',
              icon: Icons.text_fields,
              accent: kTidepoolKelp,
            ),
            restorableCard(
              type: 'RestorableBool',
              initial: 'false',
              use: 'Toggle switches, expansion flags, "do not show '
                  'again" preferences.',
              icon: Icons.toggle_on,
              accent: kTidepoolDriftwood,
            ),
            restorableCard(
              type: 'RestorableNum<num>',
              initial: '0',
              use: 'Generic numeric storage where int/double dynamic — '
                  'rarely needed directly.',
              icon: Icons.calculate,
              accent: kTidepoolStorm,
            ),
            restorableCard(
              type: 'RestorableNumN<num>',
              initial: 'null',
              use: 'Nullable numeric value. The trailing N marks "may '
                  'be null" — distinguishes from RestorableNum.',
              icon: Icons.do_not_disturb_alt,
              accent: kTidepoolAlgae,
            ),
            restorableCard(
              type: 'RestorableDateTime',
              initial: 'epoch',
              use: 'Timestamps, scheduled dates, last-modified anchors. '
                  'Stored as int millis under the hood.',
              icon: Icons.calendar_today,
              accent: kTidepoolDeep,
            ),
            restorableCard(
              type: 'RestorableEnum<E>',
              initial: 'enum.values[0]',
              use: 'Persists an enum constant by name. Must declare the '
                  'full enum.values list to the constructor.',
              icon: Icons.list_alt,
              accent: kTidepoolCoral,
            ),
            restorableCard(
              type: 'RestorableTextEditingController',
              initial: '"" controller',
              use: 'Owns a TextEditingController and saves its text. '
                  'Use registerForRestoration in a stateful host.',
              icon: Icons.edit_note,
              accent: kTidepoolTeal,
            ),
            restorableCard(
              type: 'RestorableRouteFuture<T>',
              initial: 'route key',
              use: 'Survives a pushed route across restoration so the '
                  'caller can still receive the dialog result.',
              icon: Icons.alt_route,
              accent: kTidepoolKelp,
            ),
            restorableCard(
              type: 'RestorableIntN',
              initial: 'null',
              use: 'Nullable int. Useful when "no selection yet" must '
                  'survive restart.',
              icon: Icons.help_outline,
              accent: kTidepoolDriftwood,
            ),
            restorableCard(
              type: 'RestorableDoubleN',
              initial: 'null',
              use: 'Nullable double. Same idea as IntN for floating '
                  'point values.',
              icon: Icons.percent,
              accent: kTidepoolStorm,
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: kTidepoolMist,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: kTidepoolTeal.withValues(alpha: 0.30),
            ),
          ),
          child: Text(
            log,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: kTidepoolInk,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------- Lifecycle timeline ----------------
Widget timelineStep({
  required String index,
  required String title,
  required String description,
  required IconData icon,
  required Color color,
  required bool isLast,
}) {
  return IntrinsicHeight(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              width: 44.0,
              height: 44.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(22.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: color.withValues(alpha: 0.45),
                    blurRadius: 8.0,
                    offset: const Offset(0.0, 3.0),
                  ),
                ],
              ),
              child: Icon(icon, color: Colors.white, size: 22.0),
            ),
            if (!isLast)
              Expanded(
                child: Container(
                  width: 3.0,
                  margin: const EdgeInsets.symmetric(vertical: 4.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[
                        color,
                        color.withValues(alpha: 0.20),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 16.0),
            padding: const EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: color.withValues(alpha: 0.40)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: kTidepoolInk.withValues(alpha: 0.05),
                  blurRadius: 4.0,
                  offset: const Offset(0.0, 2.0),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 3.0,
                      ),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Text(
                        index,
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.w800,
                          fontSize: 11.0,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 14.0,
                          color: kTidepoolInk,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12.5,
                    height: 1.5,
                    color: kTidepoolStorm.withValues(alpha: 0.95),
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

Widget buildLifecycle() {
  return Container(
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: kTidepoolMist,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: kTidepoolDeep.withValues(alpha: 0.20)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'The state restoration lifecycle',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 16.0,
            color: kTidepoolInk,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          'From running to relaunched, with an OS-managed bucket bridging '
          'the two halves.',
          style: TextStyle(
            fontSize: 12.5,
            height: 1.45,
            color: kTidepoolStorm.withValues(alpha: 0.95),
          ),
        ),
        const SizedBox(height: 16.0),
        timelineStep(
          index: '01',
          title: 'App is running',
          description: 'The widget tree is alive. Restorable* values are '
              'registered with their RestorationMixin host and tracked '
              'inside the relevant RestorationBucket.',
          icon: Icons.play_arrow,
          color: kTidepoolKelp,
          isLast: false,
        ),
        timelineStep(
          index: '02',
          title: 'App goes to background',
          description: 'User switches apps or the screen turns off. '
              'Flutter signals the engine; the engine asks the platform '
              'channel for a serialization pass.',
          icon: Icons.pause,
          color: kTidepoolStorm,
          isLast: false,
        ),
        timelineStep(
          index: '03',
          title: 'Bucket serialized',
          description: 'Each Restorable value writes its current value '
              'into its slot. Buckets become a tree of maps that the '
              'StandardMessageCodec encodes to bytes.',
          icon: Icons.save,
          color: kTidepoolTeal,
          isLast: false,
        ),
        timelineStep(
          index: '04',
          title: 'OS hands bytes to platform store',
          description: 'On Android the bytes ride along with the '
              'Activity bundle; on iOS they are stored against the '
              'state-restoration archive identifier.',
          icon: Icons.storage,
          color: kTidepoolDriftwood,
          isLast: false,
        ),
        timelineStep(
          index: '05',
          title: 'Process killed',
          description: 'Memory is reclaimed. All Dart objects, all '
              'Flutter widgets, all Restorable values are gone. Only '
              'the serialized bucket survives in the platform layer.',
          icon: Icons.power_settings_new,
          color: kTidepoolCoral,
          isLast: false,
        ),
        timelineStep(
          index: '06',
          title: 'User relaunches',
          description: 'The OS rebuilds the activity, hands the saved '
              'bytes back to Flutter as the initial restoration data, '
              'and the engine signals "have a bucket, please rebuild".',
          icon: Icons.refresh,
          color: kTidepoolAlgae,
          isLast: false,
        ),
        timelineStep(
          index: '07',
          title: 'RootRestorationScope claims it',
          description: 'The RootRestorationScope at the top of the tree '
              'takes the deserialized bucket and exposes it via '
              'UnmanagedRestorationScope to its descendants.',
          icon: Icons.account_tree,
          color: kTidepoolDeep,
          isLast: false,
        ),
        timelineStep(
          index: '08',
          title: 'Each RestorationScope finds its slot',
          description: 'Children look up their restorationId inside the '
              'parent bucket. Missing ids mean "fresh state". Found ids '
              'feed values back into their Restorable* objects.',
          icon: Icons.search,
          color: kTidepoolTeal,
          isLast: false,
        ),
        timelineStep(
          index: '09',
          title: 'State restored',
          description: 'Every Restorable* delivers its prior value. '
              'TextEditingControllers re-show their text, sliders snap '
              'back, expanded panels stay expanded. The user notices '
              'nothing.',
          icon: Icons.check_circle,
          color: kTidepoolKelp,
          isLast: true,
        ),
      ],
    ),
  );
}

// ---------------- Code card (string-only) ----------------
Widget codeLine(String text, {Color color = kTidepoolFoam}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 1.0),
    child: Text(
      text,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 12.5,
        color: color,
        height: 1.55,
      ),
    ),
  );
}

Widget buildMixinCodeCard() {
  return Container(
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: kTidepoolInk,
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kTidepoolInk.withValues(alpha: 0.45),
          blurRadius: 12.0,
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
              width: 12.0,
              height: 12.0,
              decoration: const BoxDecoration(
                color: kTidepoolCoral,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6.0),
            Container(
              width: 12.0,
              height: 12.0,
              decoration: const BoxDecoration(
                color: kTidepoolSand,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6.0),
            Container(
              width: 12.0,
              height: 12.0,
              decoration: const BoxDecoration(
                color: kTidepoolAlgae,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 12.0),
            Text(
              'reference_only.dart',
              style: TextStyle(
                color: kTidepoolSand.withValues(alpha: 0.85),
                fontFamily: 'monospace',
                fontSize: 12.0,
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 3.0,
              ),
              decoration: BoxDecoration(
                color: kTidepoolCoral.withValues(alpha: 0.30),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: const Text(
                'NOT EXECUTED',
                style: TextStyle(
                  color: kTidepoolFoam,
                  fontWeight: FontWeight.w800,
                  fontSize: 10.0,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        codeLine('// The classic RestorationMixin pattern.',
            color: kTidepoolSand.withValues(alpha: 0.75)),
        codeLine('// Shown as a string literal — this demo never',
            color: kTidepoolSand.withValues(alpha: 0.75)),
        codeLine('// subclasses State or mixes in RestorationMixin.',
            color: kTidepoolSand.withValues(alpha: 0.75)),
        const SizedBox(height: 6.0),
        codeLine('class _CounterPageState extends State<CounterPage>'),
        codeLine('    with RestorationMixin {'),
        codeLine('  final RestorableInt _count = RestorableInt(0);',
            color: kTidepoolFoam),
        codeLine('  final RestorableString _label =',
            color: kTidepoolFoam),
        codeLine('      RestorableString(\'\');', color: kTidepoolFoam),
        const SizedBox(height: 6.0),
        codeLine('  @override',
            color: kTidepoolAlgae),
        codeLine('  String get restorationId => \'counter_page\';',
            color: kTidepoolFoam),
        const SizedBox(height: 6.0),
        codeLine('  @override', color: kTidepoolAlgae),
        codeLine('  void restoreState('),
        codeLine('      RestorationBucket? oldBucket, bool initialRestore) {'),
        codeLine('    registerForRestoration(_count, \'count\');'),
        codeLine('    registerForRestoration(_label, \'label\');'),
        codeLine('  }'),
        const SizedBox(height: 6.0),
        codeLine('  @override', color: kTidepoolAlgae),
        codeLine('  void dispose() {'),
        codeLine('    _count.dispose();'),
        codeLine('    _label.dispose();'),
        codeLine('    super.dispose();'),
        codeLine('  }'),
        const SizedBox(height: 6.0),
        codeLine('  @override', color: kTidepoolAlgae),
        codeLine('  Widget build(BuildContext context) {'),
        codeLine('    return Text(\'\${_count.value}: \${_label.value}\');'),
        codeLine('  }'),
        codeLine('}'),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: kTidepoolStorm.withValues(alpha: 0.40),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'restoreState fires once at first registration and again '
            'whenever a different bucket is handed in. Ids you pass to '
            'registerForRestoration must be unique within the host.',
            style: TextStyle(
              color: kTidepoolFoam.withValues(alpha: 0.90),
              fontSize: 11.5,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------- Bucket diagram ----------------
Widget bucketBlock(
  String title,
  String contents,
  Color color, {
  bool isRoot = false,
}) {
  return Container(
    width: 230.0,
    margin: const EdgeInsets.only(right: 12.0, bottom: 12.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.10),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(
        color: color,
        width: isRoot ? 2.5 : 1.5,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.inbox, color: kTidepoolInk, size: 18.0),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 13.0,
                  color: kTidepoolInk,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: color.withValues(alpha: 0.55)),
          ),
          child: Text(
            contents,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: kTidepoolInk,
              height: 1.55,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildBucketDiagram() {
  return Container(
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: kTidepoolFoam,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: kTidepoolKelp.withValues(alpha: 0.30)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'RestorationBucket — the wire format',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 16.0,
            color: kTidepoolInk,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          'Conceptually, every bucket is a (values, children) pair. The '
          'whole tree is a Map<String, Object?> when serialized.',
          style: TextStyle(
            fontSize: 12.5,
            height: 1.45,
            color: kTidepoolStorm.withValues(alpha: 0.95),
          ),
        ),
        const SizedBox(height: 14.0),
        Wrap(
          children: <Widget>[
            bucketBlock(
              'root_bucket',
              'values: { app_theme: \'dark\' }\n'
                  'children:\n'
                  '  home -> {...}\n'
                  '  detail -> {...}',
              kTidepoolDeep,
              isRoot: true,
            ),
            bucketBlock(
              'home',
              'values: {\n'
                  '  tab_index: 2,\n'
                  '  expanded: true,\n'
                  '}\n'
                  'children:\n'
                  '  search -> {...}',
              kTidepoolTeal,
            ),
            bucketBlock(
              'detail',
              'values: {\n'
                  '  sort_mode: \'date\',\n'
                  '  last_seen: 1714900000000,\n'
                  '}\n'
                  'children:\n'
                  '  editor -> {...}',
              kTidepoolCoral,
            ),
            bucketBlock(
              'search',
              'values: {\n'
                  '  query: \'tide\',\n'
                  '  filter_count: 3,\n'
                  '}',
              kTidepoolKelp,
            ),
            bucketBlock(
              'editor',
              'values: {\n'
                  '  draft: \'Hello world\',\n'
                  '  zoom: 1.25,\n'
                  '}',
              kTidepoolDriftwood,
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: kTidepoolStorm.withValues(alpha: 0.30)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                'Bucket invariants',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 13.0,
                  color: kTidepoolInk,
                ),
              ),
              const SizedBox(height: 6.0),
              Text(
                '- Each child key inside a bucket is unique.\n'
                '- Each registered Restorable id inside a host is unique.\n'
                '- Values must be StandardMessageCodec-encodable.\n'
                '- Buckets can be claimed and released — Restorable* '
                'objects keep a stable reference even when the bucket '
                'is replaced under them.',
                style: TextStyle(
                  fontSize: 12.0,
                  height: 1.55,
                  color: kTidepoolStorm.withValues(alpha: 0.95),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------- Comparison table ----------------
Widget compareCell(String text, {bool header = false, Color? bg}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: bg ?? (header ? kTidepoolDeep : Colors.white),
      border: Border.all(
        color: kTidepoolMist,
        width: 1.0,
      ),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 12.0,
        fontWeight: header ? FontWeight.w800 : FontWeight.w400,
        color: header ? Colors.white : kTidepoolInk,
        height: 1.4,
      ),
    ),
  );
}

Widget buildComparisonTable() {
  Widget row(List<String> cells, {bool header = false, Color? bg}) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 3,
          child: compareCell(cells[0], header: header, bg: bg),
        ),
        Expanded(
          flex: 4,
          child: compareCell(cells[1], header: header, bg: bg),
        ),
        Expanded(
          flex: 4,
          child: compareCell(cells[2], header: header, bg: bg),
        ),
        Expanded(
          flex: 4,
          child: compareCell(cells[3], header: header, bg: bg),
        ),
      ],
    );
  }

  return Container(
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: kTidepoolTeal.withValues(alpha: 0.20)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'RestorableValue vs ValueNotifier vs ChangeNotifier',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 16.0,
            color: kTidepoolInk,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          'Three notifier-shaped patterns; only one of them survives a '
          'process kill.',
          style: TextStyle(
            fontSize: 12.5,
            height: 1.45,
            color: kTidepoolStorm.withValues(alpha: 0.95),
          ),
        ),
        const SizedBox(height: 14.0),
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Column(
            children: <Widget>[
              row(
                <String>[
                  'Aspect',
                  'RestorableValue<T>',
                  'ValueNotifier<T>',
                  'ChangeNotifier',
                ],
                header: true,
              ),
              row(<String>[
                'Survives process death',
                'Yes — registered with bucket',
                'No — pure Dart object',
                'No — pure Dart object',
              ]),
              row(
                <String>[
                  'Has a value',
                  'Yes — typed T',
                  'Yes — typed T',
                  'No — bring your own',
                ],
                bg: kTidepoolMist,
              ),
              row(<String>[
                'Notifies listeners',
                'Yes (via Listenable)',
                'Yes',
                'Yes (manual notifyListeners)',
              ]),
              row(
                <String>[
                  'Requires restorationId',
                  'Yes — at register time',
                  'No',
                  'No',
                ],
                bg: kTidepoolMist,
              ),
              row(<String>[
                'Disposed by host',
                'Yes — must call .dispose()',
                'Yes',
                'Yes',
              ]),
              row(
                <String>[
                  'Serialization codec',
                  'StandardMessageCodec',
                  'n/a',
                  'n/a',
                ],
                bg: kTidepoolMist,
              ),
              row(<String>[
                'Initial value source',
                'Constructor or restored bucket',
                'Constructor only',
                'Constructor only',
              ]),
              row(
                <String>[
                  'Typical owner',
                  'RestorationMixin host',
                  'StatefulWidget',
                  'StatefulWidget',
                ],
                bg: kTidepoolMist,
              ),
              row(<String>[
                'Restoration scope',
                'Tied to bucket lookup',
                'No notion of scope',
                'No notion of scope',
              ]),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------- Reference list ----------------
Widget referenceRow(String name, String summary, IconData icon) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8.0),
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: kTidepoolMist),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, color: kTidepoolTeal, size: 18.0),
        const SizedBox(width: 12.0),
        Expanded(
          flex: 4,
          child: Text(
            name,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
              fontSize: 12.5,
              color: kTidepoolInk,
            ),
          ),
        ),
        Expanded(
          flex: 7,
          child: Text(
            summary,
            style: TextStyle(
              fontSize: 12.0,
              height: 1.45,
              color: kTidepoolStorm.withValues(alpha: 0.95),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildReference() {
  return Container(
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: kTidepoolMist,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: kTidepoolTeal.withValues(alpha: 0.20)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Restoration API reference',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 16.0,
            color: kTidepoolInk,
          ),
        ),
        const SizedBox(height: 12.0),
        referenceRow(
          'RestorationScope',
          'Inserts a named restoration bucket as a child of the surrounding '
          'scope. Use restorationId to pick the slot inside the parent '
          'bucket.',
          Icons.account_tree_outlined,
        ),
        referenceRow(
          'RootRestorationScope',
          'Top-of-tree variant that gathers the initial bucket from the '
          'engine. Place it once near MaterialApp.',
          Icons.flag_outlined,
        ),
        referenceRow(
          'UnmanagedRestorationScope',
          'Inserts a bucket directly without claiming a slot. Useful when '
          'the bucket is owned externally — for example by a route.',
          Icons.layers_outlined,
        ),
        referenceRow(
          'RestorationBucket',
          'Container of (values, children). Buckets can be claimed, '
          'renamed, and adopted. Buckets are not widgets.',
          Icons.inbox,
        ),
        referenceRow(
          'RestorationMixin',
          'State mixin that hosts Restorable* fields. Provides '
          'restorationId, restoreState, and registerForRestoration.',
          Icons.extension_outlined,
        ),
        referenceRow(
          'RestorableValue<T>',
          'Abstract base for serializable, listenable, restorable values. '
          'Demo runtime uses concrete subclasses only.',
          Icons.functions,
        ),
        referenceRow(
          'RestorableProperty<T>',
          'Even more abstract base used by the controller variants. Holds '
          'a property without exposing it via .value.',
          Icons.settings_ethernet,
        ),
        referenceRow(
          'RestorableInt',
          'Concrete RestorableValue<int>. Serialized as a single integer.',
          Icons.looks_one,
        ),
        referenceRow(
          'RestorableIntN',
          'Nullable counterpart of RestorableInt. Stores int? values.',
          Icons.help_outline,
        ),
        referenceRow(
          'RestorableDouble',
          'Concrete RestorableValue<double>. Serialized as a double.',
          Icons.linear_scale,
        ),
        referenceRow(
          'RestorableDoubleN',
          'Nullable counterpart of RestorableDouble. Stores double?.',
          Icons.percent,
        ),
        referenceRow(
          'RestorableNum<T extends num>',
          'Numeric value parameterized by num subtype. Picks codec based '
          'on actual runtime type.',
          Icons.calculate,
        ),
        referenceRow(
          'RestorableNumN<T extends num?>',
          'Nullable numeric value. Convenient when "no number yet" is '
          'meaningful state.',
          Icons.do_not_disturb_alt,
        ),
        referenceRow(
          'RestorableString',
          'Concrete RestorableValue<String>. Empty string by default.',
          Icons.text_fields,
        ),
        referenceRow(
          'RestorableStringN',
          'Nullable RestorableValue<String?>. Disambiguates "empty" from '
          '"unset".',
          Icons.text_format,
        ),
        referenceRow(
          'RestorableBool',
          'Concrete RestorableValue<bool>. Common for toggles and flags.',
          Icons.toggle_on,
        ),
        referenceRow(
          'RestorableBoolN',
          'Nullable bool. Lets a tri-state toggle survive restart.',
          Icons.toggle_off,
        ),
        referenceRow(
          'RestorableDateTime',
          'Stores a DateTime as int millisecondsSinceEpoch under the hood.',
          Icons.calendar_today,
        ),
        referenceRow(
          'RestorableEnum<E extends Enum>',
          'Stores an enum constant by name; constructor needs the full '
          'values list to look it back up.',
          Icons.list_alt,
        ),
        referenceRow(
          'RestorableEnumN<E extends Enum?>',
          'Nullable enum. Same lookup mechanism as RestorableEnum.',
          Icons.list_outlined,
        ),
        referenceRow(
          'RestorableTextEditingController',
          'Wraps a TextEditingController and persists its text. Created '
          'via RestorableTextEditingController(text: ...).',
          Icons.edit_note,
        ),
        referenceRow(
          'RestorableRouteFuture<T>',
          'Persists a pushed Navigator route across restoration so the '
          'eventual result still reaches the caller.',
          Icons.alt_route,
        ),
        referenceRow(
          'RestorableListenable<T>',
          'Internal helper for property-style restorables; rarely used '
          'directly outside the framework.',
          Icons.podcasts,
        ),
        referenceRow(
          'RestorationManager',
          'The bridge to the platform channel. Surfaces the root bucket '
          'and reports updates back. Lives behind '
          'WidgetsBinding.instance.restorationManager.',
          Icons.settings_input_component,
        ),
      ],
    ),
  );
}

// ---------------- Edge cases ----------------
Widget edgeCard({
  required String title,
  required String body,
  required IconData icon,
  required Color color,
}) {
  return Container(
    width: 290.0,
    margin: const EdgeInsets.only(right: 12.0, bottom: 12.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 36.0,
              height: 36.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(icon, color: Colors.white, size: 20.0),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 14.0,
                  color: kTidepoolInk,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Text(
          body,
          style: TextStyle(
            fontSize: 12.0,
            height: 1.5,
            color: kTidepoolStorm.withValues(alpha: 0.95),
          ),
        ),
      ],
    ),
  );
}

Widget buildEdgeCases() {
  return Container(
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: kTidepoolFoam,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: kTidepoolDriftwood.withValues(alpha: 0.30)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Edge cases and footguns',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 16.0,
            color: kTidepoolInk,
          ),
        ),
        const SizedBox(height: 12.0),
        Wrap(
          children: <Widget>[
            edgeCard(
              title: 'Null restorationId disables it',
              body: 'A RestorationScope with a null restorationId becomes a '
                  'pass-through. Children that look for a bucket get '
                  'nothing back. Restoration silently turns off for that '
                  'subtree.',
              icon: Icons.power_off,
              color: kTidepoolCoral,
            ),
            edgeCard(
              title: 'Conflicting restorationIds',
              body: 'Two siblings sharing one id corrupt their shared slot. '
                  'Flutter asserts in debug; in release the second sibling '
                  'overwrites the first.',
              icon: Icons.warning_amber_rounded,
              color: kTidepoolDriftwood,
            ),
            edgeCard(
              title: 'Renaming an id breaks history',
              body: 'Restoration data is keyed by id, so renaming after a '
                  'release means existing users come back to a fresh '
                  'state for that field. Treat ids as a public contract.',
              icon: Icons.history,
              color: kTidepoolStorm,
            ),
            edgeCard(
              title: 'Forgetting to dispose',
              body: 'Restorable* objects own listeners. Always call '
                  '.dispose() in your State.dispose() or you leak the '
                  'subscription back to the bucket.',
              icon: Icons.delete_outline,
              color: kTidepoolKelp,
            ),
            edgeCard(
              title: 'No RootRestorationScope',
              body: 'Without one near the top of the tree the framework '
                  'never receives the initial bucket. Children built '
                  'without a root scope behave as if restoration is off.',
              icon: Icons.flag_outlined,
              color: kTidepoolTeal,
            ),
            edgeCard(
              title: 'restorationScopeId on MaterialApp',
              body: 'Setting MaterialApp.restorationScopeId is the easiest '
                  'way to install a RootRestorationScope; you do not '
                  'usually wire one by hand.',
              icon: Icons.app_settings_alt,
              color: kTidepoolDeep,
            ),
            edgeCard(
              title: 'Big payloads are bad',
              body: 'Buckets are not designed for blobs. If you stash an '
                  'image or a long text into a Restorable*, expect slow '
                  'serialization and OS-imposed size caps.',
              icon: Icons.warning,
              color: kTidepoolCoral,
            ),
            edgeCard(
              title: 'Async values',
              body: 'A RestorableValue resolves synchronously. If your '
                  'real state is async, persist a small token and re-fetch '
                  'on relaunch using that token.',
              icon: Icons.hourglass_empty,
              color: kTidepoolAlgae,
            ),
            edgeCard(
              title: 'Hot reload vs restoration',
              body: 'Hot reload preserves Dart objects and never goes '
                  'through the bucket. Test restoration by killing the '
                  'process, not by reloading.',
              icon: Icons.local_fire_department,
              color: kTidepoolDriftwood,
            ),
            edgeCard(
              title: 'Restoration is opt-in',
              body: 'Even with all scopes wired, a Restorable* that is '
                  'never registered behaves as a plain notifier. Always '
                  'pair construction with registerForRestoration.',
              icon: Icons.toggle_off,
              color: kTidepoolStorm,
            ),
            edgeCard(
              title: 'Nested scopes are namespaces',
              body: 'A RestorationScope inside another scope adds its '
                  'restorationId as a path component. Same id at '
                  'different depths is fine.',
              icon: Icons.layers,
              color: kTidepoolTeal,
            ),
            edgeCard(
              title: 'Values must be codec-friendly',
              body: 'Maps, Lists, ints, doubles, bools, strings, '
                  'Uint8List, ByteData. A custom class will throw at '
                  'serialization time.',
              icon: Icons.code,
              color: kTidepoolKelp,
            ),
          ],
        ),
      ],
    ),
  );
}

// ---------------- Construction probes ----------------
Widget probeRow(String label, String result, bool ok) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8.0),
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(
        color: ok
            ? kTidepoolKelp.withValues(alpha: 0.55)
            : kTidepoolCoral.withValues(alpha: 0.55),
      ),
    ),
    child: Row(
      children: <Widget>[
        Icon(
          ok ? Icons.check_circle : Icons.error,
          color: ok ? kTidepoolKelp : kTidepoolCoral,
          size: 18.0,
        ),
        const SizedBox(width: 10.0),
        Expanded(
          flex: 3,
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
              fontSize: 12.0,
              color: kTidepoolInk,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            result,
            style: TextStyle(
              fontSize: 12.0,
              color: kTidepoolStorm.withValues(alpha: 0.95),
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildConstructionProbes() {
  // Carefully wrap every constructor that might throw.
  final List<Widget> rows = <Widget>[];

  // RestorationScope (widget) — try to construct.
  try {
    final RestorationScope scope = const RestorationScope(
      restorationId: 'probe_scope',
      child: SizedBox.shrink(),
    );
    rows.add(probeRow(
      'RestorationScope',
      'constructed (id=probe_scope, runtimeType=${scope.runtimeType})',
      true,
    ));
  } catch (e) {
    rows.add(probeRow('RestorationScope', 'threw: $e', false));
  }

  // RootRestorationScope.
  try {
    final RootRestorationScope root = const RootRestorationScope(
      restorationId: 'probe_root',
      child: SizedBox.shrink(),
    );
    rows.add(probeRow(
      'RootRestorationScope',
      'constructed (id=probe_root, runtimeType=${root.runtimeType})',
      true,
    ));
  } catch (e) {
    rows.add(probeRow('RootRestorationScope', 'threw: $e', false));
  }

  // UnmanagedRestorationScope is rarely used standalone but the
  // constructor itself is cheap.
  try {
    // Bucket can legitimately be null; we pass null to avoid touching the
    // RestorationManager from a top-level demo.
    final UnmanagedRestorationScope unmanaged =
        const UnmanagedRestorationScope(
      bucket: null,
      child: SizedBox.shrink(),
    );
    rows.add(probeRow(
      'UnmanagedRestorationScope',
      'constructed (bucket=null, runtimeType=${unmanaged.runtimeType})',
      true,
    ));
  } catch (e) {
    rows.add(probeRow('UnmanagedRestorationScope', 'threw: $e', false));
  }

  // Concrete Restorable*.
  try {
    final RestorableInt v = RestorableInt(7);
    rows.add(probeRow('RestorableInt', 'value=${v.value}', true));
  } catch (e) {
    rows.add(probeRow('RestorableInt', 'threw: $e', false));
  }
  try {
    final RestorableDouble v = RestorableDouble(3.14);
    rows.add(probeRow('RestorableDouble', 'value=${v.value}', true));
  } catch (e) {
    rows.add(probeRow('RestorableDouble', 'threw: $e', false));
  }
  try {
    final RestorableString v = RestorableString('seed');
    rows.add(probeRow('RestorableString', 'value=${v.value}', true));
  } catch (e) {
    rows.add(probeRow('RestorableString', 'threw: $e', false));
  }
  try {
    final RestorableBool v = RestorableBool(true);
    rows.add(probeRow('RestorableBool', 'value=${v.value}', true));
  } catch (e) {
    rows.add(probeRow('RestorableBool', 'threw: $e', false));
  }
  try {
    final RestorableNum<num> v = RestorableNum<num>(11);
    rows.add(probeRow('RestorableNum<num>', 'value=${v.value}', true));
  } catch (e) {
    rows.add(probeRow('RestorableNum<num>', 'threw: $e', false));
  }
  try {
    final RestorableNumN<num> v = RestorableNumN<num>(0);
    rows.add(probeRow('RestorableNumN<num>', 'value=${v.value}', true));
  } catch (e) {
    rows.add(probeRow('RestorableNumN<num>', 'threw: $e', false));
  }
  try {
    final RestorableDateTime v = RestorableDateTime(
      DateTime.utc(2026, 5, 5),
    );
    rows.add(probeRow(
      'RestorableDateTime',
      'value=${v.value.toIso8601String()}',
      true,
    ));
  } catch (e) {
    rows.add(probeRow('RestorableDateTime', 'threw: $e', false));
  }

  // RestorationManager — read-only sanity probe; do not touch buckets.
  try {
    final RestorationManager manager = RestorationManager();
    rows.add(probeRow(
      'RestorationManager',
      'constructed (runtimeType=${manager.runtimeType})',
      true,
    ));
  } catch (e) {
    rows.add(probeRow('RestorationManager', 'threw: $e', false));
  }

  return Container(
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: kTidepoolKelp.withValues(alpha: 0.30)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Construction probes (try/catch wrapped)',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 16.0,
            color: kTidepoolInk,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          'Every risky bridged constructor is wrapped — failures fold '
          'into the result row instead of bubbling up.',
          style: TextStyle(
            fontSize: 12.5,
            height: 1.45,
            color: kTidepoolStorm.withValues(alpha: 0.95),
          ),
        ),
        const SizedBox(height: 14.0),
        ...rows,
      ],
    ),
  );
}

// ---------------- Footer ----------------
Widget buildFooter() {
  return Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[kTidepoolInk, kTidepoolDeep],
      ),
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 44.0,
              height: 44.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: kTidepoolCoral,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Icon(
                Icons.bookmark,
                color: Colors.white,
                size: 22.0,
              ),
            ),
            const SizedBox(width: 14.0),
            const Expanded(
              child: Text(
                'Recap — three things to remember',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        _footerBullet(
          '01',
          'Identify boundaries with restorationId. A RestorationScope '
          'is meaningless without one.',
        ),
        _footerBullet(
          '02',
          'Use concrete Restorable* types. They already wire the codec, '
          'the listener plumbing, and the value getter for you.',
        ),
        _footerBullet(
          '03',
          'Treat ids as a versioned schema. Renames break existing '
          'users. Add new ids next to old ones, do not replace them.',
        ),
        const SizedBox(height: 18.0),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 14.0,
            vertical: 10.0,
          ),
          decoration: BoxDecoration(
            color: kTidepoolTeal.withValues(alpha: 0.40),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: kTidepoolSand.withValues(alpha: 0.40),
            ),
          ),
          child: const Text(
            'demo: restoration_scope_test.dart  -  palette: Tidepool',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 12.0,
              fontFamily: 'monospace',
              letterSpacing: 0.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _footerBullet(String num, String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 4.0,
          ),
          decoration: BoxDecoration(
            color: kTidepoolCoral,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Text(
            num,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 11.0,
              fontFamily: 'monospace',
            ),
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: kTidepoolFoam.withValues(alpha: 0.92),
              fontSize: 13.0,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// Build entry point
// =====================================================================
dynamic build(BuildContext context) {
  // Pre-build sanity log (kept for parity with the existing harness style).
  print('RestorationScope deep demo executing');
  print('--- palette: Tidepool ---');
  print('sections: hero, pitch, tree, gallery, lifecycle, code-card, '
      'bucket, comparison, reference, edge-cases, probes, footer');

  // A risky bridged construction up front, wrapped so the demo never
  // fails to render even if something is missing in the bridge.
  RestorationScope? topProbe;
  try {
    topProbe = const RestorationScope(
      restorationId: 'demo_root',
      child: SizedBox.shrink(),
    );
    print('top-level RestorationScope probe ok: ${topProbe.runtimeType}');
  } catch (e) {
    print('top-level RestorationScope probe failed: $e');
  }

  return Scaffold(
    backgroundColor: kTidepoolMist,
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 18.0,
          vertical: 24.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // ----- 1. Hero -----
            buildHero(),

            // ----- 2. Why state restoration -----
            sectionTitle(
              '01',
              'Why state restoration?',
              'Process death is a different beast from configuration changes.',
            ),
            buildPitch(),

            // ----- 3. Tree schematic -----
            sectionTitle(
              '02',
              'Tree schematic',
              'Each scope is a slot in its parent\'s bucket.',
            ),
            buildTreeSchematic(),

            // ----- 4. Gallery of Restorable types -----
            sectionTitle(
              '03',
              'Restorable* gallery',
              'A grid of the concrete types you actually instantiate.',
            ),
            buildRestorableGallery(),

            // ----- 5. Lifecycle -----
            sectionTitle(
              '04',
              'Lifecycle timeline',
              'Running, paused, killed, relaunched, restored.',
            ),
            buildLifecycle(),

            // ----- 6. Code card -----
            sectionTitle(
              '05',
              'RestorationMixin in code (reference only)',
              'Shown as text. The demo never subclasses State.',
            ),
            buildMixinCodeCard(),

            // ----- 7. Bucket diagram -----
            sectionTitle(
              '06',
              'RestorationBucket diagram',
              '(values, children) all the way down.',
            ),
            buildBucketDiagram(),

            // ----- 8. Comparison table -----
            sectionTitle(
              '07',
              'Comparison: Restorable vs ValueNotifier vs ChangeNotifier',
              'Three notifier patterns, one survival strategy.',
            ),
            buildComparisonTable(),

            // ----- 9. Reference list -----
            sectionTitle(
              '08',
              'API reference',
              'Every Restorable* class mentioned in this demo.',
            ),
            buildReference(),

            // ----- 10. Edge cases -----
            sectionTitle(
              '09',
              'Edge cases',
              'The traps that catch first-time restoration users.',
            ),
            buildEdgeCases(),

            // ----- 11. Construction probes -----
            sectionTitle(
              '10',
              'Live construction probes',
              'Try/catch around every bridged constructor.',
            ),
            buildConstructionProbes(),

            // ----- 12. Footer -----
            sectionTitle(
              '11',
              'Recap',
              'Three things you carry into your next restoration story.',
            ),
            buildFooter(),

            const SizedBox(height: 24.0),
          ],
        ),
      ),
    ),
  );
}
