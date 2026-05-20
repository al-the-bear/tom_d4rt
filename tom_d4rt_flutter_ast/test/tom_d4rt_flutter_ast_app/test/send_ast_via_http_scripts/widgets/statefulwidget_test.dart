// D4rt test script: Deep Demo - StatefulWidget / State / StatefulBuilder
// Comprehensive visual demonstration of stateful patterns expressed entirely
// through StatefulBuilder. Showcases counters, toggles, expansion, accordion,
// tab switching, color pickers, sliders, multi-input forms, undo/redo, list
// editing, pagination, async-mock loading, error/retry state machines, multi
// step wizards and a settings-panel mirror.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ===========================================================================
  // PALETTE COLOR CONSTANTS
  // ===========================================================================

  const Color paletteInk = Color(0xFF18203A);
  const Color paletteInkSoft = Color(0xFF45506F);
  const Color paletteAccent = Color(0xFF5B4CFF);
  const Color paletteAccentSoft = Color(0xFFE6E1FF);
  const Color paletteTeal = Color(0xFF008C8C);
  const Color paletteTealSoft = Color(0xFFCEEDED);
  const Color paletteRose = Color(0xFFD81B60);
  const Color paletteAmber = Color(0xFFD68900);
  const Color paletteGreen = Color(0xFF1B873F);
  const Color paletteGreenSoft = Color(0xFFD7F5DC);
  const Color paletteRed = Color(0xFFB3261E);
  const Color paletteRedSoft = Color(0xFFFADBD8);
  const Color paletteBlue = Color(0xFF1565C0);
  const Color paletteSurface = Color(0xFFF7F6FB);
  const Color paletteSurfaceAlt = Color(0xFFEEEAF8);
  const Color paletteOutline = Color(0xFFD9D5E8);
  const Color paletteMidnight = Color(0xFF1A1740);

  // ===========================================================================
  // SECTION SHELL HELPER
  // ===========================================================================

  Widget sectionShell({
    required String title,
    required String subtitle,
    required Color surface,
    required Color border,
    required Color titleColor,
    required Widget child,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 4.0),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: border, width: 1.4),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: titleColor.withValues(alpha: 0.08),
            blurRadius: 18.0,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(20.0, 18.0, 20.0, 16.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  titleColor.withValues(alpha: 0.18),
                  titleColor.withValues(alpha: 0.04),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(19.0),
                topRight: Radius.circular(19.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 10.0,
                      height: 28.0,
                      decoration: BoxDecoration(
                        color: titleColor,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          color: titleColor,
                          fontSize: 21.0,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.only(left: 22.0),
                  child: Text(
                    subtitle,
                    style: const TextStyle(
                      color: paletteInkSoft,
                      fontSize: 13.0,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 20.0),
            child: child,
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // HERO BANNER
  // ===========================================================================

  final List<String> heroChips = const <String>[
    'StatefulBuilder',
    'setState',
    'State<T>',
    'Counters',
    'Toggles',
    'Expansion',
    'Tabs',
    'Sliders',
    'Forms',
    'Undo/Redo',
    'Lists',
    'Pagination',
    'Async',
    'Wizard',
    'Settings',
  ];

  final List<Widget> heroChipWidgets = heroChips.map((String chip) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.42),
          width: 1.0,
        ),
      ),
      child: Text(
        chip,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11.5,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
        ),
      ),
    );
  }).toList();

  final Widget heroBanner = Container(
    margin: const EdgeInsets.only(bottom: 4.0),
    padding: const EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[
          paletteMidnight,
          paletteAccent,
          Color(0xFF8C7BFF),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(24.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.28),
          blurRadius: 24.0,
          offset: const Offset(0, 14),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.4),
                  width: 1.4,
                ),
              ),
              child: const Icon(
                Icons.dynamic_form,
                color: Colors.white,
                size: 36.0,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    'StatefulWidget — Deep Demo',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26.0,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.4,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    'Fifteen interactive sections, all driven by StatefulBuilder. '
                    'Each section keeps and mutates its own State.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.5,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: heroChipWidgets,
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 1 - COUNTER WITH STATEFULBUILDER
  // ===========================================================================
  // State held in a mutable holder, captured by the StatefulBuilder closure
  // so values survive across rebuilds triggered by setState.

  final Map<String, dynamic> counterState = <String, dynamic>{
    'count': 0,
    'step': 1,
    'locked': false,
    'history': <int>[0],
  };

  final Widget section1Counter = StatefulBuilder(
    builder: (BuildContext ctx, StateSetter setState) {
      final int count = counterState['count'] as int;
      final int step = counterState['step'] as int;
      final bool locked = counterState['locked'] as bool;
      final List<int> history = counterState['history'] as List<int>;
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              paletteAccentSoft.withValues(alpha: 0.65),
              Colors.white,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: paletteOutline, width: 1.0),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Live counter',
                      style: TextStyle(
                        color: paletteAccent,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.4,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      count.toString(),
                      style: const TextStyle(
                        color: paletteInk,
                        fontSize: 56.0,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1.5,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14.0,
                    vertical: 8.0,
                  ),
                  decoration: BoxDecoration(
                    color: locked ? paletteRedSoft : paletteGreenSoft,
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: locked ? paletteRed : paletteGreen,
                      width: 1.2,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        locked ? Icons.lock : Icons.lock_open,
                        color: locked ? paletteRed : paletteGreen,
                        size: 16.0,
                      ),
                      const SizedBox(width: 6.0),
                      Text(
                        locked ? 'LOCKED' : 'ACTIVE',
                        style: TextStyle(
                          color: locked ? paletteRed : paletteGreen,
                          fontSize: 11.0,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18.0),
            Row(
              children: <Widget>[
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: locked
                        ? null
                        : () {
                            setState(() {
                              counterState['count'] = count - step;
                              history.add(count - step);
                            });
                          },
                    icon: const Icon(Icons.remove),
                    label: Text('- $step'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: paletteRose,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                    ),
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: locked
                        ? null
                        : () {
                            setState(() {
                              counterState['count'] = 0;
                              history.clear();
                              history.add(0);
                            });
                          },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reset'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: paletteInkSoft,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                    ),
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: locked
                        ? null
                        : () {
                            setState(() {
                              counterState['count'] = count + step;
                              history.add(count + step);
                            });
                          },
                    icon: const Icon(Icons.add),
                    label: Text('+ $step'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: paletteAccent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18.0),
            Row(
              children: <Widget>[
                const Text(
                  'Step size:',
                  style: TextStyle(
                    color: paletteInk,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Wrap(
                    spacing: 8.0,
                    children: List<Widget>.generate(4, (int i) {
                      final int value = <int>[1, 5, 10, 25][i];
                      final bool active = step == value;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            counterState['step'] = value;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14.0,
                            vertical: 8.0,
                          ),
                          decoration: BoxDecoration(
                            color: active ? paletteAccent : Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              color: active ? paletteAccent : paletteOutline,
                              width: 1.4,
                            ),
                          ),
                          child: Text(
                            value.toString(),
                            style: TextStyle(
                              color: active ? Colors.white : paletteInk,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                Switch(
                  value: locked,
                  activeThumbColor: paletteRed,
                  onChanged: (bool v) {
                    setState(() {
                      counterState['locked'] = v;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 14.0),
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: paletteOutline, width: 1.0),
              ),
              child: Row(
                children: <Widget>[
                  const Icon(
                    Icons.timeline,
                    color: paletteAccent,
                    size: 18.0,
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      'History: ${history.join(" -> ")}',
                      style: const TextStyle(
                        color: paletteInkSoft,
                        fontSize: 12.0,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );


  // ===========================================================================
  // SECTION 2 - TOGGLE SWITCH STATE
  // ===========================================================================

  final Map<String, bool> toggleState = <String, bool>{
    'notifications': true,
    'darkMode': false,
    'analytics': true,
    'beta': false,
    'autosave': true,
    'sounds': false,
  };

  final List<Map<String, dynamic>> toggleItems = <Map<String, dynamic>>[
    <String, dynamic>{
      'key': 'notifications',
      'label': 'Push notifications',
      'subtitle': 'Receive alerts about activity and mentions',
      'icon': Icons.notifications_active,
      'color': paletteAccent,
    },
    <String, dynamic>{
      'key': 'darkMode',
      'label': 'Dark mode',
      'subtitle': 'Easier on the eyes in low light',
      'icon': Icons.dark_mode,
      'color': paletteMidnight,
    },
    <String, dynamic>{
      'key': 'analytics',
      'label': 'Anonymous analytics',
      'subtitle': 'Help improve the product with crash data',
      'icon': Icons.analytics,
      'color': paletteTeal,
    },
    <String, dynamic>{
      'key': 'beta',
      'label': 'Beta features',
      'subtitle': 'Try unreleased functionality early',
      'icon': Icons.science,
      'color': paletteAmber,
    },
    <String, dynamic>{
      'key': 'autosave',
      'label': 'Autosave',
      'subtitle': 'Save your work automatically every minute',
      'icon': Icons.save,
      'color': paletteGreen,
    },
    <String, dynamic>{
      'key': 'sounds',
      'label': 'UI sounds',
      'subtitle': 'Subtle audio cues for actions',
      'icon': Icons.music_note,
      'color': paletteRose,
    },
  ];

  final Widget section2Toggles = StatefulBuilder(
    builder: (BuildContext ctx, StateSetter setState) {
      final List<Widget> rows = toggleItems.map((Map<String, dynamic> item) {
        final String key = item['key'] as String;
        final String label = item['label'] as String;
        final String subtitle = item['subtitle'] as String;
        final IconData icon = item['icon'] as IconData;
        final Color color = item['color'] as Color;
        final bool value = toggleState[key] ?? false;
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          padding: const EdgeInsets.symmetric(
            horizontal: 14.0,
            vertical: 12.0,
          ),
          decoration: BoxDecoration(
            color: value
                ? color.withValues(alpha: 0.10)
                : Colors.white,
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(
              color: value ? color : paletteOutline,
              width: value ? 1.6 : 1.0,
            ),
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: 42.0,
                height: 42.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: value ? color : paletteSurfaceAlt,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Icon(
                  icon,
                  color: value ? Colors.white : paletteInkSoft,
                  size: 22.0,
                ),
              ),
              const SizedBox(width: 14.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      label,
                      style: TextStyle(
                        color: value ? color : paletteInk,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: paletteInkSoft,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: value,
                activeThumbColor: color,
                onChanged: (bool v) {
                  setState(() {
                    toggleState[key] = v;
                  });
                },
              ),
            ],
          ),
        );
      }).toList();

      final int onCount =
          toggleState.values.where((bool v) => v).length;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14.0,
              vertical: 10.0,
            ),
            decoration: BoxDecoration(
              color: paletteAccentSoft,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              children: <Widget>[
                const Icon(
                  Icons.toggle_on,
                  color: paletteAccent,
                  size: 20.0,
                ),
                const SizedBox(width: 8.0),
                Text(
                  '$onCount of ${toggleItems.length} preferences enabled',
                  style: const TextStyle(
                    color: paletteAccent,
                    fontSize: 13.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          ...rows,
        ],
      );
    },
  );

  // ===========================================================================
  // SECTION 3 - EXPANDED CARD
  // ===========================================================================

  final Map<String, dynamic> expandedState = <String, dynamic>{
    'expanded': false,
  };

  final Widget section3ExpandedCard = StatefulBuilder(
    builder: (BuildContext ctx, StateSetter setState) {
      final bool expanded = expandedState['expanded'] as bool;
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: paletteOutline, width: 1.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: paletteTeal.withValues(alpha: 0.10),
              blurRadius: 14.0,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            InkWell(
              onTap: () {
                setState(() {
                  expandedState['expanded'] = !expanded;
                });
              },
              borderRadius: BorderRadius.circular(16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 52.0,
                      height: 52.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: <Color>[
                            paletteTeal,
                            Color(0xFF00BFA5),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      child: const Icon(
                        Icons.cloud_outlined,
                        color: Colors.white,
                        size: 28.0,
                      ),
                    ),
                    const SizedBox(width: 14.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>[
                          Text(
                            'Cloud workspace',
                            style: TextStyle(
                              color: paletteInk,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            'Tap to expand and see details',
                            style: TextStyle(
                              color: paletteInkSoft,
                              fontSize: 12.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    AnimatedRotation(
                      turns: expanded ? 0.5 : 0.0,
                      duration: const Duration(milliseconds: 280),
                      child: const Icon(
                        Icons.expand_more,
                        color: paletteTeal,
                        size: 26.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AnimatedCrossFade(
              firstChild: const SizedBox(height: 0.0),
              secondChild: Container(
                padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Divider(color: paletteOutline),
                    const SizedBox(height: 10.0),
                    Row(
                      children: <Widget>[
                        for (final List<dynamic> stat in const <List<dynamic>>[
                          <dynamic>['Storage', '42 GB', Icons.storage],
                          <dynamic>['Members', '8', Icons.group],
                          <dynamic>['Uptime', '99.9%', Icons.bolt],
                        ])
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 4.0,
                              ),
                              padding: const EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                color: paletteTealSoft.withValues(alpha: 0.5),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Icon(
                                    stat[2] as IconData,
                                    color: paletteTeal,
                                    size: 22.0,
                                  ),
                                  const SizedBox(height: 6.0),
                                  Text(
                                    stat[1] as String,
                                    style: const TextStyle(
                                      color: paletteInk,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  Text(
                                    stat[0] as String,
                                    style: const TextStyle(
                                      color: paletteInkSoft,
                                      fontSize: 11.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 12.0),
                    const Text(
                      'Last sync 2 minutes ago. All files are mirrored across '
                      'three regions and encrypted at rest. Snapshots are '
                      'taken every six hours.',
                      style: TextStyle(
                        color: paletteInkSoft,
                        fontSize: 12.5,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              crossFadeState: expanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 280),
            ),
          ],
        ),
      );
    },
  );

  // ===========================================================================
  // SECTION 4 - ACCORDION (MULTIPLE EXPANSIONS)
  // ===========================================================================

  final List<bool> accordionOpen = <bool>[true, false, false, false];
  final List<Map<String, dynamic>> accordionItems = <Map<String, dynamic>>[
    <String, dynamic>{
      'icon': Icons.help_outline,
      'title': 'Why do panels exist?',
      'body':
          'Accordion panels collapse and expand to make dense lists of content '
          'browseable. They share a common visual rhythm and align their '
          'control affordance on the right.',
      'color': paletteAccent,
    },
    <String, dynamic>{
      'icon': Icons.lock_outline,
      'title': 'Are my secrets safe?',
      'body':
          'All sensitive fields are encrypted with envelope encryption. The '
          'private key never leaves the secure enclave. We rotate keys every '
          'ninety days.',
      'color': paletteTeal,
    },
    <String, dynamic>{
      'icon': Icons.payments,
      'title': 'How does billing work?',
      'body':
          'Billing is monthly, in arrears, based on actual usage. You can set '
          'spending caps and receive alerts when 50%, 80%, and 100% thresholds '
          'are crossed.',
      'color': paletteAmber,
    },
    <String, dynamic>{
      'icon': Icons.support_agent,
      'title': 'Can I talk to a human?',
      'body':
          'Absolutely. Our team is in three time zones, online almost around '
          'the clock. Click the chat bubble or email support@example.com.',
      'color': paletteRose,
    },
  ];

  final Widget section4Accordion = StatefulBuilder(
    builder: (BuildContext ctx, StateSetter setState) {
      final List<Widget> panels =
          List<Widget>.generate(accordionItems.length, (int i) {
        final Map<String, dynamic> item = accordionItems[i];
        final bool open = accordionOpen[i];
        final Color color = item['color'] as Color;
        return Container(
          margin: const EdgeInsets.only(bottom: 8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: open ? color : paletteOutline,
              width: open ? 1.6 : 1.0,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              InkWell(
                borderRadius: BorderRadius.circular(12.0),
                onTap: () {
                  setState(() {
                    accordionOpen[i] = !open;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 36.0,
                        height: 36.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: open
                              ? color
                              : color.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Icon(
                          item['icon'] as IconData,
                          color: open ? Colors.white : color,
                          size: 20.0,
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      Expanded(
                        child: Text(
                          item['title'] as String,
                          style: TextStyle(
                            color: open ? color : paletteInk,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Icon(
                        open ? Icons.remove_circle : Icons.add_circle,
                        color: color,
                        size: 22.0,
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    16.0, 0.0, 16.0, 14.0,
                  ),
                  child: Text(
                    item['body'] as String,
                    style: const TextStyle(
                      color: paletteInkSoft,
                      fontSize: 13.0,
                      height: 1.5,
                    ),
                  ),
                ),
                crossFadeState: open
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 220),
              ),
            ],
          ),
        );
      });

      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton.icon(
                onPressed: () {
                  setState(() {
                    for (int i = 0; i < accordionOpen.length; i++) {
                      accordionOpen[i] = true;
                    }
                  });
                },
                icon: const Icon(Icons.unfold_more),
                label: const Text('Expand all'),
              ),
              const SizedBox(width: 4.0),
              TextButton.icon(
                onPressed: () {
                  setState(() {
                    for (int i = 0; i < accordionOpen.length; i++) {
                      accordionOpen[i] = false;
                    }
                  });
                },
                icon: const Icon(Icons.unfold_less),
                label: const Text('Collapse all'),
              ),
            ],
          ),
          const SizedBox(height: 6.0),
          ...panels,
        ],
      );
    },
  );

  // ===========================================================================
  // SECTION 5 - TAB SWITCHER
  // ===========================================================================

  final Map<String, dynamic> tabState = <String, dynamic>{
    'index': 0,
  };
  final List<Map<String, dynamic>> tabs = <Map<String, dynamic>>[
    <String, dynamic>{
      'label': 'Overview',
      'icon': Icons.dashboard,
      'title': 'Project Kestrel',
      'body':
          'A high-velocity initiative aimed at consolidating analytics across '
          'all customer surfaces. Twelve squads contribute, three release '
          'trains per quarter.',
      'color': paletteAccent,
    },
    <String, dynamic>{
      'label': 'Metrics',
      'icon': Icons.show_chart,
      'title': 'Telemetry snapshot',
      'body':
          'p50 response time is 84ms, p99 is 218ms. Error budget consumption '
          'is at 31% with seventeen days left in the window. Throughput is '
          'tracking 9% above last quarter.',
      'color': paletteTeal,
    },
    <String, dynamic>{
      'label': 'Team',
      'icon': Icons.people,
      'title': 'People involved',
      'body':
          'Twenty-eight engineers, four designers, two product managers. Time '
          'zones span from Pacific to Central European. Daily handoff at '
          '15:00 UTC.',
      'color': paletteRose,
    },
    <String, dynamic>{
      'label': 'Risks',
      'icon': Icons.warning_amber,
      'title': 'Open risks',
      'body':
          'Vendor lock-in on payment gateway is the top risk. Migration plan '
          'is drafted but not staffed. Two more risks pending triage.',
      'color': paletteAmber,
    },
  ];

  final Widget section5Tabs = StatefulBuilder(
    builder: (BuildContext ctx, StateSetter setState) {
      final int idx = tabState['index'] as int;
      final Map<String, dynamic> active = tabs[idx];
      final Color color = active['color'] as Color;
      final List<Widget> tabButtons =
          List<Widget>.generate(tabs.length, (int i) {
        final Map<String, dynamic> t = tabs[i];
        final bool sel = i == idx;
        return Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                tabState['index'] = i;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              decoration: BoxDecoration(
                color: sel ? (t['color'] as Color) : Colors.transparent,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: <Widget>[
                  Icon(
                    t['icon'] as IconData,
                    color: sel ? Colors.white : paletteInkSoft,
                    size: 22.0,
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    t['label'] as String,
                    style: TextStyle(
                      color: sel ? Colors.white : paletteInkSoft,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: paletteSurfaceAlt,
              borderRadius: BorderRadius.circular(14.0),
            ),
            child: Row(children: tabButtons),
          ),
          const SizedBox(height: 14.0),
          AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            padding: const EdgeInsets.all(18.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(14.0),
              border: Border.all(color: color, width: 1.4),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Icon(
                        active['icon'] as IconData,
                        color: Colors.white,
                        size: 22.0,
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: Text(
                        active['title'] as String,
                        style: TextStyle(
                          color: color,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),
                Text(
                  active['body'] as String,
                  style: const TextStyle(
                    color: paletteInk,
                    fontSize: 13.0,
                    height: 1.55,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );

  // ===========================================================================
  // SECTION 6 - COLOR PICKER GRID
  // ===========================================================================

  final Map<String, dynamic> colorPickerState = <String, dynamic>{
    'index': 4,
  };
  final List<Map<String, dynamic>> swatches = <Map<String, dynamic>>[
    <String, dynamic>{'color': const Color(0xFFB3261E), 'name': 'Crimson'},
    <String, dynamic>{'color': const Color(0xFFD68900), 'name': 'Amber'},
    <String, dynamic>{'color': const Color(0xFFFFC727), 'name': 'Sunflower'},
    <String, dynamic>{'color': const Color(0xFF1B873F), 'name': 'Emerald'},
    <String, dynamic>{'color': const Color(0xFF008C8C), 'name': 'Teal'},
    <String, dynamic>{'color': const Color(0xFF1565C0), 'name': 'Ocean'},
    <String, dynamic>{'color': const Color(0xFF5B4CFF), 'name': 'Indigo'},
    <String, dynamic>{'color': const Color(0xFF6A1B9A), 'name': 'Plum'},
    <String, dynamic>{'color': const Color(0xFFD81B60), 'name': 'Rose'},
    <String, dynamic>{'color': const Color(0xFF455A64), 'name': 'Slate'},
    <String, dynamic>{'color': const Color(0xFF18203A), 'name': 'Midnight'},
    <String, dynamic>{'color': const Color(0xFF8E7CC3), 'name': 'Lavender'},
  ];

  final Widget section6ColorPicker = StatefulBuilder(
    builder: (BuildContext ctx, StateSetter setState) {
      final int idx = colorPickerState['index'] as int;
      final Color sel = swatches[idx]['color'] as Color;
      final String selName = swatches[idx]['name'] as String;
      final List<Widget> swatchWidgets =
          List<Widget>.generate(swatches.length, (int i) {
        final Color c = swatches[i]['color'] as Color;
        final bool active = i == idx;
        return GestureDetector(
          onTap: () {
            setState(() {
              colorPickerState['index'] = i;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 56.0,
            height: 56.0,
            decoration: BoxDecoration(
              color: c,
              borderRadius: BorderRadius.circular(active ? 18.0 : 12.0),
              border: Border.all(
                color: active ? Colors.white : Colors.transparent,
                width: 3.0,
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: c.withValues(alpha: active ? 0.55 : 0.20),
                  blurRadius: active ? 14.0 : 6.0,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: active
                ? const Icon(Icons.check, color: Colors.white, size: 26.0)
                : null,
          ),
        );
      });
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[sel, sel.withValues(alpha: 0.7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14.0),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 56.0,
                  height: 56.0,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(14.0),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.5),
                      width: 1.6,
                    ),
                  ),
                  child: const Icon(
                    Icons.palette,
                    color: Colors.white,
                    size: 28.0,
                  ),
                ),
                const SizedBox(width: 14.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'CURRENT SELECTION',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11.0,
                          letterSpacing: 1.6,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        selName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        '#${sel.toARGB32().toRadixString(16).toUpperCase()}',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.85),
                          fontSize: 12.0,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14.0),
          Wrap(
            spacing: 10.0,
            runSpacing: 10.0,
            children: swatchWidgets,
          ),
        ],
      );
    },
  );

  // ===========================================================================
  // SECTION 7 - SLIDER WITH LIVE READOUT
  // ===========================================================================

  final Map<String, double> sliderState = <String, double>{
    'volume': 60.0,
    'brightness': 80.0,
    'contrast': 45.0,
    'warmth': 30.0,
  };
  final List<Map<String, dynamic>> sliderItems = <Map<String, dynamic>>[
    <String, dynamic>{
      'key': 'volume',
      'label': 'Volume',
      'icon': Icons.volume_up,
      'color': paletteAccent,
      'unit': '%',
    },
    <String, dynamic>{
      'key': 'brightness',
      'label': 'Brightness',
      'icon': Icons.wb_sunny,
      'color': paletteAmber,
      'unit': '%',
    },
    <String, dynamic>{
      'key': 'contrast',
      'label': 'Contrast',
      'icon': Icons.contrast,
      'color': paletteTeal,
      'unit': '%',
    },
    <String, dynamic>{
      'key': 'warmth',
      'label': 'Warmth',
      'icon': Icons.thermostat,
      'color': paletteRose,
      'unit': '%',
    },
  ];

  final Widget section7Sliders = StatefulBuilder(
    builder: (BuildContext ctx, StateSetter setState) {
      final List<Widget> rows =
          List<Widget>.generate(sliderItems.length, (int i) {
        final Map<String, dynamic> item = sliderItems[i];
        final String key = item['key'] as String;
        final Color color = item['color'] as Color;
        final double value = sliderState[key] ?? 0.0;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 36.0,
                    height: 36.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Icon(
                      item['icon'] as IconData,
                      color: Colors.white,
                      size: 18.0,
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: Text(
                      item['label'] as String,
                      style: const TextStyle(
                        color: paletteInk,
                        fontWeight: FontWeight.w700,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 6.0,
                    ),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text(
                      '${value.toStringAsFixed(0)}${item['unit']}',
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.w800,
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              SliderTheme(
                data: SliderTheme.of(ctx).copyWith(
                  activeTrackColor: color,
                  inactiveTrackColor: color.withValues(alpha: 0.18),
                  thumbColor: color,
                  overlayColor: color.withValues(alpha: 0.25),
                  trackHeight: 6.0,
                ),
                child: Slider(
                  value: value,
                  min: 0.0,
                  max: 100.0,
                  divisions: 100,
                  onChanged: (double v) {
                    setState(() {
                      sliderState[key] = v;
                    });
                  },
                ),
              ),
            ],
          ),
        );
      });
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ...rows,
          const SizedBox(height: 8.0),
          Container(
            padding: const EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: paletteSurfaceAlt,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Row(
              children: <Widget>[
                const Icon(
                  Icons.equalizer,
                  color: paletteAccent,
                  size: 20.0,
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    'Composite score: ${(sliderState.values.reduce(
                      (double a, double b) => a + b,
                    ) / 4).toStringAsFixed(1)}',
                    style: const TextStyle(
                      color: paletteInk,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      sliderState['volume'] = 50.0;
                      sliderState['brightness'] = 50.0;
                      sliderState['contrast'] = 50.0;
                      sliderState['warmth'] = 50.0;
                    });
                  },
                  child: const Text('Center all'),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );

  // ===========================================================================
  // SECTION 8 - MULTI-INPUT FORM SUMMARY
  // ===========================================================================

  final Map<String, dynamic> formState = <String, dynamic>{
    'name': '',
    'email': '',
    'role': 'Developer',
    'years': 3,
    'remote': true,
  };
  final List<String> roles = const <String>[
    'Developer',
    'Designer',
    'Manager',
    'QA',
    'DevOps',
  ];

  final Widget section8Form = StatefulBuilder(
    builder: (BuildContext ctx, StateSetter setState) {
      final String name = formState['name'] as String;
      final String email = formState['email'] as String;
      final String role = formState['role'] as String;
      final int years = formState['years'] as int;
      final bool remote = formState['remote'] as bool;
      final List<Widget> roleChips = roles.map((String r) {
        final bool sel = r == role;
        return Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: ChoiceChip(
            label: Text(r),
            selected: sel,
            selectedColor: paletteAccent,
            backgroundColor: Colors.white,
            labelStyle: TextStyle(
              color: sel ? Colors.white : paletteInk,
              fontWeight: FontWeight.w700,
            ),
            side: BorderSide(
              color: sel ? paletteAccent : paletteOutline,
              width: 1.2,
            ),
            onSelected: (bool s) {
              setState(() {
                formState['role'] = r;
              });
            },
          ),
        );
      }).toList();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Full name',
                    prefixIcon: const Icon(Icons.person),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide:
                          const BorderSide(color: paletteOutline),
                    ),
                  ),
                  onChanged: (String v) {
                    setState(() {
                      formState['name'] = v;
                    });
                  },
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: const Icon(Icons.email),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide:
                          const BorderSide(color: paletteOutline),
                    ),
                  ),
                  onChanged: (String v) {
                    setState(() {
                      formState['email'] = v;
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 14.0),
          const Text(
            'Role',
            style: TextStyle(
              color: paletteInkSoft,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8.0),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: roleChips),
          ),
          const SizedBox(height: 14.0),
          Row(
            children: <Widget>[
              const Text(
                'Years of experience',
                style: TextStyle(
                  color: paletteInkSoft,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Expanded(
                child: Slider(
                  value: years.toDouble(),
                  min: 0.0,
                  max: 30.0,
                  divisions: 30,
                  label: '$years yr',
                  onChanged: (double v) {
                    setState(() {
                      formState['years'] = v.round();
                    });
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 6.0,
                ),
                decoration: BoxDecoration(
                  color: paletteAccent,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Text(
                  '$years yr',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          SwitchListTile(
            title: const Text('Remote position'),
            subtitle: const Text('Work from anywhere'),
            value: remote,
            activeThumbColor: paletteAccent,
            onChanged: (bool v) {
              setState(() {
                formState['remote'] = v;
              });
            },
          ),
          const SizedBox(height: 8.0),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: paletteAccentSoft.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: paletteAccent, width: 1.2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'LIVE SUMMARY',
                  style: TextStyle(
                    color: paletteAccent,
                    fontSize: 11.0,
                    letterSpacing: 1.4,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Name: ${name.isEmpty ? "(empty)" : name}',
                  style: const TextStyle(color: paletteInk),
                ),
                Text(
                  'Email: ${email.isEmpty ? "(empty)" : email}',
                  style: const TextStyle(color: paletteInk),
                ),
                Text('Role: $role',
                    style: const TextStyle(color: paletteInk)),
                Text('Experience: $years years',
                    style: const TextStyle(color: paletteInk)),
                Text('Remote: ${remote ? "yes" : "no"}',
                    style: const TextStyle(color: paletteInk)),
              ],
            ),
          ),
        ],
      );
    },
  );

  // ===========================================================================
  // SECTION 9 - UNDO / REDO DEMO
  // ===========================================================================

  final Map<String, dynamic> undoState = <String, dynamic>{
    'value': 'Hello',
    'history': <String>['Hello'],
    'pointer': 0,
  };
  final List<String> undoSnippets = const <String>[
    'Hello',
    'Hello world',
    'Hello world!',
    'Hello world! How are you?',
    'Hello world! How are you doing today?',
  ];

  final Widget section9UndoRedo = StatefulBuilder(
    builder: (BuildContext ctx, StateSetter setState) {
      final String value = undoState['value'] as String;
      final List<String> history = undoState['history'] as List<String>;
      final int pointer = undoState['pointer'] as int;
      final bool canUndo = pointer > 0;
      final bool canRedo = pointer < history.length - 1;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(18.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14.0),
              border: Border.all(color: paletteOutline, width: 1.2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'DOCUMENT',
                  style: TextStyle(
                    color: paletteInkSoft,
                    fontSize: 11.0,
                    letterSpacing: 1.6,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  value,
                  style: const TextStyle(
                    color: paletteInk,
                    fontSize: 22.0,
                    fontWeight: FontWeight.w700,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14.0),
          Row(
            children: <Widget>[
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: canUndo
                      ? () {
                          setState(() {
                            final int np = pointer - 1;
                            undoState['pointer'] = np;
                            undoState['value'] = history[np];
                          });
                        }
                      : null,
                  icon: const Icon(Icons.undo),
                  label: const Text('Undo'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: paletteAccent,
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                    side: const BorderSide(color: paletteAccent),
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    final int next = (pointer + 1) % undoSnippets.length;
                    setState(() {
                      // truncate redo branch
                      if (pointer < history.length - 1) {
                        history.removeRange(pointer + 1, history.length);
                      }
                      history.add(undoSnippets[next]);
                      undoState['pointer'] = history.length - 1;
                      undoState['value'] = undoSnippets[next];
                    });
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text('Edit'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: paletteAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: canRedo
                      ? () {
                          setState(() {
                            final int np = pointer + 1;
                            undoState['pointer'] = np;
                            undoState['value'] = history[np];
                          });
                        }
                      : null,
                  icon: const Icon(Icons.redo),
                  label: const Text('Redo'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: paletteAccent,
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                    side: const BorderSide(color: paletteAccent),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14.0),
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: paletteSurfaceAlt,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'History (${pointer + 1}/${history.length})',
                  style: const TextStyle(
                    color: paletteInkSoft,
                    fontSize: 11.0,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6.0),
                Wrap(
                  spacing: 6.0,
                  runSpacing: 6.0,
                  children: List<Widget>.generate(history.length, (int i) {
                    final bool current = i == pointer;
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        color: current
                            ? paletteAccent
                            : Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: current
                              ? paletteAccent
                              : paletteOutline,
                          width: 1.0,
                        ),
                      ),
                      child: Text(
                        '#${i + 1}',
                        style: TextStyle(
                          color: current ? Colors.white : paletteInk,
                          fontSize: 11.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );

  // ===========================================================================
  // SECTION 10 - LIST EDITOR (ADD / REMOVE / REORDER)
  // ===========================================================================

  final Map<String, dynamic> listState = <String, dynamic>{
    'items': <Map<String, dynamic>>[
      <String, dynamic>{'label': 'Outline architecture', 'done': true},
      <String, dynamic>{'label': 'Draft project plan', 'done': true},
      <String, dynamic>{'label': 'Review with stakeholders', 'done': false},
      <String, dynamic>{'label': 'Schedule kickoff meeting', 'done': false},
      <String, dynamic>{'label': 'Provision dev environment', 'done': false},
    ],
    'counter': 6,
  };

  final Widget section10ListEditor = StatefulBuilder(
    builder: (BuildContext ctx, StateSetter setState) {
      final List<Map<String, dynamic>> items =
          listState['items'] as List<Map<String, dynamic>>;
      final int counter = listState['counter'] as int;
      final List<Widget> rows = List<Widget>.generate(items.length, (int i) {
        final Map<String, dynamic> it = items[i];
        final bool done = it['done'] as bool;
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 10.0,
          ),
          decoration: BoxDecoration(
            color: done
                ? paletteGreenSoft.withValues(alpha: 0.45)
                : Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: done ? paletteGreen : paletteOutline,
              width: 1.1,
            ),
          ),
          child: Row(
            children: <Widget>[
              Checkbox(
                value: done,
                activeColor: paletteGreen,
                onChanged: (bool? v) {
                  setState(() {
                    it['done'] = v ?? false;
                  });
                },
              ),
              Expanded(
                child: Text(
                  it['label'] as String,
                  style: TextStyle(
                    color: done ? paletteInkSoft : paletteInk,
                    fontWeight: FontWeight.w600,
                    decoration: done
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_upward, size: 18.0),
                tooltip: 'Move up',
                color: paletteInkSoft,
                onPressed: i == 0
                    ? null
                    : () {
                        setState(() {
                          final Map<String, dynamic> tmp = items[i];
                          items[i] = items[i - 1];
                          items[i - 1] = tmp;
                        });
                      },
              ),
              IconButton(
                icon: const Icon(Icons.arrow_downward, size: 18.0),
                tooltip: 'Move down',
                color: paletteInkSoft,
                onPressed: i == items.length - 1
                    ? null
                    : () {
                        setState(() {
                          final Map<String, dynamic> tmp = items[i];
                          items[i] = items[i + 1];
                          items[i + 1] = tmp;
                        });
                      },
              ),
              IconButton(
                icon: const Icon(Icons.close, size: 18.0),
                tooltip: 'Remove',
                color: paletteRed,
                onPressed: () {
                  setState(() {
                    items.removeAt(i);
                  });
                },
              ),
            ],
          ),
        );
      });
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  '${items.length} tasks, ${items.where(
                    (Map<String, dynamic> m) => m['done'] as bool,
                  ).length} done',
                  style: const TextStyle(
                    color: paletteInkSoft,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    items.add(<String, dynamic>{
                      'label': 'New task #$counter',
                      'done': false,
                    });
                    listState['counter'] = counter + 1;
                  });
                },
                icon: const Icon(Icons.add),
                label: const Text('Add'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: paletteAccent,
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(width: 8.0),
              OutlinedButton.icon(
                onPressed: items.isEmpty
                    ? null
                    : () {
                        setState(() {
                          items.removeWhere(
                            (Map<String, dynamic> m) => m['done'] as bool,
                          );
                        });
                      },
                icon: const Icon(Icons.cleaning_services),
                label: const Text('Clear done'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: paletteRed,
                  side: const BorderSide(color: paletteRed),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          ...rows,
          if (items.isEmpty)
            Container(
              padding: const EdgeInsets.all(20.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: paletteSurfaceAlt,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: const Text(
                'List is empty — press Add to start.',
                style: TextStyle(color: paletteInkSoft),
              ),
            ),
        ],
      );
    },
  );

  // ===========================================================================
  // SECTION 11 - PAGINATION
  // ===========================================================================

  final Map<String, dynamic> paginationState = <String, dynamic>{
    'page': 0,
  };
  const int pageSize = 5;
  final List<Map<String, dynamic>> paginatedRows = List<Map<String, dynamic>>
      .generate(38, (int i) {
    return <String, dynamic>{
      'id': 1000 + i,
      'name': 'Record ${(i + 1).toString().padLeft(2, "0")}',
      'category': <String>[
        'Alpha',
        'Bravo',
        'Charlie',
        'Delta',
      ][i % 4],
      'amount': (i * 7 + 13) % 250,
    };
  });

  final Widget section11Pagination = StatefulBuilder(
    builder: (BuildContext ctx, StateSetter setState) {
      final int page = paginationState['page'] as int;
      final int totalPages =
          (paginatedRows.length / pageSize).ceil();
      final int start = page * pageSize;
      final int end = (start + pageSize).clamp(0, paginatedRows.length);
      final List<Map<String, dynamic>> slice =
          paginatedRows.sublist(start, end);
      final List<Widget> pageButtons =
          List<Widget>.generate(totalPages, (int i) {
        final bool active = i == page;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3.0),
          child: GestureDetector(
            onTap: () {
              setState(() {
                paginationState['page'] = i;
              });
            },
            child: Container(
              width: 34.0,
              height: 34.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: active ? paletteAccent : Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: active ? paletteAccent : paletteOutline,
                  width: 1.2,
                ),
              ),
              child: Text(
                (i + 1).toString(),
                style: TextStyle(
                  color: active ? Colors.white : paletteInk,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        );
      });
      final List<Widget> sliceRows = slice.map((Map<String, dynamic> r) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 3.0),
          padding: const EdgeInsets.symmetric(
            horizontal: 14.0,
            vertical: 10.0,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: paletteOutline, width: 1.0),
          ),
          child: Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 3.0,
                ),
                decoration: BoxDecoration(
                  color: paletteAccentSoft,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  '#${r['id']}',
                  style: const TextStyle(
                    color: paletteAccent,
                    fontFamily: 'monospace',
                    fontSize: 11.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Text(
                  r['name'] as String,
                  style: const TextStyle(
                    color: paletteInk,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 3.0,
                ),
                decoration: BoxDecoration(
                  color: paletteTealSoft,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  r['category'] as String,
                  style: const TextStyle(
                    color: paletteTeal,
                    fontWeight: FontWeight.w700,
                    fontSize: 11.0,
                  ),
                ),
              ),
              const SizedBox(width: 12.0),
              Text(
                '\$${r['amount']}',
                style: const TextStyle(
                  color: paletteGreen,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        );
      }).toList();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14.0,
              vertical: 10.0,
            ),
            decoration: BoxDecoration(
              color: paletteAccentSoft.withValues(alpha: 0.45),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              children: <Widget>[
                const Icon(
                  Icons.table_rows,
                  color: paletteAccent,
                  size: 18.0,
                ),
                const SizedBox(width: 8.0),
                Text(
                  'Showing ${start + 1}-$end of '
                  '${paginatedRows.length}',
                  style: const TextStyle(
                    color: paletteAccent,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                Text(
                  'Page ${page + 1} of $totalPages',
                  style: const TextStyle(
                    color: paletteInkSoft,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          ...sliceRows,
          const SizedBox(height: 12.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: page == 0
                    ? null
                    : () {
                        setState(() {
                          paginationState['page'] = page - 1;
                        });
                      },
              ),
              ...pageButtons,
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: page == totalPages - 1
                    ? null
                    : () {
                        setState(() {
                          paginationState['page'] = page + 1;
                        });
                      },
              ),
            ],
          ),
        ],
      );
    },
  );

  // ===========================================================================
  // SECTION 12 - ASYNC MOCK LOADING STATE
  // ===========================================================================
  // States: idle | loading | success. No real async — toggled by buttons.

  final Map<String, dynamic> asyncState = <String, dynamic>{
    'phase': 'idle',
    'progress': 0.0,
    'records': 0,
  };

  final Widget section12Async = StatefulBuilder(
    builder: (BuildContext ctx, StateSetter setState) {
      final String phase = asyncState['phase'] as String;
      final double progress = asyncState['progress'] as double;
      final int records = asyncState['records'] as int;
      Color phaseColor;
      String phaseLabel;
      IconData phaseIcon;
      if (phase == 'idle') {
        phaseColor = paletteInkSoft;
        phaseLabel = 'Idle';
        phaseIcon = Icons.pause_circle_outline;
      } else if (phase == 'loading') {
        phaseColor = paletteAmber;
        phaseLabel = 'Loading';
        phaseIcon = Icons.downloading;
      } else {
        phaseColor = paletteGreen;
        phaseLabel = 'Success';
        phaseIcon = Icons.check_circle;
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(18.0),
            decoration: BoxDecoration(
              color: phaseColor.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(14.0),
              border: Border.all(color: phaseColor, width: 1.4),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 56.0,
                  height: 56.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: phaseColor,
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  child: Icon(
                    phaseIcon,
                    color: Colors.white,
                    size: 30.0,
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'STATE',
                        style: TextStyle(
                          color: phaseColor,
                          fontSize: 11.0,
                          letterSpacing: 1.4,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        phaseLabel,
                        style: TextStyle(
                          color: phaseColor,
                          fontSize: 22.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      if (phase == 'success')
                        Text(
                          'Loaded $records records',
                          style: const TextStyle(
                            color: paletteInk,
                            fontSize: 13.0,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14.0),
          if (phase == 'loading')
            Container(
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: paletteOutline, width: 1.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const SizedBox(
                        width: 18.0,
                        height: 18.0,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.4,
                          color: paletteAmber,
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      Expanded(
                        child: Text(
                          'Fetching ${(progress * 100).toStringAsFixed(0)}%',
                          style: const TextStyle(
                            color: paletteInk,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6.0),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 8.0,
                      backgroundColor: paletteSurfaceAlt,
                      color: paletteAmber,
                    ),
                  ),
                ],
              ),
            )
          else if (phase == 'success')
            Container(
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: paletteGreenSoft.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  for (final String line in const <String>[
                    'Connected to backend',
                    'Authenticated user session',
                    'Fetched dataset shard 1/3',
                    'Fetched dataset shard 2/3',
                    'Fetched dataset shard 3/3',
                    'Hydrated client cache',
                  ])
                    Row(
                      children: <Widget>[
                        const Icon(
                          Icons.check,
                          color: paletteGreen,
                          size: 16.0,
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          line,
                          style: const TextStyle(
                            color: paletteInk,
                            fontSize: 12.5,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            )
          else
            Container(
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: paletteSurfaceAlt,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: const Row(
                children: <Widget>[
                  Icon(
                    Icons.info_outline,
                    color: paletteInkSoft,
                    size: 20.0,
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: Text(
                      'Press "Start" to simulate a fetch sequence.',
                      style: TextStyle(color: paletteInkSoft),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 14.0),
          Row(
            children: <Widget>[
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: phase == 'loading'
                      ? null
                      : () {
                          setState(() {
                            asyncState['phase'] = 'loading';
                            asyncState['progress'] = 0.4;
                          });
                        },
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Start'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: paletteAmber,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: phase == 'loading'
                      ? () {
                          setState(() {
                            asyncState['phase'] = 'success';
                            asyncState['progress'] = 1.0;
                            asyncState['records'] = 248;
                          });
                        }
                      : null,
                  icon: const Icon(Icons.check),
                  label: const Text('Finish'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: paletteGreen,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    setState(() {
                      asyncState['phase'] = 'idle';
                      asyncState['progress'] = 0.0;
                      asyncState['records'] = 0;
                    });
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reset'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: paletteInkSoft,
                    side: const BorderSide(color: paletteInkSoft),
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );

  // ===========================================================================
  // SECTION 13 - ERROR / RETRY STATE MACHINE
  // ===========================================================================
  // States: ready | trying | error | recovered

  final Map<String, dynamic> errorState = <String, dynamic>{
    'phase': 'ready',
    'attempts': 0,
    'lastError': '',
  };

  final List<String> errorPool = const <String>[
    'NetworkException: connection reset by peer (ECONNRESET)',
    'TimeoutException: request exceeded 30000ms',
    'AuthException: token rotated, retry with fresh credentials',
    'ServerException: upstream returned 503 Service Unavailable',
  ];

  final Widget section13ErrorMachine = StatefulBuilder(
    builder: (BuildContext ctx, StateSetter setState) {
      final String phase = errorState['phase'] as String;
      final int attempts = errorState['attempts'] as int;
      final String lastError = errorState['lastError'] as String;
      Color color;
      IconData icon;
      String label;
      if (phase == 'ready') {
        color = paletteInkSoft;
        icon = Icons.cloud_outlined;
        label = 'Ready';
      } else if (phase == 'trying') {
        color = paletteBlue;
        icon = Icons.sync;
        label = 'Trying';
      } else if (phase == 'error') {
        color = paletteRed;
        icon = Icons.error;
        label = 'Error';
      } else {
        color = paletteGreen;
        icon = Icons.verified;
        label = 'Recovered';
      }
      final List<Widget> attemptDots =
          List<Widget>.generate(5, (int i) {
        final bool filled = i < attempts;
        return Container(
          width: 16.0,
          height: 16.0,
          margin: const EdgeInsets.symmetric(horizontal: 3.0),
          decoration: BoxDecoration(
            color: filled ? paletteRed : Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(color: paletteRed, width: 1.4),
          ),
        );
      });
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(18.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  color.withValues(alpha: 0.18),
                  color.withValues(alpha: 0.04),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14.0),
              border: Border.all(color: color, width: 1.4),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 56.0,
                  height: 56.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: Colors.white, size: 26.0),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        label,
                        style: TextStyle(
                          color: color,
                          fontSize: 22.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        'Attempts: $attempts',
                        style: const TextStyle(
                          color: paletteInk,
                          fontSize: 12.5,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(children: attemptDots),
              ],
            ),
          ),
          const SizedBox(height: 12.0),
          if (phase == 'error')
            Container(
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: paletteRedSoft.withValues(alpha: 0.45),
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: paletteRed, width: 1.2),
              ),
              child: Row(
                children: <Widget>[
                  const Icon(
                    Icons.bug_report,
                    color: paletteRed,
                    size: 22.0,
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Text(
                      lastError,
                      style: const TextStyle(
                        color: paletteInk,
                        fontFamily: 'monospace',
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          if (phase == 'recovered')
            Container(
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: paletteGreenSoft.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: paletteGreen, width: 1.2),
              ),
              child: const Row(
                children: <Widget>[
                  Icon(
                    Icons.celebration,
                    color: paletteGreen,
                    size: 22.0,
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: Text(
                      'Operation completed after retries. The state machine '
                      'has returned to a stable phase.',
                      style: TextStyle(color: paletteInk),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 12.0),
          Row(
            children: <Widget>[
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: (phase == 'trying' || phase == 'recovered')
                      ? null
                      : () {
                          setState(() {
                            errorState['phase'] = 'trying';
                          });
                        },
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Try'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: paletteBlue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: phase == 'trying'
                      ? () {
                          setState(() {
                            final int nextAttempt = attempts + 1;
                            errorState['attempts'] = nextAttempt;
                            errorState['phase'] = 'error';
                            errorState['lastError'] =
                                errorPool[nextAttempt % errorPool.length];
                          });
                        }
                      : null,
                  icon: const Icon(Icons.error),
                  label: const Text('Fail'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: paletteRed,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: phase == 'trying'
                      ? () {
                          setState(() {
                            errorState['phase'] = 'recovered';
                          });
                        }
                      : null,
                  icon: const Icon(Icons.done),
                  label: const Text('Pass'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: paletteGreen,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    setState(() {
                      errorState['phase'] = 'ready';
                      errorState['attempts'] = 0;
                      errorState['lastError'] = '';
                    });
                  },
                  icon: const Icon(Icons.restart_alt),
                  label: const Text('Reset'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: paletteInkSoft,
                    side: const BorderSide(color: paletteInkSoft),
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );

  // ===========================================================================
  // SECTION 14 - MULTI-STEP WIZARD WITH STEP STATE
  // ===========================================================================

  final Map<String, dynamic> wizardState = <String, dynamic>{
    'step': 0,
    'company': '',
    'plan': 'Pro',
    'seats': 5,
    'consent': false,
  };

  final List<Map<String, String>> wizardSteps = const <Map<String, String>>[
    <String, String>{
      'title': 'Company',
      'subtitle': 'Tell us about your organisation',
    },
    <String, String>{
      'title': 'Plan',
      'subtitle': 'Choose the right tier',
    },
    <String, String>{
      'title': 'Seats',
      'subtitle': 'How many people will join',
    },
    <String, String>{
      'title': 'Consent',
      'subtitle': 'Confirm and submit',
    },
  ];

  final Widget section14Wizard = StatefulBuilder(
    builder: (BuildContext ctx, StateSetter setState) {
      final int step = wizardState['step'] as int;
      final String company = wizardState['company'] as String;
      final String plan = wizardState['plan'] as String;
      final int seats = wizardState['seats'] as int;
      final bool consent = wizardState['consent'] as bool;
      final List<Widget> stepIndicators =
          List<Widget>.generate(wizardSteps.length, (int i) {
        final bool done = i < step;
        final bool current = i == step;
        return Expanded(
          child: Row(
            children: <Widget>[
              Container(
                width: 32.0,
                height: 32.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: done
                      ? paletteGreen
                      : (current ? paletteAccent : Colors.white),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: done
                        ? paletteGreen
                        : (current ? paletteAccent : paletteOutline),
                    width: 1.6,
                  ),
                ),
                child: done
                    ? const Icon(Icons.check,
                        color: Colors.white, size: 18.0)
                    : Text(
                        '${i + 1}',
                        style: TextStyle(
                          color: current ? Colors.white : paletteInkSoft,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
              ),
              if (i < wizardSteps.length - 1)
                Expanded(
                  child: Container(
                    height: 2.0,
                    color: done ? paletteGreen : paletteOutline,
                  ),
                ),
            ],
          ),
        );
      });

      Widget content;
      if (step == 0) {
        content = TextField(
          decoration: InputDecoration(
            labelText: 'Company name',
            prefixIcon: const Icon(Icons.business),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          onChanged: (String v) {
            setState(() {
              wizardState['company'] = v;
            });
          },
        );
      } else if (step == 1) {
        content = Column(
          children: const <String>['Starter', 'Pro', 'Business']
              .map((String p) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 5.0),
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: p == plan
                    ? paletteAccent
                    : Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: p == plan ? paletteAccent : paletteOutline,
                  width: 1.4,
                ),
              ),
              child: Row(
                children: <Widget>[
                  Icon(
                    p == plan
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked,
                    color: p == plan ? Colors.white : paletteInkSoft,
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          wizardState['plan'] = p;
                        });
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Text(
                        p,
                        style: TextStyle(
                          color: p == plan ? Colors.white : paletteInk,
                          fontWeight: FontWeight.w800,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      } else if (step == 2) {
        content = Column(
          children: <Widget>[
            Text(
              '$seats seats',
              style: const TextStyle(
                color: paletteAccent,
                fontSize: 36.0,
                fontWeight: FontWeight.w900,
              ),
            ),
            Slider(
              value: seats.toDouble(),
              min: 1.0,
              max: 50.0,
              divisions: 49,
              activeColor: paletteAccent,
              onChanged: (double v) {
                setState(() {
                  wizardState['seats'] = v.round();
                });
              },
            ),
            const Text(
              'Choose between 1 and 50 collaborators.',
              style: TextStyle(color: paletteInkSoft),
            ),
          ],
        );
      } else {
        content = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: paletteAccentSoft.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Company: ${company.isEmpty ? "(none)" : company}'),
                  Text('Plan: $plan'),
                  Text('Seats: $seats'),
                ],
              ),
            ),
            CheckboxListTile(
              value: consent,
              onChanged: (bool? v) {
                setState(() {
                  wizardState['consent'] = v ?? false;
                });
              },
              title: const Text('I agree to the terms of service'),
              activeColor: paletteAccent,
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ],
        );
      }

      final bool canNext = step < wizardSteps.length - 1;
      final bool canSubmit = step == wizardSteps.length - 1 && consent;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(children: stepIndicators),
          const SizedBox(height: 14.0),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14.0),
              border: Border.all(color: paletteOutline, width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  wizardSteps[step]['title']!,
                  style: const TextStyle(
                    color: paletteAccent,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  wizardSteps[step]['subtitle']!,
                  style: const TextStyle(color: paletteInkSoft),
                ),
                const SizedBox(height: 14.0),
                content,
              ],
            ),
          ),
          const SizedBox(height: 14.0),
          Row(
            children: <Widget>[
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: step == 0
                      ? null
                      : () {
                          setState(() {
                            wizardState['step'] = step - 1;
                          });
                        },
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Back'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: paletteInkSoft,
                    side: const BorderSide(color: paletteInkSoft),
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: canNext
                      ? () {
                          setState(() {
                            wizardState['step'] = step + 1;
                          });
                        }
                      : (canSubmit
                          ? () {
                              setState(() {
                                wizardState['step'] = 0;
                                wizardState['consent'] = false;
                              });
                            }
                          : null),
                  icon: Icon(canNext ? Icons.arrow_forward : Icons.send),
                  label: Text(canNext ? 'Continue' : 'Submit'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        canNext ? paletteAccent : paletteGreen,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );

  // ===========================================================================
  // SECTION 15 - SETTINGS PANEL (REAL PREFERENCES MIRROR)
  // ===========================================================================

  final Map<String, dynamic> settingsState = <String, dynamic>{
    'theme': 'system',
    'language': 'English',
    'fontScale': 1.0,
    'syncWifiOnly': true,
    'biometric': false,
    'autoUpdate': true,
    'telemetryLevel': 'balanced',
  };

  final Widget section15Settings = StatefulBuilder(
    builder: (BuildContext ctx, StateSetter setState) {
      final String theme = settingsState['theme'] as String;
      final String language = settingsState['language'] as String;
      final double fontScale = settingsState['fontScale'] as double;
      final bool syncWifiOnly = settingsState['syncWifiOnly'] as bool;
      final bool biometric = settingsState['biometric'] as bool;
      final bool autoUpdate = settingsState['autoUpdate'] as bool;
      final String tele = settingsState['telemetryLevel'] as String;
      final List<Widget> themeChoices =
          List<Widget>.generate(3, (int i) {
        final String t = <String>['system', 'light', 'dark'][i];
        final IconData ic = <IconData>[
          Icons.smartphone,
          Icons.light_mode,
          Icons.dark_mode,
        ][i];
        final bool sel = t == theme;
        return Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                settingsState['theme'] = t;
              });
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              padding: const EdgeInsets.symmetric(vertical: 14.0),
              decoration: BoxDecoration(
                color: sel ? paletteAccent : Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: sel ? paletteAccent : paletteOutline,
                ),
              ),
              child: Column(
                children: <Widget>[
                  Icon(
                    ic,
                    color: sel ? Colors.white : paletteInkSoft,
                    size: 22.0,
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    t.toUpperCase(),
                    style: TextStyle(
                      color: sel ? Colors.white : paletteInk,
                      fontWeight: FontWeight.w800,
                      fontSize: 11.0,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
      final List<Widget> teleChoices =
          const <String>['minimal', 'balanced', 'full'].map((String t) {
        return Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: ChoiceChip(
            label: Text(t),
            selected: t == tele,
            selectedColor: paletteAccent,
            labelStyle: TextStyle(
              color: t == tele ? Colors.white : paletteInk,
              fontWeight: FontWeight.w700,
            ),
            backgroundColor: Colors.white,
            side: BorderSide(
              color: t == tele ? paletteAccent : paletteOutline,
            ),
            onSelected: (bool s) {
              setState(() {
                settingsState['telemetryLevel'] = t;
              });
            },
          ),
        );
      }).toList();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text(
            'APPEARANCE',
            style: TextStyle(
              color: paletteInkSoft,
              fontSize: 11.0,
              letterSpacing: 1.4,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8.0),
          Row(children: themeChoices),
          const SizedBox(height: 8.0),
          Row(
            children: <Widget>[
              const Text('Font scale',
                  style: TextStyle(
                    color: paletteInk,
                    fontWeight: FontWeight.w700,
                  )),
              Expanded(
                child: Slider(
                  value: fontScale,
                  min: 0.8,
                  max: 1.6,
                  divisions: 16,
                  label: '${(fontScale * 100).toStringAsFixed(0)}%',
                  activeColor: paletteAccent,
                  onChanged: (double v) {
                    setState(() {
                      settingsState['fontScale'] = v;
                    });
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  color: paletteAccentSoft,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  '${(fontScale * 100).toStringAsFixed(0)}%',
                  style: const TextStyle(
                    color: paletteAccent,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18.0),
          const Text(
            'PRIVACY & SYNC',
            style: TextStyle(
              color: paletteInkSoft,
              fontSize: 11.0,
              letterSpacing: 1.4,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8.0),
          SwitchListTile(
            title: const Text('Sync over Wi-Fi only'),
            subtitle: const Text('Avoid using mobile data for backups'),
            value: syncWifiOnly,
            activeThumbColor: paletteAccent,
            onChanged: (bool v) {
              setState(() {
                settingsState['syncWifiOnly'] = v;
              });
            },
          ),
          SwitchListTile(
            title: const Text('Biometric unlock'),
            subtitle: const Text('Use fingerprint or face recognition'),
            value: biometric,
            activeThumbColor: paletteAccent,
            onChanged: (bool v) {
              setState(() {
                settingsState['biometric'] = v;
              });
            },
          ),
          SwitchListTile(
            title: const Text('Auto-update'),
            subtitle: const Text('Install updates automatically when ready'),
            value: autoUpdate,
            activeThumbColor: paletteAccent,
            onChanged: (bool v) {
              setState(() {
                settingsState['autoUpdate'] = v;
              });
            },
          ),
          const SizedBox(height: 8.0),
          const Text(
            'TELEMETRY LEVEL',
            style: TextStyle(
              color: paletteInkSoft,
              fontSize: 11.0,
              letterSpacing: 1.4,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8.0),
          Wrap(children: teleChoices),
          const SizedBox(height: 18.0),
          const Text(
            'LANGUAGE',
            style: TextStyle(
              color: paletteInkSoft,
              fontSize: 11.0,
              letterSpacing: 1.4,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: const <String>[
              'English',
              'Deutsch',
              'Français',
              'Español',
              '日本語',
            ].map((String l) {
              return ChoiceChip(
                label: Text(l),
                selected: l == language,
                selectedColor: paletteAccent,
                labelStyle: TextStyle(
                  color: l == language ? Colors.white : paletteInk,
                  fontWeight: FontWeight.w700,
                ),
                side: BorderSide(
                  color: l == language ? paletteAccent : paletteOutline,
                ),
                backgroundColor: Colors.white,
                onSelected: (bool s) {
                  setState(() {
                    settingsState['language'] = l;
                  });
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 18.0),
          Container(
            padding: const EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: paletteSurfaceAlt,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'CURRENT STATE SNAPSHOT',
                  style: TextStyle(
                    color: paletteInkSoft,
                    fontSize: 11.0,
                    letterSpacing: 1.4,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text('theme: $theme', style: const TextStyle(color: paletteInk)),
                Text('language: $language',
                    style: const TextStyle(color: paletteInk)),
                Text('font scale: ${(fontScale * 100).toStringAsFixed(0)}%',
                    style: const TextStyle(color: paletteInk)),
                Text('sync wifi-only: $syncWifiOnly',
                    style: const TextStyle(color: paletteInk)),
                Text('biometric: $biometric',
                    style: const TextStyle(color: paletteInk)),
                Text('auto-update: $autoUpdate',
                    style: const TextStyle(color: paletteInk)),
                Text('telemetry: $tele',
                    style: const TextStyle(color: paletteInk)),
              ],
            ),
          ),
        ],
      );
    },
  );

  // ===========================================================================
  // FINAL ASSEMBLY
  // ===========================================================================

  return Scaffold(
    backgroundColor: paletteSurface,
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          heroBanner,
          sectionShell(
            title: '1. Counter with StatefulBuilder',
            subtitle:
                'A classic example: setState bumps the captured integer and '
                'the builder re-renders.',
            surface: Colors.white,
            border: paletteOutline,
            titleColor: paletteAccent,
            child: section1Counter,
          ),
          sectionShell(
            title: '2. Toggle switch state',
            subtitle:
                'Six independent boolean preferences, each driving its own '
                'visual highlight.',
            surface: Colors.white,
            border: paletteOutline,
            titleColor: paletteTeal,
            child: section2Toggles,
          ),
          sectionShell(
            title: '3. Expanded card',
            subtitle:
                'A single-card expand/collapse with animated arrow rotation '
                'and cross-fade.',
            surface: Colors.white,
            border: paletteOutline,
            titleColor: paletteTeal,
            child: section3ExpandedCard,
          ),
          sectionShell(
            title: '4. Accordion',
            subtitle:
                'Multiple panels that open and close independently, with bulk '
                'expand/collapse controls.',
            surface: Colors.white,
            border: paletteOutline,
            titleColor: paletteAccent,
            child: section4Accordion,
          ),
          sectionShell(
            title: '5. Tab switcher',
            subtitle:
                'Custom segmented control that swaps the body widget on tap.',
            surface: Colors.white,
            border: paletteOutline,
            titleColor: paletteRose,
            child: section5Tabs,
          ),
          sectionShell(
            title: '6. Color picker grid',
            subtitle:
                'Twelve swatches with an animated preview header that tracks '
                'the selection.',
            surface: Colors.white,
            border: paletteOutline,
            titleColor: paletteBlue,
            child: section6ColorPicker,
          ),
          sectionShell(
            title: '7. Sliders with live readout',
            subtitle:
                'Four themed sliders that report their current value via a '
                'pill and a composite score.',
            surface: Colors.white,
            border: paletteOutline,
            titleColor: paletteAmber,
            child: section7Sliders,
          ),
          sectionShell(
            title: '8. Multi-input form summary',
            subtitle:
                'TextFields, ChoiceChips, a Slider and a SwitchListTile feed '
                'into a single live summary card.',
            surface: Colors.white,
            border: paletteOutline,
            titleColor: paletteAccent,
            child: section8Form,
          ),
          sectionShell(
            title: '9. Undo / redo demo',
            subtitle:
                'A pointer walks a small history list. Edits truncate the '
                'redo branch.',
            surface: Colors.white,
            border: paletteOutline,
            titleColor: paletteAccent,
            child: section9UndoRedo,
          ),
          sectionShell(
            title: '10. List editor',
            subtitle:
                'Add, remove, reorder and toggle the done flag on a mutable '
                'list of tasks.',
            surface: Colors.white,
            border: paletteOutline,
            titleColor: paletteGreen,
            child: section10ListEditor,
          ),
          sectionShell(
            title: '11. Pagination',
            subtitle:
                'Thirty-eight rows split into pages of five. Numbered buttons '
                'plus chevrons.',
            surface: Colors.white,
            border: paletteOutline,
            titleColor: paletteAccent,
            child: section11Pagination,
          ),
          sectionShell(
            title: '12. Async-mock loading state',
            subtitle:
                'Three phases: idle, loading, success. Each phase renders a '
                'completely different body.',
            surface: Colors.white,
            border: paletteOutline,
            titleColor: paletteAmber,
            child: section12Async,
          ),
          sectionShell(
            title: '13. Error / retry state machine',
            subtitle:
                'A small FSM with ready, trying, error and recovered states, '
                'plus attempt tracking.',
            surface: Colors.white,
            border: paletteOutline,
            titleColor: paletteRed,
            child: section13ErrorMachine,
          ),
          sectionShell(
            title: '14. Multi-step wizard',
            subtitle:
                'Four-step onboarding with custom step indicator and live '
                'summary on the final step.',
            surface: Colors.white,
            border: paletteOutline,
            titleColor: paletteAccent,
            child: section14Wizard,
          ),
          sectionShell(
            title: '15. Settings panel',
            subtitle:
                'A composite of switches, choice chips and sliders mirroring '
                'realistic application preferences.',
            surface: Colors.white,
            border: paletteOutline,
            titleColor: paletteTeal,
            child: section15Settings,
          ),
          const SizedBox(height: 26.0),
          Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: <Color>[paletteAccent, Color(0xFF8C7BFF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(18.0),
            ),
            child: Row(
              children: <Widget>[
                const Icon(
                  Icons.task_alt,
                  color: Colors.white,
                  size: 32.0,
                ),
                const SizedBox(width: 14.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Text(
                        'Demo complete',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        'Fifteen StatefulBuilder-powered sections, each '
                        'managing its own state and reacting to user input '
                        'without ever leaving the build() entry point.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.5,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30.0),
        ],
      ),
    ),
  );
}
