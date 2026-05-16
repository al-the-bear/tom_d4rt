// ignore_for_file: avoid_print, unused_local_variable
// D4rt visual deep demo: CupertinoSliverRefreshControl anatomy & states.
// This file is hand-authored as a static visual presentation. It does not
// drive any real refresh logic; instead it renders frozen mock-ups of the
// five RefreshIndicatorMode states so the interpreter can be exercised
// against a rich Cupertino widget tree without async machinery.
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Icons;

// ===========================================================================
// PALETTE
// ===========================================================================
// iOS system grey backdrop, classic iOS blue tint, separator hairlines and a
// muted secondary text colour. All colours are const so they can be reused
// across the many panels in this file without re-allocation.
const Color kBackdrop = Color(0xFFF2F2F7);
const Color kCard = Color(0xFFFFFFFF);
const Color kAccent = Color(0xFF007AFF);
const Color kAccentSoft = Color(0xFFCCE0FF);
const Color kHairline = Color(0xFFD1D1D6);
const Color kTextPrimary = Color(0xFF1C1C1E);
const Color kTextSecondary = Color(0xFF6E6E73);
const Color kTextMuted = Color(0xFF8E8E93);
const Color kSuccess = Color(0xFF34C759);
const Color kWarning = Color(0xFFFF9500);
const Color kDanger = Color(0xFFFF3B30);
const Color kBadgeBg = Color(0xFFE5E5EA);
const Color kCodeBg = Color(0xFF1C1C1E);
const Color kCodeFg = Color(0xFFEDEDED);

// ===========================================================================
// TYPOGRAPHY HELPERS
// ===========================================================================
TextStyle _sectionTitleStyle() => const TextStyle(
      fontSize: 19.0,
      fontWeight: FontWeight.w700,
      color: kTextPrimary,
      letterSpacing: -0.2,
    );

TextStyle _subTitleStyle() => const TextStyle(
      fontSize: 15.0,
      fontWeight: FontWeight.w600,
      color: kTextPrimary,
    );

TextStyle _bodyStyle() => const TextStyle(
      fontSize: 14.0,
      color: kTextPrimary,
      height: 1.4,
    );

TextStyle _captionStyle() => const TextStyle(
      fontSize: 12.0,
      color: kTextSecondary,
      height: 1.3,
    );

TextStyle _mutedStyle() => const TextStyle(
      fontSize: 11.0,
      color: kTextMuted,
    );

TextStyle _codeStyle() => const TextStyle(
      fontFamily: 'Menlo',
      fontSize: 12.0,
      color: kCodeFg,
      height: 1.45,
    );

TextStyle _badgeStyle() => const TextStyle(
      fontSize: 11.0,
      fontWeight: FontWeight.w600,
      color: kTextPrimary,
      letterSpacing: 0.4,
    );

// ===========================================================================
// SMALL BUILDING BLOCKS
// ===========================================================================
Widget _gap(double h) => SizedBox(height: h);
Widget _hgap(double w) => SizedBox(width: w);

Widget _hairline() => Container(height: 1.0, color: kHairline);

Widget _badge(String label, {Color bg = kBadgeBg, Color? fg}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Text(
      label,
      style: _badgeStyle().copyWith(color: fg ?? kTextPrimary),
    ),
  );
}

Widget _card({required Widget child, EdgeInsets? padding}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: padding ?? const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: kCard,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: kHairline, width: 0.5),
    ),
    child: child,
  );
}

Widget _sectionHeader(String index, String title, String subtitle) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(16.0, 18.0, 16.0, 6.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 3.0,
              ),
              decoration: BoxDecoration(
                color: kAccent,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                index,
                style: const TextStyle(
                  color: CupertinoColors.white,
                  fontSize: 11.0,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            _hgap(8.0),
            Expanded(child: Text(title, style: _sectionTitleStyle())),
          ],
        ),
        _gap(4.0),
        Text(subtitle, style: _captionStyle()),
      ],
    ),
  );
}

Widget _bullet(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 6.0, right: 8.0),
          child: Container(
            width: 4.0,
            height: 4.0,
            decoration: const BoxDecoration(
              color: kAccent,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Expanded(child: Text(text, style: _bodyStyle())),
      ],
    ),
  );
}

Widget _keyValueRow(String key, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 140.0,
          child: Text(key, style: _subTitleStyle()),
        ),
        Expanded(child: Text(value, style: _bodyStyle())),
      ],
    ),
  );
}

Widget _codeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: kCodeBg,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Text(code, style: _codeStyle()),
  );
}

// ===========================================================================
// 1. HERO HEADER
// ===========================================================================
Widget _hero() {
  return Container(
    margin: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 4.0),
    padding: const EdgeInsets.fromLTRB(20.0, 22.0, 20.0, 22.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF0A84FF), Color(0xFF5E5CE6)],
      ),
      borderRadius: BorderRadius.circular(18.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _badge('CUPERTINO', bg: CupertinoColors.white, fg: kAccent),
            _hgap(6.0),
            _badge('SLIVER', bg: kAccentSoft, fg: kAccent),
            _hgap(6.0),
            _badge('REFRESH CONTROL',
                bg: const Color(0x33FFFFFF), fg: CupertinoColors.white),
          ],
        ),
        _gap(14.0),
        const Text(
          'CupertinoSliverRefreshControl',
          style: TextStyle(
            color: CupertinoColors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.6,
          ),
        ),
        _gap(6.0),
        const Text(
          'The iOS pull-to-refresh paradigm, frozen frame by frame.',
          style: TextStyle(
            color: Color(0xFFEDEDFF),
            fontSize: 14.5,
            height: 1.35,
          ),
        ),
        _gap(14.0),
        Row(
          children: [
            const Icon(
              CupertinoIcons.arrow_down_circle_fill,
              color: CupertinoColors.white,
              size: 20.0,
            ),
            _hgap(8.0),
            const Expanded(
              child: Text(
                'A deep visual tour through state, threshold, and builder.',
                style: TextStyle(
                  color: CupertinoColors.white,
                  fontSize: 13.0,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// ===========================================================================
// 2. CONCEPT CARD
// ===========================================================================
Widget _concept() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Pull-to-refresh, the iOS way', style: _subTitleStyle()),
        _gap(8.0),
        Text(
          'Originally popularised by the Tweetie app, pull-to-refresh became '
          'the canonical "fetch newer items" gesture on iOS. The user drags '
          'the scroll view past its leading edge; once the drag passes the '
          'trigger distance the control commits to a refresh, the activity '
          'indicator spins, and when the future completes the indicator '
          'retracts.',
          style: _bodyStyle(),
        ),
        _gap(10.0),
        _keyValueRow('Widget',
            'CupertinoSliverRefreshControl — a sliver, lives in CustomScrollView.slivers.'),
        _keyValueRow('Trigger',
            'refreshTriggerPullDistance, default 100.0 logical pixels.'),
        _keyValueRow('Indicator',
            'refreshIndicatorExtent, default 60.0 logical pixels.'),
        _keyValueRow('Callback',
            'onRefresh: Future<void> Function()? — null disables the control.'),
        _keyValueRow('Builder',
            'builder: optional override with full state-machine access.'),
      ],
    ),
  );
}

// ===========================================================================
// 3. ANATOMY DIAGRAM
// ===========================================================================
Widget _anatomyDiagram() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Anatomy of a pull gesture', style: _subTitleStyle()),
        _gap(6.0),
        Text(
          'Vertical axis = drag offset. The dotted line marks the trigger '
          'threshold. Crossing it arms the control; releasing past the line '
          'commits the refresh.',
          style: _captionStyle(),
        ),
        _gap(14.0),
        SizedBox(
          height: 220.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: 90.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('0 px', style: _mutedStyle()),
                    Text('40 px', style: _mutedStyle()),
                    Text('80 px', style: _mutedStyle()),
                    Text('100 px',
                        style: _mutedStyle().copyWith(color: kAccent)),
                    Text('120 px', style: _mutedStyle()),
                    Text('160 px', style: _mutedStyle()),
                  ],
                ),
              ),
              _hgap(10.0),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: kBackdrop,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: kHairline),
                  ),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(color: const Color(0x11007AFF)),
                            ),
                            Container(
                              height: 1.0,
                              color: kAccent,
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(color: const Color(0x0834C759)),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        left: 16.0,
                        top: 12.0,
                        child: Text('inactive band',
                            style: _captionStyle()
                                .copyWith(color: kTextSecondary)),
                      ),
                      Positioned(
                        left: 16.0,
                        top: 70.0,
                        child: Text('drag band',
                            style: _captionStyle().copyWith(color: kAccent)),
                      ),
                      const Positioned(
                        left: 12.0,
                        top: 92.0,
                        child: Icon(CupertinoIcons.arrow_down,
                            color: kAccent, size: 16.0),
                      ),
                      Positioned(
                        right: 12.0,
                        top: 92.0,
                        child: Text('THRESHOLD',
                            style: _badgeStyle().copyWith(color: kAccent)),
                      ),
                      Positioned(
                        left: 16.0,
                        top: 130.0,
                        child: Text('armed / refresh band',
                            style: _captionStyle().copyWith(color: kSuccess)),
                      ),
                      const Positioned(
                        right: 24.0,
                        top: 150.0,
                        child: CupertinoActivityIndicator(radius: 12.0),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        _gap(10.0),
        _bullet(
            'Above the threshold the indicator only previews intent — no commit.'),
        _bullet(
            'Releasing while armed commits the refresh and starts the spinner.'),
        _bullet(
            'When the future completes, the indicator retracts past the line.'),
      ],
    ),
  );
}

// ===========================================================================
// 4. STATE SEQUENCE — 5 FROZEN PANELS
// ===========================================================================
Widget _statePanel({
  required String label,
  required Color tint,
  required Widget visual,
  required String caption,
}) {
  return Container(
    width: 150.0,
    margin: const EdgeInsets.symmetric(horizontal: 4.0),
    decoration: BoxDecoration(
      color: kCard,
      border: Border.all(color: kHairline),
      borderRadius: BorderRadius.circular(12.0),
    ),
    padding: const EdgeInsets.all(12.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 10.0,
              height: 10.0,
              decoration: BoxDecoration(
                color: tint,
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
            _hgap(6.0),
            Expanded(
              child: Text(label,
                  style: _subTitleStyle().copyWith(fontSize: 13.0)),
            ),
          ],
        ),
        _gap(8.0),
        SizedBox(height: 96.0, child: Center(child: visual)),
        _gap(8.0),
        Text(caption, style: _captionStyle()),
      ],
    ),
  );
}

Widget _stateSequence() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('RefreshIndicatorMode — state by state', style: _subTitleStyle()),
        _gap(6.0),
        Text(
          'Each panel below is a static mock of one mode in the state '
          'machine. The real control transitions between them based on '
          'drag offset and the onRefresh future.',
          style: _captionStyle(),
        ),
        _gap(12.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            children: [
              _statePanel(
                label: 'inactive',
                tint: kTextMuted,
                visual: Container(
                  width: 90.0,
                  height: 6.0,
                  decoration: BoxDecoration(
                    color: kHairline,
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                ),
                caption: 'No drag, no indicator. Sliver yields zero extent.',
              ),
              _statePanel(
                label: 'drag (partial)',
                tint: kAccent,
                visual: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(CupertinoIcons.arrow_down,
                        color: kAccent, size: 24.0),
                    _gap(4.0),
                    Text('40 / 100',
                        style: _captionStyle().copyWith(color: kAccent)),
                  ],
                ),
                caption:
                    'Drag below threshold; arrow shown, no spinner yet.',
              ),
              _statePanel(
                label: 'armed',
                tint: kSuccess,
                visual: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(CupertinoIcons.arrow_up,
                        color: kSuccess, size: 24.0),
                    _gap(4.0),
                    Text('release →',
                        style: _captionStyle().copyWith(color: kSuccess)),
                  ],
                ),
                caption: 'At/past threshold. Release will commit.',
              ),
              _statePanel(
                label: 'refresh',
                tint: kAccent,
                visual: const CupertinoActivityIndicator(
                  radius: 14.0,
                  animating: false,
                ),
                caption: 'Spinner shown; onRefresh future awaited.',
              ),
              _statePanel(
                label: 'done',
                tint: kWarning,
                visual: const Icon(CupertinoIcons.checkmark_alt,
                    color: kSuccess, size: 26.0),
                caption: 'Future resolved; control retracts.',
              ),
            ],
          ),
        ),
        _gap(10.0),
        _codeBlock(
          'enum RefreshIndicatorMode {\n'
          '  inactive,\n'
          '  drag,\n'
          '  armed,\n'
          '  refresh,\n'
          '  done,\n'
          '}',
        ),
      ],
    ),
  );
}

// ===========================================================================
// 5. EMBEDDED REAL CONTROL
// ===========================================================================
Widget _embeddedReal() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Embedded CupertinoSliverRefreshControl',
            style: _subTitleStyle()),
        _gap(6.0),
        Text(
          'Below is an actual CustomScrollView containing the sliver. The '
          'control is invisible by default (offscreen above the viewport) '
          '— the embed proves the bridge accepts the widget tree.',
          style: _captionStyle(),
        ),
        _gap(12.0),
        Container(
          height: 200.0,
          decoration: BoxDecoration(
            color: kBackdrop,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: kHairline),
          ),
          clipBehavior: Clip.antiAlias,
          child: CustomScrollView(
            slivers: [
              const CupertinoSliverRefreshControl(
                onRefresh: null,
                refreshTriggerPullDistance: 100.0,
                refreshIndicatorExtent: 60.0,
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Inbox', style: _subTitleStyle()),
                      _gap(8.0),
                      _inboxItem('Jane Doe', '11:24', 'Re: Quarterly review'),
                      _inboxItem('GitHub', '10:58', 'PR #1284 approved'),
                      _inboxItem('Apple Pay', '09:30', 'Receipt for purchase'),
                      _inboxItem('Family', '08:14', 'Dinner on Friday?'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        _gap(10.0),
        _bullet(
            'onRefresh: null disables the gesture but the constructor is valid.'),
        _bullet(
            'The sliver participates in scroll physics regardless of mode.'),
      ],
    ),
  );
}

Widget _inboxItem(String from, String time, String subject) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      children: [
        Container(
          width: 28.0,
          height: 28.0,
          decoration: const BoxDecoration(
            color: kAccentSoft,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(from.substring(0, 1),
              style: _badgeStyle().copyWith(color: kAccent)),
        ),
        _hgap(10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(from, style: _subTitleStyle().copyWith(fontSize: 13.0)),
              Text(subject, style: _captionStyle()),
            ],
          ),
        ),
        Text(time, style: _mutedStyle()),
      ],
    ),
  );
}

// ===========================================================================
// 6. DRAG OFFSET SPECTRUM
// ===========================================================================
Widget _offsetTile(double offset, double trigger) {
  final double ratio = (offset / trigger).clamp(0.0, 1.0);
  final bool armed = offset >= trigger;
  return Container(
    width: 90.0,
    margin: const EdgeInsets.symmetric(horizontal: 4.0),
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: armed ? const Color(0x1A34C759) : kCard,
      border: Border.all(
          color: armed ? kSuccess : kHairline, width: armed ? 1.0 : 0.5),
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Column(
      children: [
        Text('${offset.toInt()} px',
            style: _subTitleStyle().copyWith(fontSize: 13.0)),
        _gap(6.0),
        Container(
          height: 60.0,
          width: 8.0,
          decoration: BoxDecoration(
            color: kBackdrop,
            borderRadius: BorderRadius.circular(4.0),
          ),
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 60.0 * ratio,
            width: 8.0,
            decoration: BoxDecoration(
              color: armed ? kSuccess : kAccent,
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
        ),
        _gap(6.0),
        Text(armed ? 'armed' : '${(ratio * 100).toInt()}%',
            style: _captionStyle()
                .copyWith(color: armed ? kSuccess : kTextSecondary)),
      ],
    ),
  );
}

Widget _offsetSpectrum() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Drag offset spectrum', style: _subTitleStyle()),
        _gap(6.0),
        Text(
          'How the control feels at different drag offsets against the '
          'default 100 px trigger.',
          style: _captionStyle(),
        ),
        _gap(12.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _offsetTile(0.0, 100.0),
              _offsetTile(20.0, 100.0),
              _offsetTile(40.0, 100.0),
              _offsetTile(60.0, 100.0),
              _offsetTile(80.0, 100.0),
              _offsetTile(100.0, 100.0),
              _offsetTile(120.0, 100.0),
            ],
          ),
        ),
        _gap(8.0),
        _bullet('Below 100: drag mode — arrow indicator.'),
        _bullet('At/above 100: armed mode — release will commit.'),
        _bullet('Past 100: overscroll-style stretch, still armed.'),
      ],
    ),
  );
}

// ===========================================================================
// 7. TRIGGER THRESHOLD COMPARISON
// ===========================================================================
Widget _thresholdCard(String label, double trigger, double extent, Color hue) {
  return Expanded(
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: kCard,
        border: Border.all(color: kHairline),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 10.0,
                height: 10.0,
                decoration: BoxDecoration(
                  color: hue,
                  borderRadius: BorderRadius.circular(2.0),
                ),
              ),
              _hgap(6.0),
              Text(label,
                  style: _subTitleStyle().copyWith(fontSize: 13.0)),
            ],
          ),
          _gap(8.0),
          _keyValueRowSmall('Trigger', '${trigger.toInt()} px'),
          _keyValueRowSmall('Extent', '${extent.toInt()} px'),
          _gap(8.0),
          Container(
            height: 80.0,
            decoration: BoxDecoration(
              color: kBackdrop,
              borderRadius: BorderRadius.circular(8.0),
            ),
            alignment: Alignment.center,
            child: SizedBox(
              width: 8.0,
              height: 70.0,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: kHairline,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                  Positioned(
                    bottom: 70.0 * (extent / trigger).clamp(0.0, 1.0),
                    left: -10.0,
                    right: -10.0,
                    child: Container(
                      height: 1.0,
                      color: hue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _keyValueRowSmall(String k, String v) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      children: [
        SizedBox(
          width: 60.0,
          child: Text(k, style: _captionStyle()),
        ),
        Text(v, style: _bodyStyle().copyWith(fontSize: 13.0)),
      ],
    ),
  );
}

Widget _thresholds() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Trigger thresholds compared', style: _subTitleStyle()),
        _gap(6.0),
        Text(
          'Tighter triggers feel snappy; looser triggers reduce false '
          'positives. Apple\'s default of 100 strikes the canonical balance.',
          style: _captionStyle(),
        ),
        _gap(12.0),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _thresholdCard('Tight (60)', 60.0, 40.0, kDanger),
              _thresholdCard('Default (100)', 100.0, 60.0, kAccent),
              _thresholdCard('Loose (140)', 140.0, 80.0, kSuccess),
            ],
          ),
        ),
        _gap(10.0),
        _bullet('Smaller trigger = faster commit, easier accidental refresh.'),
        _bullet('Larger trigger = deliberate commit, slower perceived response.'),
        _bullet('Indicator extent governs the spinner pocket height.'),
      ],
    ),
  );
}

// ===========================================================================
// 8. DEFAULT VS CUSTOM BUILDER
// ===========================================================================
Widget _builderColumn(String title, String desc, Widget content) {
  return Expanded(
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: kCard,
        border: Border.all(color: kHairline),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: _subTitleStyle()),
          _gap(4.0),
          Text(desc, style: _captionStyle()),
          _gap(10.0),
          Container(
            height: 100.0,
            decoration: BoxDecoration(
              color: kBackdrop,
              borderRadius: BorderRadius.circular(10.0),
            ),
            alignment: Alignment.center,
            child: content,
          ),
        ],
      ),
    ),
  );
}

Widget _builderCard() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Default vs custom builder', style: _subTitleStyle()),
        _gap(6.0),
        Text(
          'Pass a builder callback to override the indicator visuals. The '
          'callback receives the current mode and live offsets — perfect '
          'for tying the indicator to a branded animation curve.',
          style: _captionStyle(),
        ),
        _gap(12.0),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _builderColumn(
                'Default',
                'CupertinoActivityIndicator with default tuning.',
                const CupertinoActivityIndicator(
                    radius: 14.0, animating: false),
              ),
              _builderColumn(
                'Custom',
                'Branded checkmark once a refresh completes.',
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 36.0,
                      height: 36.0,
                      decoration: const BoxDecoration(
                        color: kSuccess,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        CupertinoIcons.checkmark_alt,
                        color: CupertinoColors.white,
                        size: 22.0,
                      ),
                    ),
                    _gap(6.0),
                    Text('Up to date', style: _captionStyle()),
                  ],
                ),
              ),
            ],
          ),
        ),
        _gap(12.0),
        _codeBlock(
          'CupertinoSliverRefreshControl(\n'
          '  onRefresh: null,\n'
          '  builder: (BuildContext ctx,\n'
          '            RefreshIndicatorMode mode,\n'
          '            double pulledExtent,\n'
          '            double triggerPullDistance,\n'
          '            double indicatorExtent) {\n'
          '    return Center(child: CupertinoActivityIndicator());\n'
          '  },\n'
          ');',
        ),
      ],
    ),
  );
}

// ===========================================================================
// 9. CUPERTINO HOST VS MATERIAL HOST
// ===========================================================================
Widget _hostPanel({
  required String label,
  required String caption,
  required Color chipColor,
  required Widget body,
}) {
  return Expanded(
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        color: kCard,
        border: Border.all(color: kHairline),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: chipColor.withAlpha(20),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12.0),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 10.0,
                  height: 10.0,
                  decoration: BoxDecoration(
                    color: chipColor,
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
                _hgap(6.0),
                Text(label, style: _subTitleStyle()),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(caption, style: _captionStyle()),
                _gap(8.0),
                body,
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _hostsCard() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Cupertino host vs Material host', style: _subTitleStyle()),
        _gap(6.0),
        Text(
          'The sliver is host-agnostic. It happily lives inside a '
          'CupertinoPageScaffold or a Material Scaffold; the surrounding '
          'chrome is what differs.',
          style: _captionStyle(),
        ),
        _gap(12.0),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _hostPanel(
                label: 'CupertinoPageScaffold',
                caption: 'Translucent nav bar, hairline border, iOS feel.',
                chipColor: kAccent,
                body: Row(
                  children: [
                    const Icon(CupertinoIcons.bars,
                        color: kAccent, size: 20.0),
                    _hgap(8.0),
                    Expanded(
                        child: Text('Inbox',
                            style: _subTitleStyle().copyWith(fontSize: 13.0))),
                    Text('Edit',
                        style: _bodyStyle().copyWith(color: kAccent)),
                  ],
                ),
              ),
              _hostPanel(
                label: 'Material Scaffold',
                caption: 'Material AppBar, elevation, Material ripple feel.',
                chipColor: kSuccess,
                body: Row(
                  children: [
                    const Icon(Icons.menu, color: kSuccess, size: 20.0),
                    _hgap(8.0),
                    Expanded(
                        child: Text('Inbox',
                            style: _subTitleStyle().copyWith(fontSize: 13.0))),
                    const Icon(Icons.more_vert, color: kTextSecondary),
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

// ===========================================================================
// 10. COMPARISON TABLE
// ===========================================================================
Widget _tableHeader(String l, String r) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: const BoxDecoration(
      color: kBadgeBg,
      borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
    ),
    child: Row(
      children: [
        Expanded(child: Text(l, style: _subTitleStyle())),
        Expanded(child: Text(r, style: _subTitleStyle())),
      ],
    ),
  );
}

Widget _tableRow(String k, String l, String r, {bool last = false}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
    decoration: BoxDecoration(
      border: last
          ? null
          : const Border(bottom: BorderSide(color: kHairline, width: 0.5)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 110.0,
          child: Text(k, style: _captionStyle()),
        ),
        Expanded(child: Text(l, style: _bodyStyle().copyWith(fontSize: 13.0))),
        Expanded(child: Text(r, style: _bodyStyle().copyWith(fontSize: 13.0))),
      ],
    ),
  );
}

Widget _comparisonTable() {
  return _card(
    padding: const EdgeInsets.all(0.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _tableHeader('CupertinoSliverRefreshControl', 'RefreshIndicator'),
        _tableRow('Type', 'Sliver',
            'Box widget wrapping a scrollable child'),
        _tableRow('Host', 'Cupertino / any', 'Material'),
        _tableRow('Trigger', 'refreshTriggerPullDistance',
            'Implicit, sensitive to drag delta'),
        _tableRow('Spinner', 'CupertinoActivityIndicator',
            'CircularProgressIndicator'),
        _tableRow('Builder', 'Custom builder callback',
            'Color, backgroundColor, strokeWidth'),
        _tableRow('Async', 'Future<void> Function()?',
            'Future<void> Function()'),
        _tableRow('Visual', 'iOS pull-down stretch',
            'Material spinner descends from top'),
        _tableRow('Pairing', 'CustomScrollView',
            'ListView / SingleChildScrollView', last: true),
      ],
    ),
  );
}

// ===========================================================================
// 11. RECIPE PANELS
// ===========================================================================
Widget _recipeHeader(IconData icon, String title) {
  return Row(
    children: [
      Icon(icon, color: kAccent, size: 18.0),
      _hgap(8.0),
      Text(title, style: _subTitleStyle()),
    ],
  );
}

Widget _recipeEmail() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _recipeHeader(CupertinoIcons.mail, 'Recipe — Email inbox refresh'),
        _gap(8.0),
        Text(
          'A classic. The user drags the message list down to fetch newer '
          'messages from the IMAP server.',
          style: _captionStyle(),
        ),
        _gap(10.0),
        Container(
          decoration: BoxDecoration(
            color: kBackdrop,
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              _inboxItem('Alice', '11:00', 'Lunch?'),
              _hairline(),
              _inboxItem('Bob', '10:35', 'Re: contract'),
              _hairline(),
              _inboxItem('Carol', '09:14', 'Photos from the trip'),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _newsItem(String headline, String section, String when) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: kHairline, width: 0.5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _badge(section),
            _hgap(6.0),
            Text(when, style: _mutedStyle()),
          ],
        ),
        _gap(4.0),
        Text(headline, style: _bodyStyle()),
      ],
    ),
  );
}

Widget _recipeNews() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _recipeHeader(CupertinoIcons.news, 'Recipe — News feed refresh'),
        _gap(8.0),
        Text(
          'News apps refresh top stories. Combine the sliver with sticky '
          'section headers and lazy image loading.',
          style: _captionStyle(),
        ),
        _gap(10.0),
        _newsItem('Markets close mixed after volatile session',
            'FINANCE', '2 min'),
        _newsItem('New Cupertino design language teased',
            'TECH', '11 min'),
        _newsItem('Coastal storm forces evacuations',
            'WEATHER', '34 min'),
        _newsItem('Local team upsets reigning champions',
            'SPORTS', '1 h'),
      ],
    ),
  );
}

Widget _photoTile(int idx) {
  final List<Color> palette = [
    Color(0xFFFFB3BA),
    Color(0xFFBAFFC9),
    Color(0xFFBAE1FF),
    Color(0xFFFFFFBA),
    Color(0xFFFFDFBA),
    Color(0xFFE0BBE4),
  ];
  return Container(
    decoration: BoxDecoration(
      color: palette[idx % palette.length],
      borderRadius: BorderRadius.circular(6.0),
    ),
    alignment: Alignment.center,
    child: Text('#${idx + 1}', style: _captionStyle()),
  );
}

Widget _recipePhotos() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _recipeHeader(CupertinoIcons.photo, 'Recipe — Photo grid refresh'),
        _gap(8.0),
        Text(
          'Photo libraries pull-to-refresh to surface newly synced media. '
          'Pair with a SliverGrid below the control.',
          style: _captionStyle(),
        ),
        _gap(10.0),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 4,
          mainAxisSpacing: 6.0,
          crossAxisSpacing: 6.0,
          children: List<Widget>.generate(8, _photoTile),
        ),
      ],
    ),
  );
}

// ===========================================================================
// 12. GLOSSARY
// ===========================================================================
Widget _glossaryRow(String term, String def) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: kHairline, width: 0.5)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 140.0,
          child: Text(term, style: _subTitleStyle().copyWith(fontSize: 13.0)),
        ),
        Expanded(child: Text(def, style: _bodyStyle().copyWith(fontSize: 13.0))),
      ],
    ),
  );
}

Widget _glossary() {
  return _card(
    padding: const EdgeInsets.all(0.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text('Glossary', style: _subTitleStyle()),
        ),
        _glossaryRow('Sliver',
            'A lazy, scroll-aware widget that participates in CustomScrollView layout.'),
        _glossaryRow('Trigger distance',
            'How far the scroll must drag past the leading edge before commit.'),
        _glossaryRow('Indicator extent',
            'Visible spinner pocket height while the refresh is in progress.'),
        _glossaryRow('Mode',
            'A RefreshIndicatorMode value describing one phase of the gesture.'),
        _glossaryRow('Inactive',
            'No drag is occurring; the sliver yields zero layout extent.'),
        _glossaryRow('Drag',
            'A pull is underway but the trigger distance is not yet reached.'),
        _glossaryRow('Armed',
            'The drag has crossed the trigger; release will commit a refresh.'),
        _glossaryRow('Refresh',
            'The onRefresh future is awaited; spinner is visible.'),
        _glossaryRow('Done',
            'Future has resolved; the indicator retracts to inactive.'),
        _glossaryRow('Activity indicator',
            'The classic iOS rotating-petals spinner.'),
        _glossaryRow('Overscroll',
            'Drag past the natural rest point of the scrollable.'),
        _glossaryRow('Builder',
            'Custom callback for rendering the indicator visuals per-frame.'),
      ],
    ),
  );
}

// ===========================================================================
// 13. EPILOGUE
// ===========================================================================
Widget _epilogue() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Epilogue', style: _subTitleStyle()),
        _gap(8.0),
        Text(
          'CupertinoSliverRefreshControl is small in surface area but rich '
          'in nuance. Its state machine — inactive / drag / armed / '
          'refresh / done — is the same regardless of host, builder, or '
          'business logic. Tuning trigger and indicator extents tailors '
          'the feel; the builder callback opens the door to bespoke '
          'visuals while keeping the gesture canonical.',
          style: _bodyStyle(),
        ),
        _gap(10.0),
        _bullet('Always render the control as the first sliver.'),
        _bullet('Keep onRefresh idempotent — users will pull repeatedly.'),
        _bullet(
            'Disable the control with onRefresh: null while a refresh is queued.'),
        _bullet(
            'Test thresholds on real devices; perceived weight differs per-screen.'),
        _gap(14.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: kAccentSoft,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            children: [
              const Icon(CupertinoIcons.info_circle_fill,
                  color: kAccent, size: 20.0),
              _hgap(10.0),
              Expanded(
                child: Text(
                  'This file is a static, analyzer-clean demo intended for '
                  'the D4rt analyzer-free Flutter interpreter test corpus.',
                  style: _bodyStyle().copyWith(fontSize: 13.0),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// FOOTER STRIP
// ===========================================================================
Widget _footer() {
  return Padding(
    padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 24.0),
    child: Column(
      children: [
        _hairline(),
        _gap(10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('tom_d4rt_flutter_ast', style: _mutedStyle()),
            Text('refresh_test.dart', style: _mutedStyle()),
          ],
        ),
      ],
    ),
  );
}

// ===========================================================================
// ENTRY POINT
// ===========================================================================
dynamic build(BuildContext context) {
  // Local debug echo. The print is allowed by the ignore directive at the
  // top of the file and helps when running this demo against the D4rt
  // interpreter trail.
  print('CupertinoSliverRefreshControl deep visual demo: building tree.');
  final List<String> sections = <String>[
    'hero',
    'concept',
    'anatomy',
    'state-sequence',
    'embedded-real',
    'offset-spectrum',
    'thresholds',
    'builder',
    'hosts',
    'comparison',
    'recipes',
    'glossary',
    'epilogue',
  ];
  print('Sections rendered: ${sections.length}.');

  return CupertinoApp(
    debugShowCheckedModeBanner: false,
    home: CupertinoPageScaffold(
      backgroundColor: kBackdrop,
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Refresh Control — Deep Demo'),
        backgroundColor: Color(0xF2F9F9FB),
        border: Border(bottom: BorderSide(color: kHairline, width: 0.0)),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          children: [
            _hero(),
            _sectionHeader('01', 'Concept',
                'The iOS pull-to-refresh paradigm in one paragraph.'),
            _concept(),
            _sectionHeader('02', 'Anatomy',
                'Drag axis, threshold, indicator pocket — labelled.'),
            _anatomyDiagram(),
            _sectionHeader('03', 'States',
                'Five frozen panels of the RefreshIndicatorMode sequence.'),
            _stateSequence(),
            _sectionHeader('04', 'Embedded',
                'A real CupertinoSliverRefreshControl living in a scroll view.'),
            _embeddedReal(),
            _sectionHeader('05', 'Drag spectrum',
                'Visual progression of drag offset against the trigger.'),
            _offsetSpectrum(),
            _sectionHeader('06', 'Thresholds',
                'Three trigger-distance presets, side by side.'),
            _thresholds(),
            _sectionHeader('07', 'Builder',
                'Default activity indicator vs branded custom visuals.'),
            _builderCard(),
            _sectionHeader('08', 'Hosts',
                'Cupertino scaffold compared with Material scaffold.'),
            _hostsCard(),
            _sectionHeader('09', 'Comparison',
                'CupertinoSliverRefreshControl vs Material RefreshIndicator.'),
            _comparisonTable(),
            _sectionHeader('10', 'Recipes',
                'Three real-world UIs that pair well with the control.'),
            _recipeEmail(),
            _recipeNews(),
            _recipePhotos(),
            _sectionHeader('11', 'Glossary',
                'Twelve terms you will run into when wiring this widget.'),
            _glossary(),
            _sectionHeader('12', 'Epilogue',
                'Closing notes and idiomatic usage tips.'),
            _epilogue(),
            _footer(),
          ],
        ),
      ),
    ),
  );
}
