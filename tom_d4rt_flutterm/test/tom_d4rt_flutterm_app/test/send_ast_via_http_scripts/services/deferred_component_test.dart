// ignore_for_file: avoid_print
// D4rt deep demo: DeferredComponent — deferred loading and code splitting
// for modular Flutter applications on Android.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── Olive / Sage palette ───
  const Color olive = Color(0xFF808000);
  const Color sage = Color(0xFFBCB88A);
  const Color deepOlive = Color(0xFF556B2F);
  const Color paleSage = Color(0xFFFAFAF0);
  const Color darkOlive = Color(0xFF2E3A1F);
  const Color moss = Color(0xFF8A9A5B);
  const Color fern = Color(0xFF4F7942);
  const Color khaki = Color(0xFFF0E68C);
  const Color artichoke = Color(0xFF8F9779);
  const Color celadon = Color(0xFFACE1AF);

  print('[dc] ===== DEFERRED COMPONENT DEEP DEMO =====');

  // ─── Local helpers ───

  Widget dcBanner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [darkOlive, deepOlive],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: darkOlive.withValues(alpha: 0.35),
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
              color: olive,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: sage, width: 1.5),
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

  Widget dcNote(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: paleSage,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: sage.withValues(alpha: 0.4)),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 13,
              color: darkOlive.withValues(alpha: 0.9),
              height: 1.5)),
    );
  }

  Widget dcCode(String label, String detail) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: khaki.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(6),
        border: Border(left: BorderSide(color: olive, width: 3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: darkOlive,
                  fontFamily: 'monospace')),
          const SizedBox(width: 8),
          Expanded(
            child: Text(detail,
                style: TextStyle(fontSize: 12, color: deepOlive)),
          ),
        ],
      ),
    );
  }

  Widget dcCard(String heading, Widget content) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: sage.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: darkOlive.withValues(alpha: 0.06),
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
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: olive.withValues(alpha: 0.06),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Text(heading,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: darkOlive)),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: content,
          ),
        ],
      ),
    );
  }

  Widget dcRow(List<String> cells, {bool isHeader = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 4),
      decoration: BoxDecoration(
        color: isHeader ? olive.withValues(alpha: 0.06) : Colors.transparent,
        border: Border(
          bottom: BorderSide(color: sage.withValues(alpha: 0.3)),
        ),
      ),
      child: Row(
        children: cells.map((c) {
          return Expanded(
            child: Text(c,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                    color: isHeader ? darkOlive : deepOlive)),
          );
        }).toList(),
      ),
    );
  }

  Widget dcFlow(List<String> steps) {
    List<Widget> items = [];
    for (int i = 0; i < steps.length; i++) {
      items.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: (i % 2 == 0) ? darkOlive : deepOlive,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(steps[i],
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w600)),
        ),
      );
      if (i < steps.length - 1) {
        items.add(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Icon(Icons.east, size: 12, color: moss),
        ));
      }
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: items),
    );
  }

  // ━━━━━━ SECTION 1: What is DeferredComponent? ━━━━━━
  print('[dc-01] Section 1: What is DeferredComponent?');

  Widget section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      dcBanner('01', 'What Is DeferredComponent?'),
      dcNote(
        'DeferredComponent represents a unit of code and assets that can be '
        'loaded on demand rather than at app startup. On Android, deferred '
        'components map to Play Feature Delivery dynamic feature modules, '
        'allowing users to download parts of the app only when needed.',
      ),
      dcCard(
        'Deferred vs Bundled',
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: paleSage,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: sage),
                ),
                child: Column(
                  children: [
                    Icon(Icons.all_inclusive, size: 24, color: deepOlive),
                    const SizedBox(height: 6),
                    Text('Bundled (Default)',
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: deepOlive)),
                    const SizedBox(height: 4),
                    Text('All code + assets in APK',
                        style: TextStyle(fontSize: 10, color: olive),
                        textAlign: TextAlign.center),
                    Text('Large initial download',
                        style: TextStyle(fontSize: 10, color: olive),
                        textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Icon(Icons.compare_arrows, size: 20, color: moss),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: celadon.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: fern),
                ),
                child: Column(
                  children: [
                    Icon(Icons.dynamic_feed, size: 24, color: fern),
                    const SizedBox(height: 6),
                    Text('Deferred',
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: fern)),
                    const SizedBox(height: 4),
                    Text('Load on demand',
                        style: TextStyle(fontSize: 10, color: deepOlive),
                        textAlign: TextAlign.center),
                    Text('Smaller initial APK',
                        style: TextStyle(fontSize: 10, color: deepOlive),
                        textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 2: Android Play Feature Delivery ━━━━━━
  print('[dc-02] Section 2: Play Feature Delivery');

  Widget section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      dcBanner('02', 'Android Play Feature Delivery'),
      dcNote(
        'Deferred components on Android build on Google Play\'s Dynamic '
        'Delivery system. Each deferred component becomes a dynamic feature '
        'module in the Android App Bundle (AAB). Play Store delivers the '
        'module when the app requests it at runtime.',
      ),
      dcCard(
        'Delivery Modes',
        Column(
          children: [
            dcRow(['Mode', 'When', 'Auto?'], isHeader: true),
            dcRow(['install-time', 'App install', 'Yes']),
            dcRow(['on-demand', 'User action', 'No']),
            dcRow(['fast-follow', 'After install', 'Background']),
            dcRow(['conditional', 'Device match', 'Automatic']),
          ],
        ),
      ),
      dcCard(
        'Flutter Uses On-Demand',
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: khaki.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'Flutter\'s DeferredComponent maps to on-demand delivery mode. '
            'The app explicitly calls installDeferredComponent() when the '
            'feature is needed, triggering a Play Store download.',
            style: TextStyle(fontSize: 11, color: darkOlive),
          ),
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 3: Loading API ━━━━━━
  print('[dc-03] Section 3: Loading API');

  Widget section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      dcBanner('03', 'The Loading API'),
      dcNote(
        'Components are loaded via DeferredComponent.installDeferredComponent() '
        'which returns a Future that completes when the component is ready. '
        'Dart deferred imports (loadLibrary()) trigger this automatically.',
      ),
      dcCard(
        'API Methods',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            dcCode('installDeferredComponent()',
                'Downloads and installs the named component'),
            dcCode('uninstallDeferredComponent()',
                'Removes the component to free space'),
            dcCode('loadLibrary()',
                'Dart deferred import — triggers install'),
            dcCode('DeferredWidget()',
                'Convenience widget that handles loading UI'),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 4: Dart deferred imports ━━━━━━
  print('[dc-04] Section 4: Dart deferred imports');

  Widget section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      dcBanner('04', 'Dart Deferred Imports'),
      dcNote(
        'Dart\'s "deferred as" import syntax splits code at compilation. '
        'When combined with Flutter\'s deferred components, the split code '
        'is packaged into separate modules and loaded from Play Store.',
      ),
      dcCard(
        'Import Syntax',
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: paleSage,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('// Standard import — bundled in base APK:',
                  style: TextStyle(
                      fontSize: 11, fontFamily: 'monospace', color: artichoke)),
              Text("import 'package:app/feature.dart';",
                  style: TextStyle(
                      fontSize: 11, fontFamily: 'monospace', color: darkOlive)),
              const SizedBox(height: 10),
              Text('// Deferred import — loaded on demand:',
                  style: TextStyle(
                      fontSize: 11, fontFamily: 'monospace', color: artichoke)),
              Text("import 'package:app/feature.dart' deferred as feature;",
                  style: TextStyle(
                      fontSize: 11,
                      fontFamily: 'monospace',
                      color: fern,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text('// Usage — must await loading:',
                  style: TextStyle(
                      fontSize: 11, fontFamily: 'monospace', color: artichoke)),
              Text('await feature.loadLibrary();',
                  style: TextStyle(
                      fontSize: 11,
                      fontFamily: 'monospace',
                      color: fern,
                      fontWeight: FontWeight.bold)),
              Text('feature.FeatureWidget();',
                  style: TextStyle(
                      fontSize: 11, fontFamily: 'monospace', color: darkOlive)),
            ],
          ),
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 5: Configuration ━━━━━━
  print('[dc-05] Section 5: Configuration');

  Widget section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      dcBanner('05', 'Project Configuration'),
      dcNote(
        'Deferred components require configuration in multiple places: '
        'pubspec.yaml defines component names and assets, the Android build '
        'creates feature modules, and the Dart code uses deferred imports.',
      ),
      dcCard(
        'Configuration Files',
        Column(
          children: [
            dcRow(['File', 'Purpose', 'Key Field'], isHeader: true),
            dcRow(['pubspec.yaml', 'Define components', 'deferred-components:']),
            dcRow(['build.gradle', 'Feature module', 'dynamicFeatures']),
            dcRow(['AndroidManifest', 'Module metadata', 'dist:module']),
            dcRow(['loading_units.yaml', 'Generated mapping', 'loading-units:']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 6: DeferredWidget ━━━━━━
  print('[dc-06] Section 6: DeferredWidget');

  Widget section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      dcBanner('06', 'The DeferredWidget Helper'),
      dcNote(
        'Flutter provides a DeferredWidget that wraps the deferred loading '
        'pattern with built-in placeholder and error handling. It shows a '
        'loading indicator while the component downloads and the widget '
        'itself once ready.',
      ),
      dcCard(
        'DeferredWidget States',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _dcStateBox('Not loaded', 'Component not yet requested',
                Icons.cloud_off, artichoke),
            const SizedBox(height: 6),
            _dcStateBox('Downloading', 'Play Store delivering module',
                Icons.cloud_download, olive),
            const SizedBox(height: 6),
            _dcStateBox('Installing', 'Module being installed locally',
                Icons.install_mobile, moss),
            const SizedBox(height: 6),
            _dcStateBox('Ready', 'Widget available for rendering',
                Icons.check_circle, fern),
            const SizedBox(height: 6),
            _dcStateBox('Error', 'Download or install failed',
                Icons.error, const Color(0xFFE53935)),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 7: Loading UI ━━━━━━
  print('[dc-07] Section 7: Loading UI');

  Widget section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      dcBanner('07', 'Loading UI Patterns'),
      dcNote(
        'While a deferred component downloads, the user needs feedback. '
        'Common patterns include shimmer placeholders, progress indicators '
        'with download percentage, and skeleton screens.',
      ),
      dcCard(
        'Loading Indicator Designs',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: paleSage,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: sage),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor: AlwaysStoppedAnimation(olive),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text('Spinner',
                            style: TextStyle(fontSize: 10, color: deepOlive)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: paleSage,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: sage),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          width: 60,
                          child: LinearProgressIndicator(
                            value: 0.65,
                            backgroundColor: sage.withValues(alpha: 0.3),
                            valueColor: AlwaysStoppedAnimation(fern),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text('Progress',
                            style: TextStyle(fontSize: 10, color: deepOlive)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: paleSage,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: sage),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 20,
                          decoration: BoxDecoration(
                            color: sage.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text('Skeleton',
                            style: TextStyle(fontSize: 10, color: deepOlive)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 8: Size reduction ━━━━━━
  print('[dc-08] Section 8: Size reduction');

  Widget section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      dcBanner('08', 'App Size Reduction'),
      dcNote(
        'The primary motivation for deferred components is reducing initial '
        'app size. Features used by a small percentage of users can be '
        'loaded on demand, keeping the base APK small for faster installs.',
      ),
      dcCard(
        'Size Impact Example',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: _dcSizeBox('Base APK', '15 MB', 'Core app', olive)),
                const SizedBox(width: 6),
                Expanded(child: _dcSizeBox('AR Module', '8 MB', '5% of users', moss)),
                const SizedBox(width: 6),
                Expanded(child: _dcSizeBox('ML Model', '12 MB', '10% of users', fern)),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: celadon.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                children: [
                  Text('Without deferred: 35 MB for all users',
                      style: TextStyle(fontSize: 11, color: const Color(0xFFE53935))),
                  Text('With deferred: 15 MB base, modules on demand',
                      style: TextStyle(
                          fontSize: 11,
                          color: fern,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 9: Asset loading ━━━━━━
  print('[dc-09] Section 9: Asset loading');

  Widget section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      dcBanner('09', 'Deferred Asset Loading'),
      dcNote(
        'Deferred components can include assets (images, fonts, data files) '
        'alongside code. Assets in a deferred component are only downloaded '
        'when the component is installed. reference them normally once loaded.',
      ),
      dcCard(
        'Asset Configuration',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            dcCode('deferred-components:',
                'Top-level pubspec.yaml key'),
            dcCode('  - name: premium_themes',
                'Component name'),
            dcCode('    assets:',
                'Assets included in this component'),
            dcCode('      - assets/themes/',
                'Asset directory path'),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: khaki.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'Assets in deferred components cannot be accessed before '
                'the component is installed — AssetImage will throw.',
                style: TextStyle(fontSize: 10, color: darkOlive),
              ),
            ),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 10: Uninstalling ━━━━━━
  print('[dc-10] Section 10: Uninstalling');

  Widget section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      dcBanner('10', 'Uninstalling Components'),
      dcNote(
        'Components can be uninstalled to free device storage. The app '
        'calls uninstallDeferredComponent() and the system removes the '
        'module. The feature becomes unavailable until re-installed.',
      ),
      dcCard(
        'Uninstall Flow',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            dcFlow(['Feature visible', 'User triggers uninstall',
                'Module removed', 'Space freed', 'Feature hidden']),
            const SizedBox(height: 10),
            dcRow(['Action', 'State Change'], isHeader: true),
            dcRow(['installDeferredComponent()', 'Not Loaded → Ready']),
            dcRow(['uninstallDeferredComponent()', 'Ready → Not Loaded']),
            dcRow(['loadLibrary() on uninstalled', 'Re-triggers install']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 11: Error handling ━━━━━━
  print('[dc-11] Section 11: Error handling');

  Widget section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      dcBanner('11', 'Error Handling'),
      dcNote(
        'Deferred loading can fail: network errors, Play Store issues, '
        'insufficient storage, or module corruption. Apps must handle '
        'these gracefully with retry logic and user-friendly messages.',
      ),
      dcCard(
        'Error Scenarios',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _dcErrorItem('Network failure',
                'No connectivity during download', olive),
            _dcErrorItem('Storage full',
                'Insufficient space for module', deepOlive),
            _dcErrorItem('Play Store error',
                'Backend delivery failure', moss),
            _dcErrorItem('Module corrupted',
                'Verification failed after download', fern),
            _dcErrorItem('Version mismatch',
                'Base app updated, module outdated', artichoke),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 12: Platform limitations ━━━━━━
  print('[dc-12] Section 12: Platform limitations');

  Widget section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      dcBanner('12', 'Platform Limitations'),
      dcNote(
        'Deferred components are currently Android-only with Play Feature '
        'Delivery. iOS, web, desktop, and sideloaded Android APKs include '
        'all code in the base install. The API is safe to call on other '
        'platforms — it simply bundles everything upfront.',
      ),
      dcCard(
        'Platform Support',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: _dcPlatformStatus('Android (Play)', true, fern)),
                const SizedBox(width: 6),
                Expanded(child: _dcPlatformStatus('Android (APK)', false, artichoke)),
                const SizedBox(width: 6),
                Expanded(child: _dcPlatformStatus('iOS', false, artichoke)),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(child: _dcPlatformStatus('Web', false, artichoke)),
                const SizedBox(width: 6),
                Expanded(child: _dcPlatformStatus('macOS', false, artichoke)),
                const SizedBox(width: 6),
                Expanded(child: _dcPlatformStatus('Linux', false, artichoke)),
              ],
            ),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 13: Build process ━━━━━━
  print('[dc-13] Section 13: Build process');

  Widget section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      dcBanner('13', 'Build Process'),
      dcNote(
        'Building with deferred components requires flutter build appbundle '
        'which produces an AAB with separate feature modules. The tool '
        'validates the deferred-components config and generates the Android '
        'module structure automatically.',
      ),
      dcCard(
        'Build Steps',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _dcBuildStep(1, 'flutter build appbundle --deferred-components',
                'Compile with splitting', olive),
            _dcBuildStep(2, 'Gen loading_units.yaml',
                'Map Dart libs to modules', deepOlive),
            _dcBuildStep(3, 'Create feature modules',
                'Android dynamic features', moss),
            _dcBuildStep(4, 'Package AAB',
                'Base + feature modules', fern),
            _dcBuildStep(5, 'Upload to Play Console',
                'Enable Dynamic Delivery', darkOlive),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 14: Testing deferred ━━━━━━
  print('[dc-14] Section 14: Testing');

  Widget section14 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      dcBanner('14', 'Testing Deferred Components'),
      dcNote(
        'Testing deferred loading requires special setup. In debug mode, '
        'all code is bundled (no actual deferral). Use bundletool to test '
        'locally, or internal test tracks on Play Console for real behavior.',
      ),
      dcCard(
        'Test Strategies',
        Column(
          children: [
            dcRow(['Method', 'Deferred?', 'Effort'], isHeader: true),
            dcRow(['Debug mode', 'No (all bundled)', 'Low']),
            dcRow(['bundletool local', 'Simulated', 'Medium']),
            dcRow(['Play internal track', 'Real', 'High']),
            dcRow(['Widget test', 'Mocked', 'Low']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 15: Best practices ━━━━━━
  print('[dc-15] Section 15: Best practices');

  Widget section15 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      dcBanner('15', 'Best Practices'),
      dcNote(
        'Choose wisely what to defer. Large, rarely-used features with '
        'heavy assets are ideal candidates. Core functionality should '
        'remain in the base module for instant availability.',
      ),
      dcCard(
        'Decision Matrix',
        Column(
          children: [
            dcRow(['Feature Type', 'Defer?', 'Reason'], isHeader: true),
            dcRow(['Core navigation', 'No', 'Always needed']),
            dcRow(['Auth flow', 'No', 'Used at startup']),
            dcRow(['AR experience', 'Yes', 'Large, rare use']),
            dcRow(['ML model', 'Yes', 'Heavy assets']),
            dcRow(['Premium themes', 'Yes', 'Only for subscribers']),
            dcRow(['Admin panel', 'Yes', 'Small user group']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 16: Summary dashboard ━━━━━━
  print('[dc-16] Section 16: Summary dashboard');

  Widget section16 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      dcBanner('16', 'Summary Dashboard'),
      dcCard(
        'DeferredComponent — Complete',
        Column(
          children: [
            dcRow(['Topic', 'Section', 'Key Insight'], isHeader: true),
            dcRow(['What', 'S01', 'On-demand code + asset loading']),
            dcRow(['Play', 'S02', 'Dynamic Feature Delivery']),
            dcRow(['API', 'S03', 'install/uninstall/loadLibrary']),
            dcRow(['Dart', 'S04', 'deferred as import syntax']),
            dcRow(['Config', 'S05', 'pubspec + build.gradle + manifest']),
            dcRow(['Widget', 'S06', 'DeferredWidget helper']),
            dcRow(['Loading', 'S07', 'Spinner/progress/skeleton UI']),
            dcRow(['Size', 'S08', 'Smaller base APK']),
            dcRow(['Assets', 'S09', 'Images/fonts per component']),
            dcRow(['Uninstall', 'S10', 'Free space on demand']),
            dcRow(['Errors', 'S11', 'Network, storage, Play errors']),
            dcRow(['Platforms', 'S12', 'Android Play Store only']),
            dcRow(['Build', 'S13', 'flutter build appbundle']),
            dcRow(['Testing', 'S14', 'bundletool + Play internal']),
            dcRow(['Practices', 'S15', 'Defer large, rare features']),
          ],
        ),
      ),
      dcCard(
        'Olive / Sage Theme',
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _dcColorSwatch('Olive', olive),
            _dcColorSwatch('Sage', sage),
            _dcColorSwatch('Fern', fern),
            _dcColorSwatch('Moss', moss),
            _dcColorSwatch('Dark', darkOlive),
          ],
        ),
      ),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [darkOlive, deepOlive],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            const Text('DeferredComponent — Complete',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(
              'From Play Feature Delivery through deferred Dart imports, '
              'asset loading, size reduction, error handling, build process, '
              'and testing — the full Android deferred component story.',
              style: TextStyle(color: khaki, fontSize: 12, height: 1.4),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ],
  );

  print('[dc] ===== ALL 16 SECTIONS BUILT =====');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: const Text('DeferredComponent — Code Splitting'),
        backgroundColor: darkOlive,
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFFAFAF5),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            section1, section2, section3, section4,
            section5, section6, section7, section8,
            section9, section10, section11, section12,
            section13, section14, section15, section16,
          ],
        ),
      ),
    ),
  );
}

// ═══════════════════════════════════════════════════
// Top-level helpers
// ═══════════════════════════════════════════════════

Widget _dcStateBox(String title, String desc, IconData icon, Color color) {
  return Row(
    children: [
      Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(child: Icon(icon, size: 18, color: color)),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: color)),
            Text(desc,
                style: const TextStyle(
                    fontSize: 10, color: Color(0xFF2E3A1F))),
          ],
        ),
      ),
    ],
  );
}

Widget _dcSizeBox(String label, String size, String note, Color color) {
  return Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Column(
      children: [
        Text(size,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color)),
        Text(label,
            style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: color)),
        Text(note,
            style: TextStyle(fontSize: 8, color: color.withValues(alpha: 0.7))),
      ],
    ),
  );
}

Widget _dcErrorItem(String title, String desc, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.warning_amber, size: 16, color: color),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: color)),
              Text(desc,
                  style: const TextStyle(
                      fontSize: 10, color: Color(0xFF556B2F))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _dcPlatformStatus(String name, bool supported, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      color: supported
          ? color.withValues(alpha: 0.1)
          : const Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(
        color: supported ? color : const Color(0xFFE0E0E0),
      ),
    ),
    child: Column(
      children: [
        Text(name,
            style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                color: supported ? color : const Color(0xFF9E9E9E)),
            textAlign: TextAlign.center),
        Text(supported ? 'Deferred' : 'Bundled',
            style: TextStyle(
                fontSize: 8,
                color: supported ? color : const Color(0xFFBDBDBD))),
      ],
    ),
  );
}

Widget _dcBuildStep(int num, String cmd, String desc, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text('$num',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(cmd,
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace',
                      color: color)),
              Text(desc,
                  style: const TextStyle(
                      fontSize: 10, color: Color(0xFF2E3A1F))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _dcColorSwatch(String name, Color color) {
  return Column(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      ),
      const SizedBox(height: 3),
      Text(name, style: const TextStyle(fontSize: 8)),
    ],
  );
}
