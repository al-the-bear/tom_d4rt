// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';

// =============================================================================
// SnackBar — Visual Deep Demo
// =============================================================================
// Hand-authored static snapshot exploring the Material SnackBar family:
//   - SnackBar
//   - SnackBarAction
//   - SnackBarBehavior
//   - ScaffoldMessenger
//   - SnackBarThemeData
// All SnackBars below are rendered as inline mocks (no runtime show calls).
// =============================================================================

const Color _ink = Color(0xFF1B1410);
const Color _inkSoft = Color(0xFF4E433C);
const Color _inkMuted = Color(0xFF8A7E73);
const Color _paper = Color(0xFFFAF7F2);
const Color _paperSoft = Color(0xFFF1EAE0);
const Color _line = Color(0xFFE3D9CC);
const Color _accent = Color(0xFFB5651D);
const Color _accentSoft = Color(0xFFF3D9BD);

const Color _infoBg = Color(0xFF1E4F8C);
const Color _infoSoft = Color(0xFFCFE0F5);
const Color _successBg = Color(0xFF1F6B3A);
const Color _successSoft = Color(0xFFCFE8D6);
const Color _warnBg = Color(0xFF8A5A00);
const Color _warnSoft = Color(0xFFF5E2BC);
const Color _errorBg = Color(0xFF8B2A1F);
const Color _errorSoft = Color(0xFFF1CFCB);
const Color _neutralBg = Color(0xFF333030);
const Color _neutralSoft = Color(0xFFDAD4CB);

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(useMaterial3: true),
    home: Scaffold(
      backgroundColor: _paper,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20.0, 24.0, 20.0, 60.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const <Widget>[
              _HeroCard(),
              SizedBox(height: 28.0),
              _AnatomySection(),
              SizedBox(height: 28.0),
              _BehaviorSection(),
              SizedBox(height: 28.0),
              _ActionSection(),
              SizedBox(height: 28.0),
              _SeveritySection(),
              SizedBox(height: 28.0),
              _MultiLineSection(),
              SizedBox(height: 28.0),
              _DurationSection(),
              SizedBox(height: 28.0),
              _ThemeSection(),
              SizedBox(height: 28.0),
              _LifecycleSection(),
              SizedBox(height: 28.0),
              _CompareSection(),
              SizedBox(height: 28.0),
              _PitfallsSection(),
              SizedBox(height: 28.0),
              _UseCasesSection(),
              SizedBox(height: 28.0),
              _FooterCard(),
            ],
          ),
        ),
      ),
    ),
  );
}

// =============================================================================
// Hero Card
// =============================================================================

class _HeroCard extends StatelessWidget {
  const _HeroCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24.0, 28.0, 24.0, 28.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFF2A2017),
            Color(0xFF4C3526),
            Color(0xFF7A4F2E),
          ],
          stops: <double>[0.0, 0.55, 1.0],
        ),
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0x331B1410),
            blurRadius: 18.0,
            offset: Offset(0.0, 8.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 56.0,
                height: 56.0,
                decoration: BoxDecoration(
                  color: const Color(0xFFFAF7F2).withValues(alpha: 0.14),
                  borderRadius: const BorderRadius.all(Radius.circular(14.0)),
                  border: Border.all(
                    color: const Color(0xFFFAF7F2).withValues(alpha: 0.32),
                    width: 1.2,
                  ),
                ),
                child: const Icon(
                  Icons.notifications_active_outlined,
                  color: Color(0xFFFAF7F2),
                  size: 30.0,
                ),
              ),
              const SizedBox(width: 16.0),
              const Expanded(
                child: Text(
                  'SnackBar',
                  style: TextStyle(
                    color: Color(0xFFFAF7F2),
                    fontSize: 32.0,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                    height: 1.05,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 6.0,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFAF7F2).withValues(alpha: 0.18),
                  borderRadius: const BorderRadius.all(Radius.circular(40.0)),
                  border: Border.all(
                    color: const Color(0xFFFAF7F2).withValues(alpha: 0.36),
                    width: 1.0,
                  ),
                ),
                child: const Text(
                  'material',
                  style: TextStyle(
                    color: Color(0xFFFAF7F2),
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          const Text(
            'Brief, low-attention notifications',
            style: TextStyle(
              color: Color(0xFFF6E7D8),
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 14.0),
          Container(
            height: 1.0,
            color: const Color(0xFFFAF7F2).withValues(alpha: 0.18),
          ),
          const SizedBox(height: 14.0),
          const Text(
            'A SnackBar is a transient bar shown at the bottom of the screen '
            'that provides brief feedback about an operation. It does not '
            'block the user, can offer a single optional action, and is '
            'orchestrated by the ScaffoldMessenger queue.',
            style: TextStyle(
              color: Color(0xFFEFE0D0),
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              height: 1.55,
            ),
          ),
          const SizedBox(height: 18.0),
          Row(
            children: const <Widget>[
              _HeroChip(label: 'transient'),
              SizedBox(width: 8.0),
              _HeroChip(label: 'non-blocking'),
              SizedBox(width: 8.0),
              _HeroChip(label: 'queued'),
              SizedBox(width: 8.0),
              _HeroChip(label: 'one action'),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroChip extends StatelessWidget {
  const _HeroChip({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF7F2).withValues(alpha: 0.10),
        borderRadius: const BorderRadius.all(Radius.circular(40.0)),
        border: Border.all(
          color: const Color(0xFFFAF7F2).withValues(alpha: 0.28),
          width: 1.0,
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFFFAF7F2),
          fontSize: 11.0,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

// =============================================================================
// Section Header (reused)
// =============================================================================

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.number,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.tint,
  });

  final String number;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color tint;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18.0, 16.0, 18.0, 16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: <Color>[
            tint.withValues(alpha: 0.18),
            tint.withValues(alpha: 0.04),
          ],
        ),
        borderRadius: const BorderRadius.all(Radius.circular(14.0)),
        border: Border.all(color: tint.withValues(alpha: 0.45), width: 1.0),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 42.0,
            height: 42.0,
            decoration: BoxDecoration(
              color: tint.withValues(alpha: 0.22),
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              border: Border.all(
                color: tint.withValues(alpha: 0.55),
                width: 1.0,
              ),
            ),
            child: Icon(icon, color: tint, size: 22.0),
          ),
          const SizedBox(width: 14.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      number,
                      style: TextStyle(
                        color: tint,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: _ink,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4.0),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: _inkSoft,
                    fontSize: 13.0,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// Inline SnackBar Mock — used throughout
// =============================================================================

class _InlineSnackBar extends StatelessWidget {
  const _InlineSnackBar({
    required this.message,
    this.actionLabel,
    this.actionColor = const Color(0xFFFFB347),
    this.background = const Color(0xFF333030),
    this.floating = false,
    this.showClose = false,
    this.icon,
    this.iconColor,
    this.subtitle,
  });

  final String message;
  final String? actionLabel;
  final Color actionColor;
  final Color background;
  final bool floating;
  final bool showClose;
  final IconData? icon;
  final Color? iconColor;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final BorderRadius radius = floating
        ? const BorderRadius.all(Radius.circular(6.0))
        : const BorderRadius.only(
            topLeft: Radius.circular(4.0),
            topRight: Radius.circular(4.0),
          );
    final EdgeInsets margin = floating
        ? const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0)
        : EdgeInsets.zero;

    return Container(
      margin: margin,
      padding: const EdgeInsets.fromLTRB(16.0, 14.0, 8.0, 14.0),
      decoration: BoxDecoration(
        color: background,
        borderRadius: radius,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF000000).withValues(alpha: 0.28),
            blurRadius: floating ? 12.0 : 6.0,
            offset: Offset(0.0, floating ? 6.0 : 2.0),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          if (icon != null) ...<Widget>[
            Icon(
              icon,
              color: iconColor ?? const Color(0xFFFAF7F2),
              size: 20.0,
            ),
            const SizedBox(width: 12.0),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  message,
                  style: const TextStyle(
                    color: Color(0xFFFAF7F2),
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    height: 1.35,
                  ),
                ),
                if (subtitle != null) ...<Widget>[
                  const SizedBox(height: 3.0),
                  Text(
                    subtitle!,
                    style: TextStyle(
                      color: const Color(0xFFFAF7F2).withValues(alpha: 0.78),
                      fontSize: 12.5,
                      fontWeight: FontWeight.w400,
                      height: 1.35,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (actionLabel != null) ...<Widget>[
            const SizedBox(width: 8.0),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 6.0,
              ),
              child: Text(
                actionLabel!,
                style: TextStyle(
                  color: actionColor,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                ),
              ),
            ),
          ],
          if (showClose) ...<Widget>[
            const SizedBox(width: 4.0),
            Container(
              width: 30.0,
              height: 30.0,
              alignment: Alignment.center,
              child: Icon(
                Icons.close,
                color: const Color(0xFFFAF7F2).withValues(alpha: 0.78),
                size: 18.0,
              ),
            ),
          ],
          const SizedBox(width: 4.0),
        ],
      ),
    );
  }
}

// =============================================================================
// 2. Anatomy
// =============================================================================

class _AnatomySection extends StatelessWidget {
  const _AnatomySection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeader(
          number: '02',
          title: 'Anatomy',
          subtitle: 'The visual parts of a SnackBar.',
          icon: Icons.account_tree_outlined,
          tint: Color(0xFF1E4F8C),
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 22.0),
          decoration: BoxDecoration(
            color: _paperSoft,
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            border: Border.all(color: _line, width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                'Diagram (annotated)',
                style: TextStyle(
                  color: _ink,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.6,
                ),
              ),
              const SizedBox(height: 14.0),
              // Diagram with callout labels.
              const _InlineSnackBar(
                message: 'Connection restored.',
                actionLabel: 'OK',
                floating: true,
                showClose: true,
                icon: Icons.wifi,
              ),
              const SizedBox(height: 18.0),
              Container(
                padding: const EdgeInsets.fromLTRB(14.0, 14.0, 14.0, 14.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFAF7F2),
                  borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                  border: Border.all(color: _line, width: 1.0),
                ),
                child: Column(
                  children: const <Widget>[
                    _AnatomyRow(
                      label: 'container',
                      desc: 'Material surface (rounded if floating).',
                      color: Color(0xFF333030),
                    ),
                    _AnatomyRow(
                      label: 'content',
                      desc: 'Widget — typically a Text. The message body.',
                      color: Color(0xFF1E4F8C),
                    ),
                    _AnatomyRow(
                      label: 'action',
                      desc: 'Optional SnackBarAction — single recovery action.',
                      color: Color(0xFFB5651D),
                    ),
                    _AnatomyRow(
                      label: 'closeIcon',
                      desc: 'Optional dismiss affordance (showCloseIcon: true).',
                      color: Color(0xFF6E6259),
                    ),
                    _AnatomyRow(
                      label: 'elevation',
                      desc: 'Defaults to 6.0 (fixed) or higher for floating.',
                      color: Color(0xFF1F6B3A),
                    ),
                    _AnatomyRow(
                      label: 'behavior',
                      desc: 'SnackBarBehavior.fixed | floating.',
                      color: Color(0xFF8A5A00),
                    ),
                    _AnatomyRow(
                      label: 'shape',
                      desc: 'ShapeBorder — overrides default rounded corners.',
                      color: Color(0xFF8B2A1F),
                      last: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AnatomyRow extends StatelessWidget {
  const _AnatomyRow({
    required this.label,
    required this.desc,
    required this.color,
    this.last = false,
  });

  final String label;
  final String desc;
  final Color color;
  final bool last;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        border: last
            ? null
            : const Border(bottom: BorderSide(color: _line, width: 1.0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 5.0),
            width: 10.0,
            height: 10.0,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(
                color: color.withValues(alpha: 0.4),
                width: 2.0,
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          SizedBox(
            width: 96.0,
            child: Text(
              label,
              style: const TextStyle(
                color: _ink,
                fontSize: 13.0,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              desc,
              style: const TextStyle(
                color: _inkSoft,
                fontSize: 12.5,
                fontWeight: FontWeight.w400,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// 3. Behavior — fixed vs floating
// =============================================================================

class _BehaviorSection extends StatelessWidget {
  const _BehaviorSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeader(
          number: '03',
          title: 'SnackBarBehavior',
          subtitle: 'fixed pins to the bottom; floating gets margin + corners.',
          icon: Icons.dashboard_customize_outlined,
          tint: Color(0xFF1F6B3A),
        ),
        const SizedBox(height: 14.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Expanded(
              child: _BehaviorCard(
                heading: 'SnackBarBehavior.fixed',
                tint: Color(0xFF1E4F8C),
                description:
                    'Pinned to the bottom edge, full width. The Scaffold body '
                    'is pushed up to make room. Default behavior.',
                snackbar: _InlineSnackBar(
                  message: 'File uploaded.',
                  actionLabel: 'VIEW',
                  background: Color(0xFF333030),
                  floating: false,
                ),
                attrs: <String>[
                  'edge-to-edge',
                  'no margin',
                  'square top corners',
                  'pushes content',
                ],
              ),
            ),
            SizedBox(width: 12.0),
            const Expanded(
              child: _BehaviorCard(
                heading: 'SnackBarBehavior.floating',
                tint: Color(0xFFB5651D),
                description:
                    'Detached card with margins and rounded corners. Floats '
                    'over content. Good with FloatingActionButton.',
                snackbar: _InlineSnackBar(
                  message: 'File uploaded.',
                  actionLabel: 'VIEW',
                  background: Color(0xFF333030),
                  floating: true,
                ),
                attrs: <String>[
                  'margin: 16',
                  'rounded',
                  'higher elevation',
                  'overlaps FAB',
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _BehaviorCard extends StatelessWidget {
  const _BehaviorCard({
    required this.heading,
    required this.tint,
    required this.description,
    required this.snackbar,
    required this.attrs,
  });

  final String heading;
  final Color tint;
  final String description;
  final Widget snackbar;
  final List<String> attrs;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14.0, 16.0, 14.0, 16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            tint.withValues(alpha: 0.08),
            const Color(0xFFFAF7F2),
          ],
        ),
        borderRadius: const BorderRadius.all(Radius.circular(14.0)),
        border: Border.all(color: tint.withValues(alpha: 0.4), width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            heading,
            style: TextStyle(
              color: tint,
              fontSize: 13.0,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 10.0),
          // Mini scaffold preview.
          Container(
            height: 110.0,
            decoration: BoxDecoration(
              color: const Color(0xFFFAF7F2),
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              border: Border.all(color: _line, width: 1.0),
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                  left: 0.0,
                  right: 0.0,
                  top: 0.0,
                  child: Container(
                    height: 18.0,
                    color: _paperSoft,
                    alignment: Alignment.center,
                    child: const Text(
                      'AppBar',
                      style: TextStyle(
                        color: _inkMuted,
                        fontSize: 9.0,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0.0,
                  right: 0.0,
                  bottom: 0.0,
                  child: snackbar,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12.0),
          Text(
            description,
            style: const TextStyle(
              color: _inkSoft,
              fontSize: 12.0,
              height: 1.45,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 10.0),
          Wrap(
            spacing: 6.0,
            runSpacing: 6.0,
            children: attrs.map<Widget>((String a) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 3.0,
                ),
                decoration: BoxDecoration(
                  color: tint.withValues(alpha: 0.12),
                  borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                  border: Border.all(
                    color: tint.withValues(alpha: 0.4),
                    width: 1.0,
                  ),
                ),
                child: Text(
                  a,
                  style: TextStyle(
                    color: tint,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// 4. SnackBarAction
// =============================================================================

class _ActionSection extends StatelessWidget {
  const _ActionSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeader(
          number: '04',
          title: 'SnackBarAction',
          subtitle:
              'A single inline action — short label, idempotent callback.',
          icon: Icons.touch_app_outlined,
          tint: Color(0xFFB5651D),
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: _paperSoft,
            borderRadius: const BorderRadius.all(Radius.circular(14.0)),
            border: Border.all(color: _line, width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const <Widget>[
              _ActionVariant(
                title: 'Simple OK',
                desc: 'Acknowledge / dismiss confirmation.',
                snackbar: _InlineSnackBar(
                  message: 'Profile saved.',
                  actionLabel: 'OK',
                  floating: true,
                  actionColor: Color(0xFFFFB347),
                ),
              ),
              SizedBox(height: 10.0),
              _ActionVariant(
                title: 'Undo with affordance',
                desc: 'Reversible operation — short window to revert.',
                snackbar: _InlineSnackBar(
                  message: '3 items moved to trash.',
                  actionLabel: 'UNDO',
                  icon: Icons.delete_outline,
                  floating: true,
                  actionColor: Color(0xFF8FD3F4),
                ),
              ),
              SizedBox(height: 10.0),
              _ActionVariant(
                title: 'Destructive',
                desc: 'Highlight action color to signal danger or finality.',
                snackbar: _InlineSnackBar(
                  message: 'Unsaved changes will be lost.',
                  actionLabel: 'DISCARD',
                  floating: true,
                  background: Color(0xFF3A1A17),
                  actionColor: Color(0xFFFF8A7A),
                  icon: Icons.warning_amber_rounded,
                  iconColor: Color(0xFFFFB39A),
                ),
              ),
              SizedBox(height: 14.0),
              _ApiTable(
                rows: <_ApiRow>[
                  _ApiRow('label', 'String', 'Button text (required).'),
                  _ApiRow('onPressed', 'VoidCallback?',
                      'Tap handler. May be null to disable.'),
                  _ApiRow('textColor', 'Color?',
                      'Foreground color of the label.'),
                  _ApiRow('disabledTextColor', 'Color?',
                      'Color when onPressed is null.'),
                  _ApiRow('backgroundColor', 'Color?',
                      'Optional pill background behind the label.'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ActionVariant extends StatelessWidget {
  const _ActionVariant({
    required this.title,
    required this.desc,
    required this.snackbar,
  });

  final String title;
  final String desc;
  final Widget snackbar;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF7F2),
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        border: Border.all(color: _line, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 6.0,
                height: 14.0,
                decoration: const BoxDecoration(
                  color: _accent,
                  borderRadius: BorderRadius.all(Radius.circular(3.0)),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: _ink,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6.0),
          Padding(
            padding: const EdgeInsets.only(left: 14.0),
            child: Text(
              desc,
              style: const TextStyle(
                color: _inkSoft,
                fontSize: 12.0,
                height: 1.4,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          snackbar,
        ],
      ),
    );
  }
}

// =============================================================================
// API Table — reused
// =============================================================================

class _ApiRow {
  const _ApiRow(this.name, this.type, this.desc);
  final String name;
  final String type;
  final String desc;
}

class _ApiTable extends StatelessWidget {
  const _ApiTable({required this.rows});
  final List<_ApiRow> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFAF7F2),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        border: Border.all(color: _line, width: 1.0),
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 8.0,
            ),
            decoration: const BoxDecoration(
              color: Color(0xFFEFE3D2),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
            child: Row(
              children: const <Widget>[
                SizedBox(
                  width: 130.0,
                  child: Text(
                    'parameter',
                    style: TextStyle(
                      color: _ink,
                      fontSize: 11.0,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
                SizedBox(
                  width: 110.0,
                  child: Text(
                    'type',
                    style: TextStyle(
                      color: _ink,
                      fontSize: 11.0,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'description',
                    style: TextStyle(
                      color: _ink,
                      fontSize: 11.0,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ...rows.asMap().entries.map<Widget>((MapEntry<int, _ApiRow> e) {
            final bool last = e.key == rows.length - 1;
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 8.0,
              ),
              decoration: BoxDecoration(
                border: last
                    ? null
                    : const Border(
                        bottom: BorderSide(color: _line, width: 1.0),
                      ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 130.0,
                    child: Text(
                      e.value.name,
                      style: const TextStyle(
                        color: _ink,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 110.0,
                    child: Text(
                      e.value.type,
                      style: const TextStyle(
                        color: _accent,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      e.value.desc,
                      style: const TextStyle(
                        color: _inkSoft,
                        fontSize: 12.0,
                        height: 1.35,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

// =============================================================================
// 5. Severity variants
// =============================================================================

class _SeveritySection extends StatelessWidget {
  const _SeveritySection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeader(
          number: '05',
          title: 'Severity variants',
          subtitle: 'Color + icon convey meaning at a glance.',
          icon: Icons.palette_outlined,
          tint: Color(0xFF8B2A1F),
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Color(0xFFFAF7F2),
                Color(0xFFEFE3D2),
              ],
            ),
            borderRadius: const BorderRadius.all(Radius.circular(14.0)),
            border: Border.all(color: _line, width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const <Widget>[
              _SeverityRow(
                label: 'info',
                tint: _infoBg,
                soft: _infoSoft,
                snackbar: _InlineSnackBar(
                  message: 'New version available — 1.4.0',
                  actionLabel: 'DETAILS',
                  background: _infoBg,
                  floating: true,
                  icon: Icons.info_outline,
                  actionColor: Color(0xFFCFE0F5),
                ),
              ),
              SizedBox(height: 10.0),
              _SeverityRow(
                label: 'success',
                tint: _successBg,
                soft: _successSoft,
                snackbar: _InlineSnackBar(
                  message: 'Backup completed.',
                  actionLabel: 'VIEW',
                  background: _successBg,
                  floating: true,
                  icon: Icons.check_circle_outline,
                  actionColor: Color(0xFFCFE8D6),
                ),
              ),
              SizedBox(height: 10.0),
              _SeverityRow(
                label: 'warning',
                tint: _warnBg,
                soft: _warnSoft,
                snackbar: _InlineSnackBar(
                  message: 'Battery low (12%).',
                  actionLabel: 'POWER',
                  background: _warnBg,
                  floating: true,
                  icon: Icons.battery_alert,
                  actionColor: Color(0xFFFFE0A6),
                ),
              ),
              SizedBox(height: 10.0),
              _SeverityRow(
                label: 'error',
                tint: _errorBg,
                soft: _errorSoft,
                snackbar: _InlineSnackBar(
                  message: 'Failed to send message.',
                  actionLabel: 'RETRY',
                  background: _errorBg,
                  floating: true,
                  icon: Icons.error_outline,
                  actionColor: Color(0xFFFFB39A),
                ),
              ),
              SizedBox(height: 10.0),
              _SeverityRow(
                label: 'neutral',
                tint: _neutralBg,
                soft: _neutralSoft,
                snackbar: _InlineSnackBar(
                  message: 'Clipboard cleared.',
                  background: _neutralBg,
                  floating: true,
                  icon: Icons.content_paste_off_outlined,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SeverityRow extends StatelessWidget {
  const _SeverityRow({
    required this.label,
    required this.tint,
    required this.soft,
    required this.snackbar,
  });

  final String label;
  final Color tint;
  final Color soft;
  final Widget snackbar;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 84.0,
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 6.0,
          ),
          decoration: BoxDecoration(
            color: soft,
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            border: Border.all(color: tint.withValues(alpha: 0.6), width: 1.0),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: tint,
              fontSize: 11.0,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.8,
              fontFamily: 'monospace',
            ),
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(child: snackbar),
      ],
    );
  }
}

// =============================================================================
// 6. Multi-line + dismissible
// =============================================================================

class _MultiLineSection extends StatelessWidget {
  const _MultiLineSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeader(
          number: '06',
          title: 'Multi-line & dismissible',
          subtitle:
              'Longer text wraps; showCloseIcon adds an explicit dismiss.',
          icon: Icons.format_align_left_outlined,
          tint: Color(0xFF4E433C),
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: _paperSoft,
            borderRadius: const BorderRadius.all(Radius.circular(14.0)),
            border: Border.all(color: _line, width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const <Widget>[
              _InlineSnackBar(
                message: 'Couldn\'t sync your library.',
                subtitle:
                    'Your internet connection appears unstable. We\'ll keep '
                    'retrying every 30 seconds until you\'re back online.',
                actionLabel: 'RETRY',
                showClose: true,
                icon: Icons.sync_problem,
                floating: true,
                actionColor: Color(0xFFFFB347),
              ),
              SizedBox(height: 12.0),
              _BulletList(
                items: <String>[
                  'Use 2-line content sparingly — keep messages glanceable.',
                  'showCloseIcon: true forces an explicit dismiss control.',
                  'For ongoing tasks use a progress card, not a SnackBar.',
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _BulletList extends StatelessWidget {
  const _BulletList({required this.items});
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: items.map<Widget>((String s) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 7.0, right: 8.0),
                width: 6.0,
                height: 6.0,
                decoration: const BoxDecoration(
                  color: _accent,
                  shape: BoxShape.circle,
                ),
              ),
              Expanded(
                child: Text(
                  s,
                  style: const TextStyle(
                    color: _inkSoft,
                    fontSize: 12.5,
                    height: 1.45,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

// =============================================================================
// 7. Duration / queueing
// =============================================================================

class _DurationSection extends StatelessWidget {
  const _DurationSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeader(
          number: '07',
          title: 'Duration & queueing',
          subtitle:
              'ScaffoldMessenger serialises SnackBars — one at a time, FIFO.',
          icon: Icons.timer_outlined,
          tint: Color(0xFF1E4F8C),
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Color(0xFFE9EEF6),
                Color(0xFFFAF7F2),
              ],
            ),
            borderRadius: const BorderRadius.all(Radius.circular(14.0)),
            border: Border.all(color: _line, width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                'Queue (first → waits → next)',
                style: TextStyle(
                  color: _ink,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.6,
                ),
              ),
              const SizedBox(height: 12.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const <Widget>[
                  Expanded(
                    child: _QueueSlot(
                      stage: 'showing',
                      stageColor: Color(0xFF1F6B3A),
                      message: 'Saved draft.',
                      durationLabel: '2s',
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Icon(Icons.arrow_forward, color: _inkMuted, size: 18.0),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: _QueueSlot(
                      stage: 'next',
                      stageColor: Color(0xFFB5651D),
                      message: 'Uploaded image.',
                      durationLabel: '4s',
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Icon(Icons.arrow_forward, color: _inkMuted, size: 18.0),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: _QueueSlot(
                      stage: 'queued',
                      stageColor: Color(0xFF6E6259),
                      message: 'Synced 12 files.',
                      durationLabel: '10s',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18.0),
              const _DurationLegend(),
              const SizedBox(height: 12.0),
              _ApiTable(
                rows: <_ApiRow>[
                  _ApiRow('duration', 'Duration',
                      'Time visible. Defaults to 4 seconds.'),
                  _ApiRow('SnackBarClosedReason', 'enum',
                      'timeout | action | dismiss | hide | remove | swipe.'),
                  _ApiRow('hideCurrentSnackBar', 'method',
                      'Removes the current bar and shows the next queued.'),
                  _ApiRow('clearSnackBars', 'method',
                      'Removes the current bar AND clears the queue.'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _QueueSlot extends StatelessWidget {
  const _QueueSlot({
    required this.stage,
    required this.stageColor,
    required this.message,
    required this.durationLabel,
  });

  final String stage;
  final Color stageColor;
  final String message;
  final String durationLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF7F2),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        border: Border.all(color: stageColor.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 7.0,
              vertical: 2.0,
            ),
            decoration: BoxDecoration(
              color: stageColor.withValues(alpha: 0.18),
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            ),
            child: Text(
              stage,
              style: TextStyle(
                color: stageColor,
                fontSize: 10.0,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.8,
              ),
            ),
          ),
          const SizedBox(height: 6.0),
          _InlineSnackBar(
            message: message,
            background: const Color(0xFF333030),
            floating: true,
          ),
          const SizedBox(height: 6.0),
          Row(
            children: <Widget>[
              const Icon(Icons.access_time, size: 11.0, color: _inkMuted),
              const SizedBox(width: 4.0),
              Text(
                'duration: $durationLabel',
                style: const TextStyle(
                  color: _inkMuted,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DurationLegend extends StatelessWidget {
  const _DurationLegend();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const <Widget>[
        Expanded(
          child: _DurationChip(
            label: 'Duration(seconds: 2)',
            usage: 'Quick acknowledgements (saved, copied).',
            tint: Color(0xFF1F6B3A),
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: _DurationChip(
            label: 'Duration(seconds: 4)',
            usage: 'Default — most actionable messages.',
            tint: Color(0xFF1E4F8C),
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: _DurationChip(
            label: 'Duration(seconds: 10)',
            usage: 'Long messages or undo windows.',
            tint: Color(0xFF8A5A00),
          ),
        ),
      ],
    );
  }
}

class _DurationChip extends StatelessWidget {
  const _DurationChip({
    required this.label,
    required this.usage,
    required this.tint,
  });

  final String label;
  final String usage;
  final Color tint;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            tint.withValues(alpha: 0.14),
            tint.withValues(alpha: 0.02),
          ],
        ),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        border: Border.all(color: tint.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              color: tint,
              fontSize: 11.0,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
              height: 1.3,
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            usage,
            style: const TextStyle(
              color: _inkSoft,
              fontSize: 11.5,
              height: 1.4,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// 8. SnackBarThemeData
// =============================================================================

class _ThemeSection extends StatelessWidget {
  const _ThemeSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeader(
          number: '08',
          title: 'SnackBarThemeData',
          subtitle:
              'Theme-level defaults — set once in ThemeData.snackBarTheme.',
          icon: Icons.brush_outlined,
          tint: Color(0xFF6E2F8B),
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Color(0xFFF1E6F8),
                Color(0xFFFAF7F2),
              ],
            ),
            borderRadius: const BorderRadius.all(Radius.circular(14.0)),
            border: Border.all(color: _line, width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                'Theme parameters',
                style: TextStyle(
                  color: _ink,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.6,
                ),
              ),
              const SizedBox(height: 12.0),
              _ApiTable(
                rows: const <_ApiRow>[
                  _ApiRow('backgroundColor', 'Color?',
                      'Default container color for SnackBars.'),
                  _ApiRow('contentTextStyle', 'TextStyle?',
                      'Style applied to the content text widget.'),
                  _ApiRow('actionTextColor', 'Color?',
                      'Default color of the SnackBarAction label.'),
                  _ApiRow('disabledActionTextColor', 'Color?',
                      'Action color when onPressed is null.'),
                  _ApiRow('actionBackgroundColor', 'Color?',
                      'Optional pill behind the action label.'),
                  _ApiRow('shape', 'ShapeBorder?',
                      'Default border / corner radius.'),
                  _ApiRow('elevation', 'double?',
                      'Default Material elevation (e.g. 6.0).'),
                  _ApiRow('behavior', 'SnackBarBehavior?',
                      'fixed | floating default.'),
                  _ApiRow('width', 'double?',
                      'Fixed width when floating. Null = match margin.'),
                  _ApiRow('insetPadding', 'EdgeInsets?',
                      'Margin around a floating SnackBar.'),
                  _ApiRow('closeIconColor', 'Color?',
                      'Tint of the close icon when showCloseIcon: true.'),
                  _ApiRow('showCloseIcon', 'bool?',
                      'Whether the close icon shows by default.'),
                ],
              ),
              const SizedBox(height: 14.0),
              Container(
                padding: const EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF1B1410),
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  border: Border.all(
                    color: const Color(0xFF6E2F8B).withValues(alpha: 0.5),
                  ),
                ),
                child: const Text(
                  'ThemeData(\n'
                  '  useMaterial3: true,\n'
                  '  snackBarTheme: SnackBarThemeData(\n'
                  '    behavior: SnackBarBehavior.floating,\n'
                  '    backgroundColor: Color(0xFF333030),\n'
                  '    actionTextColor: Color(0xFFFFB347),\n'
                  '    contentTextStyle: TextStyle(\n'
                  '      color: Color(0xFFFAF7F2),\n'
                  '      fontSize: 14.0,\n'
                  '      fontWeight: FontWeight.w500,\n'
                  '    ),\n'
                  '    shape: RoundedRectangleBorder(\n'
                  '      borderRadius: BorderRadius.all(Radius.circular(8)),\n'
                  '    ),\n'
                  '    elevation: 6.0,\n'
                  '    insetPadding: EdgeInsets.symmetric(\n'
                  '      horizontal: 16.0,\n'
                  '      vertical: 12.0,\n'
                  '    ),\n'
                  '    closeIconColor: Color(0xFFFAF7F2),\n'
                  '  ),\n'
                  ')',
                  style: TextStyle(
                    color: Color(0xFFE8DDF1),
                    fontSize: 11.5,
                    height: 1.55,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// 9. ScaffoldMessenger lifecycle
// =============================================================================

class _LifecycleSection extends StatelessWidget {
  const _LifecycleSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeader(
          number: '09',
          title: 'ScaffoldMessenger',
          subtitle:
              'The host that queues, shows, and disposes SnackBars per scope.',
          icon: Icons.layers_outlined,
          tint: Color(0xFF1F6B3A),
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: _paperSoft,
            borderRadius: const BorderRadius.all(Radius.circular(14.0)),
            border: Border.all(color: _line, width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF14241A),
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  border: Border.all(
                    color: const Color(0xFF1F6B3A).withValues(alpha: 0.6),
                  ),
                ),
                child: const Text(
                  '// Canonical pattern\n'
                  'ScaffoldMessenger.of(context).showSnackBar(\n'
                  '  SnackBar(\n'
                  '    content: const Text(\'Saved\'),\n'
                  '    behavior: SnackBarBehavior.floating,\n'
                  '    duration: const Duration(seconds: 4),\n'
                  '    action: SnackBarAction(\n'
                  '      label: \'Undo\',\n'
                  '      onPressed: undo,\n'
                  '    ),\n'
                  '  ),\n'
                  ');',
                  style: TextStyle(
                    color: Color(0xFFCFE8D6),
                    fontSize: 12.0,
                    height: 1.55,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 14.0),
              const Text(
                'Lifecycle steps',
                style: TextStyle(
                  color: _ink,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.6,
                ),
              ),
              const SizedBox(height: 10.0),
              const _LifecycleStep(
                index: '1',
                title: 'Look up the messenger',
                desc:
                    'ScaffoldMessenger.of(context) walks up the tree to find '
                    'the nearest ScaffoldMessenger above the Scaffold.',
              ),
              const _LifecycleStep(
                index: '2',
                title: 'Enqueue the SnackBar',
                desc:
                    'showSnackBar returns a ScaffoldFeatureController. The '
                    'SnackBar is appended to the FIFO queue.',
              ),
              const _LifecycleStep(
                index: '3',
                title: 'Present',
                desc:
                    'The current bar slides in. Other queued bars wait until '
                    'the current bar is dismissed or times out.',
              ),
              const _LifecycleStep(
                index: '4',
                title: 'Dismiss',
                desc:
                    'Triggered by timeout, action tap, swipe, hideCurrent or '
                    'removeCurrent. Closed reason is reported to listeners.',
              ),
              const _LifecycleStep(
                index: '5',
                title: 'Dispose',
                desc:
                    'Controller is closed; widget is disposed; next queued '
                    'bar (if any) becomes current.',
                last: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LifecycleStep extends StatelessWidget {
  const _LifecycleStep({
    required this.index,
    required this.title,
    required this.desc,
    this.last = false,
  });

  final String index;
  final String title;
  final String desc;
  final bool last;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                width: 28.0,
                height: 28.0,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Color(0xFF1F6B3A),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  index,
                  style: const TextStyle(
                    color: Color(0xFFFAF7F2),
                    fontSize: 12.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              if (!last)
                Expanded(
                  child: Container(
                    width: 2.0,
                    color: const Color(0xFF1F6B3A).withValues(alpha: 0.3),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: last ? 0.0 : 14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: _ink,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    desc,
                    style: const TextStyle(
                      color: _inkSoft,
                      fontSize: 12.5,
                      height: 1.45,
                      fontWeight: FontWeight.w400,
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
}

// =============================================================================
// 10. vs BottomSheet vs Banner vs Dialog
// =============================================================================

class _CompareSection extends StatelessWidget {
  const _CompareSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeader(
          number: '10',
          title: 'Compare to siblings',
          subtitle:
              'SnackBar vs BottomSheet vs MaterialBanner vs Dialog.',
          icon: Icons.compare_arrows,
          tint: Color(0xFF4E433C),
        ),
        const SizedBox(height: 14.0),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFAF7F2),
            borderRadius: const BorderRadius.all(Radius.circular(14.0)),
            border: Border.all(color: _line, width: 1.0),
          ),
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 10.0,
                ),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: <Color>[
                      Color(0xFFEFE3D2),
                      Color(0xFFE3D9CC),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14.0),
                    topRight: Radius.circular(14.0),
                  ),
                ),
                child: Row(
                  children: const <Widget>[
                    SizedBox(
                      width: 120.0,
                      child: Text(
                        'widget',
                        style: TextStyle(
                          color: _ink,
                          fontSize: 11.0,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 80.0,
                      child: Text(
                        'modal',
                        style: TextStyle(
                          color: _ink,
                          fontSize: 11.0,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 70.0,
                      child: Text(
                        'persists',
                        style: TextStyle(
                          color: _ink,
                          fontSize: 11.0,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'best for',
                        style: TextStyle(
                          color: _ink,
                          fontSize: 11.0,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const _CompareRow(
                widget: 'SnackBar',
                modal: 'no',
                persists: 'no (4s)',
                best: 'Brief feedback, one optional action.',
                tint: Color(0xFFB5651D),
              ),
              const _CompareRow(
                widget: 'MaterialBanner',
                modal: 'no',
                persists: 'yes',
                best:
                    'High-priority info that stays until acknowledged. '
                    'Up to 2 actions.',
                tint: Color(0xFF1E4F8C),
              ),
              const _CompareRow(
                widget: 'BottomSheet',
                modal: 'optional',
                persists: 'yes',
                best:
                    'Secondary content / forms anchored to the bottom. May '
                    'cover most of the screen.',
                tint: Color(0xFF1F6B3A),
              ),
              const _CompareRow(
                widget: 'Dialog',
                modal: 'yes',
                persists: 'yes',
                best:
                    'Critical decisions that block other work — confirm, '
                    'authenticate, fatal errors.',
                tint: Color(0xFF8B2A1F),
                last: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CompareRow extends StatelessWidget {
  const _CompareRow({
    required this.widget,
    required this.modal,
    required this.persists,
    required this.best,
    required this.tint,
    this.last = false,
  });

  final String widget;
  final String modal;
  final String persists;
  final String best;
  final Color tint;
  final bool last;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      decoration: BoxDecoration(
        border: last
            ? null
            : const Border(bottom: BorderSide(color: _line, width: 1.0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 120.0,
            child: Row(
              children: <Widget>[
                Container(
                  width: 8.0,
                  height: 8.0,
                  decoration: BoxDecoration(
                    color: tint,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6.0),
                Flexible(
                  child: Text(
                    widget,
                    style: TextStyle(
                      color: tint,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 80.0,
            child: Text(
              modal,
              style: const TextStyle(
                color: _inkSoft,
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            width: 70.0,
            child: Text(
              persists,
              style: const TextStyle(
                color: _inkSoft,
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              best,
              style: const TextStyle(
                color: _inkSoft,
                fontSize: 12.0,
                height: 1.4,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// 11. Pitfalls
// =============================================================================

class _PitfallsSection extends StatelessWidget {
  const _PitfallsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeader(
          number: '11',
          title: 'Pitfalls',
          subtitle: 'Common mistakes and how to avoid them.',
          icon: Icons.warning_amber_rounded,
          tint: Color(0xFF8A5A00),
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Color(0xFFFFF5E2),
                Color(0xFFFAF7F2),
              ],
            ),
            borderRadius: const BorderRadius.all(Radius.circular(14.0)),
            border: Border.all(color: _line, width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const <Widget>[
              _Pitfall(
                bad: 'Hard-to-read action text.',
                good:
                    'Use textColor with strong contrast against the SnackBar '
                    'background — yellow on dark, dark on light.',
              ),
              _Pitfall(
                bad: 'SnackBar hidden behind the soft keyboard.',
                good:
                    'Use SnackBarBehavior.floating + close the keyboard, or '
                    'wrap content in a Scaffold that accounts for the inset.',
              ),
              _Pitfall(
                bad:
                    'FloatingActionButton overlaps the action label so taps '
                    'land on the wrong target.',
                good:
                    'Use floating behavior and set width / insetPadding so '
                    'the bar sits clear of the FAB.',
              ),
              _Pitfall(
                bad:
                    'SnackBarAction.onPressed left null — the action looks '
                    'tappable but is disabled.',
                good:
                    'Always provide a real handler; rely on disabled colors '
                    'only for transient post-tap states.',
              ),
              _Pitfall(
                bad: 'Using SnackBar for critical errors that must be acted on.',
                good:
                    'Use a Dialog or MaterialBanner. SnackBar is dismissed in '
                    'seconds and may never be seen.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Pitfall extends StatelessWidget {
  const _Pitfall({required this.bad, required this.good});
  final String bad;
  final String good;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF7F2),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        border: Border.all(color: _line, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 2.0),
                padding: const EdgeInsets.symmetric(
                  horizontal: 6.0,
                  vertical: 1.0,
                ),
                decoration: const BoxDecoration(
                  color: Color(0xFFF1CFCB),
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
                child: const Text(
                  'NO',
                  style: TextStyle(
                    color: _errorBg,
                    fontSize: 10.0,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  bad,
                  style: const TextStyle(
                    color: _ink,
                    fontSize: 13.0,
                    fontWeight: FontWeight.w700,
                    height: 1.35,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 2.0),
                padding: const EdgeInsets.symmetric(
                  horizontal: 6.0,
                  vertical: 1.0,
                ),
                decoration: const BoxDecoration(
                  color: Color(0xFFCFE8D6),
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
                child: const Text(
                  'YES',
                  style: TextStyle(
                    color: _successBg,
                    fontSize: 10.0,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  good,
                  style: const TextStyle(
                    color: _inkSoft,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// 12. Use cases
// =============================================================================

class _UseCasesSection extends StatelessWidget {
  const _UseCasesSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeader(
          number: '12',
          title: 'Use cases',
          subtitle: 'Four canonical SnackBar patterns.',
          icon: Icons.lightbulb_outline,
          tint: Color(0xFF1F6B3A),
        ),
        const SizedBox(height: 14.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Expanded(
              child: _UseCaseCard(
                title: 'Undo deletion',
                description:
                    'Soft-delete a record, then offer a short window to '
                    'recover it. Pair with a Duration of 5-7 seconds.',
                tint: Color(0xFFB5651D),
                snackbar: _InlineSnackBar(
                  message: 'Note moved to trash.',
                  actionLabel: 'UNDO',
                  icon: Icons.delete_outline,
                  floating: true,
                  actionColor: Color(0xFFFFB347),
                ),
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: _UseCaseCard(
                title: 'Network failure',
                description:
                    'Surface a transient failure and offer to retry. Keep '
                    'the message short; the action is the recovery path.',
                tint: Color(0xFF8B2A1F),
                snackbar: _InlineSnackBar(
                  message: 'Couldn\'t reach server.',
                  actionLabel: 'RETRY',
                  icon: Icons.cloud_off,
                  floating: true,
                  background: _errorBg,
                  actionColor: Color(0xFFFFB39A),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Expanded(
              child: _UseCaseCard(
                title: 'Save confirmation',
                description:
                    'Acknowledge that an operation completed successfully — '
                    'short duration, no action needed.',
                tint: Color(0xFF1F6B3A),
                snackbar: _InlineSnackBar(
                  message: 'Profile saved.',
                  icon: Icons.check_circle_outline,
                  floating: true,
                  background: _successBg,
                ),
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: _UseCaseCard(
                title: 'Sync progress',
                description:
                    'A neutral status update. Pair with a DETAILS action so '
                    'the user can drill into the sync log if curious.',
                tint: Color(0xFF1E4F8C),
                snackbar: _InlineSnackBar(
                  message: 'Synced 12 files.',
                  actionLabel: 'DETAILS',
                  icon: Icons.sync,
                  floating: true,
                  background: _infoBg,
                  actionColor: Color(0xFFCFE0F5),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _UseCaseCard extends StatelessWidget {
  const _UseCaseCard({
    required this.title,
    required this.description,
    required this.tint,
    required this.snackbar,
  });

  final String title;
  final String description;
  final Color tint;
  final Widget snackbar;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            tint.withValues(alpha: 0.10),
            const Color(0xFFFAF7F2),
          ],
        ),
        borderRadius: const BorderRadius.all(Radius.circular(14.0)),
        border: Border.all(color: tint.withValues(alpha: 0.4), width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 28.0,
                height: 28.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: tint.withValues(alpha: 0.18),
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Icon(Icons.star_outline, color: tint, size: 16.0),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: tint,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            description,
            style: const TextStyle(
              color: _inkSoft,
              fontSize: 12.0,
              height: 1.45,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 12.0),
          snackbar,
        ],
      ),
    );
  }
}

// =============================================================================
// Footer
// =============================================================================

class _FooterCard extends StatelessWidget {
  const _FooterCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20.0, 18.0, 20.0, 18.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFFE3D9CC),
            Color(0xFFF1EAE0),
            Color(0xFFFAF7F2),
          ],
        ),
        borderRadius: const BorderRadius.all(Radius.circular(14.0)),
        border: Border.all(color: _line, width: 1.0),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 36.0,
            height: 36.0,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: _ink,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.notifications_active_outlined,
              color: _paper,
              size: 18.0,
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  'SnackBar — visual deep demo',
                  style: TextStyle(
                    color: _ink,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.2,
                  ),
                ),
                SizedBox(height: 3.0),
                Text(
                  'flutter/material.dart · Material 3 · static snapshot',
                  style: TextStyle(
                    color: _inkSoft,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w500,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 5.0,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFFAF7F2),
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
              border: Border.all(color: _line, width: 1.0),
            ),
            child: const Text(
              'v1.0',
              style: TextStyle(
                color: _ink,
                fontSize: 11.0,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.6,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
