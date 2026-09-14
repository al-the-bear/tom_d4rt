// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
// D4rt test script: Visual deep demo of PopupMenuButton family.
//
// Static snapshot — does not call showMenu live; renders the menu surface
// inline as a styled Container that mimics the actual rendered popup.
import 'package:flutter/material.dart';

// =============================================================================
// SECTION HEADER + COLOR PALETTE
// =============================================================================

class PopDemoPalette {
  static const Color primary = Color(0xFF6750A4);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color secondary = Color(0xFF625B71);
  static const Color tertiary = Color(0xFF7D5260);
  static const Color surface = Color(0xFFFFFBFE);
  static const Color surfaceVariant = Color(0xFFE7E0EC);
  static const Color outline = Color(0xFF79747E);
  static const Color outlineVariant = Color(0xFFCAC4D0);
  static const Color success = Color(0xFF2E7D32);
  static const Color warning = Color(0xFFE65100);
  static const Color danger = Color(0xFFB3261E);
  static const Color info = Color(0xFF1565C0);
  static const Color hero = Color(0xFF311B92);
  static const Color overOpen = Color(0xFF00695C);
  static const Color underOpen = Color(0xFF4527A0);
}

Widget buildSectionHeader(
  String index,
  String title,
  String subtitle,
  IconData icon,
  Color color,
) {
  return Container(
    margin: EdgeInsets.fromLTRB(8, 24, 8, 12),
    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 14),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [color, color.withValues(alpha: 0.72)],
      ),
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.35),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.22),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.white, size: 22),
        ),
        SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      index,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.2,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.92),
                  fontSize: 12.5,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildCaption(String text) {
  return Padding(
    padding: EdgeInsets.fromLTRB(14, 6, 14, 12),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 12.5,
        color: Colors.grey.shade700,
        height: 1.45,
      ),
    ),
  );
}

Widget buildLabelChip(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.14),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withValues(alpha: 0.45)),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 10.5,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.4,
      ),
    ),
  );
}

Widget buildKeyValueRow(String key, String value, {Color? valueColor}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 110,
          child: Text(
            key,
            style: TextStyle(
              fontSize: 11.5,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12,
              color: valueColor ?? Colors.grey.shade900,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildSoftDivider({double height = 16, Color? color}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: height / 2),
    height: 1,
    color: (color ?? Colors.grey.shade300).withValues(alpha: 0.7),
  );
}

// =============================================================================
// MENU SURFACE PRIMITIVES (static snapshot — never calls showMenu)
// =============================================================================

Widget buildMenuSurface({
  required List<Widget> entries,
  double elevation = 8,
  Color color = Colors.white,
  Color? surfaceTint,
  ShapeBorder? shape,
  BoxConstraints? constraints,
  EdgeInsetsGeometry padding = const EdgeInsets.symmetric(vertical: 8),
  String? floatingLabel,
}) {
  final BoxConstraints effective =
      constraints ?? BoxConstraints(minWidth: 112, maxWidth: 280);
  final Color tint = surfaceTint ?? color;
  return Stack(
    clipBehavior: Clip.none,
    children: [
      ConstrainedBox(
        constraints: effective,
        child: Material(
          color: Color.alphaBlend(
            tint.withValues(alpha: elevation > 0 ? 0.05 : 0.0),
            color,
          ),
          elevation: elevation,
          shadowColor: Colors.black.withValues(alpha: 0.35),
          shape:
              shape ??
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
          child: Padding(padding: padding, child: Column(children: entries)),
        ),
      ),
      if (floatingLabel != null)
        Positioned(
          top: -10,
          right: 8,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: PopDemoPalette.hero,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.25),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Text(
              floatingLabel,
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.4,
              ),
            ),
          ),
        ),
    ],
  );
}

Widget buildPopupMenuItemSnapshot({
  required String label,
  IconData? leading,
  Widget? trailing,
  bool enabled = true,
  bool highlighted = false,
  String? subtitle,
  Color leadingColor = Colors.black87,
  EdgeInsetsGeometry? padding,
}) {
  final Color textColor = enabled
      ? Colors.black.withValues(alpha: 0.87)
      : Colors.black.withValues(alpha: 0.38);
  final Color subtitleColor = enabled
      ? Colors.black.withValues(alpha: 0.6)
      : Colors.black.withValues(alpha: 0.32);
  return Container(
    constraints: BoxConstraints(minHeight: 48),
    width: double.infinity,
    color: highlighted
        ? PopDemoPalette.primary.withValues(alpha: 0.08)
        : Colors.transparent,
    padding:
        padding ?? EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      children: [
        if (leading != null) ...[
          Icon(
            leading,
            size: 20,
            color: enabled ? leadingColor : Colors.grey.shade400,
          ),
          SizedBox(width: 12),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (subtitle != null) ...[
                SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 11.5, color: subtitleColor),
                ),
              ],
            ],
          ),
        ),
        if (trailing != null) ...[SizedBox(width: 12), trailing],
      ],
    ),
  );
}

Widget buildPopupMenuDividerSnapshot({double height = 16}) {
  return Container(
    height: height,
    alignment: Alignment.center,
    child: Container(
      height: 1,
      margin: EdgeInsets.symmetric(horizontal: 0),
      color: Colors.grey.shade300,
    ),
  );
}

Widget buildCheckedPopupMenuItemSnapshot({
  required String label,
  required bool checked,
  bool enabled = true,
  String? trailing,
}) {
  return buildPopupMenuItemSnapshot(
    label: label,
    leading: checked ? Icons.check : null,
    leadingColor: checked ? PopDemoPalette.primary : Colors.transparent,
    enabled: enabled,
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    trailing: trailing != null
        ? Text(
            trailing,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade600,
              fontFamily: 'monospace',
            ),
          )
        : null,
  );
}

// =============================================================================
// SECTION 1 — HERO / TITLE CARD
// =============================================================================

Widget buildHeroStatChip({
  required IconData icon,
  required String value,
  required String label,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.16),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: Colors.white.withValues(alpha: 0.35),
        width: 1.0,
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 32.0,
          height: 32.0,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.22),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.white, size: 18.0),
        ),
        SizedBox(width: 10.0),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.4,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: 10.5,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.6,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildHeroCard() {
  return Container(
    margin: EdgeInsets.fromLTRB(4.0, 0.0, 4.0, 12.0),
    padding: EdgeInsets.fromLTRB(24.0, 26.0, 24.0, 24.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          PopDemoPalette.hero,
          PopDemoPalette.primary,
          PopDemoPalette.tertiary,
        ],
        stops: <double>[0.0, 0.55, 1.0],
      ),
      borderRadius: BorderRadius.circular(22.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: PopDemoPalette.hero.withValues(alpha: 0.45),
          blurRadius: 24.0,
          offset: Offset(0.0, 10.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.35),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.fiber_manual_record,
                      color: PopDemoPalette.success, size: 10.0),
                  SizedBox(width: 6.0),
                  Text(
                    'STATIC SNAPSHOT',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.5,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.1,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                'v1.4',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Text(
          'PopupMenuButton',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
            height: 1.0,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Visual Deep Demo',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.85),
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.2,
          ),
        ),
        SizedBox(height: 14.0),
        Text(
          'A static, analyzer-clean exploration of the PopupMenuButton family — '
          'items, dividers, checked items, anchors, elevation, theming and '
          'pitfalls. No animations, no async, no live menus.',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.92),
            fontSize: 13.5,
            height: 1.5,
          ),
        ),
        SizedBox(height: 20.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: <Widget>[
            buildHeroStatChip(
              icon: Icons.layers_outlined,
              value: '11',
              label: 'SECTIONS',
            ),
            buildHeroStatChip(
              icon: Icons.grid_view_outlined,
              value: '7',
              label: 'ITEM VARIANTS',
            ),
            buildHeroStatChip(
              icon: Icons.center_focus_strong_outlined,
              value: '4',
              label: 'ANCHOR DEMOS',
            ),
          ],
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 2 — ANATOMY DIAGRAM
// =============================================================================

Widget buildAnatomyCalloutBadge(String number, Color color) {
  return Container(
    width: 22.0,
    height: 22.0,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[color, color.withValues(alpha: 0.7)],
      ),
      shape: BoxShape.circle,
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color.withValues(alpha: 0.5),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    alignment: Alignment.center,
    child: Text(
      number,
      style: TextStyle(
        color: Colors.white,
        fontSize: 11.0,
        fontWeight: FontWeight.w900,
      ),
    ),
  );
}

Widget buildAnatomyLegendRow(
  String number,
  String name,
  String desc,
  Color color,
) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildAnatomyCalloutBadge(number, color),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                name,
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w800,
                  color: Colors.black.withValues(alpha: 0.85),
                  fontFamily: 'monospace',
                ),
              ),
              Text(
                desc,
                style: TextStyle(
                  fontSize: 11.5,
                  color: Colors.grey.shade700,
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

Widget buildAnatomySection() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: PopDemoPalette.outlineVariant),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.04),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Anatomy of an open popup',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w800,
            color: Colors.black.withValues(alpha: 0.85),
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Anchored numbered callouts identify each part of the rendered menu.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 18.0),
        Container(
          height: 360.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Color(0xFFF3EEF8),
                Color(0xFFE8E0F0),
              ],
            ),
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(color: PopDemoPalette.outlineVariant),
          ),
          padding: EdgeInsets.all(14.0),
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 8.0,
                left: 12.0,
                child: Row(
                  children: <Widget>[
                    buildAnatomyCalloutBadge('1', PopDemoPalette.info),
                    SizedBox(width: 8.0),
                    Container(
                      width: 44.0,
                      height: 44.0,
                      decoration: BoxDecoration(
                        color: PopDemoPalette.surfaceVariant,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: PopDemoPalette.primary,
                          width: 2.0,
                          style: BorderStyle.solid,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.more_vert,
                        color: PopDemoPalette.primary,
                        size: 22.0,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 70.0,
                left: 60.0,
                child: buildMenuSurface(
                  elevation: 8.0,
                  floatingLabel: 'elev 8',
                  entries: <Widget>[
                    buildPopupMenuItemSnapshot(
                      label: 'New file',
                      leading: Icons.note_add_outlined,
                    ),
                    buildPopupMenuItemSnapshot(
                      label: 'Open recent',
                      leading: Icons.folder_open_outlined,
                    ),
                    buildPopupMenuDividerSnapshot(),
                    buildCheckedPopupMenuItemSnapshot(
                      label: 'Word wrap',
                      checked: true,
                    ),
                    buildPopupMenuItemSnapshot(
                      label: 'Settings',
                      leading: Icons.settings_outlined,
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 60.0,
                right: 6.0,
                child: buildAnatomyCalloutBadge('2', PopDemoPalette.warning),
              ),
              Positioned(
                top: 110.0,
                right: 6.0,
                child: buildAnatomyCalloutBadge('3', PopDemoPalette.success),
              ),
              Positioned(
                top: 170.0,
                right: 6.0,
                child: buildAnatomyCalloutBadge('4', PopDemoPalette.danger),
              ),
              Positioned(
                top: 220.0,
                right: 6.0,
                child: buildAnatomyCalloutBadge('5', PopDemoPalette.tertiary),
              ),
              Positioned(
                top: 280.0,
                right: 6.0,
                child: buildAnatomyCalloutBadge('6', PopDemoPalette.hero),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.0),
        buildAnatomyLegendRow(
          '1',
          'anchor + IconButton',
          'The trigger that opens the popup; provides the anchor RelativeRect.',
          PopDemoPalette.info,
        ),
        buildAnatomyLegendRow(
          '2',
          'Material elevation',
          'Drop shadow indicating how the surface floats above the page.',
          PopDemoPalette.warning,
        ),
        buildAnatomyLegendRow(
          '3',
          'menu surface (color)',
          'Background color, tinted by surfaceTint when M3 is enabled.',
          PopDemoPalette.success,
        ),
        buildAnatomyLegendRow(
          '4',
          'PopupMenuItem',
          'A selectable row carrying a value of type T returned to onSelected.',
          PopDemoPalette.danger,
        ),
        buildAnatomyLegendRow(
          '5',
          'PopupMenuDivider',
          'Visual grouping separator; default height 16.',
          PopDemoPalette.tertiary,
        ),
        buildAnatomyLegendRow(
          '6',
          'CheckedPopupMenuItem',
          'PopupMenuItem variant that reserves leading slot for a check mark.',
          PopDemoPalette.hero,
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 3 — POPUPMENUITEM VARIANTS
// =============================================================================

Widget buildVariantTile({
  required String title,
  required String description,
  required Widget body,
  Color? accent,
}) {
  final Color a = accent ?? PopDemoPalette.primary;
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: PopDemoPalette.outlineVariant),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.04),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 8.0,
              height: 18.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[a, a.withValues(alpha: 0.55)],
                ),
                borderRadius: BorderRadius.circular(3.0),
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w800,
                  color: Colors.black.withValues(alpha: 0.85),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          description,
          style: TextStyle(
            fontSize: 11.5,
            color: Colors.grey.shade700,
            height: 1.4,
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Color(0xFFF6F2FA),
                Color(0xFFEDE7F3),
              ],
            ),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: PopDemoPalette.outlineVariant),
          ),
          padding: EdgeInsets.all(10.0),
          child: body,
        ),
      ],
    ),
  );
}

Widget buildShortcutText(String text) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(4.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 10.5,
        color: Colors.grey.shade700,
        fontFamily: 'monospace',
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

Widget buildPopupItemVariantsSection() {
  final List<Widget> tiles = <Widget>[
    buildVariantTile(
      title: 'Enabled',
      description: 'Default state. Receives taps and is fully opaque.',
      accent: PopDemoPalette.primary,
      body: buildMenuSurface(
        entries: <Widget>[
          buildPopupMenuItemSnapshot(label: 'Cut'),
          buildPopupMenuItemSnapshot(label: 'Copy'),
          buildPopupMenuItemSnapshot(label: 'Paste'),
        ],
      ),
    ),
    buildVariantTile(
      title: 'Disabled',
      description: 'enabled: false → no callback, text dimmed to ~38% opacity.',
      accent: PopDemoPalette.outline,
      body: buildMenuSurface(
        entries: <Widget>[
          buildPopupMenuItemSnapshot(label: 'Undo', enabled: false),
          buildPopupMenuItemSnapshot(label: 'Redo', enabled: false),
          buildPopupMenuItemSnapshot(label: 'Paste'),
        ],
      ),
    ),
    buildVariantTile(
      title: 'Leading icon',
      description: 'Use a leading Icon for affordance and quick scanning.',
      accent: PopDemoPalette.info,
      body: buildMenuSurface(
        entries: <Widget>[
          buildPopupMenuItemSnapshot(
            label: 'Save',
            leading: Icons.save_outlined,
          ),
          buildPopupMenuItemSnapshot(
            label: 'Print',
            leading: Icons.print_outlined,
          ),
          buildPopupMenuItemSnapshot(
            label: 'Share',
            leading: Icons.share_outlined,
          ),
        ],
      ),
    ),
    buildVariantTile(
      title: 'Trailing shortcut',
      description: 'Trailing slot is ideal for keyboard accelerators.',
      accent: PopDemoPalette.tertiary,
      body: buildMenuSurface(
        entries: <Widget>[
          buildPopupMenuItemSnapshot(
            label: 'Cut',
            leading: Icons.content_cut,
            trailing: buildShortcutText('Ctrl+X'),
          ),
          buildPopupMenuItemSnapshot(
            label: 'Copy',
            leading: Icons.content_copy,
            trailing: buildShortcutText('Ctrl+C'),
          ),
          buildPopupMenuItemSnapshot(
            label: 'Paste',
            leading: Icons.content_paste,
            trailing: buildShortcutText('Ctrl+V'),
          ),
        ],
      ),
    ),
    buildVariantTile(
      title: 'With subtitle',
      description: 'Two-line item using a child Column inside the item.',
      accent: PopDemoPalette.secondary,
      body: buildMenuSurface(
        entries: <Widget>[
          buildPopupMenuItemSnapshot(
            label: 'Account settings',
            leading: Icons.person_outline,
            subtitle: 'Profile, security, sessions',
          ),
          buildPopupMenuItemSnapshot(
            label: 'Notifications',
            leading: Icons.notifications_outlined,
            subtitle: 'Email, push, in-app',
          ),
        ],
      ),
    ),
    buildVariantTile(
      title: 'Destructive',
      description: 'Color a destructive action red, never the default.',
      accent: PopDemoPalette.danger,
      body: buildMenuSurface(
        entries: <Widget>[
          buildPopupMenuItemSnapshot(
            label: 'Archive',
            leading: Icons.archive_outlined,
          ),
          buildPopupMenuDividerSnapshot(),
          Container(
            constraints: BoxConstraints(minHeight: 48.0),
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: <Widget>[
                Icon(Icons.delete_outline,
                    size: 20.0, color: PopDemoPalette.danger),
                SizedBox(width: 12.0),
                Text(
                  'Delete forever',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: PopDemoPalette.danger,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    buildVariantTile(
      title: 'Multi-line label',
      description: 'Wrap long labels by allowing the Text widget to wrap.',
      accent: PopDemoPalette.warning,
      body: buildMenuSurface(
        constraints: BoxConstraints(minWidth: 220.0, maxWidth: 240.0),
        entries: <Widget>[
          Container(
            constraints: BoxConstraints(minHeight: 48.0),
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.warning_amber_outlined,
                    size: 20.0, color: PopDemoPalette.warning),
                SizedBox(width: 12.0),
                Expanded(
                  child: Text(
                    'This action cannot be undone unless you have a recent '
                    'backup snapshot.',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.black.withValues(alpha: 0.85),
                      height: 1.35,
                    ),
                  ),
                ),
              ],
            ),
          ),
          buildPopupMenuItemSnapshot(label: 'Continue'),
        ],
      ),
    ),
  ];
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      buildCaption(
        'PopupMenuItem accepts any child. The variants below show the most '
        'common compositions used in production apps.',
      ),
      LayoutBuilder(
        builder: (BuildContext c, BoxConstraints cs) {
          final double w = cs.maxWidth;
          final int cols = w > 760.0 ? 3 : (w > 500.0 ? 2 : 1);
          final List<List<Widget>> rows = <List<Widget>>[];
          for (int i = 0; i < tiles.length; i += cols) {
            final List<Widget> row = <Widget>[];
            for (int j = 0; j < cols; j++) {
              final int k = i + j;
              if (k < tiles.length) {
                row.add(Expanded(child: tiles[k]));
              } else {
                row.add(Expanded(child: SizedBox.shrink()));
              }
              if (j < cols - 1) {
                row.add(SizedBox(width: 10.0));
              }
            }
            rows.add(row);
          }
          return Column(
            children: <Widget>[
              for (int r = 0; r < rows.length; r++) ...<Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: rows[r],
                ),
                if (r < rows.length - 1) SizedBox(height: 10.0),
              ],
            ],
          );
        },
      ),
    ],
  );
}

// =============================================================================
// SECTION 4 — CHECKEDPOPUPMENUITEM VARIANTS
// =============================================================================

Widget buildCheckedVariantsSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      buildCaption(
        'CheckedPopupMenuItem reserves the leading slot for a check mark, '
        'animated in/out when the value changes.',
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: buildVariantTile(
              title: 'Checked / unchecked',
              description: 'Mirrors a boolean state via the leading check.',
              accent: PopDemoPalette.primary,
              body: buildMenuSurface(
                entries: <Widget>[
                  buildCheckedPopupMenuItemSnapshot(
                      label: 'Word wrap', checked: true),
                  buildCheckedPopupMenuItemSnapshot(
                      label: 'Minimap', checked: false),
                  buildCheckedPopupMenuItemSnapshot(
                      label: 'Line numbers', checked: true),
                ],
              ),
            ),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: buildVariantTile(
              title: 'Enabled / disabled',
              description: 'Disabled checked items still reserve the slot.',
              accent: PopDemoPalette.outline,
              body: buildMenuSurface(
                entries: <Widget>[
                  buildCheckedPopupMenuItemSnapshot(
                      label: 'Show whitespace',
                      checked: false,
                      enabled: false),
                  buildCheckedPopupMenuItemSnapshot(
                      label: 'Auto-format',
                      checked: true,
                      enabled: false),
                  buildCheckedPopupMenuItemSnapshot(
                      label: 'Inline diff', checked: false),
                ],
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 10.0),
      buildVariantTile(
        title: 'With trailing shortcut',
        description:
            'A monospace trailing label keeps shortcuts aligned vertically.',
        accent: PopDemoPalette.tertiary,
        body: buildMenuSurface(
          constraints: BoxConstraints(minWidth: 240.0, maxWidth: 320.0),
          entries: <Widget>[
            buildCheckedPopupMenuItemSnapshot(
              label: 'Word wrap',
              checked: true,
              trailing: 'Alt+Z',
            ),
            buildCheckedPopupMenuItemSnapshot(
              label: 'Minimap',
              checked: false,
              trailing: 'Alt+M',
            ),
            buildCheckedPopupMenuItemSnapshot(
              label: 'Sticky scroll',
              checked: true,
              trailing: 'Alt+S',
            ),
            buildPopupMenuDividerSnapshot(),
            buildCheckedPopupMenuItemSnapshot(
              label: 'Render control characters',
              checked: false,
              trailing: 'Alt+Ctrl+C',
            ),
          ],
        ),
      ),
    ],
  );
}

// =============================================================================
// SECTION 5 — DIVIDER SHOWCASE
// =============================================================================

Widget buildDividerShowcaseColumn(double h, Color accent) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Colors.white,
            accent.withValues(alpha: 0.06),
          ],
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: PopDemoPalette.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 8.0, vertical: 3.0),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  'height: ${h.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: accent,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          buildMenuSurface(
            entries: <Widget>[
              buildPopupMenuItemSnapshot(label: 'Group A · item 1'),
              buildPopupMenuItemSnapshot(label: 'Group A · item 2'),
              buildPopupMenuDividerSnapshot(height: h),
              buildPopupMenuItemSnapshot(label: 'Group B · item 1'),
              buildPopupMenuItemSnapshot(label: 'Group B · item 2'),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget buildDividerSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      buildCaption(
        'PopupMenuDivider.height controls the total vertical space — the line '
        'itself stays 1 logical pixel. Use larger heights for coarser groups.',
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildDividerShowcaseColumn(8.0, PopDemoPalette.info),
          SizedBox(width: 10.0),
          buildDividerShowcaseColumn(16.0, PopDemoPalette.primary),
          SizedBox(width: 10.0),
          buildDividerShowcaseColumn(24.0, PopDemoPalette.tertiary),
        ],
      ),
    ],
  );
}

// =============================================================================
// SECTION 6 — ANCHOR POSITIONS (PHONE FRAMES)
// =============================================================================

Widget buildPhoneFrame({
  required String title,
  required String position,
  required Widget child,
  required Color accent,
}) {
  return Expanded(
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: PopDemoPalette.outlineVariant),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8.0,
            offset: Offset(0.0, 4.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 8.0,
                height: 8.0,
                decoration: BoxDecoration(
                  color: accent,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 6.0),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                    color: Colors.black.withValues(alpha: 0.85),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 4.0),
          Text(
            position,
            style: TextStyle(
              fontSize: 10.5,
              color: Colors.grey.shade600,
              fontFamily: 'monospace',
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            height: 280.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  Color(0xFFF4F1F8),
                  Color(0xFFE7E0EC),
                ],
              ),
              borderRadius: BorderRadius.circular(18.0),
              border: Border.all(
                color: PopDemoPalette.outline.withValues(alpha: 0.5),
                width: 2.0,
              ),
            ),
            padding: EdgeInsets.all(8.0),
            child: child,
          ),
        ],
      ),
    ),
  );
}

Widget buildPhoneAnchorButton({
  required Alignment align,
  required Color color,
}) {
  return Align(
    alignment: align,
    child: Container(
      width: 36.0,
      height: 36.0,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 1.5),
      ),
      alignment: Alignment.center,
      child: Icon(Icons.more_vert, color: color, size: 18.0),
    ),
  );
}

Widget buildMiniPopup() {
  return buildMenuSurface(
    constraints: BoxConstraints(minWidth: 120.0, maxWidth: 150.0),
    padding: EdgeInsets.symmetric(vertical: 4.0),
    entries: <Widget>[
      buildPopupMenuItemSnapshot(
        label: 'Action A',
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      ),
      buildPopupMenuItemSnapshot(
        label: 'Action B',
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      ),
      buildPopupMenuItemSnapshot(
        label: 'Action C',
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      ),
    ],
  );
}

Widget buildAnchorOver() {
  return Stack(
    children: <Widget>[
      buildPhoneAnchorButton(
        align: Alignment.center,
        color: PopDemoPalette.overOpen,
      ),
      Positioned(
        top: 110.0,
        left: 40.0,
        child: buildMiniPopup(),
      ),
      Positioned(
        top: 124.0,
        left: 124.0,
        child: Container(
          width: 8.0,
          height: 8.0,
          decoration: BoxDecoration(
            color: PopDemoPalette.overOpen,
            shape: BoxShape.circle,
          ),
        ),
      ),
    ],
  );
}

Widget buildAnchorUnder() {
  return Stack(
    children: <Widget>[
      buildPhoneAnchorButton(
        align: Alignment.topCenter,
        color: PopDemoPalette.underOpen,
      ),
      Positioned(
        top: 56.0,
        left: 40.0,
        child: buildMiniPopup(),
      ),
    ],
  );
}

Widget buildAnchorTopLeft() {
  return Stack(
    children: <Widget>[
      buildPhoneAnchorButton(
        align: Alignment.topRight,
        color: PopDemoPalette.tertiary,
      ),
      Positioned(
        top: 8.0,
        left: 8.0,
        child: buildMiniPopup(),
      ),
    ],
  );
}

Widget buildAnchorTopRight() {
  return Stack(
    children: <Widget>[
      buildPhoneAnchorButton(
        align: Alignment.topLeft,
        color: PopDemoPalette.warning,
      ),
      Positioned(
        top: 8.0,
        right: 8.0,
        child: buildMiniPopup(),
      ),
    ],
  );
}

Widget buildAnchorSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      buildCaption(
        'PopupMenuButton uses a RelativeRect built from the anchor and an '
        'optional offset/PopupMenuPosition to decide where the menu opens.',
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildPhoneFrame(
            title: 'over',
            position: 'PopupMenuPosition.over',
            accent: PopDemoPalette.overOpen,
            child: buildAnchorOver(),
          ),
          buildPhoneFrame(
            title: 'under',
            position: 'PopupMenuPosition.under',
            accent: PopDemoPalette.underOpen,
            child: buildAnchorUnder(),
          ),
        ],
      ),
      SizedBox(height: 12.0),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildPhoneFrame(
            title: 'top-left anchor',
            position: 'RelativeRect.fromLTRB(0,0,*,*)',
            accent: PopDemoPalette.tertiary,
            child: buildAnchorTopLeft(),
          ),
          buildPhoneFrame(
            title: 'top-right anchor',
            position: 'RelativeRect.fromLTRB(*,0,0,*)',
            accent: PopDemoPalette.warning,
            child: buildAnchorTopRight(),
          ),
        ],
      ),
    ],
  );
}

// =============================================================================
// SECTION 7 — ELEVATION COMPARISON
// =============================================================================

Widget buildElevationCard({
  required double elevation,
  required Color accent,
  required String label,
}) {
  return Expanded(
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 6.0),
      padding: EdgeInsets.fromLTRB(14.0, 14.0, 14.0, 24.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            accent.withValues(alpha: 0.05),
            accent.withValues(alpha: 0.16),
          ],
        ),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: accent.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 8.0, vertical: 3.0),
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  label,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11.0,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
              SizedBox(width: 8.0),
              Text(
                'elevation ${elevation.toStringAsFixed(0)}',
                style: TextStyle(
                  fontSize: 11.5,
                  color: Colors.grey.shade700,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 14.0),
          Center(
            child: buildMenuSurface(
              elevation: elevation,
              entries: <Widget>[
                buildPopupMenuItemSnapshot(
                  label: 'Rename',
                  leading: Icons.edit_outlined,
                ),
                buildPopupMenuItemSnapshot(
                  label: 'Duplicate',
                  leading: Icons.copy_outlined,
                ),
                buildPopupMenuItemSnapshot(
                  label: 'Move',
                  leading: Icons.drive_file_move_outlined,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildElevationSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      buildCaption(
        'Material elevation determines shadow blur and offset. Default is 8; '
        'use lower values for inline menus, higher for global app bars.',
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildElevationCard(
            elevation: 1.0,
            accent: PopDemoPalette.info,
            label: 'LOW',
          ),
          buildElevationCard(
            elevation: 4.0,
            accent: PopDemoPalette.primary,
            label: 'MED',
          ),
          buildElevationCard(
            elevation: 8.0,
            accent: PopDemoPalette.danger,
            label: 'HIGH',
          ),
        ],
      ),
    ],
  );
}

// =============================================================================
// SECTION 8 — THEME INTEGRATION
// =============================================================================

Widget buildThemeTokenCard({
  required String token,
  required String type,
  required String value,
  required Color swatch,
  required IconData icon,
}) {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: PopDemoPalette.outlineVariant),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.03),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 36.0,
              height: 36.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[swatch, swatch.withValues(alpha: 0.55)],
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(icon, color: Colors.white, size: 20.0),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    token,
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w800,
                      color: Colors.black.withValues(alpha: 0.85),
                      fontFamily: 'monospace',
                    ),
                  ),
                  Text(
                    type,
                    style: TextStyle(
                      fontSize: 10.5,
                      color: Colors.grey.shade600,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Color(0xFFFAF6FD),
                Color(0xFFEDE7F3),
              ],
            ),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: PopDemoPalette.outlineVariant),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 11.5,
              color: Colors.black.withValues(alpha: 0.85),
              fontFamily: 'monospace',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildThemeSection() {
  final List<Widget> cards = <Widget>[
    buildThemeTokenCard(
      token: 'color',
      type: 'Color?',
      value: 'theme.colorScheme.surface',
      swatch: PopDemoPalette.primary,
      icon: Icons.color_lens_outlined,
    ),
    buildThemeTokenCard(
      token: 'elevation',
      type: 'double?',
      value: '8.0',
      swatch: PopDemoPalette.tertiary,
      icon: Icons.layers_outlined,
    ),
    buildThemeTokenCard(
      token: 'textStyle',
      type: 'TextStyle?',
      value: 'theme.textTheme.labelLarge',
      swatch: PopDemoPalette.info,
      icon: Icons.text_fields_outlined,
    ),
    buildThemeTokenCard(
      token: 'shape',
      type: 'ShapeBorder?',
      value: 'RoundedRectangleBorder(\n  borderRadius: 4.0,\n)',
      swatch: PopDemoPalette.warning,
      icon: Icons.crop_square_outlined,
    ),
    buildThemeTokenCard(
      token: 'surfaceTintColor',
      type: 'Color?',
      value: 'theme.colorScheme.surfaceTint',
      swatch: PopDemoPalette.success,
      icon: Icons.format_paint_outlined,
    ),
    buildThemeTokenCard(
      token: 'iconColor',
      type: 'Color?',
      value: 'theme.colorScheme.onSurface',
      swatch: PopDemoPalette.danger,
      icon: Icons.palette_outlined,
    ),
  ];
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      buildCaption(
        'PopupMenuThemeData centralizes appearance across the app. Override '
        'tokens on a per-button basis via PopupMenuButton parameters.',
      ),
      LayoutBuilder(
        builder: (BuildContext c, BoxConstraints cs) {
          final int cols = cs.maxWidth > 700.0 ? 3 : 2;
          final List<List<Widget>> rows = <List<Widget>>[];
          for (int i = 0; i < cards.length; i += cols) {
            final List<Widget> row = <Widget>[];
            for (int j = 0; j < cols; j++) {
              final int k = i + j;
              if (k < cards.length) {
                row.add(Expanded(child: cards[k]));
              } else {
                row.add(Expanded(child: SizedBox.shrink()));
              }
              if (j < cols - 1) row.add(SizedBox(width: 10.0));
            }
            rows.add(row);
          }
          return Column(
            children: <Widget>[
              for (int r = 0; r < rows.length; r++) ...<Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: rows[r],
                ),
                if (r < rows.length - 1) SizedBox(height: 10.0),
              ],
            ],
          );
        },
      ),
      SizedBox(height: 16.0),
      Container(
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              PopDemoPalette.primary.withValues(alpha: 0.08),
              PopDemoPalette.tertiary.withValues(alpha: 0.08),
            ],
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: PopDemoPalette.primary.withValues(alpha: 0.25),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(Icons.tips_and_updates_outlined,
                color: PopDemoPalette.primary, size: 22.0),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                'In M3, surfaceTintColor blends with color based on elevation. '
                'Setting surfaceTintColor to Colors.transparent disables the '
                'tint for a flatter look.',
                style: TextStyle(
                  fontSize: 12.5,
                  color: Colors.black.withValues(alpha: 0.85),
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// =============================================================================
// SECTION 9 — COMMON PITFALLS
// =============================================================================

Widget buildPitfallBullet({
  required IconData icon,
  required Color color,
  required String title,
  required String body,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 32.0,
          height: 32.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[color, color.withValues(alpha: 0.6)],
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(icon, color: Colors.white, size: 18.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w800,
                  color: Colors.black.withValues(alpha: 0.85),
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                body,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade700,
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

Widget buildPitfallsSection() {
  return Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Color(0xFFFFFAF5),
          Color(0xFFFFF3E8),
        ],
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(
        color: PopDemoPalette.warning.withValues(alpha: 0.35),
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: PopDemoPalette.warning.withValues(alpha: 0.12),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.report_problem_outlined,
                color: PopDemoPalette.warning, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Common pitfalls',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w800,
                color: Colors.black.withValues(alpha: 0.85),
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Text(
          'Reading these once will save you a long debugging session later.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 8.0),
        buildPitfallBullet(
          icon: Icons.block,
          color: PopDemoPalette.danger,
          title: 'itemBuilder must not return an empty list',
          body:
              'PopupMenuButton asserts the menu has at least one entry. Guard '
              'with a stub disabled item when no actions are available.',
        ),
        buildPitfallBullet(
          icon: Icons.key_outlined,
          color: PopDemoPalette.info,
          title: 'Use ValueKey for stable selection',
          body:
              'When items are rebuilt across frames, providing a ValueKey to '
              'each PopupMenuItem keeps focus and animations stable.',
        ),
        buildPitfallBullet(
          icon: Icons.compare_arrows_outlined,
          color: PopDemoPalette.tertiary,
          title: 'PopupMenuItem.value is compared by identity, not ==',
          body:
              'Treat values as opaque tokens. If you rebuild a value object on '
              'every frame, equality wins of "currently selected" can be lost.',
        ),
        buildPitfallBullet(
          icon: Icons.touch_app_outlined,
          color: PopDemoPalette.warning,
          title: 'enabled: false suppresses onTap, not gestures',
          body:
              'Disabled items still occupy hit-test space. Avoid stacking '
              'GestureDetectors beneath them — taps will not pass through.',
        ),
        buildPitfallBullet(
          icon: Icons.screen_rotation_outlined,
          color: PopDemoPalette.hero,
          title: 'showMenu does not reposition on rotate / resize',
          body:
              'If the screen resizes while a popup is open, the menu remains '
              'anchored to the original RelativeRect. Dismiss + reshow when '
              'orientation changes.',
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 10 — API CODE BLOCK
// =============================================================================

Widget buildCodeLine(String text, {Color? color, bool comment = false}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 1.0),
    child: Text(
      text,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 12.5,
        height: 1.45,
        color: comment
            ? Colors.grey.shade500
            : (color ?? Color(0xFFEDE7F6)),
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

Widget buildApiCodeSection() {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Color(0xFF1E1B2E),
          Color(0xFF2A2342),
        ],
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.35),
          blurRadius: 16.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: 10.0,
                height: 10.0,
                decoration: BoxDecoration(
                  color: Color(0xFFFF5F56),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 6.0),
              Container(
                width: 10.0,
                height: 10.0,
                decoration: BoxDecoration(
                  color: Color(0xFFFFBD2E),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 6.0),
              Container(
                width: 10.0,
                height: 10.0,
                decoration: BoxDecoration(
                  color: Color(0xFF27C93F),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 14.0),
              Text(
                'popup_menu_button.dart',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  color: Colors.white.withValues(alpha: 0.7),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(18.0, 14.0, 18.0, 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildCodeLine('// Constructor signature', comment: true),
              buildCodeLine('PopupMenuButton<T>({',
                  color: Color(0xFFBA9DF5)),
              buildCodeLine(
                  '  Key? key,',
                  color: Color(0xFFEDE7F6)),
              buildCodeLine(
                  '  required PopupMenuItemBuilder<T> itemBuilder,',
                  color: Color(0xFFEDE7F6)),
              buildCodeLine(
                  '  T? initialValue,',
                  color: Color(0xFFEDE7F6)),
              buildCodeLine(
                  '  PopupMenuItemSelected<T>? onSelected,',
                  color: Color(0xFFEDE7F6)),
              buildCodeLine(
                  '  PopupMenuCanceled? onCanceled,',
                  color: Color(0xFFEDE7F6)),
              buildCodeLine(
                  '  String? tooltip,',
                  color: Color(0xFFEDE7F6)),
              buildCodeLine(
                  '  double? elevation,',
                  color: Color(0xFFEDE7F6)),
              buildCodeLine(
                  '  Color? color,',
                  color: Color(0xFFEDE7F6)),
              buildCodeLine(
                  '  Color? surfaceTintColor,',
                  color: Color(0xFFEDE7F6)),
              buildCodeLine(
                  '  ShapeBorder? shape,',
                  color: Color(0xFFEDE7F6)),
              buildCodeLine(
                  '  Offset offset = Offset.zero,',
                  color: Color(0xFFEDE7F6)),
              buildCodeLine(
                  '  PopupMenuPosition? position,',
                  color: Color(0xFFEDE7F6)),
              buildCodeLine(
                  '  bool enabled = true,',
                  color: Color(0xFFEDE7F6)),
              buildCodeLine('});', color: Color(0xFFBA9DF5)),
              SizedBox(height: 12.0),
              buildCodeLine('// Typical usage', comment: true),
              buildCodeLine(
                  'PopupMenuButton<String>(',
                  color: Color(0xFFBA9DF5)),
              buildCodeLine(
                  '  tooltip: \'More actions\',',
                  color: Color(0xFFB5EAD7)),
              buildCodeLine(
                  '  position: PopupMenuPosition.under,',
                  color: Color(0xFFEDE7F6)),
              buildCodeLine(
                  '  onSelected: (String value) => handle(value),',
                  color: Color(0xFFEDE7F6)),
              buildCodeLine(
                  '  itemBuilder: (BuildContext context) =>',
                  color: Color(0xFFEDE7F6)),
              buildCodeLine(
                  '      <PopupMenuEntry<String>>[',
                  color: Color(0xFFEDE7F6)),
              buildCodeLine(
                  '    const PopupMenuItem<String>(',
                  color: Color(0xFFEDE7F6)),
              buildCodeLine(
                  '      value: \'edit\',',
                  color: Color(0xFFB5EAD7)),
              buildCodeLine(
                  '      child: Text(\'Edit\'),',
                  color: Color(0xFFEDE7F6)),
              buildCodeLine('    ),',
                  color: Color(0xFFEDE7F6)),
              buildCodeLine(
                  '    const PopupMenuDivider(),',
                  color: Color(0xFFEDE7F6)),
              buildCodeLine(
                  '    CheckedPopupMenuItem<String>(',
                  color: Color(0xFFEDE7F6)),
              buildCodeLine(
                  '      value: \'wrap\',',
                  color: Color(0xFFB5EAD7)),
              buildCodeLine(
                  '      checked: wrapEnabled,',
                  color: Color(0xFFEDE7F6)),
              buildCodeLine(
                  '      child: const Text(\'Word wrap\'),',
                  color: Color(0xFFEDE7F6)),
              buildCodeLine('    ),',
                  color: Color(0xFFEDE7F6)),
              buildCodeLine('  ],',
                  color: Color(0xFFEDE7F6)),
              buildCodeLine(');', color: Color(0xFFBA9DF5)),
            ],
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 11 — FOOTER
// =============================================================================

Widget buildFooterLinkChip(IconData icon, String label) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: PopDemoPalette.outlineVariant),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, size: 14.0, color: PopDemoPalette.primary),
        SizedBox(width: 6.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 11.5,
            color: Colors.black.withValues(alpha: 0.75),
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}

Widget buildFooterCard() {
  return Container(
    margin: EdgeInsets.fromLTRB(4.0, 0.0, 4.0, 12.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Color(0xFFEDE7F6),
          Color(0xFFE0D7F0),
        ],
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: PopDemoPalette.outlineVariant),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 38.0,
              height: 38.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    PopDemoPalette.primary,
                    PopDemoPalette.tertiary,
                  ],
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(Icons.menu_open,
                  color: Colors.white, size: 22.0),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'PopupMenuButton — Visual Deep Demo',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w800,
                      color: Colors.black.withValues(alpha: 0.85),
                    ),
                  ),
                  Text(
                    'Generated by tom_d4rt_flutter_ast · static snapshot',
                    style: TextStyle(
                      fontSize: 11.5,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            buildFooterLinkChip(Icons.menu_book_outlined, 'API reference'),
            buildFooterLinkChip(Icons.bug_report_outlined, 'Report issue'),
            buildFooterLinkChip(Icons.code_outlined, 'Source on GitHub'),
            buildFooterLinkChip(Icons.school_outlined, 'Cookbook'),
          ],
        ),
        SizedBox(height: 14.0),
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 8.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: PopDemoPalette.primary.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                'v1.4 · Flutter 3.27+',
                style: TextStyle(
                  fontSize: 10.5,
                  color: PopDemoPalette.primary,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Text(
              'Last updated 2026-05-11',
              style: TextStyle(
                fontSize: 11.0,
                color: Colors.grey.shade600,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// =============================================================================
// ENTRY POINT
// =============================================================================

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(useMaterial3: true),
    home: Scaffold(
      backgroundColor: PopDemoPalette.surface,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildHeroCard(),
            buildSectionHeader(
              '02',
              'Anatomy',
              'Labelled diagram of an open popup with numbered callouts.',
              Icons.architecture_outlined,
              PopDemoPalette.info,
            ),
            buildAnatomySection(),
            buildSectionHeader(
              '03',
              'PopupMenuItem variants',
              'Enabled, disabled, leading icon, trailing shortcut, subtitle, '
                  'destructive, multi-line.',
              Icons.list_alt_outlined,
              PopDemoPalette.primary,
            ),
            buildPopupItemVariantsSection(),
            buildSectionHeader(
              '04',
              'CheckedPopupMenuItem',
              'Checked / unchecked, enabled / disabled, trailing shortcuts.',
              Icons.check_box_outlined,
              PopDemoPalette.success,
            ),
            buildCheckedVariantsSection(),
            buildSectionHeader(
              '05',
              'Dividers',
              'PopupMenuDivider with three height variants.',
              Icons.horizontal_rule,
              PopDemoPalette.tertiary,
            ),
            buildDividerSection(),
            buildSectionHeader(
              '06',
              'Anchor positions',
              'Four phone frames showing over/under and top-left/top-right.',
              Icons.center_focus_strong_outlined,
              PopDemoPalette.overOpen,
            ),
            buildAnchorSection(),
            buildSectionHeader(
              '07',
              'Elevation comparison',
              'Three popup surfaces at elevation 1, 4 and 8.',
              Icons.layers_outlined,
              PopDemoPalette.warning,
            ),
            buildElevationSection(),
            buildSectionHeader(
              '08',
              'Theme integration',
              'PopupMenuThemeData tokens with sample values.',
              Icons.palette_outlined,
              PopDemoPalette.secondary,
            ),
            buildThemeSection(),
            buildSectionHeader(
              '09',
              'Common pitfalls',
              'Mistakes that bite in production — read before shipping.',
              Icons.report_problem_outlined,
              PopDemoPalette.danger,
            ),
            buildPitfallsSection(),
            buildSectionHeader(
              '10',
              'API code block',
              'Constructor signature and a typical usage block.',
              Icons.code_outlined,
              PopDemoPalette.hero,
            ),
            buildApiCodeSection(),
            buildSectionHeader(
              '11',
              'Footer',
              'Version stamp and reference links.',
              Icons.flag_outlined,
              PopDemoPalette.underOpen,
            ),
            buildFooterCard(),
          ],
        ),
      ),
    ),
  );
}
