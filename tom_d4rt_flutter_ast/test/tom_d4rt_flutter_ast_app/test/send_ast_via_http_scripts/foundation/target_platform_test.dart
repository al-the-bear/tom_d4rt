// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo - TargetPlatform from foundation
// Live, hand-built demonstration of TargetPlatform values and how Flutter
// adapts widgets, fonts, gestures and physics for each one.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// =============================================================================
// PLATFORM METADATA HELPERS (top-level, hand-written, no codegen)
// =============================================================================

// ----------------------------------------------------------------------------
// Cluster P4 workaround: d4rt may fail to match `case BridgedEnum.value:` in
// switch statements over bridged Flutter enums (TargetPlatform is one). When
// that happens a String-returning switch falls through and the function
// returns null implicitly, which then surfaces as `Text(data: null)` in
// downstream widgets. Convert each helper to an if/else chain over `==`
// (the path already used by `_isCupertinoFamily` below — proven working).
// ----------------------------------------------------------------------------

String _platformOs(TargetPlatform p) {
  if (p == TargetPlatform.android) return 'Android';
  if (p == TargetPlatform.iOS) return 'iOS / iPadOS';
  if (p == TargetPlatform.fuchsia) return 'Fuchsia';
  if (p == TargetPlatform.linux) return 'Linux desktop';
  if (p == TargetPlatform.macOS) return 'macOS';
  if (p == TargetPlatform.windows) return 'Windows';
  return p.name; // unreachable on real Dart; safety net for the d4rt path
}

String _platformFamily(TargetPlatform p) {
  if (p == TargetPlatform.iOS || p == TargetPlatform.macOS) return 'Cupertino';
  return 'Material';
}

bool _isCupertinoFamily(TargetPlatform p) {
  return p == TargetPlatform.iOS || p == TargetPlatform.macOS;
}

String _platformFontFamily(TargetPlatform p) {
  if (p == TargetPlatform.android) return 'Roboto';
  if (p == TargetPlatform.iOS) return '.SF Pro Text';
  if (p == TargetPlatform.fuchsia) return 'Noto Sans';
  if (p == TargetPlatform.linux) return 'Noto Sans';
  if (p == TargetPlatform.macOS) return '.SF Pro Display';
  if (p == TargetPlatform.windows) return 'Segoe UI';
  return 'Roboto';
}

String _platformBackGesture(TargetPlatform p) {
  if (p == TargetPlatform.iOS || p == TargetPlatform.macOS) {
    return 'edge swipe + chevron';
  }
  if (p == TargetPlatform.android || p == TargetPlatform.fuchsia) {
    return 'system back + arrow';
  }
  return 'desktop chrome back';
}

String _platformLongPress(TargetPlatform p) {
  if (p == TargetPlatform.iOS || p == TargetPlatform.macOS) {
    return 'context menu (preview)';
  }
  if (p == TargetPlatform.android || p == TargetPlatform.fuchsia) {
    return 'selection toolbar';
  }
  return 'right-click menu';
}

String _platformIcon(TargetPlatform p) {
  if (p == TargetPlatform.android) return 'A';
  if (p == TargetPlatform.iOS) return 'i';
  if (p == TargetPlatform.fuchsia) return 'F';
  if (p == TargetPlatform.linux) return 'L';
  if (p == TargetPlatform.macOS) return 'M';
  if (p == TargetPlatform.windows) return 'W';
  return '?';
}

String _platformPhysics(TargetPlatform p) {
  return _isCupertinoFamily(p)
      ? 'BouncingScrollPhysics'
      : 'ClampingScrollPhysics';
}

Color _platformTint(TargetPlatform p) {
  if (p == TargetPlatform.android) return const Color(0xFF2E7D32);
  if (p == TargetPlatform.iOS) return const Color(0xFF455A64);
  if (p == TargetPlatform.fuchsia) return const Color(0xFFAD1457);
  if (p == TargetPlatform.linux) return const Color(0xFF5D4037);
  if (p == TargetPlatform.macOS) return const Color(0xFF37474F);
  if (p == TargetPlatform.windows) return const Color(0xFF1565C0);
  return const Color(0xFF455A64);
}

Color _platformTintSoft(TargetPlatform p) {
  if (p == TargetPlatform.android) return const Color(0xFFC8E6C9);
  if (p == TargetPlatform.iOS) return const Color(0xFFCFD8DC);
  if (p == TargetPlatform.fuchsia) return const Color(0xFFF8BBD0);
  if (p == TargetPlatform.linux) return const Color(0xFFD7CCC8);
  if (p == TargetPlatform.macOS) return const Color(0xFFB0BEC5);
  if (p == TargetPlatform.windows) return const Color(0xFFBBDEFB);
  return const Color(0xFFCFD8DC);
}

String _platformAdaptSummary(TargetPlatform p) {
  if (p == TargetPlatform.android) {
    return 'Material 3 widgets, Roboto, ripple feedback, '
        'ClampingScrollPhysics, MaterialPageRoute fade-up.';
  }
  if (p == TargetPlatform.iOS) {
    return 'Cupertino widgets, .SF Pro Text, edge-swipe back, '
        'BouncingScrollPhysics, CupertinoPageRoute slide.';
  }
  if (p == TargetPlatform.fuchsia) {
    return 'Material widgets with neutral defaults, Noto Sans fallback, '
        'ClampingScrollPhysics.';
  }
  if (p == TargetPlatform.linux) {
    return 'Material widgets sized for pointer input, Noto Sans, '
        'ClampingScrollPhysics, mouse-friendly hit areas.';
  }
  if (p == TargetPlatform.macOS) {
    return 'Cupertino widgets with desktop spacing, .SF Pro Display, '
        'BouncingScrollPhysics, native menu/cmd shortcuts.';
  }
  if (p == TargetPlatform.windows) {
    return 'Material widgets with Windows accent, Segoe UI, '
        'ClampingScrollPhysics, right-click menus.';
  }
  return 'Material widgets, default theme.';
}

// =============================================================================
// SECTION 1 — CURRENT PLATFORM HERO CARD
// =============================================================================

Widget _buildHeroCard(BuildContext context) {
  final TargetPlatform current = defaultTargetPlatform;
  final Color tint = _platformTint(current);
  final Color soft = _platformTintSoft(current);

  return Container(
    margin: const EdgeInsets.all(16),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: soft,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: tint, width: 2),
      boxShadow: [
        BoxShadow(
          color: tint.withOpacity(0.25),
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 56,
              height: 56,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: tint,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                _platformIcon(current),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'defaultTargetPlatform',
                    style: TextStyle(
                      fontSize: 12,
                      color: tint,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    current.name,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: tint,
                      fontFamily: _platformFontFamily(current),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _heroChip('OS', _platformOs(current), tint),
            _heroChip('Family', _platformFamily(current), tint),
            _heroChip('kIsWeb', kIsWeb.toString(), tint),
            _heroChip('Index', current.index.toString(), tint),
            _heroChip('Physics', _platformPhysics(current), tint),
            _heroChip('Font', _platformFontFamily(current), tint),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.7),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.auto_awesome, color: tint, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'What Flutter adapts for you: '
                  '${_platformAdaptSummary(current)}',
                  style: TextStyle(
                    fontSize: 13,
                    color: tint,
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

Widget _heroChip(String label, String value, Color tint) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: tint.withOpacity(0.4)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$label:',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: tint.withOpacity(0.7),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: tint,
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 2 — ADAPTED WIDGET GALLERY
// =============================================================================

Widget _buildGallery(BuildContext context) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFFFFF8E1),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: const Color(0xFFFFB300)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Section 2 — Adapted-widget gallery',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFFE65100),
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Each card builds the widgets Flutter would pick on that platform, '
          'independent of the runner.',
          style: TextStyle(fontSize: 12, color: Color(0xFF6D4C00)),
        ),
        const SizedBox(height: 16),
        for (final TargetPlatform p in TargetPlatform.values)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _galleryCard(p),
          ),
      ],
    ),
  );
}

Widget _galleryCard(TargetPlatform p) {
  final Color tint = _platformTint(p);
  final Color soft = _platformTintSoft(p);
  final bool cupertino = _isCupertinoFamily(p);

  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: tint.withOpacity(0.5)),
      boxShadow: [
        BoxShadow(
          color: tint.withOpacity(0.15),
          blurRadius: 8,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: tint,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(14),
              topRight: Radius.circular(14),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _platformIcon(p),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      p.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${_platformOs(p)} · ${_platformFamily(p)} family',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.85),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  cupertino ? 'Cupertino' : 'Material',
                  style: TextStyle(
                    color: tint,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _galleryRowLabel('Navigation bar', p),
              const SizedBox(height: 6),
              _navBarFor(p, tint, soft, cupertino),
              const SizedBox(height: 12),
              _galleryRowLabel('Buttons', p),
              const SizedBox(height: 6),
              _buttonsFor(cupertino, tint),
              const SizedBox(height: 12),
              _galleryRowLabel('Switch', p),
              const SizedBox(height: 6),
              _switchesFor(cupertino, tint),
              const SizedBox(height: 12),
              _galleryRowLabel('Slider', p),
              const SizedBox(height: 6),
              _slidersFor(cupertino, tint),
              const SizedBox(height: 12),
              _galleryRowLabel('Dialog actions', p),
              const SizedBox(height: 6),
              _dialogActionsFor(cupertino, tint),
              const SizedBox(height: 12),
              _galleryRowLabel('Scroll physics', p),
              const SizedBox(height: 6),
              _scrollPhysicsFor(p, cupertino, tint, soft),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: soft.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Note: Flutter chooses ${_platformFamily(p)} widgets, '
                  '${_platformPhysics(p)}, '
                  'and ${_platformFontFamily(p)} for ${p.name}.',
                  style: TextStyle(
                    fontSize: 11,
                    color: tint,
                    fontStyle: FontStyle.italic,
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

Widget _galleryRowLabel(String text, TargetPlatform p) {
  return Text(
    text,
    style: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: _platformTint(p),
      letterSpacing: 0.5,
    ),
  );
}

Widget _navBarFor(
  TargetPlatform p,
  Color tint,
  Color soft,
  bool cupertino,
) {
  if (cupertino) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: tint.withOpacity(0.3)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CupertinoNavigationBar(
          backgroundColor: soft,
          middle: Text(
            '${p.name} title',
            style: TextStyle(color: tint),
          ),
          leading: Icon(CupertinoIcons.back, color: tint),
          trailing: Icon(CupertinoIcons.add, color: tint),
        ),
      ),
    );
  }
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: tint.withOpacity(0.3)),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: AppBar(
        backgroundColor: tint,
        foregroundColor: Colors.white,
        title: Text('${p.name} title'),
        leading: const Icon(Icons.arrow_back),
        actions: const [Icon(Icons.add), SizedBox(width: 12)],
        elevation: 0,
      ),
    ),
  );
}

Widget _buttonsFor(bool cupertino, Color tint) {
  if (cupertino) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        CupertinoButton.filled(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 6,
          ),
          onPressed: () {},
          child: const Text('Filled'),
        ),
        CupertinoButton(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 6,
          ),
          onPressed: () {},
          child: Text('Plain', style: TextStyle(color: tint)),
        ),
      ],
    );
  }
  return Wrap(
    spacing: 8,
    runSpacing: 8,
    children: [
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: tint,
          foregroundColor: Colors.white,
        ),
        onPressed: () {},
        child: const Text('Elevated'),
      ),
      TextButton(
        style: TextButton.styleFrom(foregroundColor: tint),
        onPressed: () {},
        child: const Text('Text'),
      ),
      OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: tint,
          side: BorderSide(color: tint),
        ),
        onPressed: () {},
        child: const Text('Outlined'),
      ),
    ],
  );
}

Widget _switchesFor(bool cupertino, Color tint) {
  if (cupertino) {
    return Row(
      children: [
        CupertinoSwitch(
          value: true,
          activeColor: tint,
          onChanged: (_) {},
        ),
        const SizedBox(width: 8),
        CupertinoSwitch(
          value: false,
          activeColor: tint,
          onChanged: (_) {},
        ),
      ],
    );
  }
  return Row(
    children: [
      Switch(
        value: true,
        activeColor: tint,
        onChanged: (_) {},
      ),
      const SizedBox(width: 8),
      Switch(
        value: false,
        activeColor: tint,
        onChanged: (_) {},
      ),
    ],
  );
}

Widget _slidersFor(bool cupertino, Color tint) {
  if (cupertino) {
    return SizedBox(
      width: 240,
      child: CupertinoSlider(
        value: 0.4,
        activeColor: tint,
        onChanged: (_) {},
      ),
    );
  }
  return SizedBox(
    width: 240,
    child: Slider(
      value: 0.4,
      activeColor: tint,
      onChanged: (_) {},
    ),
  );
}

Widget _dialogActionsFor(bool cupertino, Color tint) {
  if (cupertino) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F7),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {},
            child: Text(
              'Cancel',
              style: TextStyle(color: CupertinoColors.systemRed),
            ),
          ),
          Container(
            width: 1,
            height: 18,
            color: const Color(0xFFD1D1D6),
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {},
            child: Text(
              'Confirm',
              style: TextStyle(
                color: tint,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      TextButton(
        style: TextButton.styleFrom(foregroundColor: tint),
        onPressed: () {},
        child: const Text('CANCEL'),
      ),
      const SizedBox(width: 8),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: tint,
          foregroundColor: Colors.white,
        ),
        onPressed: () {},
        child: const Text('CONFIRM'),
      ),
    ],
  );
}

Widget _scrollPhysicsFor(
  TargetPlatform p,
  bool cupertino,
  Color tint,
  Color soft,
) {
  final ScrollPhysics physics = cupertino
      ? const BouncingScrollPhysics()
      : const ClampingScrollPhysics();
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: tint,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          _platformPhysics(p),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const SizedBox(width: 8),
      Expanded(
        child: SizedBox(
          height: 36,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: physics,
            children: [
              for (int i = 0; i < 8; i++)
                Container(
                  width: 36,
                  margin: const EdgeInsets.only(right: 4),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: soft,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '$i',
                    style: TextStyle(
                      color: tint,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    ],
  );
}

// =============================================================================
// SECTION 3 — BRANCHING HELPERS
// =============================================================================

Widget _buildBranchingHelpers(BuildContext context) {
  final TargetPlatform current = defaultTargetPlatform;
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFFE3F2FD),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: const Color(0xFF1976D2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Section 3 — Branching helpers',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0D47A1),
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Each helper switches on defaultTargetPlatform AND shows the '
          'alternative renderings for the other five platforms.',
          style: TextStyle(fontSize: 12, color: Color(0xFF1565C0)),
        ),
        const SizedBox(height: 16),
        _branchingPanel(
          'Modal route style chooser',
          'Material vs Cupertino page transitions',
          current,
          (p) => _routePreviewFor(p),
        ),
        const SizedBox(height: 16),
        _branchingPanel(
          'Font defaults',
          'Per-platform fontFamily fallback chain',
          current,
          (p) => _fontPreviewFor(p),
        ),
        const SizedBox(height: 16),
        _branchingPanel(
          'Gesture mappings (back affordance)',
          'Material arrow vs Cupertino chevron',
          current,
          (p) => _gesturePreviewFor(p),
        ),
      ],
    ),
  );
}

Widget _branchingPanel(
  String title,
  String subtitle,
  TargetPlatform current,
  Widget Function(TargetPlatform) builder,
) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFF90CAF9)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0D47A1),
          ),
        ),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 11,
            color: Color(0xFF1976D2),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFE8F5E9),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFF66BB6A)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.flash_on,
                    size: 14,
                    color: Color(0xFF2E7D32),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Live (defaultTargetPlatform = ${current.name})',
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF2E7D32),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              builder(current),
            ],
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Other platforms (hard-coded preview)',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1976D2),
          ),
        ),
        const SizedBox(height: 6),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final TargetPlatform p in TargetPlatform.values)
              if (p != current)
                Container(
                  width: 220,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFAFAFA),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFBDBDBD)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        p.name,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: _platformTint(p),
                        ),
                      ),
                      const SizedBox(height: 4),
                      builder(p),
                    ],
                  ),
                ),
          ],
        ),
      ],
    ),
  );
}

Widget _routePreviewFor(TargetPlatform p) {
  final bool cupertino = _isCupertinoFamily(p);
  if (cupertino) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F7),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFB0BEC5)),
      ),
      child: Row(
        children: [
          const Icon(
            CupertinoIcons.arrow_left_right,
            size: 16,
            color: Color(0xFF455A64),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              'CupertinoPageRoute — slides from the right with a parallax '
              'on the previous page. Edge-swipe pops back.',
              style: TextStyle(
                fontSize: 11,
                color: _platformTint(p),
              ),
            ),
          ),
        ],
      ),
    );
  }
  return Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: const Color(0xFFE8EAF6),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _platformTint(p).withOpacity(0.4)),
    ),
    child: Row(
      children: [
        Icon(
          Icons.swap_vert,
          size: 16,
          color: _platformTint(p),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            'MaterialPageRoute — fades and slides up. System back '
            'gesture pops it.',
            style: TextStyle(
              fontSize: 11,
              color: _platformTint(p),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _fontPreviewFor(TargetPlatform p) {
  final String fontFamily = _platformFontFamily(p);
  return Row(
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: _platformTint(p),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          fontFamily,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const SizedBox(width: 8),
      Expanded(
        child: Text(
          'Sample',
          style: TextStyle(
            fontSize: 18,
            fontFamily: fontFamily,
            color: _platformTint(p),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ],
  );
}

Widget _gesturePreviewFor(TargetPlatform p) {
  final bool cupertino = _isCupertinoFamily(p);
  return Row(
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: _platformTintSoft(p),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: _platformTint(p)),
        ),
        child: Text(
          cupertino ? '\u2039 Back' : '\u2190',
          style: TextStyle(
            color: _platformTint(p),
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const SizedBox(width: 8),
      Expanded(
        child: Text(
          cupertino
              ? 'iOS-style chevron with label, edge-swipe enabled.'
              : 'Material arrow icon, system back button intercepts.',
          style: TextStyle(
            fontSize: 11,
            color: _platformTint(p),
          ),
        ),
      ),
    ],
  );
}

// =============================================================================
// SECTION 4 — Theme.platform vs defaultTargetPlatform
// =============================================================================

Widget _buildThemeVsDefault(BuildContext context) {
  final TargetPlatform themePlatform = Theme.of(context).platform;
  final TargetPlatform defaultPlatform = defaultTargetPlatform;
  final Color themeTint = _platformTint(themePlatform);
  final Color defaultTint = _platformTint(defaultPlatform);

  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFFF3E5F5),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: const Color(0xFF8E24AA)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Section 4 — Theme.platform vs defaultTargetPlatform',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4A148C),
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Both expose a TargetPlatform value, but only Theme.platform '
          'respects ThemeData overrides.',
          style: TextStyle(fontSize: 12, color: Color(0xFF6A1B9A)),
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _themeComparePanel(
                'Theme.of(context).platform',
                themePlatform,
                themeTint,
                'Use this when widgets should react to theme overrides — '
                'e.g. inside a Theme(data: ThemeData(platform: ...)) wrapper. '
                'Most Material widgets read this.',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _themeComparePanel(
                'defaultTargetPlatform',
                defaultPlatform,
                defaultTint,
                'Use this for code that lives outside the widget tree '
                '(services, state, controllers) where no BuildContext is '
                'available. Ignores Theme overrides.',
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFCE93D8)),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.compare_arrows,
                color: Color(0xFF6A1B9A),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  themePlatform == defaultPlatform
                      ? 'Both currently agree on ${themePlatform.name}. '
                          'No theme override is in effect for this subtree.'
                      : 'Mismatch! Theme reports ${themePlatform.name} '
                          'while defaultTargetPlatform is '
                          '${defaultPlatform.name} — a Theme override is '
                          'reshaping this subtree.',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF4A148C),
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

Widget _themeComparePanel(
  String label,
  TargetPlatform value,
  Color tint,
  String guidance,
) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: tint),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4A148C),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            color: tint,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            value.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          guidance,
          style: TextStyle(
            fontSize: 11,
            color: tint,
            height: 1.35,
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 5 — ENUM REFERENCE CARD
// =============================================================================

Widget _buildEnumReference(BuildContext context) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFFFFF3E0),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: const Color(0xFFEF6C00)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Section 5 — Enum reference card',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFFE65100),
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'All six TargetPlatform values with name, index, OS, default '
          'widget family, and gesture conventions.',
          style: TextStyle(fontSize: 12, color: Color(0xFFBF360C)),
        ),
        const SizedBox(height: 12),
        _enumHeaderRow(),
        const SizedBox(height: 4),
        for (final TargetPlatform p in TargetPlatform.values)
          _enumDataRow(p),
      ],
    ),
  );
}

Widget _enumHeaderRow() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    decoration: BoxDecoration(
      color: const Color(0xFFEF6C00),
      borderRadius: BorderRadius.circular(8),
    ),
    child: const Row(
      children: [
        SizedBox(
          width: 70,
          child: Text(
            'Name',
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          width: 30,
          child: Text(
            '#',
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          width: 110,
          child: Text(
            'Typical OS',
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          width: 80,
          child: Text(
            'Family',
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Text(
            'Gesture conventions',
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _enumDataRow(TargetPlatform p) {
  final Color tint = _platformTint(p);
  return Container(
    margin: const EdgeInsets.only(top: 4),
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: tint.withOpacity(0.4)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 70,
          child: Row(
            children: [
              Container(
                width: 18,
                height: 18,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: tint,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  _platformIcon(p),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  p.name,
                  style: TextStyle(
                    fontSize: 12,
                    color: tint,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 30,
          child: Text(
            p.index.toString(),
            style: TextStyle(fontSize: 12, color: tint),
          ),
        ),
        SizedBox(
          width: 110,
          child: Text(
            _platformOs(p),
            style: const TextStyle(fontSize: 11, color: Color(0xFF424242)),
          ),
        ),
        SizedBox(
          width: 80,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 6,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: tint.withOpacity(0.15),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              _platformFamily(p),
              style: TextStyle(
                fontSize: 11,
                color: tint,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Back: ${_platformBackGesture(p)}',
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF424242),
                ),
              ),
              Text(
                'Long-press: ${_platformLongPress(p)}',
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF424242),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 6 — OVERRIDE DEMO (Theme.platform override)
// =============================================================================

Widget _buildOverrideDemo(BuildContext context) {
  return Container(
    margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFFE0F2F1),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: const Color(0xFF00897B)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Section 6 — Override demo',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF004D40),
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Wrapping a subtree in Theme(data: ThemeData(platform: ...)) '
          'forces Material widgets in that subtree to behave like the chosen '
          'platform — useful for previews and screenshot tests.',
          style: TextStyle(fontSize: 12, color: Color(0xFF00695C)),
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _overridePanel(
                'No override',
                'Uses the host platform reported via Theme.of(context).',
                null,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _overridePanel(
                'Override → iOS',
                'Theme(data: ThemeData(platform: TargetPlatform.iOS))',
                TargetPlatform.iOS,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _overridePanel(
                'Override → macOS',
                'Theme(data: ThemeData(platform: TargetPlatform.macOS))',
                TargetPlatform.macOS,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _overridePanel(
                'Override → windows',
                'Theme(data: ThemeData(platform: TargetPlatform.windows))',
                TargetPlatform.windows,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _overridePanel(String title, String subtitle, TargetPlatform? override) {
  Widget innerWidgetTree(BuildContext innerContext) {
    final TargetPlatform shown = Theme.of(innerContext).platform;
    final Color tint = _platformTint(shown);
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tint.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.palette,
                size: 14,
                color: Color(0xFF004D40),
              ),
              const SizedBox(width: 4),
              Text(
                'Theme.of(context).platform = ${shown.name}',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF004D40),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: tint,
              foregroundColor: Colors.white,
            ),
            onPressed: () {},
            child: const Text('Material button'),
          ),
          const SizedBox(height: 6),
          Switch(
            value: true,
            activeColor: tint,
            onChanged: (_) {},
          ),
          const SizedBox(height: 4),
          Text(
            'Page transitions adopt ${_platformFamily(shown)} feel; '
            'scrollbars and back-button icons follow $shown.',
            style: TextStyle(fontSize: 10, color: tint),
          ),
        ],
      ),
    );
  }

  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFF26A69A)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Color(0xFF004D40),
          ),
        ),
        Text(
          subtitle,
          style: const TextStyle(fontSize: 10, color: Color(0xFF00695C)),
        ),
        const SizedBox(height: 8),
        if (override == null)
          Builder(builder: (ctx) => innerWidgetTree(ctx))
        else
          Theme(
            data: ThemeData(platform: override),
            child: Builder(builder: (ctx) => innerWidgetTree(ctx)),
          ),
      ],
    ),
  );
}

// =============================================================================
// TOP-LEVEL BUILD ENTRY POINT
// =============================================================================

dynamic build(BuildContext context) {
  print('=== TargetPlatform Deep Demo ===');
  print('TargetPlatform.values.length: ${TargetPlatform.values.length}');
  for (final TargetPlatform p in TargetPlatform.values) {
    print('  ${p.index}: ${p.name} '
        '(${_platformFamily(p)} family, ${_platformPhysics(p)})');
  }
  print('defaultTargetPlatform: ${defaultTargetPlatform.name}');
  print('kIsWeb: $kIsWeb');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'TargetPlatform demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      useMaterial3: true,
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('TargetPlatform demo'),
        backgroundColor: const Color(0xFF1A237E),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Section 1
              _buildHeroCard(context),
              // Section divider
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Text(
                  'Section 1 — Current platform hero card (above)',
                  style: TextStyle(
                    fontSize: 11,
                    fontStyle: FontStyle.italic,
                    color: Color(0xFF616161),
                  ),
                ),
              ),
              // Section 2
              _buildGallery(context),
              const SizedBox(height: 16),
              // Section 3
              _buildBranchingHelpers(context),
              const SizedBox(height: 16),
              // Section 4
              _buildThemeVsDefault(context),
              const SizedBox(height: 16),
              // Section 5
              _buildEnumReference(context),
              const SizedBox(height: 16),
              // Section 6
              _buildOverrideDemo(context),
              const SizedBox(height: 24),
              // Footer
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 24),
                child: Text(
                  'End of TargetPlatform deep demo. Each section is a '
                  'real, hand-built widget tree — no codegen, no mocks.',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF616161),
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
