// ignore_for_file: avoid_print
// D4rt deep demo: UndoManager — the static singleton that coordinates
// between Flutter's undo clients and the platform's native undo system.
// It manages client registration, routes platform undo/redo events,
// and synchronizes the undo/redo availability state with the OS.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── Sapphire / Navy palette ───
  const Color sapphire = Color(0xFF2563EB);
  const Color navy = Color(0xFF1E40AF);
  const Color deepSapphire = Color(0xFF1E3A5F);
  const Color paleIce = Color(0xFFEFF6FF);
  const Color cobalt = Color(0xFF1D4ED8);
  const Color periwinkle = Color(0xFFDBEAFE);
  const Color midnight = Color(0xFF172554);
  const Color azure = Color(0xFF60A5FA);
  const Color cornflower = Color(0xFF93C5FD);
  const Color royal = Color(0xFF3B82F6);

  print('===== UNDO MANAGER DEEP DEMO =====');

  // ─── Local helpers ───

  Widget sectionBanner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [midnight, deepSapphire],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: midnight.withValues(alpha: 0.35),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: sapphire,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: azure, width: 1.5),
            ),
            child: Center(
              child: Text(number,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3)),
          ),
        ],
      ),
    );
  }

  Widget noteBox(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: paleIce,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: periwinkle),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 13,
              color: deepSapphire.withValues(alpha: 0.9),
              height: 1.5)),
    );
  }

  Widget infoCard(String heading, Widget content) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: periwinkle),
        boxShadow: [
          BoxShadow(
            color: sapphire.withValues(alpha: 0.07),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 12),
            decoration: BoxDecoration(
              color: paleIce,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(7)),
            ),
            child: Text(heading,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: midnight)),
          ),
          Padding(padding: const EdgeInsets.all(12), child: content),
        ],
      ),
    );
  }

  Widget tag(String label, Color bg, Color fg) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(label,
          style:
              TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: fg)),
    );
  }

  Widget dataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 155,
            child: Text(label,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: midnight)),
          ),
          Expanded(
            child: Text(value,
                style: TextStyle(fontSize: 12, color: deepSapphire)),
          ),
        ],
      ),
    );
  }

  Widget colorSwatch(String name, Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 8, bottom: 8),
      child: Column(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: midnight.withValues(alpha: 0.15), width: 1),
            ),
          ),
          const SizedBox(height: 4),
          Text(name,
              style: TextStyle(fontSize: 9, color: midnight),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget progressBar(String label, double fraction, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label,
                  style: TextStyle(fontSize: 11, color: midnight)),
              Text('${(fraction * 100).toStringAsFixed(0)}%',
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: color)),
            ],
          ),
          const SizedBox(height: 3),
          Container(
            width: double.infinity,
            height: 7,
            decoration: BoxDecoration(
              color: cornflower.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(3.5),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: fraction.clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(3.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget routingArrow(String from, String to, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(from,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: color)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Icon(Icons.arrow_forward, size: 14, color: color),
          ),
          Expanded(
            child: Text(to,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: color)),
          ),
        ],
      ),
    );
  }

  Widget stateIndicator(String label, bool active, Color onColor, Color offColor) {
    return Container(
      margin: const EdgeInsets.only(right: 8, bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: active ? onColor.withValues(alpha: 0.15) : offColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
            color: active ? onColor : offColor,
            width: active ? 2 : 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: active ? onColor : offColor,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          const SizedBox(width: 8),
          Text(label,
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: active ? FontWeight.w700 : FontWeight.normal,
                  color: active ? onColor : offColor)),
        ],
      ),
    );
  }

  // ─── Section 1: Overview ───
  print('[Section 1] Overview');

  final section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('01', 'Overview & Purpose'),
      noteBox(
          'UndoManager is the central coordinator between Flutter\'s undo '
          'system and the platform\'s native undo infrastructure. It is a '
          'singleton-like static class that manages which UndoManagerClient '
          'is currently active, routes platform undo/redo events to that '
          'client, and notifies the platform about undo/redo availability.'),
      infoCard(
          'Core Identity',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Type', 'Static class (singleton pattern)'),
              dataRow('Package', 'flutter/services'),
              dataRow('Purpose', 'Coordinate undo between client + platform'),
              dataRow('Manages', 'Active client registration'),
              dataRow('Routes', 'Platform undo events to active client'),
            ],
          )),
      infoCard(
          'Key Responsibilities',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Client registration', 'Track who receives undo events'),
              dataRow('Event routing', 'Forward undo/redo to active client'),
              dataRow('State sync', 'Tell platform canUndo/canRedo'),
              dataRow('Channel management', 'Handle flutter/undomanager'),
            ],
          )),
    ],
  );

  // ─── Section 2: Static API ───
  print('[Section 2] Static API');

  final section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('02', 'Static API'),
      noteBox(
          'UndoManager exposes a small API for managing client registration '
          'and undo state. Most interaction happens automatically through '
          'EditableTextState, but the API is available for custom use.'),
      infoCard(
          'client Property',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Type', 'UndoManagerClient?'),
              dataRow('Getter', 'Returns current active client'),
              dataRow('Setter', 'Register a new client'),
              dataRow('Null', 'No client registered'),
            ],
          )),
      infoCard(
          'setUndoState()',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Method', 'setUndoState(canUndo, canRedo)'),
              dataRow('Purpose', 'Inform platform of availability'),
              dataRow('canUndo', 'Whether undo is possible'),
              dataRow('canRedo', 'Whether redo is possible'),
              dataRow('Platform effect', 'Enable/disable system undo UI'),
            ],
          )),
      infoCard(
          'handlePlatformUndo()',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Method', 'handlePlatformUndo(direction)'),
              dataRow('Called by', 'Platform channel handler'),
              dataRow('Delegates to', 'client.handlePlatformUndo()'),
              dataRow('No client', 'Silently ignored'),
            ],
          )),
    ],
  );

  // ─── Section 3: Routing Architecture ───
  print('[Section 3] Routing Architecture');

  final section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('03', 'Routing Architecture'),
      noteBox(
          'UndoManager acts as a router between the platform undo system '
          'and the currently active Flutter client. Events flow from the '
          'OS through the manager to the client, and state flows back.'),
      infoCard(
          'Event Flow — Undo',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              routingArrow('Platform (3-finger swipe)', 'flutter/undomanager channel', sapphire),
              routingArrow('Channel handler', 'UndoManager.handlePlatformUndo()', cobalt),
              routingArrow('UndoManager', 'client.handlePlatformUndo(undo)', navy),
              routingArrow('Client', 'Restores previous state', royal),
            ],
          )),
      infoCard(
          'State Flow — Availability',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              routingArrow('Client modifies state', 'Calculates canUndo/canRedo', sapphire),
              routingArrow('Client calls', 'UndoManager.setUndoState()', cobalt),
              routingArrow('UndoManager sends', 'Platform channel message', navy),
              routingArrow('Platform updates', 'System undo UI enabled/disabled', royal),
            ],
          )),
    ],
  );

  // ─── Section 4: Client Management ───
  print('[Section 4] Client Management');

  final section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('04', 'Client Management'),
      noteBox(
          'At any given time, only one UndoManagerClient is active. When '
          'a text field gains focus, it registers as the client. When it '
          'loses focus, it unregisters, and the manager goes idle.'),
      infoCard(
          'Single-Client Model',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Active clients', 'Maximum 1 at a time'),
              dataRow('Set client', 'UndoManager.client = myClient'),
              dataRow('Clear client', 'UndoManager.client = null'),
              dataRow('Focus-driven', 'Typically tied to text field focus'),
            ],
          )),
      infoCard(
          'Focus Switch Scenario',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                children: [
                  stateIndicator('Field A Active', true, sapphire, cornflower),
                  stateIndicator('Field B Idle', false, sapphire, cornflower),
                ],
              ),
              const SizedBox(height: 6),
              dataRow('User taps Field B', 'Focus switches'),
              const SizedBox(height: 6),
              Wrap(
                children: [
                  stateIndicator('Field A Idle', false, sapphire, cornflower),
                  stateIndicator('Field B Active', true, sapphire, cornflower),
                ],
              ),
              const SizedBox(height: 6),
              dataRow('Undo now', 'Affects Field B\'s history only'),
            ],
          )),
    ],
  );

  // ─── Section 5: Platform Channel ───
  print('[Section 5] Platform Channel');

  final section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('05', 'Platform Channel'),
      noteBox(
          'UndoManager communicates with the native platform through the '
          '"flutter/undomanager" system channel. This channel carries both '
          'inbound (platform → Flutter) and outbound (Flutter → platform) '
          'messages.'),
      infoCard(
          'Inbound Messages',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('handleUndo', 'Platform requests undo/redo'),
              dataRow('Payload', '{"direction": "undo"} or {"direction": "redo"}'),
              dataRow('Handler', 'UndoManager routes to active client'),
            ],
          )),
      infoCard(
          'Outbound Messages',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('setUndoState', 'Flutter tells platform availability'),
              dataRow('Payload', '{"canUndo": bool, "canRedo": bool}'),
              dataRow('Effect', 'System UI updated'),
            ],
          )),
      infoCard(
          'Channel Details',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Channel name', 'flutter/undomanager'),
              dataRow('Codec', 'JSONMethodCodec'),
              dataRow('Async', 'All messages are asynchronous'),
              dataRow('Error handling', 'Silent failure if no client'),
            ],
          )),
    ],
  );

  // ─── Section 6: Interaction with EditableText ───
  print('[Section 6] Interaction with EditableText');

  final section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('06', 'Interaction with EditableText'),
      noteBox(
          'EditableTextState is the primary consumer of UndoManager. When '
          'a TextField or EditableText gains focus, its state object '
          'registers with UndoManager as the active client.'),
      infoCard(
          'Auto-Registration',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Focus gained', 'EditableTextState registers'),
              dataRow('Text changes', 'State snapshot recorded'),
              dataRow('Availability', 'setUndoState() called'),
              dataRow('Focus lost', 'EditableTextState unregisters'),
            ],
          )),
      infoCard(
          'Complete Flow',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              routingArrow('User taps TextField', 'Focus gained', sapphire),
              routingArrow('EditableTextState', 'UndoManager.client = this', cobalt),
              routingArrow('User types "Hello"', 'Snapshot saved', navy),
              routingArrow('EditableTextState', 'setUndoState(canUndo: true)', royal),
              routingArrow('User 3-finger swipes', 'Platform sends undo', sapphire),
              routingArrow('UndoManager', 'client.handlePlatformUndo(undo)', cobalt),
              routingArrow('EditableTextState', 'Restores previous value', navy),
            ],
          )),
    ],
  );

  // ─── Section 7: State Synchronization ───
  print('[Section 7] State Synchronization');

  final section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('07', 'State Synchronization'),
      noteBox(
          'Keeping the platform\'s undo UI in sync with the Flutter client\'s '
          'state is critical. If canUndo is false but the platform shows '
          'undo as available, users get confused.'),
      infoCard(
          'Sync Points',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('After text edit', 'canUndo → true'),
              dataRow('After undo', 'canRedo → true, canUndo → depends'),
              dataRow('After redo', 'canUndo → true, canRedo → depends'),
              dataRow('New edit after undo', 'canRedo → false'),
              dataRow('Client cleared', 'Both → false'),
            ],
          )),
      infoCard(
          'State Table',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: stateIndicator('canUndo: true', true, sapphire, cornflower)),
                  Expanded(child: stateIndicator('canRedo: false', false, sapphire, cornflower)),
                ],
              ),
              const SizedBox(height: 4),
              dataRow('Scenario', 'User has typed but not undone yet'),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(child: stateIndicator('canUndo: true', true, sapphire, cornflower)),
                  Expanded(child: stateIndicator('canRedo: true', true, sapphire, cornflower)),
                ],
              ),
              const SizedBox(height: 4),
              dataRow('Scenario', 'User undid once, can go either way'),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(child: stateIndicator('canUndo: false', false, sapphire, cornflower)),
                  Expanded(child: stateIndicator('canRedo: true', true, sapphire, cornflower)),
                ],
              ),
              const SizedBox(height: 4),
              dataRow('Scenario', 'Fully undone, can only redo'),
            ],
          )),
    ],
  );

  // ─── Section 8: Multiple Text Fields ───
  print('[Section 8] Multiple Text Fields');

  final section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('08', 'Multiple Text Fields'),
      noteBox(
          'In a form with multiple text fields, each field has its own '
          'undo history. UndoManager ensures only the focused field\'s '
          'undo history is active with the platform.'),
      infoCard(
          'Form Scenario',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(bottom: 6),
                decoration: BoxDecoration(
                  color: sapphire.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: sapphire, width: 2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name Field (focused)',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: sapphire)),
                    Text('"John Doe" — 3 undo steps available',
                        style: TextStyle(fontSize: 11, color: deepSapphire)),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(bottom: 6),
                decoration: BoxDecoration(
                  color: cornflower.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: cornflower),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Email Field (not focused)',
                        style: TextStyle(
                            fontSize: 12,
                            color: deepSapphire)),
                    Text('"john@example.com" — undo preserved but inactive',
                        style: TextStyle(fontSize: 11, color: deepSapphire)),
                  ],
                ),
              ),
              dataRow('Platform sees', 'canUndo: true (from Name field)'),
              dataRow('Undo gesture', 'Affects Name field only'),
            ],
          )),
    ],
  );

  // ─── Section 9: Relationship to UndoHistory ───
  print('[Section 9] Relationship to UndoHistory');

  final section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('09', 'Relationship to UndoHistory'),
      noteBox(
          'UndoManager is the platform bridge, while UndoHistory<T> is '
          'the framework-level undo stack. They work together: '
          'UndoHistory manages the state stack and uses UndoManager '
          'to receive platform signals.'),
      infoCard(
          'Roles',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('UndoManager', 'Platform ↔ Flutter bridge'),
              dataRow('UndoHistory<T>', 'State stack management'),
              dataRow('UndoManagerClient', 'Client mixin for receiving events'),
              dataRow('UndoHistoryController', 'Programmatic undo/redo'),
            ],
          )),
      infoCard(
          'How They Connect',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              routingArrow('UndoHistory widget', 'Implements UndoManagerClient', sapphire),
              routingArrow('Registers with', 'UndoManager as client', cobalt),
              routingArrow('Platform undo signal', 'UndoManager → UndoHistory', navy),
              routingArrow('UndoHistory', 'Pops state stack, rebuilds UI', royal),
            ],
          )),
    ],
  );

  // ─── Section 10: Error Scenarios ───
  print('[Section 10] Error Scenarios');

  final section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('10', 'Error Scenarios'),
      noteBox(
          'UndoManager handles various edge cases gracefully. When no '
          'client is registered or when unexpected messages arrive, it '
          'fails silently to avoid disrupting the user experience.'),
      infoCard(
          'Edge Cases',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('No client registered', 'Undo event silently ignored'),
              dataRow('Client disposed', 'Should have unregistered first'),
              dataRow('Double registration', 'Previous client replaced'),
              dataRow('Invalid direction', 'Ignored, no crash'),
              dataRow('Channel error', 'Caught and logged'),
            ],
          )),
      infoCard(
          'Defensive Patterns',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Null check', 'client?.handlePlatformUndo()'),
              dataRow('Try-catch', 'Wrap channel calls'),
              dataRow('State validation', 'Check canUndo before undo'),
              dataRow('Idempotent', 'Multiple registrations safe'),
            ],
          )),
    ],
  );

  // ─── Section 11: Platform Specifics ───
  print('[Section 11] Platform Specifics');

  final section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('11', 'Platform Specifics'),
      noteBox(
          'UndoManager behavior varies across platforms because each OS '
          'has different undo infrastructure. The manager abstracts these '
          'differences behind a consistent Dart API.'),
      infoCard(
          'iOS',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Native manager', 'NSUndoManager'),
              dataRow('Triggers', '3-finger swipe, shake, keyboard'),
              dataRow('Integration', 'Full UndoManager support'),
              dataRow('System UI', 'Undo dialog on shake'),
            ],
          )),
      infoCard(
          'macOS',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Native manager', 'NSUndoManager in responder chain'),
              dataRow('Triggers', 'Cmd+Z, Cmd+Shift+Z, Edit menu'),
              dataRow('Integration', 'Full UndoManager support'),
              dataRow('Menu items', 'Edit → Undo / Redo'),
            ],
          )),
      infoCard(
          'Other Platforms',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Android', 'No system undo manager'),
              dataRow('Web', 'No system undo bridge'),
              dataRow('Windows/Linux', 'Keyboard-only via framework'),
              dataRow('Fallback', 'UndoHistory widget handles all'),
            ],
          )),
    ],
  );

  // ─── Section 12: Lifecycle in Widget Tree ───
  print('[Section 12] Lifecycle in Widget Tree');

  final section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('12', 'Lifecycle in Widget Tree'),
      noteBox(
          'UndoManager persists as a static singleton throughout the app '
          'lifetime. Clients come and go as widgets mount and unmount, '
          'but the manager is always available to route events.'),
      infoCard(
          'App Lifecycle',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('App start', 'UndoManager initialized (static)'),
              dataRow('First field focus', 'Client registered'),
              dataRow('Navigation', 'Previous client unregistered'),
              dataRow('New page field', 'New client registered'),
              dataRow('App background', 'Client may persist or clear'),
            ],
          )),
      infoCard(
          'Navigation Impact',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Push new page', 'Previous field loses focus'),
              dataRow('Pop page', 'Previous field may refocus'),
              dataRow('Tab switch', 'BottomNav → client swaps'),
              dataRow('Dialog', 'Dialog fields can become client'),
            ],
          )),
    ],
  );

  // ─── Section 13: Testing UndoManager ───
  print('[Section 13] Testing');

  final section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('13', 'Testing'),
      noteBox(
          'Testing UndoManager interactions requires mocking the '
          'flutter/undomanager platform channel and verifying that '
          'events are correctly routed to the registered client.'),
      infoCard(
          'Test Channel Mock',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('setMockMethodCallHandler', 'Intercept calls'),
              dataRow('Simulate undo', 'Send handleUndo message'),
              dataRow('Verify routing', 'Client receives event'),
              dataRow('Verify state', 'setUndoState was called'),
            ],
          )),
      infoCard(
          'Test Scenarios',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Register + undo', 'Client receives event'),
              dataRow('No client + undo', 'No crash, silently ignored'),
              dataRow('Switch clients', 'Only active client receives'),
              dataRow('canUndo sync', 'Platform receives state update'),
            ],
          )),
    ],
  );

  // ─── Section 14: Performance ───
  print('[Section 14] Performance');

  final section14 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('14', 'Performance'),
      noteBox(
          'UndoManager itself is lightweight — it just routes events. '
          'The performance cost is in the client\'s state management: '
          'how many snapshots it keeps and how quickly it restores them.'),
      infoCard(
          'Cost Breakdown',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              progressBar('Event routing', 0.05, sapphire),
              progressBar('Channel communication', 0.10, cobalt),
              progressBar('State snapshot (client)', 0.40, navy),
              progressBar('UI rebuild after undo', 0.60, royal),
            ],
          )),
      infoCard(
          'Optimization',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Minimal snapshots', 'Group changes before snapshot'),
              dataRow('Diff-based', 'Store deltas, not full state'),
              dataRow('Lazy rebuild', 'Only rebuild affected subtree'),
              dataRow('Throttle sync', 'Batch setUndoState calls'),
            ],
          )),
    ],
  );

  // ─── Section 15: Comparison Table ───
  print('[Section 15] Comparison Table');

  final section15 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('15', 'Comparison Table'),
      noteBox(
          'Understanding the differences between UndoManager, '
          'UndoManagerClient, and UndoHistory helps use the right tool.'),
      infoCard(
          'UndoManager vs UndoManagerClient',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('UndoManager', 'Singleton coordinator'),
              dataRow('UndoManagerClient', 'Per-widget mixin'),
              dataRow('UndoManager owns', 'Platform channel'),
              dataRow('Client owns', 'State history'),
              dataRow('Relationship', 'Manager routes to client'),
            ],
          )),
      infoCard(
          'UndoManager vs UndoHistory',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('UndoManager', 'Platform integration'),
              dataRow('UndoHistory<T>', 'Framework-level undo stack'),
              dataRow('UndoManager scope', 'System undo events'),
              dataRow('UndoHistory scope', 'Any value type T'),
              dataRow('Platform', 'iOS/macOS only for UndoManager'),
              dataRow('Everywhere', 'UndoHistory works on all platforms'),
            ],
          )),
    ],
  );

  // ─── Section 16: Visual Dashboard ───
  print('[Section 16] Visual Dashboard');

  final section16 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('16', 'Visual Dashboard'),
      noteBox('Complete overview of the UndoManager deep demo.'),
      infoCard(
          'Demo Color Palette',
          Wrap(
            children: [
              colorSwatch('Sapphire', sapphire),
              colorSwatch('Navy', navy),
              colorSwatch('Deep Sapph.', deepSapphire),
              colorSwatch('Pale Ice', paleIce),
              colorSwatch('Cobalt', cobalt),
              colorSwatch('Periwinkle', periwinkle),
              colorSwatch('Midnight', midnight),
              colorSwatch('Azure', azure),
              colorSwatch('Cornflower', cornflower),
              colorSwatch('Royal', royal),
            ],
          )),
      infoCard(
          'Section Coverage',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              progressBar('Overview', 1.0, sapphire),
              progressBar('Static API', 1.0, navy),
              progressBar('Routing Architecture', 1.0, cobalt),
              progressBar('Client Management', 1.0, royal),
              progressBar('Platform Channel', 1.0, sapphire),
              progressBar('EditableText', 1.0, navy),
              progressBar('State Sync', 1.0, cobalt),
              progressBar('Multiple Fields', 1.0, royal),
              progressBar('UndoHistory', 1.0, sapphire),
              progressBar('Error Scenarios', 1.0, navy),
              progressBar('Platform Specifics', 1.0, cobalt),
              progressBar('Widget Lifecycle', 1.0, royal),
              progressBar('Testing', 1.0, sapphire),
              progressBar('Performance', 1.0, navy),
              progressBar('Comparison', 1.0, cobalt),
              progressBar('Dashboard', 1.0, royal),
            ],
          )),
      infoCard(
          'Statistics',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Total sections', '16'),
              dataRow('Theme', 'Sapphire / Navy'),
              dataRow('Palette colors', '10'),
            ],
          )),
      Wrap(
        spacing: 6,
        runSpacing: 4,
        children: [
          tag('UndoManager', sapphire, Colors.white),
          tag('Platform Bridge', navy, Colors.white),
          tag('Client Router', cobalt, Colors.white),
          tag('State Sync', royal, Colors.white),
          tag('Singleton', azure, midnight),
          tag('NSUndoManager', midnight, Colors.white),
        ],
      ),
    ],
  );

  print('===== END UNDO MANAGER DEEP DEMO =====');

  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        section15,
        section16,
      ],
    ),
  );
}
