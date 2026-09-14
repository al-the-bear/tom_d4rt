// D4rt test script: Deep visual demo of PointerRemovedEvent from
// package:flutter/gestures.dart.
//
// PointerRemovedEvent is the lifecycle mirror of PointerAddedEvent. It is
// dispatched by the engine when a pointing device that the framework was
// previously aware of becomes undetectable: a mouse is unplugged, a stylus
// is uncradled or moves out of hover range, a touch contact is released
// and the underlying input identifier is retired by the platform, an
// embedder de-registers a synthetic pointer, and so on.
//
// PointerRemovedEvent is NOT a "pointer up" event. PointerUpEvent fires
// when a contact ends (the user lifts a finger that was pressing). A
// PointerRemovedEvent fires when the entire pointer ceases to exist as
// far as the framework is concerned. On many platforms the two arrive in
// quick succession (Up then Removed) but they mean different things and
// have different invariants; PointerRemovedEvent always carries
// pressure == 0.0, distance == distanceMax, and down == false.
//
// This file constructs sample events at build time and visualises every
// declared field across hero header, lifecycle pill chain, when-it-fires
// prose, anatomy chips, a 12-card field grid, a Removed-vs-Up
// side-by-side, a code-readout pair, four device-removal scenarios,
// three real-world handling panels, five caveat cards, and a takeaway
// footer. No events are dispatched: the engine owns dispatch.
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ============================================================
  // SECTION 0: Construct the canonical sample set.
  // ------------------------------------------------------------
  // Each PointerRemovedEvent below represents a different device kind
  // that the engine reports as "no longer present". The samples are
  // referenced from multiple sections so readers can correlate the
  // visual cards with the field readouts.
  // ============================================================
  const eventMouse = PointerRemovedEvent(
    timeStamp: Duration(milliseconds: 1200),
    pointer: 1,
    kind: PointerDeviceKind.mouse,
    device: 100,
    position: Offset(120.0, 80.0),
    obscured: false,
    pressureMin: 0.0,
    pressureMax: 1.0,
    distanceMax: 0.0,
    radiusMin: 0.0,
    radiusMax: 0.0,
    embedderId: 7001,
  );

  const eventTouch = PointerRemovedEvent(
    timeStamp: Duration(milliseconds: 2400),
    pointer: 2,
    kind: PointerDeviceKind.touch,
    device: 200,
    position: Offset(220.0, 360.0),
    obscured: false,
    pressureMin: 0.0,
    pressureMax: 1.0,
    distanceMax: 0.0,
    radiusMin: 4.0,
    radiusMax: 24.0,
    embedderId: 7002,
  );

  const eventStylus = PointerRemovedEvent(
    timeStamp: Duration(milliseconds: 3600),
    pointer: 3,
    kind: PointerDeviceKind.stylus,
    device: 300,
    position: Offset(412.0, 290.0),
    obscured: false,
    pressureMin: 0.0,
    pressureMax: 4096.0,
    distanceMax: 60.0,
    radiusMin: 0.0,
    radiusMax: 8.0,
    embedderId: 7003,
  );

  const eventTrackpad = PointerRemovedEvent(
    timeStamp: Duration(milliseconds: 4800),
    pointer: 4,
    kind: PointerDeviceKind.trackpad,
    device: 400,
    position: Offset(640.0, 400.0),
    embedderId: 7004,
  );

  const eventInvertedStylus = PointerRemovedEvent(
    timeStamp: Duration(milliseconds: 6000),
    pointer: 5,
    kind: PointerDeviceKind.invertedStylus,
    device: 500,
    position: Offset(180.0, 520.0),
    obscured: true,
    pressureMin: 0.0,
    pressureMax: 4096.0,
    distanceMax: 80.0,
    radiusMin: 0.0,
    radiusMax: 6.0,
    embedderId: 7005,
  );

  const eventUnknown = PointerRemovedEvent(
    timeStamp: Duration(milliseconds: 7200),
    pointer: 6,
    kind: PointerDeviceKind.unknown,
    device: 600,
    position: Offset.zero,
    embedderId: 0,
  );

  // ============================================================
  // SECTION 1: Hero header.
  // ------------------------------------------------------------
  // Steel-grey to dark-slate gradient, an unplug icon, and the
  // class name. The header reminds the reader that this event
  // signals device lifecycle, not user interaction.
  // ============================================================
  const heroHeader = Padding(
    padding: EdgeInsets.only(bottom: 16.0),
    child: DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF455A64),
            Color(0xFF37474F),
            Color(0xFF263238),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        boxShadow: [
          BoxShadow(
            color: Color(0x66263238),
            blurRadius: 18.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(28.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.power_off_outlined,
                  size: 56.0,
                  color: Colors.white,
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PointerRemovedEvent',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        'package:flutter/gestures.dart',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 13.0,
                          color: Color(0xD9FFFFFF),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            DecoratedBox(
              decoration: BoxDecoration(
                color: Color(0x26FFFFFF),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 10.0,
                ),
                child: Text(
                  'Fired when a pointing device leaves the realm of the '
                  'framework — a mouse unplugged, a stylus uncradled, a '
                  'touch identifier retired. Mirror of PointerAddedEvent. '
                  'Carries lifecycle, not interaction.',
                  style: TextStyle(color: Colors.white, fontSize: 13.0),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );

  // ============================================================
  // SECTION 2: Lifecycle context.
  // ------------------------------------------------------------
  // Render the canonical lifecycle as chevron-connected pills:
  //   Added -> Down -> Move -> Up -> Hover -> ... -> Removed
  // The Removed pill is steel-highlighted; all others are slate.
  // ============================================================
  const lifecyclePills = Padding(
    padding: EdgeInsets.only(bottom: 16.0),
    child: DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFECEFF1), Color(0xFFCFD8DC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
        border: Border.fromBorderSide(
          BorderSide(color: Color(0xFF90A4AE), width: 2.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pointer lifecycle: where Removed sits',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF263238),
              ),
            ),
            SizedBox(height: 6.0),
            Text(
              'Removed is the closing bookend that pairs with the '
              'opening Added. Everything in between is interaction.',
              style: TextStyle(fontSize: 13.0, color: Color(0xFF455A64)),
            ),
            SizedBox(height: 14.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  LifecyclePill(
                    label: 'Added',
                    icon: Icons.usb,
                    background: Color(0xFFB0BEC5),
                    foreground: Color(0xFF263238),
                    highlight: false,
                  ),
                  PillChevron(),
                  LifecyclePill(
                    label: 'Down',
                    icon: Icons.touch_app,
                    background: Color(0xFFB0BEC5),
                    foreground: Color(0xFF263238),
                    highlight: false,
                  ),
                  PillChevron(),
                  LifecyclePill(
                    label: 'Move',
                    icon: Icons.swap_horiz,
                    background: Color(0xFFB0BEC5),
                    foreground: Color(0xFF263238),
                    highlight: false,
                  ),
                  PillChevron(),
                  LifecyclePill(
                    label: 'Up',
                    icon: Icons.swipe_up,
                    background: Color(0xFFB0BEC5),
                    foreground: Color(0xFF263238),
                    highlight: false,
                  ),
                  PillChevron(),
                  LifecyclePill(
                    label: 'Hover',
                    icon: Icons.near_me_outlined,
                    background: Color(0xFFB0BEC5),
                    foreground: Color(0xFF263238),
                    highlight: false,
                  ),
                  PillChevron(),
                  LifecyclePill(
                    label: '...',
                    icon: Icons.more_horiz,
                    background: Color(0xFFB0BEC5),
                    foreground: Color(0xFF263238),
                    highlight: false,
                  ),
                  PillChevron(),
                  LifecyclePill(
                    label: 'Removed',
                    icon: Icons.power_off_outlined,
                    background: Color(0xFF455A64),
                    foreground: Colors.white,
                    highlight: true,
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.0),
            Text(
              'On desktops the Added/Removed pair is sticky for the '
              'lifetime of the device. On mobile the engine often '
              'fabricates a fresh Added/Removed pair around every '
              'touch contact.',
              style: TextStyle(
                fontSize: 12.0,
                fontStyle: FontStyle.italic,
                color: Color(0xFF455A64),
              ),
            ),
          ],
        ),
      ),
    ),
  );

  // ============================================================
  // SECTION 3: When it fires - prose card.
  // ------------------------------------------------------------
  // Spell out the conditions that trigger the event so readers do
  // not confuse it with PointerUpEvent. The prose card uses a
  // slate accent border with a steel headline.
  // ============================================================
  const whenItFires = Padding(
    padding: EdgeInsets.only(bottom: 16.0),
    child: DecoratedBox(
      decoration: BoxDecoration(
        color: Color(0xFFFAFAFA),
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
        border: Border.fromBorderSide(
          BorderSide(color: Color(0xFF607D8B), width: 2.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x29455A64),
            blurRadius: 8.0,
            offset: Offset(0.0, 4.0),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.sensors_off_outlined,
                  size: 28.0,
                  color: Color(0xFF455A64),
                ),
                SizedBox(width: 10.0),
                Text(
                  'When PointerRemovedEvent fires',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF263238),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.0),
            FireBullet(
              icon: Icons.create_outlined,
              title: 'Stylus uncradled or out-of-range',
              body:
                  'iPad Pencil is placed back in its case, an Wacom pen '
                  'leaves the active digitiser volume, or a Bluetooth '
                  'stylus disconnects after sleep.',
            ),
            FireBullet(
              icon: Icons.usb_off_outlined,
              title: 'Mouse or trackpad unplugged',
              body:
                  'A USB mouse is yanked, a Bluetooth trackpad battery '
                  'dies, or a hot-swap KVM hands the device off to '
                  'another host.',
            ),
            FireBullet(
              icon: Icons.fingerprint_outlined,
              title: 'Touch identifier retired',
              body:
                  'After PointerUp the platform retires the underlying '
                  'finger ID. Most engines synthesise a Removed in the '
                  'same frame on Android and iOS.',
            ),
            FireBullet(
              icon: Icons.dns_outlined,
              title: 'Embedder de-registers a virtual pointer',
              body:
                  'A custom embedder (kiosk OS, AR shell, in-vehicle '
                  'UI) tells Flutter that a synthetic input source no '
                  'longer exists.',
            ),
            SizedBox(height: 4.0),
            DecoratedBox(
              decoration: BoxDecoration(
                color: Color(0xFFECEFF1),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Distinct from PointerUpEvent: Up means the contact '
                  'ended; Removed means the device itself is gone.',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontStyle: FontStyle.italic,
                    color: Color(0xFF263238),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );

  // ============================================================
  // SECTION 4: Anatomy.
  // ------------------------------------------------------------
  // Show the inheritance chain PointerEvent -> PointerRemovedEvent
  // and chip-wrap every constructor parameter.
  // ============================================================
  const anatomy = Padding(
    padding: EdgeInsets.only(bottom: 16.0),
    child: DecoratedBox(
      decoration: BoxDecoration(
        color: Color(0xFFECEFF1),
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
        border: Border.fromBorderSide(
          BorderSide(color: Color(0xFF78909C), width: 1.5),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Anatomy',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF263238),
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Inheritance chain',
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w600,
                color: Color(0xFF455A64),
              ),
            ),
            SizedBox(height: 6.0),
            Row(
              children: [
                AnatomyBox(
                  label: 'PointerEvent',
                  background: Color(0xFFCFD8DC),
                  foreground: Color(0xFF263238),
                ),
                SizedBox(width: 6.0),
                Icon(
                  Icons.arrow_forward,
                  size: 18.0,
                  color: Color(0xFF455A64),
                ),
                SizedBox(width: 6.0),
                AnatomyBox(
                  label: 'PointerRemovedEvent',
                  background: Color(0xFF455A64),
                  foreground: Colors.white,
                ),
              ],
            ),
            SizedBox(height: 14.0),
            Text(
              'Constructor parameters',
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w600,
                color: Color(0xFF455A64),
              ),
            ),
            SizedBox(height: 8.0),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                ParamChip(label: 'timeStamp'),
                ParamChip(label: 'pointer'),
                ParamChip(label: 'kind'),
                ParamChip(label: 'device'),
                ParamChip(label: 'position'),
                ParamChip(label: 'obscured'),
                ParamChip(label: 'pressureMin'),
                ParamChip(label: 'pressureMax'),
                ParamChip(label: 'distanceMax'),
                ParamChip(label: 'radiusMin'),
                ParamChip(label: 'radiusMax'),
                ParamChip(label: 'embedderId'),
                ParamChip(label: 'original'),
                ParamChip(label: 'viewId'),
              ],
            ),
            SizedBox(height: 10.0),
            Text(
              'Note: pressure is forced to 0.0 by the constructor and '
              'is therefore not user-supplied.',
              style: TextStyle(
                fontSize: 12.0,
                fontStyle: FontStyle.italic,
                color: Color(0xFF455A64),
              ),
            ),
          ],
        ),
      ),
    ),
  );

  // ============================================================
  // SECTION 5: Field grid.
  // ------------------------------------------------------------
  // 12 cards: timeStamp, pointer, kind, device, position,
  // pressureMin, pressureMax, distanceMax, radiusMin, radiusMax,
  // embedderId, original. Two columns on wide screens.
  // ============================================================
  const fieldGrid = Padding(
    padding: EdgeInsets.only(bottom: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Text(
            'Field grid (12)',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF263238),
            ),
          ),
        ),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: [
            FieldCard(
              icon: Icons.schedule,
              name: 'timeStamp',
              type: 'Duration',
              value: '1200 ms (mouse sample)',
              note: 'Engine-monotonic clock, not wall time.',
            ),
            FieldCard(
              icon: Icons.tag,
              name: 'pointer',
              type: 'int',
              value: '1',
              note: 'Per-stream identifier; reused after Removed.',
            ),
            FieldCard(
              icon: Icons.devices_other,
              name: 'kind',
              type: 'PointerDeviceKind',
              value: 'mouse / touch / stylus / trackpad / ...',
              note: 'Inherited from the Added event of the same device.',
            ),
            FieldCard(
              icon: Icons.fingerprint,
              name: 'device',
              type: 'int',
              value: '100, 200, 300, ...',
              note: 'Stable per-device id; OS may rotate after removal.',
            ),
            FieldCard(
              icon: Icons.place_outlined,
              name: 'position',
              type: 'Offset',
              value: '(120.0, 80.0) (mouse sample)',
              note: 'Last known location at the moment of removal.',
            ),
            FieldCard(
              icon: Icons.unfold_less,
              name: 'pressureMin',
              type: 'double',
              value: '0.0',
              note: 'Reported floor; the device cannot deliver below it.',
            ),
            FieldCard(
              icon: Icons.unfold_more,
              name: 'pressureMax',
              type: 'double',
              value: '1.0 mouse / 4096.0 stylus',
              note: 'Capability ceiling, not the value at removal.',
            ),
            FieldCard(
              icon: Icons.height,
              name: 'distanceMax',
              type: 'double',
              value: '0.0 contact / 60.0 stylus',
              note:
                  'Removed always carries distance == distanceMax. The '
                  'device is at maximum hover distance by definition.',
            ),
            FieldCard(
              icon: Icons.radio_button_unchecked,
              name: 'radiusMin',
              type: 'double',
              value: '0.0 / 4.0 (touch)',
              note: 'Smallest contact radius the device can report.',
            ),
            FieldCard(
              icon: Icons.radio_button_checked,
              name: 'radiusMax',
              type: 'double',
              value: '0.0 / 24.0 (touch)',
              note: 'Largest contact radius the device can report.',
            ),
            FieldCard(
              icon: Icons.qr_code_2,
              name: 'embedderId',
              type: 'int',
              value: '7001, 7002, ...',
              note:
                  'Opaque embedder-defined id; useful for routing back '
                  'to the platform-side device descriptor.',
            ),
            FieldCard(
              icon: Icons.history,
              name: 'original',
              type: 'PointerRemovedEvent?',
              value: 'null on engine-emitted events',
              note:
                  'Set when this event was produced by transformed() '
                  'so listeners can recover the untransformed source.',
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Removed vs Up.
  // ------------------------------------------------------------
  // Side-by-side comparison: PointerUpEvent ends an interaction;
  // PointerRemovedEvent ends a device's existence.
  // ============================================================
  const removedVsUp = Padding(
    padding: EdgeInsets.only(bottom: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Text(
            'Removed vs Up',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF263238),
            ),
          ),
        ),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ComparePane(
                  title: 'PointerUpEvent',
                  subtitle: 'interaction end',
                  icon: Icons.swipe_up,
                  background: Color(0xFFE0F2F1),
                  border: Color(0xFF26A69A),
                  bullets: [
                    'Fires when contact ends.',
                    'Pairs with PointerDownEvent.',
                    'Carries the gesture buttons mask.',
                    'down == false but device still alive.',
                    'Recognisers expect it for tap/drag closure.',
                    'Always preceded by Down + zero-or-more Move.',
                  ],
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: ComparePane(
                  title: 'PointerRemovedEvent',
                  subtitle: 'device lifecycle',
                  icon: Icons.power_off_outlined,
                  background: Color(0xFFECEFF1),
                  border: Color(0xFF455A64),
                  bullets: [
                    'Fires when the device is gone.',
                    'Pairs with PointerAddedEvent.',
                    'No buttons / no pressure.',
                    'distance == distanceMax always.',
                    'Recognisers should drop cached state.',
                    'May arrive with no preceding Up on hot-unplug.',
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Construction sample.
  // ------------------------------------------------------------
  // A code block plus a value-readout grid so readers can match
  // the source line to the runtime value.
  // ============================================================
  const constructionSample = Padding(
    padding: EdgeInsets.only(bottom: 16.0),
    child: DecoratedBox(
      decoration: BoxDecoration(
        color: Color(0xFFFAFAFA),
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
        border: Border.fromBorderSide(
          BorderSide(color: Color(0xFF78909C), width: 1.5),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Construction sample',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF263238),
              ),
            ),
            SizedBox(height: 10.0),
            DecoratedBox(
              decoration: BoxDecoration(
                color: Color(0xFF263238),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Padding(
                padding: EdgeInsets.all(14.0),
                child: Text(
                  'const eventStylus = PointerRemovedEvent(\n'
                  '  timeStamp: Duration(milliseconds: 3600),\n'
                  '  pointer: 3,\n'
                  '  kind: PointerDeviceKind.stylus,\n'
                  '  device: 300,\n'
                  '  position: Offset(412.0, 290.0),\n'
                  '  obscured: false,\n'
                  '  pressureMin: 0.0,\n'
                  '  pressureMax: 4096.0,\n'
                  '  distanceMax: 60.0,\n'
                  '  radiusMin: 0.0,\n'
                  '  radiusMax: 8.0,\n'
                  '  embedderId: 7003,\n'
                  ');',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12.0,
                    height: 1.45,
                    color: Color(0xFFCFD8DC),
                  ),
                ),
              ),
            ),
            SizedBox(height: 14.0),
            Text(
              'Readout',
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w600,
                color: Color(0xFF455A64),
              ),
            ),
            SizedBox(height: 6.0),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                ReadoutChip(label: 'pointer', value: '3'),
                ReadoutChip(label: 'kind', value: 'stylus'),
                ReadoutChip(label: 'device', value: '300'),
                ReadoutChip(label: 'position', value: '(412.0, 290.0)'),
                ReadoutChip(label: 'pressureMax', value: '4096.0'),
                ReadoutChip(label: 'distanceMax', value: '60.0'),
                ReadoutChip(label: 'radiusMax', value: '8.0'),
                ReadoutChip(label: 'embedderId', value: '7003'),
                ReadoutChip(label: 'down', value: 'false'),
                ReadoutChip(label: 'pressure', value: '0.0'),
                ReadoutChip(label: 'obscured', value: 'false'),
              ],
            ),
          ],
        ),
      ),
    ),
  );

  // ============================================================
  // SECTION 8: Device-removal scenarios.
  // ------------------------------------------------------------
  // Four cards covering the most common ways a real device leaves
  // the framework's awareness.
  // ============================================================
  const removalScenarios = Padding(
    padding: EdgeInsets.only(bottom: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Text(
            'Device-removal scenarios',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF263238),
            ),
          ),
        ),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: [
            ScenarioCard(
              icon: Icons.create_outlined,
              title: 'Stylus uncradled',
              subtitle: 'iPad Pencil docked',
              body:
                  'The Pencil snaps to its magnetic cradle, the digitiser '
                  'reports out-of-range, and the engine flushes a '
                  'PointerRemovedEvent for the stylus device id.',
            ),
            ScenarioCard(
              icon: Icons.usb_off_outlined,
              title: 'Mouse unplugged',
              subtitle: 'USB hot-disconnect',
              body:
                  'The OS notifies the host that the HID endpoint is '
                  'gone. Flutter receives a removal callback and the '
                  'mouse pointer disappears mid-screen.',
            ),
            ScenarioCard(
              icon: Icons.cable_outlined,
              title: 'Wired stylus disconnect',
              subtitle: 'USB digitiser',
              body:
                  'A wired drawing tablet loses USB power. Any in-flight '
                  'gesture is terminated with PointerCancel and then a '
                  'PointerRemovedEvent for cleanup.',
            ),
            ScenarioCard(
              icon: Icons.power_settings_new,
              title: 'Touch screen powered off mid-touch',
              subtitle: 'panel sleep',
              body:
                  'Display sleep / lid-close cuts touch sampling. The '
                  'engine synthesises a Removed for every active touch '
                  'so framework state can collapse cleanly.',
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Real-world handling.
  // ------------------------------------------------------------
  // Three panels covering the things a Flutter app should do when
  // it sees a PointerRemovedEvent.
  // ============================================================
  const handlingPanels = Padding(
    padding: EdgeInsets.only(bottom: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Text(
            'Real-world handling',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF263238),
            ),
          ),
        ),
        HandlingPanel(
          icon: Icons.cleaning_services_outlined,
          title: 'Drop cached per-pointer state',
          bullets: [
            'Clear hover decorations keyed by pointer id.',
            'Remove velocity trackers from your own gesture map.',
            'Forget last-known position so a reused pointer id is '
            'not treated as a continuation.',
          ],
        ),
        HandlingPanel(
          icon: Icons.memory_outlined,
          title: 'Release GPU resources held for the pointer',
          bullets: [
            'Free overlay layers used to draw a custom cursor.',
            'Drop offscreen surfaces backing per-pointer trails or '
            'pressure-sensitive ink strokes.',
            'Cancel any pointer-bound shader compilation jobs.',
          ],
        ),
        HandlingPanel(
          icon: Icons.priority_high_outlined,
          title: 'Drop in-flight gesture recognisers',
          bullets: [
            'Treat the gesture as cancelled, not completed: do not '
            'fire onTap or onDragEnd.',
            'Reject the recogniser via the gesture arena so siblings '
            'can win.',
            'Restore visual state to the pre-gesture baseline.',
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 10: Caveats.
  // ------------------------------------------------------------
  // Five cards calling out the subtle wrong assumptions developers
  // commonly bring to PointerRemovedEvent.
  // ============================================================
  const caveats = Padding(
    padding: EdgeInsets.only(bottom: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Text(
            'Caveats',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF263238),
            ),
          ),
        ),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: [
            CaveatCard(
              icon: Icons.warning_amber_outlined,
              title: 'Not every platform emits it reliably',
              body:
                  'Some embedders never fire Removed for desktop mice; '
                  'they trust the device to live forever. Code that '
                  'depends on Removed for cleanup must time-out too.',
            ),
            CaveatCard(
              icon: Icons.swap_vert_outlined,
              title: 'Ordering with Up and Cancel is platform-specific',
              body:
                  'You may see Up -> Removed, Cancel -> Removed, or '
                  'Removed alone. Do not assume Up always precedes '
                  'Removed in the same frame.',
            ),
            CaveatCard(
              icon: Icons.auto_fix_high_outlined,
              title: 'Sometimes synthesised purely for cleanup',
              body:
                  'On app suspension the framework can mint synthetic '
                  'Removed events to flush hover state. They are real '
                  'events for your code but came from no hardware.',
            ),
            CaveatCard(
              icon: Icons.straighten_outlined,
              title: 'distance is always distanceMax',
              body:
                  'By contract the pointer is at the far end of its '
                  'detection volume. Do not read meaningful proximity '
                  'data from a Removed event.',
            ),
            CaveatCard(
              icon: Icons.refresh_outlined,
              title: 'device ids may be reused',
              body:
                  'After Removed the platform is free to reassign the '
                  'numeric device id to the next attached pointer. A '
                  'new Added with the same device value is not the '
                  'old device coming back.',
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 11: Footer.
  // ------------------------------------------------------------
  // Final takeaway strip in steel/slate.
  // ============================================================
  const footer = DecoratedBox(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF455A64), Color(0xFF263238)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.all(Radius.circular(16.0)),
    ),
    child: Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.flag_outlined,
                size: 24.0,
                color: Colors.white,
              ),
              SizedBox(width: 10.0),
              Text(
                'Takeaways',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          TakeawayLine(
            text:
                'Removed is the closing bookend. It pairs with Added '
                'and signals the entire pointer is gone.',
          ),
          TakeawayLine(
            text:
                'Removed is not Up. Up ends a contact; Removed ends '
                'the device.',
          ),
          TakeawayLine(
            text:
                'pressure is forced to 0.0 and distance is always '
                'distanceMax. Treat both as sentinels, not data.',
          ),
          TakeawayLine(
            text:
                'Use it to drop cached pointer state, release any '
                'GPU resources held for that pointer, and cancel any '
                'in-flight recognisers.',
          ),
          TakeawayLine(
            text:
                'Do not depend on it for liveness: not every embedder '
                'emits it on every disconnect.',
          ),
        ],
      ),
    ),
  );

  // ============================================================
  // Final scaffold assembly.
  // ============================================================
  return const Scaffold(
    backgroundColor: Color(0xFFF5F5F5),
    body: SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            heroHeader,
            lifecyclePills,
            whenItFires,
            anatomy,
            fieldGrid,
            removedVsUp,
            constructionSample,
            removalScenarios,
            handlingPanels,
            caveats,
            footer,
            // Sample event references for visual continuity.
            SampleSummary(
              eventMouse: eventMouse,
              eventTouch: eventTouch,
              eventStylus: eventStylus,
              eventTrackpad: eventTrackpad,
              eventInvertedStylus: eventInvertedStylus,
              eventUnknown: eventUnknown,
            ),
          ],
        ),
      ),
    ),
  );
}

// ============================================================
// Helper widgets.
// ------------------------------------------------------------
// Top-level stateless helpers used by the deep-demo body. They
// are intentionally simple and const-friendly so the entire
// scaffold can be built as a const tree.
// ============================================================

class LifecyclePill extends StatelessWidget {
  const LifecyclePill({
    super.key,
    required this.label,
    required this.icon,
    required this.background,
    required this.foreground,
    required this.highlight,
  });

  final String label;
  final IconData icon;
  final Color background;
  final Color foreground;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2.0),
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 8.0,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
        border: highlight
            ? const Border.fromBorderSide(
                BorderSide(color: Color(0xFFCFD8DC), width: 2.0),
              )
            : null,
        boxShadow: highlight
            ? const [
                BoxShadow(
                  color: Color(0x66263238),
                  blurRadius: 6.0,
                  offset: Offset(0.0, 3.0),
                ),
              ]
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16.0, color: foreground),
          const SizedBox(width: 6.0),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: highlight ? FontWeight.bold : FontWeight.w500,
              color: foreground,
            ),
          ),
        ],
      ),
    );
  }
}

class PillChevron extends StatelessWidget {
  const PillChevron({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.0),
      child: Icon(
        Icons.chevron_right,
        size: 18.0,
        color: Color(0xFF607D8B),
      ),
    );
  }
}

class FireBullet extends StatelessWidget {
  const FireBullet({
    super.key,
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32.0,
            height: 32.0,
            decoration: const BoxDecoration(
              color: Color(0xFFCFD8DC),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(icon, size: 18.0, color: const Color(0xFF263238)),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF263238),
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  body,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: Color(0xFF455A64),
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
}

class AnatomyBox extends StatelessWidget {
  const AnatomyBox({
    super.key,
    required this.label,
    required this.background,
    required this.foreground,
  });

  final String label;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: background,
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13.0,
          fontFamily: 'monospace',
          fontWeight: FontWeight.w600,
          color: foreground,
        ),
      ),
    );
  }
}

class ParamChip extends StatelessWidget {
  const ParamChip({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: const BoxDecoration(
        color: Color(0xFFCFD8DC),
        borderRadius: BorderRadius.all(Radius.circular(14.0)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12.0,
          fontFamily: 'monospace',
          color: Color(0xFF263238),
        ),
      ),
    );
  }
}

class FieldCard extends StatelessWidget {
  const FieldCard({
    super.key,
    required this.icon,
    required this.name,
    required this.type,
    required this.value,
    required this.note,
  });

  final IconData icon;
  final String name;
  final String type;
  final String value;
  final String note;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320.0,
      child: Container(
        padding: const EdgeInsets.all(14.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          border: Border.fromBorderSide(
            BorderSide(color: Color(0xFFB0BEC5), width: 1.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0x14263238),
              blurRadius: 6.0,
              offset: Offset(0.0, 2.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 30.0,
                  height: 30.0,
                  decoration: const BoxDecoration(
                    color: Color(0xFFCFD8DC),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    icon,
                    size: 18.0,
                    color: const Color(0xFF263238),
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace',
                      color: Color(0xFF263238),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 3.0,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xFF455A64),
                    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  ),
                  child: Text(
                    type,
                    style: const TextStyle(
                      fontSize: 10.5,
                      fontFamily: 'monospace',
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              value,
              style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: Color(0xFF37474F),
              ),
            ),
            const SizedBox(height: 6.0),
            Text(
              note,
              style: const TextStyle(
                fontSize: 11.5,
                color: Color(0xFF607D8B),
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ComparePane extends StatelessWidget {
  const ComparePane({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.background,
    required this.border,
    required this.bullets,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color background;
  final Color border;
  final List<String> bullets;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: background,
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        border: Border.fromBorderSide(BorderSide(color: border, width: 1.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 22.0, color: border),
              const SizedBox(width: 8.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: border,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 11.0,
                        fontStyle: FontStyle.italic,
                        color: Color(0xFF455A64),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final bullet in bullets)
                Padding(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 3.0, right: 6.0),
                        child: Icon(
                          Icons.circle,
                          size: 6.0,
                          color: Color(0xFF607D8B),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          bullet,
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Color(0xFF263238),
                            height: 1.35,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class ReadoutChip extends StatelessWidget {
  const ReadoutChip({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: const BoxDecoration(
        color: Color(0xFFECEFF1),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        border: Border.fromBorderSide(
          BorderSide(color: Color(0xFFB0BEC5), width: 1.0),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 11.5,
              fontFamily: 'monospace',
              color: Color(0xFF607D8B),
            ),
          ),
          const SizedBox(width: 6.0),
          Text(
            value,
            style: const TextStyle(
              fontSize: 11.5,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w600,
              color: Color(0xFF263238),
            ),
          ),
        ],
      ),
    );
  }
}

class ScenarioCard extends StatelessWidget {
  const ScenarioCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String body;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320.0,
      child: Container(
        padding: const EdgeInsets.all(14.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          border: Border.fromBorderSide(
            BorderSide(color: Color(0xFF90A4AE), width: 1.5),
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0x1F263238),
              blurRadius: 8.0,
              offset: Offset(0.0, 3.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36.0,
                  height: 36.0,
                  decoration: const BoxDecoration(
                    color: Color(0xFF455A64),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Icon(icon, size: 20.0, color: Colors.white),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF263238),
                        ),
                      ),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 11.5,
                          fontStyle: FontStyle.italic,
                          color: Color(0xFF607D8B),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Text(
              body,
              style: const TextStyle(
                fontSize: 12.5,
                color: Color(0xFF37474F),
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HandlingPanel extends StatelessWidget {
  const HandlingPanel({
    super.key,
    required this.icon,
    required this.title,
    required this.bullets,
  });

  final IconData icon;
  final String title;
  final List<String> bullets;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      padding: const EdgeInsets.all(14.0),
      decoration: const BoxDecoration(
        color: Color(0xFFFAFAFA),
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        border: Border.fromBorderSide(
          BorderSide(color: Color(0xFFB0BEC5), width: 1.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 22.0, color: const Color(0xFF455A64)),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF263238),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final bullet in bullets)
                Padding(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 3.0, right: 6.0),
                        child: Icon(
                          Icons.check_circle_outline,
                          size: 14.0,
                          color: Color(0xFF607D8B),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          bullet,
                          style: const TextStyle(
                            fontSize: 12.5,
                            color: Color(0xFF37474F),
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class CaveatCard extends StatelessWidget {
  const CaveatCard({
    super.key,
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320.0,
      child: Container(
        padding: const EdgeInsets.all(14.0),
        decoration: const BoxDecoration(
          color: Color(0xFFECEFF1),
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          border: Border.fromBorderSide(
            BorderSide(color: Color(0xFF78909C), width: 1.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 20.0, color: const Color(0xFF455A64)),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF263238),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              body,
              style: const TextStyle(
                fontSize: 12.0,
                color: Color(0xFF455A64),
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TakeawayLine extends StatelessWidget {
  const TakeawayLine({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 4.0, right: 8.0),
            child: Icon(
              Icons.arrow_right_alt,
              size: 16.0,
              color: Color(0xFFCFD8DC),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 12.5,
                color: Colors.white,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SampleSummary extends StatelessWidget {
  const SampleSummary({
    super.key,
    required this.eventMouse,
    required this.eventTouch,
    required this.eventStylus,
    required this.eventTrackpad,
    required this.eventInvertedStylus,
    required this.eventUnknown,
  });

  final PointerRemovedEvent eventMouse;
  final PointerRemovedEvent eventTouch;
  final PointerRemovedEvent eventStylus;
  final PointerRemovedEvent eventTrackpad;
  final PointerRemovedEvent eventInvertedStylus;
  final PointerRemovedEvent eventUnknown;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Color(0xFFFAFAFA),
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        border: Border.fromBorderSide(
          BorderSide(color: Color(0xFFB0BEC5), width: 1.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sample event summary',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF263238),
            ),
          ),
          const SizedBox(height: 8.0),
          SampleLine(label: 'mouse', event: eventMouse),
          SampleLine(label: 'touch', event: eventTouch),
          SampleLine(label: 'stylus', event: eventStylus),
          SampleLine(label: 'trackpad', event: eventTrackpad),
          SampleLine(label: 'invertedStylus', event: eventInvertedStylus),
          SampleLine(label: 'unknown', event: eventUnknown),
        ],
      ),
    );
  }
}

class SampleLine extends StatelessWidget {
  const SampleLine({super.key, required this.label, required this.event});

  final String label;
  final PointerRemovedEvent event;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110.0,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12.0,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w600,
                color: Color(0xFF455A64),
              ),
            ),
          ),
          Expanded(
            child: Text(
              'pointer=${event.pointer} '
              'device=${event.device} '
              'kind=${event.kind} '
              'pos=${event.position} '
              'distanceMax=${event.distanceMax} '
              'embedderId=${event.embedderId}',
              style: const TextStyle(
                fontSize: 11.5,
                fontFamily: 'monospace',
                color: Color(0xFF263238),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
