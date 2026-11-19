/// Extended bridge tests (file 27): material classes no script exercised.
///
/// One script per small group of the Essential and Important material
/// classes the testplans showed unexercised (addtests2). Each test checks
/// lines the script prints, every one taken from the same script run
/// natively on Flutter 3.47.9, so a script that runs but computes the wrong
/// value fails. Own test app.
@TestOn('vm')
library;

import 'package:flutter_test/flutter_test.dart';

import 'send_test_runner.dart';

const String _kTestFileName = 'flutter_extended_27_test.dart';

void main() {
  setUpAll(() async {
    await SendTestRunner.setUp(suite: _kTestFileName);
  });

  tearDownAll(() async {
    await SendTestRunner.tearDown();
  });

  group('Test App Health', () {
    test('app is running', () async {
      final isRunning = await SendTestRunner.isAppRunning();
      expect(
        isRunning,
        isTrue,
        reason: 'Test app should be running (managed by setUpAll).',
      );
    });
  });

  group('Material classes (addtests2)', () {
    // ActionIconTheme, ElevatedButtonTheme, TextButtonTheme, FloatingActionButtonTheme, CheckboxTheme, RadioTheme, SwitchTheme, ButtonThemeData
    test('material/component_themes_buttons_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/component_themes_buttons_test.dart',
      );
      SendTestRunner.expectSuccess(result);
      expect(
        result.output,
        containsAll(<String>[
          'action has back builder: true',
          'action of: true',
          'elevated has style: true',
          'elevated of: ElevatedButtonThemeData',
          'text has style: true',
          'fab elevation: 9.0',
          'checkbox splashRadius: 12.0',
          'radio splashRadius: 14.0',
          'switch splashRadius: 16.0',
          'button theme: 120.0 x 44.0',
          'button theme copy height: 50.0',
          'button theme textTheme: ButtonTextTheme.normal',
        ]),
      );
    });
    // NavigationBarTheme, NavigationRailTheme, TabBarTheme, DrawerTheme, BottomAppBarTheme, BadgeTheme, SnackBarTheme, MaterialBannerTheme
    test('material/component_themes_navigation_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/component_themes_navigation_test.dart',
      );
      SendTestRunner.expectSuccess(result);
      expect(
        result.output,
        containsAll(<String>[
          'navigation bar height: 70.0',
          'navigation bar of: NavigationBarThemeData',
          'rail minWidth: 64.0',
          'tab bar dividerHeight: 2.0',
          'tab bar of: TabBarThemeData',
          'drawer width: 280.0',
          'bottom app bar height: 60.0',
          'badge smallSize: 8.0',
          'snack bar elevation: 3.0',
          'banner elevation: 2.0',
        ]),
      );
    });
    // MenuTheme, MenuBarTheme, PopupMenuTheme, DropdownMenuTheme, SearchBarTheme, SearchViewTheme, RadioMenuButton
    test('material/component_themes_menus_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/component_themes_menus_test.dart',
      );
      SendTestRunner.expectSuccess(result);
      expect(
        result.output,
        containsAll(<String>[
          'menu alignment: Alignment.bottomLeft',
          'menu bar alignment: Alignment.topRight',
          'popup elevation: 6.0',
          'dropdown font size: 13.0',
          'search bar minHeight: 48.0',
          'search view elevation: 4.0',
          'radio menu value: 2 group: 2',
        ]),
      );
    });
    // BottomSheet, MaterialRouteTransitionMixin, PredictiveBackPageTransitionsBuilder
    test('material/bottom_sheet_routes_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/bottom_sheet_routes_test.dart',
      );
      SendTestRunner.expectSuccess(result);
      expect(
        result.output,
        containsAll(<String>[
          'sheet enableDrag: false',
          'sheet closed: 1',
          'route content: page',
          'route can transition to page route: true',
          'route maintainState: true',
          'route opaque: true',
          'builder registered: true',
          'builder type: PredictiveBackPageTransitionsBuilder',
        ]),
      );
    });
    // InkFeature, InkHighlight, InteractiveInkFeature, MaterialInkController
    test('material/ink_features_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/ink_features_test.dart',
      );
      SendTestRunner.expectSuccess(result);
      expect(result.output, containsAll(<String>['ink feature types: 4']));
    });
    // RadioMenuButton.onChanged read back
    test(
      'material/radio_menu_button_on_changed_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'material/radio_menu_button_on_changed_test.dart',
        );
        SendTestRunner.expectSuccess(result);
        expect(
          result.output,
          containsAll(<String>['radio menu changed to: 3']),
        );
      },
    );
    // MaterialInkController members
    test(
      'material/material_ink_controller_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'material/material_ink_controller_test.dart',
        );
        SendTestRunner.expectSuccess(result);
        // The nested builder checks the controller's `color` and `vsync`
        // and throws on a wrong answer, which expectSuccess reports.
        expect(result.output, containsAll(<String>['controller types: 1']));
      },
    );
  });
}
