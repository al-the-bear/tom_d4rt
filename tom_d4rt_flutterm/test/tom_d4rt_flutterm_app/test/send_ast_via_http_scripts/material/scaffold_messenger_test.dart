// ScaffoldMessenger Deep Demo
// Manages SnackBars and MaterialBanners across Scaffolds
// Provides a consistent API for showing transient messages

import 'package:flutter/material.dart';

void main() {
  runApp(ScaffoldMessengerDemoApp());
}

// ============================================================================
// SECTION 1: ScaffoldMessenger Wrapping Scaffold
// ============================================================================

// Basic ScaffoldMessenger wrapper around MaterialApp
class ScaffoldMessengerDemoApp extends StatelessWidget {
  ScaffoldMessengerDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ScaffoldMessenger Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        snackBarTheme: SnackBarThemeData(
          backgroundColor: Colors.blueGrey,
          contentTextStyle: TextStyle(color: Colors.white),
          actionTextColor: Colors.amber,
        ),
      ),
      home: ScaffoldMessengerWrapper(),
    );
  }
}

// ScaffoldMessenger wraps the entire scaffold hierarchy
class ScaffoldMessengerWrapper extends StatefulWidget {
  ScaffoldMessengerWrapper({super.key});

  @override
  State<ScaffoldMessengerWrapper> createState() =>
      _ScaffoldMessengerWrapperState();
}

class _ScaffoldMessengerWrapperState extends State<ScaffoldMessengerWrapper> {
  GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: messengerKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text('ScaffoldMessenger Demo'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SectionHeader(title: 'Basic SnackBar Operations'),
              SizedBox(height: 8),
              BasicSnackBarControls(),
              SizedBox(height: 24),
              SectionHeader(title: 'SnackBar Customization'),
              SizedBox(height: 8),
              CustomSnackBarControls(),
              SizedBox(height: 24),
              SectionHeader(title: 'MaterialBanner Operations'),
              SizedBox(height: 8),
              MaterialBannerControls(),
              SizedBox(height: 24),
              SectionHeader(title: 'Advanced Messenger Patterns'),
              SizedBox(height: 8),
              AdvancedMessengerControls(),
            ],
          ),
        ),
      ),
    );
  }
}

// Section header widget
class SectionHeader extends StatelessWidget {
  SectionHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.blue.shade900,
        ),
      ),
    );
  }
}

// ============================================================================
// SECTION 2: SnackBar Display
// ============================================================================

// Basic SnackBar controls
class BasicSnackBarControls extends StatelessWidget {
  BasicSnackBarControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () {
            _showSimpleSnackBar(context);
          },
          child: Text('Show Simple SnackBar'),
        ),
        SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            _showSnackBarWithAction(context);
          },
          child: Text('Show SnackBar with Action'),
        ),
        SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            _showSnackBarWithDuration(context);
          },
          child: Text('Show SnackBar (5 seconds)'),
        ),
        SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            _hideCurrentSnackBar(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
          ),
          child: Text('Hide Current SnackBar'),
        ),
        SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            _clearSnackBars(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: Text('Clear All SnackBars'),
        ),
      ],
    );
  }

  void _showSimpleSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('This is a simple SnackBar message'),
      ),
    );
  }

  void _showSnackBarWithAction(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Message with action'),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Action pressed!')),
            );
          },
        ),
      ),
    );
  }

  void _showSnackBarWithDuration(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('This SnackBar will stay for 5 seconds'),
        duration: Duration(seconds: 5),
      ),
    );
  }

  void _hideCurrentSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  void _clearSnackBars(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
  }
}

// Custom SnackBar styling controls
class CustomSnackBarControls extends StatelessWidget {
  CustomSnackBarControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () {
            _showColoredSnackBar(context);
          },
          child: Text('Show Colored SnackBar'),
        ),
        SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            _showFloatingSnackBar(context);
          },
          child: Text('Show Floating SnackBar'),
        ),
        SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            _showSnackBarWithIcon(context);
          },
          child: Text('Show SnackBar with Icon'),
        ),
        SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            _showSnackBarWithMargin(context);
          },
          child: Text('Show SnackBar with Margin'),
        ),
        SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            _showSnackBarWithCloseIcon(context);
          },
          child: Text('Show SnackBar with Close Icon'),
        ),
        SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            _showMultiLineSnackBar(context);
          },
          child: Text('Show Multi-line SnackBar'),
        ),
      ],
    );
  }

  void _showColoredSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Custom colored SnackBar'),
        backgroundColor: Colors.purple,
      ),
    );
  }

  void _showFloatingSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Floating SnackBar'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _showSnackBarWithIcon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.info, color: Colors.white),
            SizedBox(width: 12),
            Expanded(child: Text('SnackBar with icon')),
          ],
        ),
      ),
    );
  }

  void _showSnackBarWithMargin(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('SnackBar with custom margin'),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(20),
      ),
    );
  }

  void _showSnackBarWithCloseIcon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('SnackBar with close icon'),
        showCloseIcon: true,
        closeIconColor: Colors.white,
      ),
    );
  }

  void _showMultiLineSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'This is a multi-line SnackBar message that demonstrates '
          'how longer content is displayed to the user.',
        ),
        action: SnackBarAction(
          label: 'ACTION',
          onPressed: () {},
        ),
      ),
    );
  }
}

// ============================================================================
// SECTION 3: MaterialBanner Display
// ============================================================================

// MaterialBanner controls
class MaterialBannerControls extends StatelessWidget {
  MaterialBannerControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () {
            _showSimpleBanner(context);
          },
          child: Text('Show Simple Banner'),
        ),
        SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            _showBannerWithLeading(context);
          },
          child: Text('Show Banner with Leading Icon'),
        ),
        SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            _showBannerWithMultipleActions(context);
          },
          child: Text('Show Banner with Multiple Actions'),
        ),
        SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            _showColoredBanner(context);
          },
          child: Text('Show Colored Banner'),
        ),
        SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            _hideCurrentBanner(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
          ),
          child: Text('Hide Current Banner'),
        ),
        SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            _clearBanners(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: Text('Clear All Banners'),
        ),
      ],
    );
  }

  void _showSimpleBanner(BuildContext context) {
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        content: Text('This is a simple MaterialBanner'),
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            },
            child: Text('DISMISS'),
          ),
        ],
      ),
    );
  }

  void _showBannerWithLeading(BuildContext context) {
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        leading: CircleAvatar(
          backgroundColor: Colors.amber,
          child: Icon(Icons.warning, color: Colors.white),
        ),
        content: Text('Warning: Please review your settings'),
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            },
            child: Text('DISMISS'),
          ),
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            },
            child: Text('VIEW'),
          ),
        ],
      ),
    );
  }

  void _showBannerWithMultipleActions(BuildContext context) {
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        content: Text('Multiple actions available'),
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            },
            child: Text('CANCEL'),
          ),
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            },
            child: Text('LATER'),
          ),
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showColoredBanner(BuildContext context) {
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        backgroundColor: Colors.green.shade100,
        content: Text(
          'Success! Your changes have been saved.',
          style: TextStyle(color: Colors.green.shade900),
        ),
        leading: Icon(Icons.check_circle, color: Colors.green),
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            },
            child: Text('GREAT'),
          ),
        ],
      ),
    );
  }

  void _hideCurrentBanner(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
  }

  void _clearBanners(BuildContext context) {
    ScaffoldMessenger.of(context).clearMaterialBanners();
  }
}

// ============================================================================
// SECTION 4: ScaffoldMessenger.of Pattern
// ============================================================================

// Advanced messenger patterns
class AdvancedMessengerControls extends StatefulWidget {
  AdvancedMessengerControls({super.key});

  @override
  State<AdvancedMessengerControls> createState() =>
      _AdvancedMessengerControlsState();
}

class _AdvancedMessengerControlsState extends State<AdvancedMessengerControls> {
  int snackBarCount = 0;
  int bannerCount = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () {
            _showQueuedSnackBars(context);
          },
          child: Text('Queue Multiple SnackBars'),
        ),
        SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            _showSnackBarAndRemovePrevious(context);
          },
          child: Text('Show SnackBar (Remove Previous)'),
        ),
        SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            _showPersistentSnackBar(context);
          },
          child: Text('Show Persistent SnackBar'),
        ),
        SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NestedScaffoldPage(),
              ),
            );
          },
          child: Text('Go to Nested Scaffold Page'),
        ),
        SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            _demonstrateMessengerState(context);
          },
          child: Text('Demonstrate Messenger State'),
        ),
      ],
    );
  }

  void _showQueuedSnackBars(BuildContext context) {
    for (int i = 1; i <= 3; i++) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Queued SnackBar #$i'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _showSnackBarAndRemovePrevious(BuildContext context) {
    snackBarCount++;
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Text('SnackBar #$snackBarCount (previous removed)'),
        ),
      );
  }

  void _showPersistentSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('This is a persistent SnackBar'),
        duration: Duration(days: 1),
        action: SnackBarAction(
          label: 'DISMISS',
          onPressed: () {},
        ),
      ),
    );
  }

  void _demonstrateMessengerState(BuildContext context) {
    ScaffoldMessengerState messengerState = ScaffoldMessenger.of(context);
    messengerState.showSnackBar(
      SnackBar(
        content: Text('Accessed via ScaffoldMessengerState'),
        backgroundColor: Colors.teal,
      ),
    );
  }
}

// Nested scaffold page to demonstrate cross-page messaging
class NestedScaffoldPage extends StatelessWidget {
  NestedScaffoldPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nested Scaffold'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'This page has its own Scaffold',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                _showNestedSnackBar(context);
              },
              child: Text('Show SnackBar Here'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _showNestedBanner(context);
              },
              child: Text('Show Banner Here'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }

  void _showNestedSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('SnackBar from nested scaffold'),
        backgroundColor: Colors.indigo,
      ),
    );
  }

  void _showNestedBanner(BuildContext context) {
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        content: Text('Banner from nested scaffold'),
        backgroundColor: Colors.indigo.shade100,
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            },
            child: Text('CLOSE'),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// Additional Demo Components
// ============================================================================

// Custom snackbar factory
class SnackBarFactory {
  SnackBarFactory._();

  static SnackBar success(String message) {
    return SnackBar(
      content: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.white),
          SizedBox(width: 12),
          Expanded(child: Text(message)),
        ],
      ),
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating,
    );
  }

  static SnackBar error(String message) {
    return SnackBar(
      content: Row(
        children: [
          Icon(Icons.error, color: Colors.white),
          SizedBox(width: 12),
          Expanded(child: Text(message)),
        ],
      ),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 5),
    );
  }

  static SnackBar warning(String message) {
    return SnackBar(
      content: Row(
        children: [
          Icon(Icons.warning, color: Colors.black),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.amber,
      behavior: SnackBarBehavior.floating,
    );
  }

  static SnackBar info(String message) {
    return SnackBar(
      content: Row(
        children: [
          Icon(Icons.info, color: Colors.white),
          SizedBox(width: 12),
          Expanded(child: Text(message)),
        ],
      ),
      backgroundColor: Colors.blue,
      behavior: SnackBarBehavior.floating,
    );
  }
}

// Custom banner factory
class BannerFactory {
  BannerFactory._();

  static MaterialBanner success(
    String message,
    VoidCallback onDismiss,
  ) {
    return MaterialBanner(
      content: Text(message),
      backgroundColor: Colors.green.shade100,
      leading: Icon(Icons.check_circle, color: Colors.green),
      actions: [
        TextButton(
          onPressed: onDismiss,
          child: Text('OK'),
        ),
      ],
    );
  }

  static MaterialBanner error(
    String message,
    VoidCallback onDismiss,
    VoidCallback onRetry,
  ) {
    return MaterialBanner(
      content: Text(message),
      backgroundColor: Colors.red.shade100,
      leading: Icon(Icons.error, color: Colors.red),
      actions: [
        TextButton(
          onPressed: onDismiss,
          child: Text('DISMISS'),
        ),
        TextButton(
          onPressed: onRetry,
          child: Text('RETRY'),
        ),
      ],
    );
  }

  static MaterialBanner warning(
    String message,
    VoidCallback onDismiss,
  ) {
    return MaterialBanner(
      content: Text(message),
      backgroundColor: Colors.amber.shade100,
      leading: Icon(Icons.warning, color: Colors.amber.shade800),
      actions: [
        TextButton(
          onPressed: onDismiss,
          child: Text('UNDERSTOOD'),
        ),
      ],
    );
  }
}

// Extension for easier messenger access
extension ScaffoldMessengerExtension on BuildContext {
  ScaffoldMessengerState get messenger => ScaffoldMessenger.of(this);

  void showSuccessSnackBar(String message) {
    messenger.showSnackBar(SnackBarFactory.success(message));
  }

  void showErrorSnackBar(String message) {
    messenger.showSnackBar(SnackBarFactory.error(message));
  }

  void showWarningSnackBar(String message) {
    messenger.showSnackBar(SnackBarFactory.warning(message));
  }

  void showInfoSnackBar(String message) {
    messenger.showSnackBar(SnackBarFactory.info(message));
  }
}

// Demo page using extension methods
class ExtensionDemoPage extends StatelessWidget {
  ExtensionDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Extension Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.showSuccessSnackBar('Operation successful!');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: Text('Success'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.showErrorSnackBar('Something went wrong!');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: Text('Error'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.showWarningSnackBar('Please be careful!');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
              ),
              child: Text('Warning'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.showInfoSnackBar('Here is some information.');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: Text('Info'),
            ),
          ],
        ),
      ),
    );
  }
}

// Global key approach for messenger access
class GlobalMessengerDemo extends StatefulWidget {
  GlobalMessengerDemo({super.key});

  @override
  State<GlobalMessengerDemo> createState() => _GlobalMessengerDemoState();
}

class _GlobalMessengerDemoState extends State<GlobalMessengerDemo> {
  GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: scaffoldMessengerKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Global Key Demo'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Using GlobalKey for messenger access'),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _showViaGlobalKey,
                child: Text('Show via GlobalKey'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showViaGlobalKey() {
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text('Shown via GlobalKey'),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }
}

// SnackBar controller result handling
class ControllerDemoPage extends StatefulWidget {
  ControllerDemoPage({super.key});

  @override
  State<ControllerDemoPage> createState() => _ControllerDemoPageState();
}

class _ControllerDemoPageState extends State<ControllerDemoPage> {
  String closedReason = 'None';
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason>? controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Controller Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Last close reason: $closedReason'),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _showAndTrack,
              child: Text('Show Tracked SnackBar'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _closeManually,
              child: Text('Close Manually'),
            ),
          ],
        ),
      ),
    );
  }

  void _showAndTrack() {
    controller = ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tracked SnackBar'),
        duration: Duration(seconds: 5),
        action: SnackBarAction(
          label: 'ACTION',
          onPressed: () {},
        ),
      ),
    );

    controller?.closed.then((reason) {
      setState(() {
        closedReason = reason.toString();
      });
    });
  }

  void _closeManually() {
    controller?.close();
  }
}

// MaterialBanner controller handling
class BannerControllerDemo extends StatefulWidget {
  BannerControllerDemo({super.key});

  @override
  State<BannerControllerDemo> createState() => _BannerControllerDemoState();
}

class _BannerControllerDemoState extends State<BannerControllerDemo> {
  String bannerStatus = 'No banner shown';
  ScaffoldFeatureController<MaterialBanner, MaterialBannerClosedReason>?
      bannerController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Banner Controller Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Banner status: $bannerStatus'),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _showTrackedBanner,
              child: Text('Show Tracked Banner'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _closeBannerManually,
              child: Text('Close Banner'),
            ),
          ],
        ),
      ),
    );
  }

  void _showTrackedBanner() {
    setState(() {
      bannerStatus = 'Banner showing';
    });

    bannerController = ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        content: Text('Tracked MaterialBanner'),
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            },
            child: Text('DISMISS'),
          ),
        ],
      ),
    );

    bannerController?.closed.then((reason) {
      if (mounted) {
        setState(() {
          bannerStatus = 'Closed: ${reason.toString()}';
        });
      }
    });
  }

  void _closeBannerManually() {
    bannerController?.close();
  }
}

// Snackbar animation customization
class AnimatedSnackBarDemo extends StatelessWidget {
  AnimatedSnackBarDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animated SnackBar'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _showAnimatedSnackBar(context);
              },
              child: Text('Show Animated SnackBar'),
            ),
          ],
        ),
      ),
    );
  }

  void _showAnimatedSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: AnimatedSnackBarContent(),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        duration: Duration(seconds: 4),
      ),
    );
  }
}

// Animated content for snackbar
class AnimatedSnackBarContent extends StatefulWidget {
  AnimatedSnackBarContent({super.key});

  @override
  State<AnimatedSnackBarContent> createState() =>
      _AnimatedSnackBarContentState();
}

class _AnimatedSnackBarContentState extends State<AnimatedSnackBarContent>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? scaleAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    scaleAnimation = CurvedAnimation(
      parent: animationController!,
      curve: Curves.elasticOut,
    );
    animationController?.forward();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scaleAnimation!,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(Icons.celebration, color: Colors.white),
            SizedBox(width: 12),
            Text(
              'Custom animated content!',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

// Theme-aware messenger demo
class ThemeAwareMessengerDemo extends StatelessWidget {
  ThemeAwareMessengerDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Theme Aware Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _showThemedSnackBar(context);
              },
              child: Text('Show Theme-Aware SnackBar'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _showThemedBanner(context);
              },
              child: Text('Show Theme-Aware Banner'),
            ),
          ],
        ),
      ),
    );
  }

  void _showThemedSnackBar(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Theme-aware SnackBar',
          style: TextStyle(color: theme.colorScheme.onPrimary),
        ),
        backgroundColor: theme.colorScheme.primary,
        action: SnackBarAction(
          label: 'ACTION',
          textColor: theme.colorScheme.secondary,
          onPressed: () {},
        ),
      ),
    );
  }

  void _showThemedBanner(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        content: Text(
          'Theme-aware MaterialBanner',
          style: TextStyle(color: theme.colorScheme.onSurface),
        ),
        backgroundColor: theme.colorScheme.surface,
        leading: Icon(
          Icons.palette,
          color: theme.colorScheme.primary,
        ),
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            },
            child: Text('CLOSE'),
          ),
        ],
      ),
    );
  }
}

// Dismiss direction demo
class DismissDirectionDemo extends StatelessWidget {
  DismissDirectionDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dismiss Direction'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _showHorizontalDismiss(context);
              },
              child: Text('Horizontal Dismiss'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _showVerticalDismiss(context);
              },
              child: Text('Down Dismiss'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _showStartToEndDismiss(context);
              },
              child: Text('Start to End Dismiss'),
            ),
          ],
        ),
      ),
    );
  }

  void _showHorizontalDismiss(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Swipe horizontally to dismiss'),
        dismissDirection: DismissDirection.horizontal,
        duration: Duration(seconds: 10),
      ),
    );
  }

  void _showVerticalDismiss(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Swipe down to dismiss'),
        dismissDirection: DismissDirection.down,
        duration: Duration(seconds: 10),
      ),
    );
  }

  void _showStartToEndDismiss(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Swipe start to end to dismiss'),
        dismissDirection: DismissDirection.startToEnd,
        duration: Duration(seconds: 10),
      ),
    );
  }
}

// Programmatic snackbar width control
class WidthConstrainedSnackBar extends StatelessWidget {
  WidthConstrainedSnackBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Width Control'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _showNarrowSnackBar(context);
              },
              child: Text('Show Narrow SnackBar'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _showWideSnackBar(context);
              },
              child: Text('Show Wide SnackBar'),
            ),
          ],
        ),
      ),
    );
  }

  void _showNarrowSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Narrow'),
        behavior: SnackBarBehavior.floating,
        width: 200,
      ),
    );
  }

  void _showWideSnackBar(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Wide SnackBar'),
        behavior: SnackBarBehavior.floating,
        width: screenWidth * 0.9,
      ),
    );
  }
}
