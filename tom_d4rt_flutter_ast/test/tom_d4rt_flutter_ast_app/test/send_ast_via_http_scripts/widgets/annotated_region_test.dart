// ignore_for_file: avoid_print
// Deep demo: AnnotatedRegion - Widget layer annotation for system UI overlays
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  return MaterialApp(
    theme: ThemeData.light(),
    home: const AnnotatedRegionDemo(),
  );
}

class AnnotatedRegionDemo extends StatefulWidget {
  const AnnotatedRegionDemo({super.key});

  @override
  State<AnnotatedRegionDemo> createState() => _AnnotatedRegionDemoState();
}

class _AnnotatedRegionDemoState extends State<AnnotatedRegionDemo> {
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: Basic AnnotatedRegion
  // ═══════════════════════════════════════════════════════════════════════════
  bool _basicDarkIcons = true;

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: Status Bar Styling
  // ═══════════════════════════════════════════════════════════════════════════
  Color _statusBarColor = Colors.transparent;
  Brightness _statusBarIconBrightness = Brightness.dark;
  int _statusBarPreset = 0;

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: Navigation Bar Styling
  // ═══════════════════════════════════════════════════════════════════════════
  Color _navBarColor = Colors.white;
  Brightness _navBarIconBrightness = Brightness.dark;
  int _navBarPreset = 0;

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: Light/Dark Theme Overlays
  // ═══════════════════════════════════════════════════════════════════════════
  bool _isDarkTheme = false;

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: Per-Screen Overlay Styles
  // ═══════════════════════════════════════════════════════════════════════════
  int _selectedScreen = 0;

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: Nested Regions
  // ═══════════════════════════════════════════════════════════════════════════
  bool _innerRegionActive = false;

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: Conditional Styling
  // ═══════════════════════════════════════════════════════════════════════════
  bool _isScrolledDown = false;
  bool _isFullscreen = false;

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: Practical Use Cases
  // ═══════════════════════════════════════════════════════════════════════════
  bool _immersiveMode = false;
  int _activeTab = 0;
  double _scrollOffset = 0;
  bool _photoViewerActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnnotatedRegion Deep Demo'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('1. Basic AnnotatedRegion'),
            _buildBasicSection(),
            const SizedBox(height: 32),

            _buildSectionHeader('2. Status Bar Styling'),
            _buildStatusBarSection(),
            const SizedBox(height: 32),

            _buildSectionHeader('3. Navigation Bar Styling'),
            _buildNavBarSection(),
            const SizedBox(height: 32),

            _buildSectionHeader('4. Light/Dark Theme Overlays'),
            _buildThemeOverlaySection(),
            const SizedBox(height: 32),

            _buildSectionHeader('5. Per-Screen Overlay Styles'),
            _buildPerScreenSection(),
            const SizedBox(height: 32),

            _buildSectionHeader('6. Nested Regions'),
            _buildNestedSection(),
            const SizedBox(height: 32),

            _buildSectionHeader('7. Conditional Styling'),
            _buildConditionalSection(),
            const SizedBox(height: 32),

            _buildSectionHeader('8. Practical Use Cases'),
            _buildPracticalUseCasesSection(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: Basic AnnotatedRegion
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildBasicSection() {
    print('=== Section 1: Basic AnnotatedRegion ===');
    print('Dark icons: $_basicDarkIcons');

    final style = _basicDarkIcons
        ? SystemUiOverlayStyle.dark
        : SystemUiOverlayStyle.light;

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'AnnotatedRegion<T> attaches a value of type T to the '
              'render tree layer. Flutter reads this to configure the '
              'system UI. Most common: AnnotatedRegion<SystemUiOverlayStyle>.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),

            AnnotatedRegion<SystemUiOverlayStyle>(
              value: style,
              child: Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  color: _basicDarkIcons ? Colors.white : Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.deepPurple.shade200),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.system_update,
                      color: _basicDarkIcons ? Colors.black : Colors.white,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Style: ${_basicDarkIcons ? "dark icons" : "light icons"}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _basicDarkIcons ? Colors.black : Colors.white,
                      ),
                    ),
                    Text(
                      'Status bar icons would be ${_basicDarkIcons ? "dark" : "light"}',
                      style: TextStyle(
                        fontSize: 12,
                        color: _basicDarkIcons ? Colors.black54 : Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                ChoiceChip(
                  label: const Text('Dark Icons'),
                  selected: _basicDarkIcons,
                  onSelected: (s) {
                    if (s) setState(() { _basicDarkIcons = true; });
                    print('Basic: dark icons');
                  },
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('Light Icons'),
                  selected: !_basicDarkIcons,
                  onSelected: (s) {
                    if (s) setState(() { _basicDarkIcons = false; });
                    print('Basic: light icons');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: Status Bar Styling
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildStatusBarSection() {
    print('=== Section 2: Status Bar Styling ===');
    print('Status bar color: $_statusBarColor');
    print('Icon brightness: $_statusBarIconBrightness');
    print('Preset: $_statusBarPreset');

    final presets = [
      {'name': 'Transparent', 'color': Colors.transparent, 'icons': Brightness.dark},
      {'name': 'White', 'color': Colors.white, 'icons': Brightness.dark},
      {'name': 'Black', 'color': Colors.black, 'icons': Brightness.light},
      {'name': 'Blue', 'color': Colors.blue, 'icons': Brightness.light},
      {'name': 'Red', 'color': Colors.red, 'icons': Brightness.light},
    ];

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'SystemUiOverlayStyle controls statusBarColor, '
              'statusBarIconBrightness, and statusBarBrightness (iOS).',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),

            AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle(
                statusBarColor: _statusBarColor,
                statusBarIconBrightness: _statusBarIconBrightness,
              ),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  children: [
                    // Simulated status bar
                    Container(
                      width: double.infinity,
                      height: 28,
                      decoration: BoxDecoration(
                        color: _statusBarColor == Colors.transparent
                            ? Colors.grey.shade200 : _statusBarColor,
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(11)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.signal_cellular_4_bar, size: 14,
                            color: _statusBarIconBrightness == Brightness.dark
                                ? Colors.black : Colors.white,
                          ),
                          const SizedBox(width: 4),
                          Icon(Icons.wifi, size: 14,
                            color: _statusBarIconBrightness == Brightness.dark
                                ? Colors.black : Colors.white,
                          ),
                          const SizedBox(width: 4),
                          Icon(Icons.battery_full, size: 14,
                            color: _statusBarIconBrightness == Brightness.dark
                                ? Colors.black : Colors.white,
                          ),
                          const SizedBox(width: 8),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 60,
                      color: Colors.grey.shade100,
                      child: const Center(
                        child: Text('App Content Area', style: TextStyle(color: Colors.grey)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(presets.length, (i) {
                final p = presets[i];
                return ChoiceChip(
                  label: Text(p['name'] as String),
                  selected: _statusBarPreset == i,
                  onSelected: (s) {
                    if (s) {
                      setState(() {
                        _statusBarPreset = i;
                        _statusBarColor = p['color'] as Color;
                        _statusBarIconBrightness = p['icons'] as Brightness;
                      });
                      print('Status bar preset: ${p['name']}');
                    }
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: Navigation Bar Styling
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildNavBarSection() {
    print('=== Section 3: Navigation Bar Styling ===');
    print('Nav bar color: $_navBarColor');
    print('Nav icon brightness: $_navBarIconBrightness');

    final presets = [
      {'name': 'White', 'color': Colors.white, 'icons': Brightness.dark},
      {'name': 'Black', 'color': Colors.black, 'icons': Brightness.light},
      {'name': 'Teal', 'color': Colors.teal, 'icons': Brightness.light},
      {'name': 'Grey', 'color': Colors.grey.shade800, 'icons': Brightness.light},
    ];

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'systemNavigationBarColor and systemNavigationBarIconBrightness '
              'control the bottom Android navigation bar.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),

            AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle(
                systemNavigationBarColor: _navBarColor,
                systemNavigationBarIconBrightness: _navBarIconBrightness,
              ),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 80,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.vertical(top: Radius.circular(11)),
                      ),
                      child: const Center(
                        child: Text('App Content', style: TextStyle(color: Colors.grey)),
                      ),
                    ),
                    // Simulated nav bar
                    Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                        color: _navBarColor,
                        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(11)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.arrow_back, size: 18,
                            color: _navBarIconBrightness == Brightness.dark
                                ? Colors.black54 : Colors.white70,
                          ),
                          Icon(Icons.circle_outlined, size: 18,
                            color: _navBarIconBrightness == Brightness.dark
                                ? Colors.black54 : Colors.white70,
                          ),
                          Icon(Icons.crop_square, size: 18,
                            color: _navBarIconBrightness == Brightness.dark
                                ? Colors.black54 : Colors.white70,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(presets.length, (i) {
                final p = presets[i];
                return ChoiceChip(
                  label: Text(p['name'] as String),
                  selected: _navBarPreset == i,
                  onSelected: (s) {
                    if (s) {
                      setState(() {
                        _navBarPreset = i;
                        _navBarColor = p['color'] as Color;
                        _navBarIconBrightness = p['icons'] as Brightness;
                      });
                      print('Nav bar preset: ${p['name']}');
                    }
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: Light/Dark Theme Overlays
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildThemeOverlaySection() {
    print('=== Section 4: Light/Dark Theme Overlays ===');
    print('Dark theme: $_isDarkTheme');

    final overlayStyle = _isDarkTheme
        ? const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarColor: Color(0xFF121212),
            systemNavigationBarIconBrightness: Brightness.light,
          )
        : const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Colors.white,
            systemNavigationBarIconBrightness: Brightness.dark,
          );

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Typical pattern: use AnnotatedRegion at the top level '
              'to match the app theme, toggling between light and dark.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),

            AnnotatedRegion<SystemUiOverlayStyle>(
              value: overlayStyle,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: _isDarkTheme ? const Color(0xFF121212) : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  children: [
                    // Status bar area
                    Container(
                      height: 24,
                      decoration: BoxDecoration(
                        color: _isDarkTheme ? const Color(0xFF1E1E1E) : Colors.grey.shade100,
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(11)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '12:00',
                            style: TextStyle(
                              fontSize: 11,
                              color: _isDarkTheme ? Colors.white70 : Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Icon(
                            _isDarkTheme ? Icons.dark_mode : Icons.light_mode,
                            size: 48,
                            color: _isDarkTheme ? Colors.amber : Colors.orange,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _isDarkTheme ? 'Dark Theme' : 'Light Theme',
                            style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold,
                              color: _isDarkTheme ? Colors.white : Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _isDarkTheme
                                ? 'Light status icons, dark nav bar'
                                : 'Dark status icons, white nav bar',
                            style: TextStyle(
                              fontSize: 12,
                              color: _isDarkTheme ? Colors.white54 : Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Nav bar area
                    Container(
                      height: 32,
                      decoration: BoxDecoration(
                        color: _isDarkTheme ? const Color(0xFF1E1E1E) : Colors.grey.shade100,
                        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(11)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            SwitchListTile(
              title: const Text('Dark theme'),
              value: _isDarkTheme,
              onChanged: (val) {
                setState(() { _isDarkTheme = val; });
                print('Theme: ${val ? "dark" : "light"}');
              },
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: Per-Screen Overlay Styles
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildPerScreenSection() {
    print('=== Section 5: Per-Screen Overlay Styles ===');
    print('Selected screen: $_selectedScreen');

    final screens = [
      {
        'name': 'Home',
        'icon': Icons.home,
        'bg': Colors.white,
        'fg': Colors.black,
        'statusColor': Colors.transparent,
        'statusIcons': Brightness.dark,
      },
      {
        'name': 'Gallery',
        'icon': Icons.photo_library,
        'bg': Colors.black,
        'fg': Colors.white,
        'statusColor': Colors.black,
        'statusIcons': Brightness.light,
      },
      {
        'name': 'Profile',
        'icon': Icons.person,
        'bg': Colors.deepPurple,
        'fg': Colors.white,
        'statusColor': Colors.deepPurple,
        'statusIcons': Brightness.light,
      },
      {
        'name': 'Settings',
        'icon': Icons.settings,
        'bg': Colors.grey.shade100,
        'fg': Colors.black,
        'statusColor': Colors.grey.shade100,
        'statusIcons': Brightness.dark,
      },
    ];

    final screen = screens[_selectedScreen];

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Each screen can declare its own AnnotatedRegion to '
              'configure the system UI chrome independently.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),

            AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle(
                statusBarColor: screen['statusColor'] as Color,
                statusBarIconBrightness: screen['statusIcons'] as Brightness,
              ),
              child: Container(
                width: double.infinity,
                height: 140,
                decoration: BoxDecoration(
                  color: screen['bg'] as Color,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(screen['icon'] as IconData, size: 40,
                      color: screen['fg'] as Color),
                    const SizedBox(height: 8),
                    Text(
                      screen['name'] as String,
                      style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold,
                        color: screen['fg'] as Color,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(screens.length, (i) {
                return ChoiceChip(
                  label: Text(screens[i]['name'] as String),
                  selected: _selectedScreen == i,
                  onSelected: (s) {
                    if (s) {
                      setState(() { _selectedScreen = i; });
                      print('Screen: ${screens[i]['name']}');
                    }
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: Nested Regions
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildNestedSection() {
    print('=== Section 6: Nested Regions ===');
    print('Inner region active: $_innerRegionActive');

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'AnnotatedRegions can nest. The topmost (closest to viewport) '
              'region wins. Inner regions only apply if they occupy the '
              'status bar area.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),

            // Outer region
            AnnotatedRegion<SystemUiOverlayStyle>(
              value: const SystemUiOverlayStyle(
                statusBarColor: Colors.blue,
                statusBarIconBrightness: Brightness.light,
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue, width: 2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Outer Region: Blue status bar',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                    const SizedBox(height: 12),

                    if (_innerRegionActive)
                      AnnotatedRegion<SystemUiOverlayStyle>(
                        value: const SystemUiOverlayStyle(
                          statusBarColor: Colors.red,
                          statusBarIconBrightness: Brightness.light,
                        ),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.red, width: 2),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Inner Region: Red status bar',
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'This region overrides the outer one if it reaches the status bar area',
                                style: TextStyle(fontSize: 12, color: Colors.red.shade700),
                              ),
                            ],
                          ),
                        ),
                      )
                    else
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: const Text(
                          'No inner region (outer applies)',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            SwitchListTile(
              title: const Text('Activate inner region'),
              value: _innerRegionActive,
              onChanged: (val) {
                setState(() { _innerRegionActive = val; });
                print('Inner region: ${val ? "active" : "inactive"}');
              },
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: Conditional Styling
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildConditionalSection() {
    print('=== Section 7: Conditional Styling ===');
    print('Scrolled: $_isScrolledDown, Fullscreen: $_isFullscreen');

    final SystemUiOverlayStyle conditionalStyle;
    if (_isFullscreen) {
      conditionalStyle = const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
      );
    } else if (_isScrolledDown) {
      conditionalStyle = const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
      );
    } else {
      conditionalStyle = const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
      );
    }

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dynamically change the overlay style based on '
              'scroll position, fullscreen mode, or other state.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),

            AnnotatedRegion<SystemUiOverlayStyle>(
              value: conditionalStyle,
              child: Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  color: _isFullscreen ? Colors.black
                      : _isScrolledDown ? Colors.white : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade400),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _isFullscreen ? Icons.fullscreen
                          : _isScrolledDown ? Icons.arrow_downward : Icons.arrow_upward,
                      color: _isFullscreen ? Colors.white : Colors.black,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _isFullscreen ? 'Fullscreen: all dark chrome'
                          : _isScrolledDown ? 'Scrolled: solid white bar'
                          : 'Default: transparent bar',
                      style: TextStyle(
                        fontSize: 12,
                        color: _isFullscreen ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            Wrap(
              spacing: 8,
              children: [
                ChoiceChip(
                  label: const Text('Default'),
                  selected: !_isScrolledDown && !_isFullscreen,
                  onSelected: (s) {
                    if (s) setState(() { _isScrolledDown = false; _isFullscreen = false; });
                    print('Conditional: default');
                  },
                ),
                ChoiceChip(
                  label: const Text('Scrolled'),
                  selected: _isScrolledDown && !_isFullscreen,
                  onSelected: (s) {
                    if (s) setState(() { _isScrolledDown = true; _isFullscreen = false; });
                    print('Conditional: scrolled');
                  },
                ),
                ChoiceChip(
                  label: const Text('Fullscreen'),
                  selected: _isFullscreen,
                  onSelected: (s) {
                    if (s) setState(() { _isFullscreen = true; _isScrolledDown = false; });
                    print('Conditional: fullscreen');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: Practical Use Cases
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildPracticalUseCasesSection() {
    print('=== Section 8: Practical Use Cases ===');
    print('Immersive: $_immersiveMode, Tab: $_activeTab');
    print('Scroll offset: $_scrollOffset, Photo viewer: $_photoViewerActive');

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Real-world uses of AnnotatedRegion for system UI control.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 24),

            // Use Case 1: Immersive mode
            const Text('1. Immersive Mode Toggle', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            AnnotatedRegion<SystemUiOverlayStyle>(
              value: _immersiveMode
                  ? const SystemUiOverlayStyle(
                      statusBarColor: Colors.transparent,
                      statusBarIconBrightness: Brightness.light,
                      systemNavigationBarColor: Colors.transparent,
                      systemNavigationBarIconBrightness: Brightness.light,
                    )
                  : SystemUiOverlayStyle.dark,
              child: Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  color: _immersiveMode ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _immersiveMode ? Icons.visibility_off : Icons.visibility,
                        color: _immersiveMode ? Colors.white : Colors.black,
                        size: 32,
                      ),
                      Text(
                        _immersiveMode ? 'Immersive: chrome hidden' : 'Normal: chrome visible',
                        style: TextStyle(
                          color: _immersiveMode ? Colors.white70 : Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: () {
                setState(() { _immersiveMode = !_immersiveMode; });
                print('Immersive: $_immersiveMode');
              },
              icon: Icon(_immersiveMode ? Icons.fullscreen_exit : Icons.fullscreen),
              label: Text(_immersiveMode ? 'Exit Immersive' : 'Enter Immersive'),
            ),
            const SizedBox(height: 24),

            // Use Case 2: Themed tabs
            const Text('2. Themed Tab Screens', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildThemedTabs(),
            const SizedBox(height: 24),

            // Use Case 3: Scroll-dependent styling
            const Text('3. Scroll-Dependent Styling', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle(
                statusBarColor: Color.lerp(
                  Colors.transparent,
                  Colors.deepPurple,
                  (_scrollOffset / 100).clamp(0.0, 1.0),
                ),
                statusBarIconBrightness: _scrollOffset > 50
                    ? Brightness.light : Brightness.dark,
              ),
              child: Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.lerp(Colors.white, Colors.deepPurple,
                          (_scrollOffset / 100).clamp(0.0, 1.0))!,
                      Colors.grey.shade100,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    'Scroll offset: ${_scrollOffset.toInt()}',
                    style: TextStyle(
                      color: _scrollOffset > 50 ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Slider(
              value: _scrollOffset,
              min: 0,
              max: 100,
              onChanged: (val) {
                setState(() { _scrollOffset = val; });
                print('Scroll offset: ${val.toInt()}');
              },
            ),
            const SizedBox(height: 24),

            // Use Case 4: Photo viewer overlay
            const Text('4. Photo Viewer Overlay', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            AnnotatedRegion<SystemUiOverlayStyle>(
              value: _photoViewerActive
                  ? const SystemUiOverlayStyle(
                      statusBarColor: Colors.black,
                      statusBarIconBrightness: Brightness.light,
                      systemNavigationBarColor: Colors.black,
                    )
                  : SystemUiOverlayStyle.dark,
              child: GestureDetector(
                onTap: () {
                  setState(() { _photoViewerActive = !_photoViewerActive; });
                  print('Photo viewer: $_photoViewerActive');
                },
                child: Container(
                  width: double.infinity,
                  height: 140,
                  decoration: BoxDecoration(
                    color: _photoViewerActive ? Colors.black : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Icon(
                          Icons.photo,
                          size: 60,
                          color: _photoViewerActive ? Colors.white24 : Colors.grey,
                        ),
                      ),
                      if (!_photoViewerActive)
                        Positioned(
                          top: 8,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            color: Colors.white70,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.arrow_back, size: 16),
                                SizedBox(width: 32),
                                Text('Photo Title'),
                                SizedBox(width: 32),
                                Icon(Icons.share, size: 16),
                              ],
                            ),
                          ),
                        ),
                      Center(
                        child: Text(
                          _photoViewerActive ? 'Tap to show controls' : 'Tap to view fullscreen',
                          style: TextStyle(
                            color: _photoViewerActive ? Colors.white70 : Colors.black54,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemedTabs() {
    final tabs = [
      {'name': 'Home', 'icon': Icons.home, 'color': Colors.blue},
      {'name': 'Search', 'icon': Icons.search, 'color': Colors.green},
      {'name': 'Alerts', 'icon': Icons.notifications, 'color': Colors.orange},
      {'name': 'Profile', 'icon': Icons.person, 'color': Colors.purple},
    ];

    final tab = tabs[_activeTab];
    final tabColor = tab['color'] as Color;

    return Column(
      children: [
        AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: tabColor,
            statusBarIconBrightness: Brightness.light,
          ),
          child: Container(
            width: double.infinity,
            height: 80,
            decoration: BoxDecoration(
              color: tabColor,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(tab['icon'] as IconData, color: Colors.white, size: 28),
                  Text(tab['name'] as String,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
          ),
          child: Row(
            children: List.generate(tabs.length, (i) {
              final t = tabs[i];
              final isActive = _activeTab == i;
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() { _activeTab = i; });
                    print('Tab: ${t['name']}');
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: isActive ? t['color'] as Color : Colors.transparent,
                          width: 3,
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(t['icon'] as IconData, size: 20,
                          color: isActive ? t['color'] as Color : Colors.grey,
                        ),
                        Text(
                          t['name'] as String,
                          style: TextStyle(
                            fontSize: 10,
                            color: isActive ? t['color'] as Color : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // Helper Methods
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildSectionHeader(String title) {
    print('');
    print('════════════════════════════════════════════════════════════');
    print(title);
    print('════════════════════════════════════════════════════════════');

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const Divider(thickness: 2, color: Colors.deepPurple),
        ],
      ),
    );
  }
}
