// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — WidgetsApp
// Demonstrates WidgetsApp, the foundational application widget that
// MaterialApp and CupertinoApp build upon. Covers navigation, localization,
// builder pattern, accessibility and the core app infrastructure.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('WidgetsApp Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptItems = <Map<String, dynamic>>[
    {
      'icon': Icons.foundation,
      'title': 'What is WidgetsApp?',
      'body': 'WidgetsApp is the base application widget that provides '
          'the fundamental infrastructure every Flutter app needs: '
          'navigation, localization, accessibility overlays, and '
          'the widget inspector. Both MaterialApp and CupertinoApp '
          'are built on top of WidgetsApp.',
      'accent': Colors.cyan,
    },
    {
      'icon': Icons.navigation,
      'title': 'Navigation Infrastructure',
      'body': 'WidgetsApp sets up the Navigator that manages the route '
          'stack. It provides named routes, onGenerateRoute, '
          'onUnknownRoute, and the initial route. All declarative '
          'and imperative navigation flows through this setup.',
      'accent': Colors.blue,
    },
    {
      'icon': Icons.language,
      'title': 'Localization Backbone',
      'body': 'WidgetsApp hosts the Localizations widget that provides '
          'translated strings. It resolves which locale to use, '
          'loads LocalizationsDelegate resources, and makes them '
          'available to the entire subtree via Localizations.of.',
      'accent': Colors.green,
    },
    {
      'icon': Icons.visibility,
      'title': 'Accessibility & Inspector',
      'body': 'WidgetsApp provides accessibility overlays like the '
          'SemanticsDebugger and the WidgetInspector. It wraps '
          'the app in MediaQuery and Directionality, ensuring '
          'proper text direction and screen metric access.',
      'accent': Colors.orange,
    },
  ];

  final conceptCards = <Widget>[];
  for (var i = 0; i < conceptItems.length; i++) {
    final c = conceptItems[i];
    final accent = c['accent'] as Color;
    print('Concept ${i + 1}: ${c['title']}');
    conceptCards.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [accent.withOpacity(0.12), accent.withOpacity(0.03)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: accent.withOpacity(0.3)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: accent.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(c['icon'] as IconData, color: accent, size: 26),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      c['title'] as String,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: accent,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      c['body'] as String,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade800,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 2: API
  // ============================================================
  print('=== Section 2: API ===');

  final apiEntries = <Map<String, String>>[
    {
      'name': 'home',
      'type': 'Widget?',
      'desc': 'The default route widget. Displayed when the app opens '
          'at "/". Cannot be used together with routes if routes '
          'also contains a "/" entry.',
    },
    {
      'name': 'routes',
      'type': 'Map<String, WidgetBuilder>',
      'desc': 'A table of named routes. Each key is a route name (like '
          '"/settings") and the value is a builder function that '
          'returns the route\u0027s widget.',
    },
    {
      'name': 'onGenerateRoute',
      'type': 'RouteFactory?',
      'desc': 'Called when Navigator.pushNamed is called with a name '
          'not in routes. Allows dynamic route generation based on '
          'the RouteSettings (name, arguments).',
    },
    {
      'name': 'onUnknownRoute',
      'type': 'RouteFactory?',
      'desc': 'Fallback when onGenerateRoute returns null. Used for '
          '404-style pages. If both are null for an unknown route, '
          'the framework throws an assertion error.',
    },
    {
      'name': 'builder',
      'type': 'TransitionBuilder?',
      'desc': 'Wraps the Navigator. Receives the Navigator as child '
          'and can add widgets above it (MediaQuery overrides, '
          'providers, overlays). Runs on every rebuild.',
    },
    {
      'name': 'locale',
      'type': 'Locale?',
      'desc': 'Forces a specific Locale instead of using the system '
          'locale. Useful for previewing the app in a different '
          'language during development.',
    },
    {
      'name': 'localizationsDelegates',
      'type': 'Iterable<LocalizationsDelegate>?',
      'desc': 'Delegates that load localized resources. Each delegate '
          'is responsible for a specific set of translations. '
          'WidgetsApp provides default widget localizations.',
    },
    {
      'name': 'supportedLocales',
      'type': 'Iterable<Locale>',
      'desc': 'The locales this app supports. Used during locale '
          'resolution. If the system locale is not supported, the '
          'first entry is used as fallback.',
    },
  ];

  final apiWidgets = <Widget>[];
  for (var i = 0; i < apiEntries.length; i++) {
    final ae = apiEntries[i];
    print('API ${i + 1}: ${ae['name']}');
    apiWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: i.isEven
              ? Colors.cyan.withOpacity(0.06)
              : Colors.grey.withOpacity(0.03),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.cyan.withOpacity(0.25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.cyan.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    ae['name']!,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.cyan.shade800,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    ae['type']!,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              ae['desc']!,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 3: Routing
  // ============================================================
  print('=== Section 3: Routing ===');

  final routingScenarios = <Map<String, dynamic>>[
    {
      'title': 'home Route',
      'desc': 'The simplest navigation setup: provide a home widget. '
          'WidgetsApp wraps it in a Navigator and displays it at '
          'the "/" route. No explicit route table needed.',
      'diagram': 'WidgetsApp(\n'
          '  home: MyHomePage(),\n'
          ')\n'
          '\n'
          'Navigator stack: [MyHomePage]',
      'color': Colors.cyan,
    },
    {
      'title': 'Named Routes Table',
      'desc': 'Define a Map of route names to builder functions. Each '
          'route is built on demand when navigated to. The "/" '
          'entry becomes the initial route.',
      'diagram': 'routes: {\n'
          '  "/": (ctx) => Home(),\n'
          '  "/settings": (ctx) => Settings(),\n'
          '  "/profile": (ctx) => Profile(),\n'
          '}\n'
          '\n'
          'Navigator.pushNamed(ctx, "/settings")',
      'color': Colors.blue,
    },
    {
      'title': 'onGenerateRoute (Dynamic)',
      'desc': 'For dynamic routes with parameters or complex matching. '
          'Receives RouteSettings with name and arguments. Returns '
          'a Route or null (to fall through to onUnknownRoute).',
      'diagram': 'onGenerateRoute: (settings) {\n'
          '  if (settings.name == "/user/123")\n'
          '    return MaterialPageRoute(\n'
          '      builder: (_) => UserPage(id: 123),\n'
          '    );\n'
          '  return null; // fall to unknown\n'
          '}',
      'color': Colors.green,
    },
    {
      'title': 'onUnknownRoute (404)',
      'desc': 'Fallback for unresolved routes. If onGenerateRoute '
          'returns null and the route is not in the routes table, '
          'onUnknownRoute is called. Returns a "not found" page.',
      'diagram': 'onUnknownRoute: (settings) {\n'
          '  return MaterialPageRoute(\n'
          '    builder: (_) => NotFoundPage(\n'
          '      route: settings.name,\n'
          '    ),\n'
          '  );\n'
          '}',
      'color': Colors.red,
    },
  ];

  final routingWidgets = <Widget>[];
  for (var i = 0; i < routingScenarios.length; i++) {
    final rs = routingScenarios[i];
    final rsColor = rs['color'] as Color;
    print('Routing ${i + 1}: ${rs['title']}');
    routingWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: rsColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: rsColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                rs['title'] as String,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: rsColor,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                rs['desc'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E2E),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  rs['diagram'] as String,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: Color(0xFFCDD6F4),
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 4: Locale Resolution
  // ============================================================
  print('=== Section 4: Locale ===');

  final localeSteps = <Map<String, dynamic>>[
    {
      'step': '1. System Locale',
      'desc': 'The platform provides the user\u0027s preferred locales '
          'via PlatformDispatcher.locales. This is usually set in '
          'system settings (language preferences).',
      'icon': Icons.phone_android,
      'color': Colors.cyan,
    },
    {
      'step': '2. Locale Resolution',
      'desc': 'WidgetsApp\u0027s localeResolutionCallback receives the '
          'system locales and supportedLocales. It returns the best '
          'match. If no callback, basic matching is used.',
      'icon': Icons.compare_arrows,
      'color': Colors.blue,
    },
    {
      'step': '3. Load Delegates',
      'desc': 'For the resolved locale, each LocalizationsDelegate '
          'loads its resources (translated strings, date formats, '
          'number formats). This happens asynchronously.',
      'icon': Icons.download,
      'color': Colors.green,
    },
    {
      'step': '4. Provide via Localizations',
      'desc': 'The loaded resources are available to the subtree via '
          'Localizations.of<T>(context). Widgets call this to get '
          'translated text, formatted dates, etc.',
      'icon': Icons.share,
      'color': Colors.orange,
    },
    {
      'step': '5. Locale Override',
      'desc': 'Setting WidgetsApp.locale directly overrides the system '
          'locale. Useful for language preview, per-user settings, '
          'or testing specific translations.',
      'icon': Icons.edit,
      'color': Colors.purple,
    },
  ];

  final localeWidgets = <Widget>[];
  for (var i = 0; i < localeSteps.length; i++) {
    final ls = localeSteps[i];
    final lsColor = ls['color'] as Color;
    print('Locale ${i + 1}: ${ls['step']}');
    localeWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: lsColor.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    ls['icon'] as IconData,
                    color: lsColor,
                    size: 18,
                  ),
                ),
                if (i < localeSteps.length - 1)
                  Container(
                    width: 2,
                    height: 24,
                    color: lsColor.withOpacity(0.2),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: lsColor.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: lsColor.withOpacity(0.15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ls['step'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: lsColor,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      ls['desc'] as String,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade700,
                        height: 1.35,
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

  // ============================================================
  // SECTION 5: Accessibility
  // ============================================================
  print('=== Section 5: Accessibility ===');

  final accessTopics = <Map<String, dynamic>>[
    {
      'title': 'Semantics Tree',
      'desc': 'WidgetsApp enables the semantics tree, which describes '
          'the UI for accessibility services. Screen readers use '
          'this tree to announce widgets, labels, and actions.',
      'color': Colors.cyan,
    },
    {
      'title': 'showSemanticsDebugger',
      'desc': 'When true, WidgetsApp overlays a visual representation '
          'of the semantics tree on the app. Useful for verifying '
          'that accessibility labels and roles are correct.',
      'color': Colors.blue,
    },
    {
      'title': 'Text Direction',
      'desc': 'WidgetsApp wraps the app in a Directionality widget '
          'based on the resolved locale. RTL locales (Arabic, '
          'Hebrew) get TextDirection.rtl; others get ltr.',
      'color': Colors.green,
    },
    {
      'title': 'Keyboard Shortcuts',
      'desc': 'WidgetsApp registers default keyboard shortcuts for '
          'navigation (Tab, Shift+Tab) and common actions. These '
          'are provided via the Shortcuts widget in the app tree.',
      'color': Colors.orange,
    },
    {
      'title': 'Focus Management',
      'desc': 'WidgetsApp includes a FocusScope at the app level. '
          'This manages keyboard focus traversal for the entire '
          'application, enabling accessible keyboard navigation.',
      'color': Colors.purple,
    },
  ];

  final accessWidgets = <Widget>[];
  for (var i = 0; i < accessTopics.length; i++) {
    final at = accessTopics[i];
    final atColor = at['color'] as Color;
    print('Access ${i + 1}: ${at['title']}');
    accessWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: atColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: atColor.withOpacity(0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: atColor.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${i + 1}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: atColor,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    at['title'] as String,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: atColor,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    at['desc'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade700,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 6: Builder Pattern
  // ============================================================
  print('=== Section 6: Builder ===');

  final builderUseCases = <Map<String, dynamic>>[
    {
      'title': 'MediaQuery Override',
      'desc': 'The builder can wrap the Navigator in a custom MediaQuery '
          'to override text scaling, padding, or size for the '
          'entire app. This affects all routes.',
      'diagram': 'builder: (ctx, child) {\n'
          '  return MediaQuery(\n'
          '    data: MediaQuery.of(ctx).copyWith(\n'
          '      textScaleFactor: 1.2,\n'
          '    ),\n'
          '    child: child!,\n'
          '  );\n'
          '}',
      'color': Colors.cyan,
    },
    {
      'title': 'Global Provider',
      'desc': 'The builder is ideal for adding app-wide state providers '
          'above the Navigator. State is preserved across route '
          'transitions.',
      'diagram': 'builder: (ctx, child) {\n'
          '  return AppStateProvider(\n'
          '    state: appState,\n'
          '    child: child!,\n'
          '  );\n'
          '}',
      'color': Colors.blue,
    },
    {
      'title': 'Overlay Wrapper',
      'desc': 'Add a persistent overlay (loading indicator, network '
          'status bar, debug banner) that stays visible across all '
          'routes.',
      'diagram': 'builder: (ctx, child) {\n'
          '  return Stack(\n'
          '    children: [\n'
          '      child!,\n'
          '      if (isLoading)\n'
          '        LoadingOverlay(),\n'
          '    ],\n'
          '  );\n'
          '}',
      'color': Colors.green,
    },
    {
      'title': 'No Navigator',
      'desc': 'If builder is provided but no home/routes/onGenerateRoute, '
          'WidgetsApp does not create a Navigator. The builder\u0027s '
          'child is null. Used for custom navigation implementations.',
      'diagram': 'WidgetsApp(\n'
          '  builder: (ctx, child) {\n'
          '    // child is null\n'
          '    return MyCustomNavigator();\n'
          '  },\n'
          ')',
      'color': Colors.orange,
    },
  ];

  final builderWidgets = <Widget>[];
  for (var i = 0; i < builderUseCases.length; i++) {
    final bu = builderUseCases[i];
    final buColor = bu['color'] as Color;
    print('Builder ${i + 1}: ${bu['title']}');
    builderWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: buColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: buColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                bu['title'] as String,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: buColor,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                bu['desc'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E2E),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  bu['diagram'] as String,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: Color(0xFFCDD6F4),
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 7: Hierarchy Comparison
  // ============================================================
  print('=== Section 7: Hierarchy ===');

  final hierarchyItems = <Map<String, dynamic>>[
    {
      'level': 'WidgetsApp',
      'features': 'Navigator, Localizations, Shortcuts, Actions, '
          'FocusScope, DefaultTextEditingShortcuts, SemanticsDebugger',
      'purpose': 'Bare-bones app infrastructure. No design system. '
          'Use when building a completely custom look.',
      'color': Colors.cyan,
    },
    {
      'level': 'MaterialApp',
      'features': 'WidgetsApp + Theme, AnimatedTheme, ScrollConfiguration, '
          'ScaffoldMessenger, MaterialLocalizations',
      'purpose': 'Material Design app. Adds theming, snackbar support, '
          'and Material-specific localizations on top of WidgetsApp.',
      'color': Colors.blue,
    },
    {
      'level': 'CupertinoApp',
      'features': 'WidgetsApp + CupertinoTheme, CupertinoLocalizations, '
          'iOS-specific scroll behavior and haptics',
      'purpose': 'iOS-style app. Adds Cupertino theming and localizations '
          'on top of WidgetsApp.',
      'color': Colors.orange,
    },
  ];

  final hierarchyWidgets = <Widget>[];
  for (var i = 0; i < hierarchyItems.length; i++) {
    final hi = hierarchyItems[i];
    final hiColor = hi['color'] as Color;
    print('Hierarchy ${i + 1}: ${hi['level']}');
    hierarchyWidgets.add(
      Container(
        margin: EdgeInsets.only(
          left: 16 + i * 20.0,
          right: 16,
          top: 4,
          bottom: 4,
        ),
        decoration: BoxDecoration(
          color: hiColor.withOpacity(0.06),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: hiColor.withOpacity(0.3), width: 2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                hi['level'] as String,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: hiColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                hi['purpose'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: hiColor.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  hi['features'] as String,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: hiColor,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    if (i < hierarchyItems.length - 1) {
      hierarchyWidgets.add(
        Padding(
          padding: EdgeInsets.only(left: 32 + i * 20.0),
          child: Icon(
            Icons.arrow_downward,
            color: hiColor.withOpacity(0.4),
            size: 20,
          ),
        ),
      );
    }
  }

  // ============================================================
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.foundation,
      'text': 'WidgetsApp is the base app widget. MaterialApp and '
          'CupertinoApp both extend it with design-system specifics.',
    },
    {
      'icon': Icons.navigation,
      'text': 'Provides Navigator infrastructure: home, routes, '
          'onGenerateRoute, onUnknownRoute, initialRoute.',
    },
    {
      'icon': Icons.language,
      'text': 'Hosts localization via Localizations widget, locale '
          'resolution, and LocalizationsDelegate loading.',
    },
    {
      'icon': Icons.accessibility,
      'text': 'Enables accessibility: semantics tree, keyboard '
          'shortcuts, focus management, text direction.',
    },
    {
      'icon': Icons.build,
      'text': 'The builder parameter wraps the Navigator for global '
          'providers, overlays, or custom navigation.',
    },
    {
      'icon': Icons.layers,
      'text': 'Use WidgetsApp directly for custom design systems that '
          'don\u0027t follow Material or Cupertino patterns.',
    },
  ];

  final summaryWidgets = <Widget>[];
  for (var i = 0; i < summaryPoints.length; i++) {
    final sp = summaryPoints[i];
    print('Summary ${i + 1}: ${(sp['text'] as String).substring(0, 40)}...');
    summaryWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.cyan.withOpacity(0.04 + (i % 3) * 0.02),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.cyan.withOpacity(0.15)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.cyan.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                sp['icon'] as IconData,
                color: Colors.cyan.shade800,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                sp['text'] as String,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade800,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // ASSEMBLE TABBED LAYOUT
  // ============================================================
  print('Assembling tabbed layout');

  return DefaultTabController(
    length: 8,
    child: Scaffold(
      appBar: AppBar(
        title: const Text('WidgetsApp'),
        backgroundColor: Colors.cyan.shade700,
        foregroundColor: Colors.white,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(icon: Icon(Icons.info_outline), text: 'Concept'),
            Tab(icon: Icon(Icons.api), text: 'API'),
            Tab(icon: Icon(Icons.navigation), text: 'Routing'),
            Tab(icon: Icon(Icons.language), text: 'Locale'),
            Tab(icon: Icon(Icons.accessibility), text: 'Access'),
            Tab(icon: Icon(Icons.build), text: 'Builder'),
            Tab(icon: Icon(Icons.layers), text: 'Hierarchy'),
            Tab(icon: Icon(Icons.summarize), text: 'Summary'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          // Tab 1
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.cyan.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'WidgetsApp: the foundational app widget providing '
                  'navigation, localization, and accessibility.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...conceptCards,
            ],
          ),
          // Tab 2
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.cyan.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'WidgetsApp API: constructor parameters and configuration.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...apiWidgets,
            ],
          ),
          // Tab 3
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.cyan.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Route configuration strategies and navigation setup.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...routingWidgets,
            ],
          ),
          // Tab 4
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.cyan.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'How WidgetsApp resolves and loads locales.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...localeWidgets,
            ],
          ),
          // Tab 5
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.cyan.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Accessibility features provided by WidgetsApp.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...accessWidgets,
            ],
          ),
          // Tab 6
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.cyan.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'The builder parameter: wrapping the Navigator.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...builderWidgets,
            ],
          ),
          // Tab 7
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.cyan.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'WidgetsApp \u2192 MaterialApp / CupertinoApp hierarchy.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...hierarchyWidgets,
            ],
          ),
          // Tab 8
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.cyan.withOpacity(0.12),
                      Colors.lightBlue.withOpacity(0.06),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Key takeaways about WidgetsApp.',
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              ...summaryWidgets,
            ],
          ),
        ],
      ),
    ),
  );
}
