// D4rt test script: deep visual demo of Flutter's SystemChannels.
//
// This file is intentionally a single-file Flutter widget that exposes a
// hand-authored demonstration of the predefined `SystemChannels` exposed by
// `package:flutter/services.dart`. The intent is purely visual / educational:
// no channel is actually invoked — every code-style snippet is rendered as
// monospace `Text`. This script is consumed by the D4rt-AST interpreter test
// suite which renders the returned widget tree.
//
// The build entry point is `dynamic build(BuildContext context)`. There is no
// `main()` and no `runApp()` — the harness wraps and mounts the result.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ---------------------------------------------------------------------------
// Plain value classes used by individual sections. Kept top-level so each
// section is easy to scan without fishing through a single mega-builder.
// ---------------------------------------------------------------------------

class _ChannelInfo {
  final String displayName;
  final String wireName;
  final String codecName;
  final String kind;
  final IconData icon;
  final Color accent;
  final String description;
  final String purpose;

  const _ChannelInfo({
    required this.displayName,
    required this.wireName,
    required this.codecName,
    required this.kind,
    required this.icon,
    required this.accent,
    required this.description,
    required this.purpose,
  });
}

class _CodecRow {
  final String codec;
  final String wireFormat;
  final String example;
  final Color accent;

  const _CodecRow({
    required this.codec,
    required this.wireFormat,
    required this.example,
    required this.accent,
  });
}

class _RealWorldExample {
  final String title;
  final String description;
  final String code;
  final IconData icon;
  final Color accent;

  const _RealWorldExample({
    required this.title,
    required this.description,
    required this.code,
    required this.icon,
    required this.accent,
  });
}

// Palette
const Color kPaletteIndigo = Color(0xFF3F51B5);
const Color kPaletteTeal = Color(0xFF009688);
const Color kPaletteAmber = Color(0xFFFFB300);
const Color kPaletteRose = Color(0xFFE91E63);
const Color kPaletteSlate = Color(0xFF455A64);
const Color kPaletteGreen = Color(0xFF2E7D32);
const Color kPaletteOrange = Color(0xFFEF6C00);
const Color kPalettePurple = Color(0xFF6A1B9A);
const Color kPaletteCyan = Color(0xFF0097A7);
const Color kPaletteRed = Color(0xFFC62828);
const Color kPaletteBrown = Color(0xFF6D4C41);
const Color kPaletteBlueGrey = Color(0xFF546E7A);

dynamic build(BuildContext context) {
  // Capture the channel names directly from the live SDK so the demo proves
  // the constants are reachable. We do NOT send any messages.
  final String navigationName = SystemChannels.navigation.name;
  final String platformName = SystemChannels.platform.name;
  final String platformViewsName = SystemChannels.platform_views.name;
  final String systemName = SystemChannels.system.name;
  final String accessibilityName = SystemChannels.accessibility.name;
  final String keyEventName = SystemChannels.keyEvent.name;
  final String keyboardName = SystemChannels.keyboard.name;
  final String undoManagerName = SystemChannels.undoManager.name;
  final String contextMenuName = SystemChannels.contextMenu.name;
  final String processTextName = SystemChannels.processText.name;
  final String mouseCursorName = SystemChannels.mouseCursor.name;
  final String restorationName = SystemChannels.restoration.name;
  final String textInputName = SystemChannels.textInput.name;
  final String localizationName = SystemChannels.localization.name;
  final String menuName = SystemChannels.menu.name;
  final String lifecycleName = SystemChannels.lifecycle.name;

  return Scaffold(
    backgroundColor: const Color(0xFFF5F7FA),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ---------------------------------------------------------------
          // SECTION 1 — Hero header strip
          // ---------------------------------------------------------------
          Container(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF1A237E),
                  Color(0xFF283593),
                  Color(0xFF3949AB),
                  Color(0xFF1565C0),
                ],
                stops: [0.0, 0.35, 0.7, 1.0],
              ),
              borderRadius: BorderRadius.all(Radius.circular(18)),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(70, 26, 35, 126),
                  blurRadius: 24,
                  offset: Offset(0, 12),
                ),
                BoxShadow(
                  color: Color.fromARGB(40, 0, 0, 0),
                  blurRadius: 4,
                  offset: Offset(0, 2),
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
                        color: Colors.white.withValues(alpha: 0.18),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      child: const Icon(
                        Icons.cable,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Text(
                        'SystemChannels',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.22),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'package:flutter/services.dart',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  'A predefined collection of platform channels Flutter '
                  'uses to talk to the host engine.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withValues(alpha: 0.92),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _heroChip('16+ channels', Icons.list_alt),
                    _heroChip('3 channel kinds', Icons.category),
                    _heroChip('5 codecs', Icons.compare_arrows),
                    _heroChip('0 invocations', Icons.do_not_disturb_on),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // ---------------------------------------------------------------
          // SECTION 2 — What is a system channel?
          // ---------------------------------------------------------------
          _sectionTitle(
            ordinal: '01',
            title: 'What is a system channel?',
            accent: kPaletteIndigo,
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(14)),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(20, 0, 0, 0),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'A platform channel is a typed, asynchronous pipe '
                  'between Dart and the host platform (Android/iOS/web/'
                  'desktop). Flutter ships a fixed set of these channels '
                  'under the SystemChannels umbrella so that the framework '
                  'and the engine share a stable wire contract.',
                  style: TextStyle(
                    fontSize: 14.5,
                    height: 1.55,
                    color: Color(0xFF263238),
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  'Each channel has three things you should know about:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF263238),
                  ),
                ),
                const SizedBox(height: 10),
                _bulletRow(
                  icon: Icons.label_outline,
                  color: kPaletteIndigo,
                  text:
                      'A name string (e.g. "flutter/lifecycle") which '
                      'must match across both sides.',
                ),
                _bulletRow(
                  icon: Icons.translate,
                  color: kPaletteTeal,
                  text:
                      'A codec which serializes and deserializes the '
                      'arguments and return values.',
                ),
                _bulletRow(
                  icon: Icons.swap_horiz,
                  color: kPaletteAmber,
                  text:
                      'A kind (MethodChannel, BasicMessageChannel, or '
                      'EventChannel) which constrains the call shape.',
                ),
                const SizedBox(height: 18),
                // Flow diagram
                _flowDiagram(),
              ],
            ),
          ),
          const SizedBox(height: 28),

          // ---------------------------------------------------------------
          // SECTION 3 — Channel taxonomy (3 columns)
          // ---------------------------------------------------------------
          _sectionTitle(
            ordinal: '02',
            title: 'Channel taxonomy',
            accent: kPaletteTeal,
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: Text(
              'Flutter exposes three kinds of channels. Below: which '
              'SystemChannels.* members fall into each bucket.',
              style: TextStyle(fontSize: 14, color: Color(0xFF455A64)),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _taxonomyColumn(
                  title: 'MethodChannel',
                  subtitle: 'request → response',
                  accent: kPaletteIndigo,
                  icon: Icons.call_made,
                  members: const [
                    'navigation',
                    'platform',
                    'platform_views',
                    'keyboard',
                    'undoManager',
                    'contextMenu',
                    'processText',
                    'mouseCursor',
                    'restoration',
                    'textInput',
                    'localization',
                    'menu',
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _taxonomyColumn(
                  title: 'BasicMessageChannel',
                  subtitle: 'fire-and-forget messages',
                  accent: kPaletteOrange,
                  icon: Icons.forum,
                  members: const ['lifecycle', 'system', 'accessibility', 'keyEvent'],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _taxonomyColumn(
                  title: 'EventChannel',
                  subtitle: 'continuous stream',
                  accent: kPaletteRose,
                  icon: Icons.podcasts,
                  members: const [
                    '(none in SystemChannels)',
                    'plugins commonly use these',
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),

          // ---------------------------------------------------------------
          // SECTION 4 — Channel catalog grid (one card per channel)
          // ---------------------------------------------------------------
          _sectionTitle(
            ordinal: '03',
            title: 'Channel catalog',
            accent: kPaletteRose,
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: Text(
              'One card per static getter on SystemChannels. Cards are '
              'authored individually — accent colour, icon and supporting '
              'prose are bespoke per channel.',
              style: TextStyle(fontSize: 14, color: Color(0xFF455A64)),
            ),
          ),
          // Card 01 — navigation
          _channelCard(
            info: _ChannelInfo(
              displayName: 'navigation',
              wireName: navigationName,
              codecName: 'JSONMethodCodec',
              kind: 'MethodChannel',
              icon: Icons.navigation,
              accent: kPaletteIndigo,
              description:
                  'Drives the platform-side route stack. Used internally by '
                  'Navigator.push/pop to keep the host in sync.',
              purpose:
                  'Outgoing calls: pushRoute, popRoute, pushRouteInformation.',
            ),
          ),
          const SizedBox(height: 12),
          // Card 02 — platform
          _channelCard(
            info: _ChannelInfo(
              displayName: 'platform',
              wireName: platformName,
              codecName: 'JSONMethodCodec',
              kind: 'MethodChannel',
              icon: Icons.settings_applications,
              accent: kPaletteTeal,
              description:
                  'The Swiss-army channel: clipboard, haptics, system sound, '
                  'orientation, status bar, share sheet, app exit.',
              purpose:
                  'Backed by Clipboard, HapticFeedback, SystemSound, '
                  'SystemChrome, SystemNavigator.',
            ),
          ),
          const SizedBox(height: 12),
          // Card 03 — platform_views
          _channelCard(
            info: _ChannelInfo(
              displayName: 'platform_views',
              wireName: platformViewsName,
              codecName: 'StandardMethodCodec',
              kind: 'MethodChannel',
              icon: Icons.view_compact,
              accent: kPaletteAmber,
              description:
                  'Embeds native UIView / Android View instances inside the '
                  'Flutter widget tree.',
              purpose:
                  'Used by AndroidView, UiKitView, AppKitView controllers.',
            ),
          ),
          const SizedBox(height: 12),
          // Card 04 — system
          _channelCard(
            info: _ChannelInfo(
              displayName: 'system',
              wireName: systemName,
              codecName: 'JSONMessageCodec',
              kind: 'BasicMessageChannel',
              icon: Icons.memory,
              accent: kPaletteRed,
              description:
                  'Receives system-level events. The most common payload is '
                  '{ "type": "memoryPressure" } when the OS is under stress.',
              purpose: 'WidgetsBindingObserver.didHaveMemoryPressure listens here.',
            ),
          ),
          const SizedBox(height: 12),
          // Card 05 — accessibility
          _channelCard(
            info: _ChannelInfo(
              displayName: 'accessibility',
              wireName: accessibilityName,
              codecName: 'StandardMessageCodec',
              kind: 'BasicMessageChannel',
              icon: Icons.accessibility_new,
              accent: kPaletteGreen,
              description:
                  'Pushes screen-reader announcements and tooltip events from '
                  'Dart to the platform accessibility services.',
              purpose: 'Used by SemanticsService.announce and tooltip handling.',
            ),
          ),
          const SizedBox(height: 12),
          // Card 06 — keyEvent (legacy)
          _channelCard(
            info: _ChannelInfo(
              displayName: 'keyEvent',
              wireName: keyEventName,
              codecName: 'JSONMessageCodec',
              kind: 'BasicMessageChannel',
              icon: Icons.keyboard_alt,
              accent: kPaletteSlate,
              description:
                  'Legacy raw key events. New code should prefer the '
                  'HardwareKeyboard / KeyEventManager pipeline instead.',
              purpose: 'Backed RawKeyboard before the new keyboard pipeline.',
            ),
          ),
          const SizedBox(height: 12),
          // Card 07 — keyboard
          _channelCard(
            info: _ChannelInfo(
              displayName: 'keyboard',
              wireName: keyboardName,
              codecName: 'StandardMethodCodec',
              kind: 'MethodChannel',
              icon: Icons.keyboard,
              accent: kPalettePurple,
              description:
                  'Queries the engine for the current set of pressed keys. '
                  'Used by HardwareKeyboard.syncKeyboardState.',
              purpose: 'Outgoing call: getKeyboardState.',
            ),
          ),
          const SizedBox(height: 12),
          // Card 08 — undoManager
          _channelCard(
            info: _ChannelInfo(
              displayName: 'undoManager',
              wireName: undoManagerName,
              codecName: 'JSONMethodCodec',
              kind: 'MethodChannel',
              icon: Icons.undo,
              accent: kPaletteCyan,
              description:
                  'Surfaces native undo/redo stacks (mainly iOS/macOS) into '
                  'the Flutter text editing pipeline.',
              purpose: 'Outgoing: setUndoState. Incoming: handleUndo.',
            ),
          ),
          const SizedBox(height: 12),
          // Card 09 — contextMenu
          _channelCard(
            info: _ChannelInfo(
              displayName: 'contextMenu',
              wireName: contextMenuName,
              codecName: 'JSONMethodCodec',
              kind: 'MethodChannel',
              icon: Icons.menu_open,
              accent: kPaletteOrange,
              description:
                  'Shows / hides the browser context menu in Flutter web. '
                  'No-op on most platforms.',
              purpose: 'Outgoing: enableContextMenu, disableContextMenu.',
            ),
          ),
          const SizedBox(height: 12),
          // Card 10 — processText
          _channelCard(
            info: _ChannelInfo(
              displayName: 'processText',
              wireName: processTextName,
              codecName: 'StandardMethodCodec',
              kind: 'MethodChannel',
              icon: Icons.text_fields,
              accent: kPaletteBrown,
              description:
                  'Lists Android PROCESS_TEXT activities and runs the chosen '
                  'one against a text selection (translate, search, …).',
              purpose: 'Outgoing: queryTextActions, processTextAction.',
            ),
          ),
          const SizedBox(height: 12),
          // Card 11 — mouseCursor
          _channelCard(
            info: _ChannelInfo(
              displayName: 'mouseCursor',
              wireName: mouseCursorName,
              codecName: 'StandardMethodCodec',
              kind: 'MethodChannel',
              icon: Icons.mouse,
              accent: kPaletteBlueGrey,
              description:
                  'Activates a system mouse cursor by kind ("click", "text", '
                  '"resizeUpDown", …).',
              purpose: 'Outgoing: activateSystemCursor.',
            ),
          ),
          const SizedBox(height: 12),
          // Card 12 — restoration
          _channelCard(
            info: _ChannelInfo(
              displayName: 'restoration',
              wireName: restorationName,
              codecName: 'StandardMethodCodec',
              kind: 'MethodChannel',
              icon: Icons.restore,
              accent: kPaletteRose,
              description:
                  'State restoration: the engine persists an opaque blob '
                  'across process death; Dart uses it to rehydrate state.',
              purpose: 'Outgoing: get, put. Incoming: push.',
            ),
          ),
          const SizedBox(height: 12),
          // Card 13 — textInput
          _channelCard(
            info: _ChannelInfo(
              displayName: 'textInput',
              wireName: textInputName,
              codecName: 'JSONMethodCodec',
              kind: 'MethodChannel',
              icon: Icons.text_snippet,
              accent: kPaletteIndigo,
              description:
                  'The keyboard / IME pipeline. Drives soft keyboards, '
                  'autofill suggestions and selection rectangles.',
              purpose:
                  'Outgoing: TextInput.show/hide/setEditingState. Incoming: '
                  'TextInputClient.updateEditingState.',
            ),
          ),
          const SizedBox(height: 12),
          // Card 14 — localization
          _channelCard(
            info: _ChannelInfo(
              displayName: 'localization',
              wireName: localizationName,
              codecName: 'JSONMethodCodec',
              kind: 'MethodChannel',
              icon: Icons.language,
              accent: kPaletteTeal,
              description:
                  'Asks the platform to render a locale-specific string '
                  '(date, currency, pluralization on iOS).',
              purpose: 'Outgoing: Localization.getStringResource.',
            ),
          ),
          const SizedBox(height: 12),
          // Card 15 — menu
          _channelCard(
            info: _ChannelInfo(
              displayName: 'menu',
              wireName: menuName,
              codecName: 'StandardMethodCodec',
              kind: 'MethodChannel',
              icon: Icons.menu,
              accent: kPaletteAmber,
              description:
                  'Builds and tears down the macOS / Linux menu-bar from a '
                  'Flutter PlatformMenuBar widget.',
              purpose:
                  'Outgoing: Menu.setMenus. Incoming: Menu.selectedCallback.',
            ),
          ),
          const SizedBox(height: 12),
          // Card 16 — lifecycle
          _channelCard(
            info: _ChannelInfo(
              displayName: 'lifecycle',
              wireName: lifecycleName,
              codecName: 'StringCodec',
              kind: 'BasicMessageChannel',
              icon: Icons.timeline,
              accent: kPaletteGreen,
              description:
                  'String messages mirroring AppLifecycleState. Drives '
                  'WidgetsBindingObserver.didChangeAppLifecycleState.',
              purpose:
                  'Incoming payloads: "AppLifecycleState.resumed" and '
                  'siblings.',
            ),
          ),
          const SizedBox(height: 28),

          // ---------------------------------------------------------------
          // SECTION 5 — Lifecycle channel deep-dive
          // ---------------------------------------------------------------
          _sectionTitle(
            ordinal: '04',
            title: 'Lifecycle channel deep-dive',
            accent: kPaletteGreen,
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: kPaletteGreen.withValues(alpha: 0.05),
              border: Border.all(color: kPaletteGreen.withValues(alpha: 0.25)),
              borderRadius: const BorderRadius.all(Radius.circular(14)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'SystemChannels.lifecycle is a String BasicMessageChannel. '
                  'When the engine notices the app moved foreground / '
                  'background / inactive / detached / hidden / paused it '
                  'pushes a string of the form "AppLifecycleState.<x>".',
                  style: TextStyle(fontSize: 14.5, height: 1.55),
                ),
                const SizedBox(height: 14),
                const Text(
                  'Possible payloads:',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
                const SizedBox(height: 8),
                _lifecyclePayloadRow(
                  state: 'resumed',
                  meaning: 'visible and responding to user input',
                  color: kPaletteGreen,
                ),
                _lifecyclePayloadRow(
                  state: 'inactive',
                  meaning: 'visible but not interactive (call sheet, menu)',
                  color: kPaletteAmber,
                ),
                _lifecyclePayloadRow(
                  state: 'hidden',
                  meaning: 'all views hidden, app still running',
                  color: kPaletteOrange,
                ),
                _lifecyclePayloadRow(
                  state: 'paused',
                  meaning: 'background, frames suspended',
                  color: kPaletteRose,
                ),
                _lifecyclePayloadRow(
                  state: 'detached',
                  meaning: 'engine attached but not bound to a view',
                  color: kPaletteSlate,
                ),
                const SizedBox(height: 14),
                const Text(
                  'Pseudo-code (illustrative — DO NOT subscribe in this '
                  'demo widget):',
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 13),
                ),
                const SizedBox(height: 8),
                _codeBlock(
                  '// Conceptually:\n'
                  'SystemChannels.lifecycle.setMessageHandler((msg) async {\n'
                  '  // msg is e.g. "AppLifecycleState.resumed"\n'
                  '  notifyObservers(parseState(msg));\n'
                  '  return null; // BasicMessageChannel reply\n'
                  '});',
                  accent: kPaletteGreen,
                ),
                const SizedBox(height: 12),
                const Text(
                  'In practice: never subscribe directly. Use '
                  'WidgetsBindingObserver.didChangeAppLifecycleState — the '
                  'binding subscribes for you and dispatches to all '
                  'registered observers.',
                  style: TextStyle(fontSize: 13.5, height: 1.5),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),

          // ---------------------------------------------------------------
          // SECTION 6 — Platform channel deep-dive (method names)
          // ---------------------------------------------------------------
          _sectionTitle(
            ordinal: '05',
            title: 'SystemChannels.platform method catalog',
            accent: kPaletteTeal,
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(14)),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(20, 0, 0, 0),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'SystemChannels.platform is the broadest channel. The '
                  'engine multiplexes many "topics" through it. Below are '
                  'six representative methods — none are invoked here.',
                  style: TextStyle(fontSize: 14.5, height: 1.55),
                ),
                const SizedBox(height: 14),
                _platformMethodRow(
                  method: 'SystemChrome.setPreferredOrientations',
                  args: 'List<DeviceOrientation> orientations',
                  description:
                      'Locks the app to portrait, landscape or rotation '
                      'subset. Engine ignores on web.',
                  color: kPaletteIndigo,
                ),
                _platformMethodRow(
                  method: 'SystemSound.play',
                  args: 'SystemSoundType type',
                  description:
                      'Plays a short OS sound (click, alert) without '
                      'shipping audio assets.',
                  color: kPaletteTeal,
                ),
                _platformMethodRow(
                  method: 'Clipboard.setData',
                  args: 'ClipboardData(text: "…")',
                  description:
                      'Writes plain text to the system clipboard. Returns '
                      'a Future<void> on completion.',
                  color: kPaletteAmber,
                ),
                _platformMethodRow(
                  method: 'HapticFeedback.lightImpact',
                  args: '()',
                  description:
                      'Triggers a soft haptic tap on supporting hardware '
                      '(iOS Taptic Engine, Android Vibrator).',
                  color: kPaletteRose,
                ),
                _platformMethodRow(
                  method: 'SystemNavigator.pop',
                  args: '({bool? animated})',
                  description:
                      'Asks the host to remove the current Flutter activity '
                      '/ view from its task stack.',
                  color: kPaletteSlate,
                ),
                _platformMethodRow(
                  method: 'SystemChrome.setSystemUIOverlayStyle',
                  args: 'SystemUiOverlayStyle style',
                  description:
                      'Tweaks status-bar icon brightness and navigation-bar '
                      'colour at runtime.',
                  color: kPaletteGreen,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Each of these is a thin wrapper that ultimately calls '
                  'SystemChannels.platform.invokeMethod("<name>", arg).',
                  style: TextStyle(
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                    color: Color(0xFF607D8B),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),

          // ---------------------------------------------------------------
          // SECTION 7 — Codec showcase
          // ---------------------------------------------------------------
          _sectionTitle(
            ordinal: '06',
            title: 'Codec showcase',
            accent: kPalettePurple,
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: Text(
              'How payloads cross the boundary. Each codec has a fixed '
              'wire-format; mismatched codecs on either side are the most '
              'common channel bug.',
              style: TextStyle(fontSize: 14, color: Color(0xFF455A64)),
            ),
          ),
          _codecTable(
            rows: const [
              _CodecRow(
                codec: 'StringCodec',
                wireFormat: 'UTF-8 bytes of the string',
                example: '"hello" → 0x68 0x65 0x6C 0x6C 0x6F',
                accent: kPaletteIndigo,
              ),
              _CodecRow(
                codec: 'BinaryCodec',
                wireFormat: 'identity — bytes pass through',
                example: 'Uint8List([1, 2, 3]) → 0x01 0x02 0x03',
                accent: kPaletteSlate,
              ),
              _CodecRow(
                codec: 'JSONMessageCodec',
                wireFormat: 'UTF-8 of jsonEncode(payload)',
                example: '{"a": 1} → 7B 22 61 22 3A 31 7D',
                accent: kPaletteTeal,
              ),
              _CodecRow(
                codec: 'StandardMessageCodec',
                wireFormat: 'tagged binary (Flutter standard)',
                example: 'Map → tag 0x0D + entries',
                accent: kPaletteAmber,
              ),
              _CodecRow(
                codec: 'JSONMethodCodec',
                wireFormat: '{"method": "x", "args": …} as JSON',
                example: '"setState" + 42 → JSON of envelope',
                accent: kPaletteRose,
              ),
              _CodecRow(
                codec: 'StandardMethodCodec',
                wireFormat: 'standard codec wrapping a method envelope',
                example: 'binary tag + name + standard-encoded args',
                accent: kPalettePurple,
              ),
            ],
          ),
          const SizedBox(height: 28),

          // ---------------------------------------------------------------
          // SECTION 8 — Decision tree: SystemChannels.* vs custom MethodChannel
          // ---------------------------------------------------------------
          _sectionTitle(
            ordinal: '07',
            title: 'When to use SystemChannels.*',
            accent: kPaletteOrange,
          ),
          _decisionTree(),
          const SizedBox(height: 28),

          // ---------------------------------------------------------------
          // SECTION 9 — Real-world examples
          // ---------------------------------------------------------------
          _sectionTitle(
            ordinal: '08',
            title: 'Real-world examples (read-only)',
            accent: kPaletteRed,
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: Text(
              'Four patterns you will see in production code. Snippets are '
              'rendered as text — nothing is executed by this widget.',
              style: TextStyle(fontSize: 14, color: Color(0xFF455A64)),
            ),
          ),
          _realWorldCard(
            example: const _RealWorldExample(
              title: 'Set status-bar style',
              description:
                  'Push a single SystemUiOverlayStyle so the OS draws light '
                  'icons over a dark scaffold app-bar.',
              code:
                  '// equivalent to SystemChrome.setSystemUIOverlayStyle:\n'
                  'SystemChannels.platform.invokeMethod(\n'
                  '  "SystemChrome.setSystemUIOverlayStyle",\n'
                  '  {\n'
                  '    "statusBarBrightness": "Brightness.dark",\n'
                  '    "statusBarIconBrightness": "Brightness.light",\n'
                  '  },\n'
                  ');',
              icon: Icons.brightness_4,
              accent: kPaletteIndigo,
            ),
          ),
          const SizedBox(height: 12),
          _realWorldCard(
            example: const _RealWorldExample(
              title: 'Request haptic feedback',
              description:
                  'Trigger a soft "tap" on iOS Taptic Engine or Android '
                  'Vibrator. The engine no-ops on web.',
              code:
                  '// equivalent to HapticFeedback.lightImpact():\n'
                  'SystemChannels.platform.invokeMethod(\n'
                  '  "HapticFeedback.vibrate",\n'
                  '  "HapticFeedbackType.lightImpact",\n'
                  ');',
              icon: Icons.vibration,
              accent: kPaletteRose,
            ),
          ),
          const SizedBox(height: 12),
          _realWorldCard(
            example: const _RealWorldExample(
              title: 'Pop to native screen',
              description:
                  'On Android, ask the host activity to finish; on iOS this '
                  'usually no-ops because UIKit owns navigation.',
              code:
                  '// equivalent to SystemNavigator.pop(animated: true):\n'
                  'SystemChannels.platform.invokeMethod(\n'
                  '  "SystemNavigator.pop",\n'
                  '  true, // animated\n'
                  ');',
              icon: Icons.arrow_back,
              accent: kPaletteSlate,
            ),
          ),
          const SizedBox(height: 12),
          _realWorldCard(
            example: const _RealWorldExample(
              title: 'Listen for memory pressure',
              description:
                  'Subscribe to the system channel to drop in-memory caches '
                  'when the OS is under pressure.',
              code:
                  '// equivalent to WidgetsBindingObserver.didHaveMemoryPressure:\n'
                  'SystemChannels.system.setMessageHandler((msg) async {\n'
                  '  if (msg is Map && msg["type"] == "memoryPressure") {\n'
                  '    imageCache.clear();\n'
                  '  }\n'
                  '  return null;\n'
                  '});',
              icon: Icons.warning_amber,
              accent: kPaletteOrange,
            ),
          ),
          const SizedBox(height: 28),

          // ---------------------------------------------------------------
          // SECTION 10 — Caveats and platform availability
          // ---------------------------------------------------------------
          _sectionTitle(
            ordinal: '09',
            title: 'Caveats',
            accent: kPaletteAmber,
          ),
          _caveatsPanel(),
          const SizedBox(height: 28),

          // ---------------------------------------------------------------
          // SECTION 11 — Footer / takeaways
          // ---------------------------------------------------------------
          _sectionTitle(
            ordinal: '10',
            title: 'Takeaways',
            accent: kPaletteIndigo,
          ),
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFE8EAF6), Color(0xFFC5CAE9)],
              ),
              borderRadius: const BorderRadius.all(Radius.circular(14)),
              border: Border.all(
                color: kPaletteIndigo.withValues(alpha: 0.3),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Three things to remember:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A237E),
                  ),
                ),
                const SizedBox(height: 12),
                _takeawayRow(
                  number: '1',
                  text:
                      'SystemChannels are stable, framework-internal contracts. '
                      'Prefer the high-level wrapper (Clipboard, HapticFeedback, …) '
                      'whenever one exists.',
                ),
                _takeawayRow(
                  number: '2',
                  text:
                      'Each channel has a fixed codec — mismatching the codec on '
                      'the host side is the most common platform-channel bug.',
                ),
                _takeawayRow(
                  number: '3',
                  text:
                      'For your own platform code, define a fresh MethodChannel '
                      'with a namespaced name like "com.example.app/foo". Do not '
                      'piggy-back on SystemChannels.*.',
                ),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.6),
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                  child: const Text(
                    'This widget is read-only. No channel was sent to. '
                    'No engine method was invoked.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: Color(0xFF1A237E),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Small composable visual helpers. Each returns a Widget directly. They are
// authored as functions (not StatelessWidget subclasses) to keep the demo to
// a single file with very little ceremony.
// ---------------------------------------------------------------------------

Widget _heroChip(String text, IconData icon) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.18),
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: 14),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

Widget _sectionTitle({
  required String ordinal,
  required String title,
  required Color accent,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12, top: 4),
    child: Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: accent,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: accent.withValues(alpha: 0.35),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            ordinal,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A237E),
            ),
          ),
        ),
        Container(
          height: 2,
          width: 60,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [accent, accent.withValues(alpha: 0.0)],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _bulletRow({
  required IconData icon,
  required Color color,
  required String text,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 2),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: const BorderRadius.all(Radius.circular(6)),
          ),
          child: Icon(icon, color: color, size: 14),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 13.5, height: 1.5),
          ),
        ),
      ],
    ),
  );
}

Widget _flowDiagram() {
  // Dart side → channel → engine → host platform → response
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
    decoration: BoxDecoration(
      color: const Color(0xFFF3E5F5),
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      border: Border.all(color: kPalettePurple.withValues(alpha: 0.25)),
    ),
    child: Row(
      children: [
        _flowNode(label: 'Dart side', icon: Icons.code, color: kPaletteIndigo),
        _flowArrow(),
        _flowNode(
          label: 'Channel',
          icon: Icons.cable,
          color: kPaletteTeal,
        ),
        _flowArrow(),
        _flowNode(
          label: 'Engine',
          icon: Icons.memory,
          color: kPaletteAmber,
        ),
        _flowArrow(),
        _flowNode(
          label: 'Host\nPlatform',
          icon: Icons.devices,
          color: kPaletteRose,
        ),
      ],
    ),
  );
}

Widget _flowNode({
  required String label,
  required IconData icon,
  required Color color,
}) {
  return Expanded(
    child: Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.4),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 22),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Color(0xFF263238),
          ),
        ),
      ],
    ),
  );
}

Widget _flowArrow() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 16,
          height: 2,
          color: kPalettePurple.withValues(alpha: 0.6),
        ),
        const SizedBox(height: 2),
        Icon(
          Icons.arrow_forward,
          size: 14,
          color: kPalettePurple.withValues(alpha: 0.7),
        ),
      ],
    ),
  );
}

Widget _taxonomyColumn({
  required String title,
  required String subtitle,
  required Color accent,
  required IconData icon,
  required List<String> members,
}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      border: Border.all(color: accent.withValues(alpha: 0.3)),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.1),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.15),
                borderRadius: const BorderRadius.all(Radius.circular(6)),
              ),
              child: Icon(icon, color: accent, size: 16),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: accent,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 11,
            fontStyle: FontStyle.italic,
            color: Color(0xFF607D8B),
          ),
        ),
        const SizedBox(height: 10),
        Container(height: 1, color: accent.withValues(alpha: 0.18)),
        const SizedBox(height: 8),
        // Manual member list (one Padding each — not a loop on data)
        for (final m in members)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: accent,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    m,
                    style: const TextStyle(
                      fontSize: 11.5,
                      fontFamily: 'monospace',
                      color: Color(0xFF263238),
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

Widget _channelCard({required _ChannelInfo info}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(14)),
      border: Border.all(color: info.accent.withValues(alpha: 0.25)),
      boxShadow: [
        BoxShadow(
          color: info.accent.withValues(alpha: 0.07),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: info.accent.withValues(alpha: 0.12),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Icon(info.icon, color: info.accent, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SystemChannels.${info.displayName}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: Color(0xFF1A237E),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    info.wireName,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      color: Color(0xFF455A64),
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
                color: info.accent,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: Text(
                info.kind,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: info.accent.withValues(alpha: 0.08),
            borderRadius: const BorderRadius.all(Radius.circular(6)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.compare_arrows, size: 13, color: info.accent),
              const SizedBox(width: 4),
              Text(
                'codec: ${info.codecName}',
                style: TextStyle(
                  fontSize: 11,
                  fontFamily: 'monospace',
                  color: info.accent,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Text(
          info.description,
          style: const TextStyle(
            fontSize: 13,
            height: 1.5,
            color: Color(0xFF263238),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          info.purpose,
          style: TextStyle(
            fontSize: 12,
            height: 1.45,
            fontStyle: FontStyle.italic,
            color: info.accent,
          ),
        ),
      ],
    ),
  );
}

Widget _lifecyclePayloadRow({
  required String state,
  required String meaning,
  required Color color,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            border: Border.all(color: color.withValues(alpha: 0.4)),
          ),
          child: Text(
            state,
            style: TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            meaning,
            style: const TextStyle(
              fontSize: 13,
              height: 1.45,
              color: Color(0xFF455A64),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _codeBlock(String code, {required Color accent}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFF1E1E2E),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      border: Border.all(color: accent.withValues(alpha: 0.4)),
    ),
    child: Text(
      code,
      style: const TextStyle(
        fontFamily: 'monospace',
        fontSize: 12,
        height: 1.5,
        color: Color(0xFFCDD6F4),
      ),
    ),
  );
}

Widget _platformMethodRow({
  required String method,
  required String args,
  required String description,
  required Color color,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        border: Border(
          left: BorderSide(color: color, width: 4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  method,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF263238),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                ),
                child: Text(
                  'method',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'args: $args',
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: Color(0xFF607D8B),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: const TextStyle(
              fontSize: 12.5,
              height: 1.5,
              color: Color(0xFF37474F),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _codecTable({required List<_CodecRow> rows}) {
  return Container(
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(12)),
      boxShadow: [
        BoxShadow(
          color: Color.fromARGB(20, 0, 0, 0),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      children: [
        // Header
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
          decoration: const BoxDecoration(
            color: Color(0xFF263238),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: const Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  'Codec',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Text(
                  'Wire format',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Text(
                  'Example',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
        for (final r in rows)
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 14,
            ),
            decoration: BoxDecoration(
              color: r.accent.withValues(alpha: 0.04),
              border: const Border(
                bottom: BorderSide(color: Color(0xFFECEFF1), width: 1),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      Container(
                        width: 6,
                        height: 18,
                        decoration: BoxDecoration(
                          color: r.accent,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(2),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          r.codec,
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: r.accent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    r.wireFormat,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF455A64),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Text(
                    r.example,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      color: Color(0xFF263238),
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

Widget _decisionTree() {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(14)),
      border: Border.all(color: kPaletteOrange.withValues(alpha: 0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _decisionNode(
          question: 'Need to call platform code?',
          color: kPaletteOrange,
          isQuestion: true,
        ),
        _decisionBranch(
          label: 'No',
          color: kPaletteSlate,
          child: _decisionNode(
            question:
                'Stay in pure Dart. You probably want a service / package, '
                'not a channel.',
            color: kPaletteSlate,
            isQuestion: false,
          ),
        ),
        _decisionBranch(
          label: 'Yes',
          color: kPaletteGreen,
          child: _decisionNode(
            question: 'Is the operation a built-in (clipboard, haptics, …)?',
            color: kPaletteGreen,
            isQuestion: true,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: _decisionBranch(
            label: 'Yes',
            color: kPaletteIndigo,
            child: _decisionNode(
              question:
                  'Use the high-level API (Clipboard, HapticFeedback, …). '
                  'It calls SystemChannels.platform under the hood.',
              color: kPaletteIndigo,
              isQuestion: false,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: _decisionBranch(
            label: 'No',
            color: kPaletteRose,
            child: _decisionNode(
              question:
                  'Define your own MethodChannel (e.g. '
                  '"com.example.app/foo") and implement on the host side.',
              color: kPaletteRose,
              isQuestion: false,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: kPaletteAmber.withValues(alpha: 0.1),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_outline, size: 16, color: kPaletteOrange),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Rule of thumb: never invent a new method on '
                  'SystemChannels.* — that namespace is owned by the engine.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF5D4037),
                    height: 1.5,
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

Widget _decisionNode({
  required String question,
  required Color color,
  required bool isQuestion,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          isQuestion ? Icons.help_outline : Icons.east,
          size: 16,
          color: color,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            question,
            style: TextStyle(
              fontSize: 13,
              height: 1.45,
              fontWeight: isQuestion ? FontWeight.w700 : FontWeight.w500,
              color: const Color(0xFF263238),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _decisionBranch({
  required String label,
  required Color color,
  required Widget child,
}) {
  return Padding(
    padding: const EdgeInsets.only(left: 12, top: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 8),
          width: 28,
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(4)),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(child: child),
      ],
    ),
  );
}

Widget _realWorldCard({required _RealWorldExample example}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      border: Border.all(color: example.accent.withValues(alpha: 0.3)),
      boxShadow: [
        BoxShadow(
          color: example.accent.withValues(alpha: 0.07),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: example.accent.withValues(alpha: 0.15),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: Icon(example.icon, color: example.accent, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                example.title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: example.accent,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          example.description,
          style: const TextStyle(
            fontSize: 13,
            height: 1.5,
            color: Color(0xFF455A64),
          ),
        ),
        const SizedBox(height: 12),
        _codeBlock(example.code, accent: example.accent),
      ],
    ),
  );
}

Widget _caveatsPanel() {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: kPaletteAmber.withValues(alpha: 0.05),
      borderRadius: const BorderRadius.all(Radius.circular(14)),
      border: Border.all(color: kPaletteAmber.withValues(alpha: 0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _caveatRow(
          platform: 'iOS',
          color: kPaletteCyan,
          text:
              'menu, contextMenu and undoManager are most fully implemented '
              'here. processText is a no-op.',
        ),
        _caveatRow(
          platform: 'Android',
          color: kPaletteGreen,
          text:
              'processText, keyboard and platform_views have the richest '
              'support. menu is unused on most devices.',
        ),
        _caveatRow(
          platform: 'Web',
          color: kPaletteIndigo,
          text:
              'Most channels are no-ops or report unimplemented. contextMenu '
              'is the major exception (browser context menu hide/show).',
        ),
        _caveatRow(
          platform: 'macOS / Linux / Windows',
          color: kPaletteRose,
          text:
              'menu, mouseCursor, undoManager work; haptic feedback and '
              'orientation locking are no-ops.',
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: Color(0xFFFFF8E1),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.warning_amber,
                color: kPaletteOrange,
                size: 18,
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Some channels are read-only from Dart (system, '
                  'lifecycle, accessibility): only the engine sends to them. '
                  'Calling invokeMethod on those is a misuse.',
                  style: TextStyle(
                    fontSize: 12.5,
                    height: 1.5,
                    color: Color(0xFF5D4037),
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

Widget _caveatRow({
  required String platform,
  required Color color,
  required String text,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 90,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(6)),
          ),
          alignment: Alignment.center,
          child: Text(
            platform,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              height: 1.5,
              color: Color(0xFF37474F),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _takeawayRow({required String number, required String text}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 26,
          height: 26,
          decoration: const BoxDecoration(
            color: kPaletteIndigo,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            number,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 13.5,
              height: 1.55,
              color: Color(0xFF263238),
            ),
          ),
        ),
      ],
    ),
  );
}
