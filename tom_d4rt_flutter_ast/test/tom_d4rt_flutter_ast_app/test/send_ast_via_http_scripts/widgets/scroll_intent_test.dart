import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ---------------------------------------------------------------------------
// ScrollIntent — Intent Builder Workshop
// ---------------------------------------------------------------------------
// A deep visual walkthrough of Flutter's `ScrollIntent` class: the packaged
// scroll instruction that the Actions framework dispatches to a matching
// `ScrollAction`. Unlike the neighbouring `scroll_action_test.dart` which
// concentrates on the Action side (default bindings, Shortcuts wiring),
// THIS workshop focuses on the Intent itself:
//   * construction (direction + type)
//   * programmatic dispatch via Actions.invoke
//   * use from buttons, not just from keyboard Shortcuts
//   * inspection, history, replay
//
// The file is structured as a long single-scroll page. It uses only
// `package:flutter/material.dart` and `package:flutter/services.dart`, runs
// under the d4rt AST harness (`dynamic build(BuildContext context)`), and
// contains zero `runApp`/`main` calls.
// ---------------------------------------------------------------------------

// --- Palette ---------------------------------------------------------------
const Color kTeal = Color(0xFF14B8A6);
const Color kMagenta = Color(0xFFDB2777);
const Color kInk = Color(0xFF1E293B);
const Color kPaper = Color(0xFFF8FAFC);
const Color kCard = Color(0xFFFFFFFF);
const Color kMuted = Color(0xFF64748B);
const Color kDashedBorder = Color(0xFFCBD5E1);

// Direction colours
const Color kUpGreen = Color(0xFF10B981);
const Color kDownBlue = Color(0xFF2563EB);
const Color kLeftAmber = Color(0xFFD97706);
const Color kRightMagenta = Color(0xFFDB2777);

// ---------------------------------------------------------------------------

Color colorForDirection(AxisDirection d) {
  if (d == AxisDirection.up) return kUpGreen;
  if (d == AxisDirection.down) return kDownBlue;
  if (d == AxisDirection.left) return kLeftAmber;
  return kRightMagenta;
}

IconData iconForDirection(AxisDirection d) {
  if (d == AxisDirection.up) return Icons.arrow_upward;
  if (d == AxisDirection.down) return Icons.arrow_downward;
  if (d == AxisDirection.left) return Icons.arrow_back;
  return Icons.arrow_forward;
}

String labelForDirection(AxisDirection d) {
  if (d == AxisDirection.up) return 'AxisDirection.up';
  if (d == AxisDirection.down) return 'AxisDirection.down';
  if (d == AxisDirection.left) return 'AxisDirection.left';
  return 'AxisDirection.right';
}

String shortLabelForDirection(AxisDirection d) {
  if (d == AxisDirection.up) return 'up';
  if (d == AxisDirection.down) return 'down';
  if (d == AxisDirection.left) return 'left';
  return 'right';
}

String labelForType(ScrollIncrementType t) {
  return t == ScrollIncrementType.line
      ? 'ScrollIncrementType.line'
      : 'ScrollIncrementType.page';
}

String shortLabelForType(ScrollIncrementType t) {
  return t == ScrollIncrementType.line ? 'line' : 'page';
}

// ---------------------------------------------------------------------------
// Dispatched record — kept for the timeline strip.
// ---------------------------------------------------------------------------
class DispatchedRecord {
  final AxisDirection direction;
  final ScrollIncrementType type;
  final int sequence;
  const DispatchedRecord({
    required this.direction,
    required this.type,
    required this.sequence,
  });
}

// ---------------------------------------------------------------------------
// Main widget tree — a single StatefulWidget driving the workshop.
// ---------------------------------------------------------------------------
class ScrollIntentWorkshop extends StatefulWidget {
  const ScrollIntentWorkshop({super.key});

  @override
  State<ScrollIntentWorkshop> createState() => _ScrollIntentWorkshopState();
}

class _ScrollIntentWorkshopState extends State<ScrollIntentWorkshop> {
  AxisDirection _selectedDirection = AxisDirection.down;
  ScrollIncrementType _selectedType = ScrollIncrementType.line;
  final List<DispatchedRecord> _history = <DispatchedRecord>[];
  int _sequence = 0;

  // The key of the Focus wrapping the target scroller. Used so we can
  // dispatch intents from buttons elsewhere on the page — we look up the
  // Focus' context and then call Actions.invoke(ctx, intent).
  final GlobalKey _targetFocusKey = GlobalKey(debugLabel: 'scroll-target');
  final FocusNode _targetFocus = FocusNode(debugLabel: 'scroll-target');

  // Arrow flash overlay state.
  AxisDirection? _lastFlashDirection;
  int _flashCounter = 0;

  @override
  void dispose() {
    _targetFocus.dispose();
    super.dispose();
  }

  void _recordDispatch(AxisDirection d, ScrollIncrementType t) {
    _sequence = _sequence + 1;
    _history.insert(
      0,
      DispatchedRecord(direction: d, type: t, sequence: _sequence),
    );
    if (_history.length > 15) {
      _history.removeRange(15, _history.length);
    }
    _lastFlashDirection = d;
    _flashCounter = _flashCounter + 1;
  }

  void _dispatchIntent(AxisDirection d, ScrollIncrementType t) {
    final BuildContext? targetCtx = _targetFocusKey.currentContext;
    if (targetCtx != null) {
      _targetFocus.requestFocus();
      final intent = ScrollIntent(direction: d, type: t);
      Actions.maybeInvoke<ScrollIntent>(targetCtx, intent);
      debugPrint(
        '[ScrollIntent] dispatched: direction=${shortLabelForDirection(d)} '
        'type=${shortLabelForType(t)}',
      );
    } else {
      debugPrint('[ScrollIntent] no target context yet — skipping dispatch');
    }
    setState(() {
      _recordDispatch(d, t);
    });
  }

  void _dispatchMultiple(
    AxisDirection d,
    ScrollIncrementType t,
    int count,
  ) {
    for (int i = 0; i < count; i++) {
      _dispatchIntent(d, t);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPaper,
      appBar: AppBar(
        backgroundColor: kInk,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text('ScrollIntent — Intent Builder Workshop'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: <Widget>[
          _buildHeroHeader(),
          const SizedBox(height: 28),
          _buildSectionHeading(
            number: 1,
            title: 'Interactive ScrollIntent builder',
            subtitle:
                'Compose an intent. Preview the call. Dispatch it into the '
                'live scroller below.',
          ),
          const SizedBox(height: 14),
          _buildBuilderCard(),
          const SizedBox(height: 32),
          _buildSectionHeading(
            number: 2,
            title: 'Live scrollable target',
            subtitle:
                'A ListView inside Focus + Actions. Dispatched intents land '
                'here and the arrow overlay flashes.',
          ),
          const SizedBox(height: 14),
          _buildLiveTarget(),
          const SizedBox(height: 32),
          _buildSectionHeading(
            number: 3,
            title: 'Intent history timeline',
            subtitle:
                'Last 15 dispatched intents. Tap a chip to re-dispatch that '
                'intent.',
          ),
          const SizedBox(height: 14),
          _buildHistoryStrip(),
          const SizedBox(height: 32),
          _buildSectionHeading(
            number: 4,
            title: 'Actions.invoke walk-up',
            subtitle:
                'Actions.invoke climbs the widget tree looking for an '
                '`Actions` widget that maps ScrollIntent to an Action.',
          ),
          const SizedBox(height: 14),
          _buildWalkUpDiagram(),
          const SizedBox(height: 32),
          _buildSectionHeading(
            number: 5,
            title: 'Programmatic dispatch (no keyboard)',
            subtitle:
                'ScrollIntent is not bound to Shortcuts only. You can '
                'dispatch it from any logic — taps, timers, gestures.',
          ),
          const SizedBox(height: 14),
          _buildProgrammaticButtons(),
          const SizedBox(height: 32),
          _buildSectionHeading(
            number: 6,
            title: 'Construction reference card',
            subtitle: 'Constructor parameters, types, and defaults.',
          ),
          const SizedBox(height: 14),
          _buildConstructionReferenceCard(),
          const SizedBox(height: 32),
          _buildSectionHeading(
            number: 7,
            title: 'Cross-references',
            subtitle:
                'Related pieces in the same Actions/Intent/Scroll universe.',
          ),
          const SizedBox(height: 14),
          _buildCrossReferences(),
          const SizedBox(height: 32),
          _buildSectionHeading(
            number: 8,
            title: 'Teaching panel',
            subtitle: 'Things to remember when reaching for ScrollIntent.',
          ),
          const SizedBox(height: 14),
          _buildTeachingPanel(),
          const SizedBox(height: 32),
          _buildSectionHeading(
            number: 9,
            title: 'Use cases',
            subtitle: 'Where ScrollIntent earns its keep.',
          ),
          const SizedBox(height: 14),
          _buildUseCasesStrip(),
          const SizedBox(height: 32),
          _buildFooterSummary(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // HERO HEADER (section 0)
  // -------------------------------------------------------------------------
  Widget _buildHeroHeader() {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[kInk, Color(0xFF0F172A)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: kInk.withValues(alpha: 0.20),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: kTeal.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: kTeal.withValues(alpha: 0.6)),
                ),
                child: const Text(
                  'class ScrollIntent extends Intent',
                  style: TextStyle(
                    color: kTeal,
                    fontFamily: 'monospace',
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: kMagenta.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: kMagenta.withValues(alpha: 0.6)),
                ),
                child: const Text(
                  'dart:ui • material',
                  style: TextStyle(
                    color: kMagenta,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Text(
            'ScrollIntent',
            style: TextStyle(
              color: Colors.white,
              fontSize: 42,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Packaged scroll instructions for the Actions framework.',
            style: TextStyle(
              color: Color(0xFFCBD5E1),
              fontSize: 17,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 22),
          _buildGiftBoxVisual(),
        ],
      ),
    );
  }

  Widget _buildGiftBoxVisual() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
      ),
      child: Row(
        children: <Widget>[
          _buildGiftBoxIcon(),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'An Intent packages two things:',
                  style: TextStyle(
                    color: Color(0xFFE2E8F0),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    _buildBoxLabel(
                      label: 'direction',
                      icon: Icons.compare_arrows,
                      color: kTeal,
                    ),
                    const SizedBox(width: 10),
                    _buildBoxLabel(
                      label: 'type',
                      icon: Icons.straighten,
                      color: kMagenta,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'WHICH way (up/down/left/right) and HOW MUCH (line/page).',
                  style: TextStyle(
                    color: Color(0xFF94A3B8),
                    fontSize: 12.5,
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

  Widget _buildGiftBoxIcon() {
    return Container(
      width: 96,
      height: 96,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            kTeal.withValues(alpha: 0.85),
            kMagenta.withValues(alpha: 0.85),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: kTeal.withValues(alpha: 0.35),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: <Widget>[
          Center(
            child: Container(
              width: 4,
              height: 96,
              color: Colors.white.withValues(alpha: 0.6),
            ),
          ),
          Center(
            child: Container(
              width: 96,
              height: 4,
              color: Colors.white.withValues(alpha: 0.6),
            ),
          ),
          Positioned(
            top: 6,
            left: 32,
            child: Container(
              width: 32,
              height: 14,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.85),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.card_giftcard,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBoxLabel({
    required String label,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.22),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.6)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontFamily: 'monospace',
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // SECTION HEADING helper
  // -------------------------------------------------------------------------
  Widget _buildSectionHeading({
    required int number,
    required String title,
    required String subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 42,
          height: 42,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: kTeal.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: kTeal.withValues(alpha: 0.5)),
          ),
          child: Text(
            '$number',
            style: const TextStyle(
              color: kTeal,
              fontWeight: FontWeight.w800,
              fontSize: 18,
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  color: kInk,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  color: kMuted,
                  fontSize: 13.5,
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // -------------------------------------------------------------------------
  // SECTION 1 — Builder card
  // -------------------------------------------------------------------------
  Widget _buildBuilderCard() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildBuilderFieldLabel('direction', Icons.compare_arrows, kTeal),
          const SizedBox(height: 8),
          _buildDirectionSegmented(),
          const SizedBox(height: 18),
          _buildBuilderFieldLabel('type', Icons.straighten, kMagenta),
          const SizedBox(height: 8),
          _buildTypeSegmented(),
          const SizedBox(height: 22),
          _buildCodePreview(),
          const SizedBox(height: 16),
          _buildDispatchButton(),
        ],
      ),
    );
  }

  Widget _buildBuilderFieldLabel(String label, IconData icon, Color color) {
    return Row(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.16),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, color: color, size: 14),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            color: kInk,
            fontWeight: FontWeight.w700,
            fontFamily: 'monospace',
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildDirectionSegmented() {
    final directions = <AxisDirection>[
      AxisDirection.up,
      AxisDirection.down,
      AxisDirection.left,
      AxisDirection.right,
    ];
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: directions.map((d) {
        final bool selected = _selectedDirection == d;
        final Color color = colorForDirection(d);
        return InkWell(
          onTap: () {
            setState(() {
              _selectedDirection = d;
            });
          },
          borderRadius: BorderRadius.circular(10),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 140),
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: selected
                  ? color.withValues(alpha: 0.18)
                  : const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: selected ? color : const Color(0xFFE2E8F0),
                width: selected ? 1.5 : 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(iconForDirection(d), color: color, size: 16),
                const SizedBox(width: 8),
                Text(
                  shortLabelForDirection(d),
                  style: TextStyle(
                    color: selected ? color : kInk,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'monospace',
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTypeSegmented() {
    final types = <ScrollIncrementType>[
      ScrollIncrementType.line,
      ScrollIncrementType.page,
    ];
    return Wrap(
      spacing: 8,
      children: types.map((t) {
        final bool selected = _selectedType == t;
        return InkWell(
          onTap: () {
            setState(() {
              _selectedType = t;
            });
          },
          borderRadius: BorderRadius.circular(10),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 140),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: selected
                  ? kMagenta.withValues(alpha: 0.18)
                  : const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(
                t == ScrollIncrementType.line ? 999 : 6,
              ),
              border: Border.all(
                color: selected ? kMagenta : const Color(0xFFE2E8F0),
                width: selected ? 1.5 : 1,
              ),
            ),
            child: Text(
              shortLabelForType(t),
              style: TextStyle(
                color: selected ? kMagenta : kInk,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
                fontSize: 13,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCodePreview() {
    final code =
        'ScrollIntent(\n  direction: ${labelForDirection(_selectedDirection)},\n  type: ${labelForType(_selectedType)},\n)';
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: kInk,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Color(0xFFEF4444),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Color(0xFFF59E0B),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Color(0xFF10B981),
                  shape: BoxShape.circle,
                ),
              ),
              const Spacer(),
              Text(
                'Built intent',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.55),
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            code,
            style: const TextStyle(
              color: Color(0xFFE2E8F0),
              fontFamily: 'monospace',
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDispatchButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          _dispatchIntent(_selectedDirection, _selectedType);
        },
        icon: const Icon(Icons.send),
        label: Text(
          'Dispatch  ${shortLabelForDirection(_selectedDirection)}  /  '
          '${shortLabelForType(_selectedType)}',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14.5,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: kTeal,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // SECTION 2 — Live target
  // -------------------------------------------------------------------------
  Widget _buildLiveTarget() {
    return Container(
      decoration: _cardDecoration(),
      padding: const EdgeInsets.all(14),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: kTeal.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: <Widget>[
                const Icon(Icons.center_focus_strong,
                    size: 14, color: kTeal),
                const SizedBox(width: 6),
                const Text(
                  'Focus + Actions(ScrollIntent → ScrollAction())',
                  style: TextStyle(
                    color: kTeal,
                    fontFamily: 'monospace',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                Text(
                  'flash #$_flashCounter',
                  style: const TextStyle(
                    color: kMuted,
                    fontSize: 11,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Stack(
            children: <Widget>[
              SizedBox(
                height: 260,
                child: Focus(
                  key: _targetFocusKey,
                  focusNode: _targetFocus,
                  autofocus: false,
                  child: Actions(
                    actions: <Type, Action<Intent>>{
                      ScrollIntent: ScrollAction(),
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: kDashedBorder),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: ListView.builder(
                          primary: true,
                          itemCount: 40,
                          itemBuilder: (context, index) {
                            final Color tint = Color.lerp(
                                  kTeal,
                                  kMagenta,
                                  index / 40.0,
                                )!
                                .withValues(alpha: 0.18);
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: tint,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 26,
                                    height: 26,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      '${index + 1}',
                                      style: const TextStyle(
                                        fontFamily: 'monospace',
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        color: kInk,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    'scrollable tile #${index + 1}',
                                    style: const TextStyle(
                                      color: kInk,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (_lastFlashDirection != null)
                Positioned(
                  top: 12,
                  right: 12,
                  child: _buildFlashOverlay(_lastFlashDirection!),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Last flash: '
            '${_lastFlashDirection == null ? "—" : shortLabelForDirection(_lastFlashDirection!)}   '
            '($_flashCounter dispatches since page load)',
            style: const TextStyle(color: kMuted, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildFlashOverlay(AxisDirection d) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: colorForDirection(d).withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(999),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: colorForDirection(d).withValues(alpha: 0.5),
            blurRadius: 14,
          ),
        ],
      ),
      child: Icon(iconForDirection(d), color: Colors.white, size: 22),
    );
  }

  // -------------------------------------------------------------------------
  // SECTION 3 — History strip
  // -------------------------------------------------------------------------
  Widget _buildHistoryStrip() {
    return Container(
      decoration: _cardDecoration(),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.timeline, size: 16, color: kInk),
              const SizedBox(width: 6),
              const Text(
                'Timeline',
                style: TextStyle(
                  color: kInk,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              Text(
                '${_history.length} / 15',
                style: const TextStyle(color: kMuted, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 72,
            child: _history.isEmpty
                ? _buildEmptyTimeline()
                : ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _history.length,
                    separatorBuilder: (ctx, i) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final rec = _history[index];
                      return _buildHistoryChip(rec);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyTimeline() {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: kDashedBorder),
      ),
      child: const Text(
        'No intents dispatched yet. Use the builder or programmatic buttons.',
        style: TextStyle(
          color: kMuted,
          fontStyle: FontStyle.italic,
          fontSize: 12.5,
        ),
      ),
    );
  }

  Widget _buildHistoryChip(DispatchedRecord rec) {
    final Color color = colorForDirection(rec.direction);
    final bool isPage = rec.type == ScrollIncrementType.page;
    return InkWell(
      onTap: () {
        _dispatchIntent(rec.direction, rec.type);
      },
      borderRadius: BorderRadius.circular(isPage ? 12 : 999),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.14),
          borderRadius: BorderRadius.circular(isPage ? 12 : 999),
          border: Border.all(color: color.withValues(alpha: 0.6)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(iconForDirection(rec.direction), size: 14, color: color),
                const SizedBox(width: 4),
                Text(
                  shortLabelForDirection(rec.direction),
                  style: TextStyle(
                    color: color,
                    fontFamily: 'monospace',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              '${shortLabelForType(rec.type)} · #${rec.sequence}',
              style: const TextStyle(
                color: kMuted,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // SECTION 4 — Walk-up diagram
  // -------------------------------------------------------------------------
  Widget _buildWalkUpDiagram() {
    return Container(
      decoration: _cardDecoration(),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Actions.invoke(context, ScrollIntent(...))',
            style: TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
              color: kInk,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 12),
          _buildTreeLayer(
            label: 'MaterialApp',
            color: kMuted,
            highlighted: false,
            depth: 0,
          ),
          _buildTreeLayer(
            label: 'Navigator',
            color: kMuted,
            highlighted: false,
            depth: 1,
          ),
          _buildTreeLayer(
            label: 'Scaffold',
            color: kMuted,
            highlighted: false,
            depth: 2,
          ),
          _buildTreeLayer(
            label: 'Focus(target)',
            color: kTeal,
            highlighted: false,
            depth: 3,
          ),
          _buildTreeLayer(
            label: 'Actions { ScrollIntent -> ScrollAction() }',
            color: kTeal,
            highlighted: true,
            depth: 4,
          ),
          _buildTreeLayer(
            label: 'ListView (PrimaryScrollController)',
            color: kMuted,
            highlighted: false,
            depth: 5,
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: kTeal.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: kTeal.withValues(alpha: 0.4)),
            ),
            child: const Text(
              'The first Actions widget whose map contains ScrollIntent wins. '
              'If none is found, Actions.maybeInvoke returns null and nothing '
              'happens — a safe no-op.',
              style: TextStyle(
                color: kInk,
                fontSize: 12.5,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTreeLayer({
    required String label,
    required Color color,
    required bool highlighted,
    required int depth,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: depth * 18.0, top: 4, bottom: 4),
      child: Row(
        children: <Widget>[
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: highlighted ? kTeal : const Color(0xFFE2E8F0),
              shape: BoxShape.circle,
              border: Border.all(
                color: highlighted ? kTeal : kMuted,
                width: 1.4,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: highlighted
                    ? kTeal.withValues(alpha: 0.14)
                    : const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: highlighted
                      ? kTeal.withValues(alpha: 0.5)
                      : const Color(0xFFE2E8F0),
                ),
              ),
              child: Row(
                children: <Widget>[
                  Text(
                    label,
                    style: TextStyle(
                      color: highlighted ? kInk : color,
                      fontFamily: 'monospace',
                      fontSize: 12.5,
                      fontWeight: highlighted
                          ? FontWeight.w800
                          : FontWeight.w500,
                    ),
                  ),
                  if (highlighted) ...<Widget>[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: kTeal,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'MATCH',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // SECTION 5 — Programmatic buttons
  // -------------------------------------------------------------------------
  Widget _buildProgrammaticButtons() {
    return Container(
      decoration: _cardDecoration(),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'These buttons call Actions.invoke directly. No key handler '
            'required.',
            style: TextStyle(color: kMuted, fontSize: 12.5, height: 1.45),
          ),
          const SizedBox(height: 12),
          _buildProgrammaticRow(
            label: 'Scroll one line DOWN',
            subtitle: 'ScrollIntent(direction: down, type: line)',
            icon: Icons.arrow_downward,
            color: kDownBlue,
            onTap: () {
              _dispatchIntent(AxisDirection.down, ScrollIncrementType.line);
            },
          ),
          const SizedBox(height: 10),
          _buildProgrammaticRow(
            label: 'Scroll one page UP',
            subtitle: 'ScrollIntent(direction: up, type: page)',
            icon: Icons.arrow_upward,
            color: kUpGreen,
            onTap: () {
              _dispatchIntent(AxisDirection.up, ScrollIncrementType.page);
            },
          ),
          const SizedBox(height: 10),
          _buildProgrammaticRow(
            label: 'Scroll 5× line RIGHT',
            subtitle: '5 consecutive ScrollIntent(right, line) dispatches',
            icon: Icons.arrow_forward,
            color: kRightMagenta,
            onTap: () {
              _dispatchMultiple(
                AxisDirection.right,
                ScrollIncrementType.line,
                5,
              );
            },
          ),
          const SizedBox(height: 10),
          _buildProgrammaticRow(
            label: 'Reset to top (3× page UP)',
            subtitle: '3 consecutive ScrollIntent(up, page) dispatches',
            icon: Icons.vertical_align_top,
            color: kTeal,
            onTap: () {
              _dispatchMultiple(
                AxisDirection.up,
                ScrollIncrementType.page,
                3,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProgrammaticRow({
    required String label,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withValues(alpha: 0.35)),
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: 42,
              height: 42,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    label,
                    style: const TextStyle(
                      color: kInk,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: kMuted,
                      fontFamily: 'monospace',
                      fontSize: 11.5,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.send, color: color, size: 18),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // SECTION 6 — Construction reference
  // -------------------------------------------------------------------------
  Widget _buildConstructionReferenceCard() {
    return Container(
      decoration: _cardDecoration(),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'const ScrollIntent({',
            style: TextStyle(
              fontFamily: 'monospace',
              color: kInk,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
          _buildParamRow(
            name: 'direction',
            type: 'AxisDirection',
            required: true,
            description:
                'Which way to scroll. One of AxisDirection.up/down/left/right.',
          ),
          _buildParamRow(
            name: 'type',
            type: 'ScrollIncrementType',
            required: false,
            defaultValue: 'ScrollIncrementType.line',
            description:
                'How much to scroll per dispatch. line for a keyboard-like '
                'tick, page for a full viewport.',
          ),
          const Text(
            '});',
            style: TextStyle(
              fontFamily: 'monospace',
              color: kInk,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'ScrollIntent has no keyboard-specific fields. It does NOT '
              'encode velocity, duration, or curve — those are the concern '
              'of the consuming Action (ScrollAction) or of the physics '
              'applied by the ScrollPosition.',
              style: TextStyle(color: kMuted, fontSize: 12, height: 1.45),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildParamRow({
    required String name,
    required String type,
    required bool required,
    String? defaultValue,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 14, top: 8, bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 120,
            child: Text(
              name,
              style: const TextStyle(
                fontFamily: 'monospace',
                color: kTeal,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      type,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        color: kMagenta,
                        fontWeight: FontWeight.w600,
                        fontSize: 12.5,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: required
                            ? const Color(0xFFFEE2E2)
                            : const Color(0xFFDBEAFE),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        required ? 'required' : 'optional',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: required
                              ? const Color(0xFFB91C1C)
                              : const Color(0xFF1D4ED8),
                        ),
                      ),
                    ),
                    if (defaultValue != null) ...<Widget>[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEF3C7),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'default: $defaultValue',
                          style: const TextStyle(
                            fontSize: 10,
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFB45309),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    color: kMuted,
                    fontSize: 12,
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

  // -------------------------------------------------------------------------
  // SECTION 7 — Cross refs
  // -------------------------------------------------------------------------
  Widget _buildCrossReferences() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: _buildCrossRefTile(
            title: 'ScrollIncrementType',
            body: 'The enum that ScrollIntent.type carries. Controls the '
                'step size: line or page.',
            accent: kTeal,
            file: 'scroll_increment_type_test.dart',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildCrossRefTile(
            title: 'ScrollAction',
            body: 'The built-in Action that consumes ScrollIntent. See the '
                'neighbouring test for keyboard bindings and defaults.',
            accent: kMagenta,
            file: 'scroll_action_test.dart',
          ),
        ),
      ],
    );
  }

  Widget _buildCrossRefTile({
    required String title,
    required String body,
    required Color accent,
    required String file,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.link, size: 14, color: accent),
              const SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'monospace',
                  color: accent,
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            body,
            style: const TextStyle(
              color: kInk,
              fontSize: 12.5,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 6,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: accent.withValues(alpha: 0.4)),
            ),
            child: Text(
              file,
              style: const TextStyle(
                fontFamily: 'monospace',
                color: kMuted,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // SECTION 8 — Teaching panel
  // -------------------------------------------------------------------------
  Widget _buildTeachingPanel() {
    final tiles = <Map<String, String>>[
      <String, String>{
        'title': 'First-class Intent',
        'body':
            'ScrollIntent is a first-class Intent — you can dispatch it from '
                'code, not just from key bindings. That means buttons, '
                'gestures, timers, or automated macros can all trigger scroll '
                'behaviour.',
      },
      <String, String>{
        'title': 'Stateless by design',
        'body':
            'Keep ScrollIntent stateless; if you need velocity or smoothness, '
                'use ScrollController.animateTo instead. An Intent is a tiny '
                'message — it should not carry animation curves.',
      },
      <String, String>{
        'title': 'invoke returns a result',
        'body':
            'Actions.invoke returns the Action\'s result — you can know if '
                'dispatch succeeded. Use maybeInvoke if you want a safe '
                'no-op when no binding is found.',
      },
      <String, String>{
        'title': 'Tree-scoped bindings',
        'body':
            'The Actions lookup is tree-scoped. You can wrap a single '
                'ScrollView with Actions and override what line/page means '
                'just for that part of the UI.',
      },
      <String, String>{
        'title': 'Testing is trivial',
        'body':
            'Because ScrollIntent is just a value, you can construct one in '
                'a widget test and call Actions.invoke to drive scrolling '
                'without any keyboard simulation.',
      },
    ];
    return Column(
      children: tiles.map((m) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: _buildTeachingTile(m['title']!, m['body']!),
        );
      }).toList(),
    );
  }

  Widget _buildTeachingTile(String title, String body) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 32,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: kTeal.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.lightbulb_outline,
                size: 16, color: kTeal),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    color: kInk,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: const TextStyle(
                    color: kMuted,
                    fontSize: 12.5,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // SECTION 9 — Use cases
  // -------------------------------------------------------------------------
  Widget _buildUseCasesStrip() {
    final cases = <Map<String, dynamic>>[
      <String, dynamic>{
        'icon': Icons.keyboard,
        'label': 'Desktop shortcuts',
        'body':
            'Wire Shortcuts(PageDown → ScrollIntent(down, page)) to match '
                'native desktop apps.',
        'color': kTeal,
      },
      <String, dynamic>{
        'icon': Icons.accessibility_new,
        'label': 'Accessibility',
        'body':
            'Let assistive tech dispatch ScrollIntent without having to '
                'simulate raw key events.',
        'color': kMagenta,
      },
      <String, dynamic>{
        'icon': Icons.touch_app,
        'label': 'Custom buttons',
        'body':
            'On-screen ↑/↓ buttons that reuse the exact same scrolling code '
                'as the keyboard path.',
        'color': kDownBlue,
      },
      <String, dynamic>{
        'icon': Icons.auto_awesome,
        'label': 'Macros',
        'body':
            'Scripted or AI-driven dispatch of ScrollIntents to replay a '
                'known navigation path.',
        'color': kUpGreen,
      },
    ];
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: cases.map((c) {
        final Color color = c['color'] as Color;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: kCard,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(c['icon'] as IconData, color: color),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    c['label'] as String,
                    style: const TextStyle(
                      color: kInk,
                      fontWeight: FontWeight.w800,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    c['body'] as String,
                    style: const TextStyle(
                      color: kMuted,
                      fontSize: 11.5,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  // -------------------------------------------------------------------------
  // FOOTER
  // -------------------------------------------------------------------------
  Widget _buildFooterSummary() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            kInk,
            kInk.withValues(alpha: 0.9),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Summary',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'ScrollIntent is a tiny, immutable message: a direction and a '
            'step size. Its job is to travel through the Actions tree until '
            'it finds a ScrollAction — or any other action you register — '
            'that knows how to turn it into a real scroll.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: 13.5,
              height: 1.55,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              const Icon(Icons.info_outline, size: 14, color: kTeal),
              const SizedBox(width: 6),
              Text(
                'Shortcuts → Intent → Action is Flutter\'s official '
                'indirection for keybindings.',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: kTeal.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: kTeal.withValues(alpha: 0.4)),
            ),
            child: Text(
              'Try this: press the three programmatic buttons in order, then '
              'tap a chip in the history timeline to replay it. The target '
              'scroller reacts, the arrow overlay flashes, and the sequence '
              'counter climbs.',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.9),
                fontSize: 12.5,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // SHARED DECORATIONS
  // -------------------------------------------------------------------------
  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: kCard,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: const Color(0xFFE2E8F0)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kInk.withValues(alpha: 0.04),
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Decorative Shortcut reference — demonstrates how ScrollIntent is classically
// wired up, without actually installing bindings on the live scroller (the
// live scroller uses only Actions, not Shortcuts, because we want buttons to
// be the primary dispatch path here).
// ---------------------------------------------------------------------------

Map<ShortcutActivator, Intent> decorativeScrollShortcuts() {
  return <ShortcutActivator, Intent>{
    const SingleActivator(LogicalKeyboardKey.arrowUp): const ScrollIntent(
      direction: AxisDirection.up,
    ),
    const SingleActivator(LogicalKeyboardKey.arrowDown): const ScrollIntent(
      direction: AxisDirection.down,
    ),
    const SingleActivator(LogicalKeyboardKey.arrowLeft): const ScrollIntent(
      direction: AxisDirection.left,
    ),
    const SingleActivator(LogicalKeyboardKey.arrowRight): const ScrollIntent(
      direction: AxisDirection.right,
    ),
    const SingleActivator(LogicalKeyboardKey.pageUp): const ScrollIntent(
      direction: AxisDirection.up,
      type: ScrollIncrementType.page,
    ),
    const SingleActivator(LogicalKeyboardKey.pageDown): const ScrollIntent(
      direction: AxisDirection.down,
      type: ScrollIncrementType.page,
    ),
  };
}

// ---------------------------------------------------------------------------
// d4rt entry point — the AST harness calls build(context).
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  // Reference the decorative shortcuts map so the helper survives tree
  // shaking in the AST interpreter. It also shows, at a glance, that the
  // classic Shortcuts → ScrollIntent wiring is still a first-class pattern.
  final Map<ShortcutActivator, Intent> shortcuts =
      decorativeScrollShortcuts();
  debugPrint(
    '[ScrollIntent demo] decorative shortcuts prepared: '
    '${shortcuts.length} entries',
  );
  return const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ScrollIntentWorkshop(),
  );
}
