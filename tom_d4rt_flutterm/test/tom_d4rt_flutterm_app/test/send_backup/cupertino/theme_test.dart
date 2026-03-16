import 'package:flutter/cupertino.dart';

/// Deep visual demo for CupertinoTheme - iOS theming system.
/// Demonstrates brightness, primaryColor, scaffoldBackgroundColor, and text styles.
dynamic build(BuildContext context) {
  return CupertinoTheme(
    data: const CupertinoThemeData(
      brightness: Brightness.light,
      primaryColor: CupertinoColors.systemIndigo,
      scaffoldBackgroundColor: CupertinoColors.systemGroupedBackground,
      textTheme: CupertinoTextThemeData(
        navTitleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: CupertinoColors.systemIndigo,
        ),
      ),
    ),
    child: CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('CupertinoTheme Demo'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Builder(
                builder: (ctx) {
                  final theme = CupertinoTheme.of(ctx);
                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: CupertinoColors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: CupertinoColors.systemGrey.withValues(
                            alpha: 0.2,
                          ),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Theme Properties:',
                          style: theme.textTheme.navTitleTextStyle,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: theme.primaryColor,
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text('Primary Color'),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: theme.scaffoldBackgroundColor,
                                border: Border.all(
                                  color: CupertinoColors.systemGrey4,
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text('Scaffold Background'),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Icon(
                              theme.brightness == Brightness.light
                                  ? CupertinoIcons.sun_max_fill
                                  : CupertinoIcons.moon_fill,
                              color: theme.primaryColor,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Brightness: ${theme.brightness?.name ?? 'default'}',
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              CupertinoButton.filled(
                child: const Text('Themed Button'),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
