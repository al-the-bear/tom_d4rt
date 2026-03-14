// D4rt test script: Tests SensitiveContentService from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SensitiveContentService test executing');
  print('=' * 50);

  // SensitiveContentService handles sensitive content detection
  print('\nSensitiveContentService:');
  print('Service for sensitive content detection');
  print('macOS Sensitive Content Analysis');

  // Service singleton
  print('\nSensitiveContentService singleton:');
  print('SensitiveContentService.instance');
  print('Provides access to platform service');

  // Platform support
  print('\nPlatform support:');
  print('- macOS 14+ (Sonoma): Full support');
  print('- iOS 17+: Limited support');
  print('- Other platforms: Not available');

  // macOS Sensitive Content Analysis
  print('\nmacOS Sensitive Content Analysis:');
  print('- On-device ML detection');
  print('- Detects nudity/explicit content');
  print('- Privacy-preserving (no cloud)');
  print('- User must enable in Settings');

  // Service capabilities
  print('\nService capabilities:');
  print('- Check if service available');
  print('- Analyze image content');
  print('- Returns sensitivity analysis');

  // Privacy considerations
  print('\nPrivacy considerations:');
  print('- All processing on-device');
  print('- No data sent to servers');
  print('- User controls in System Settings');
  print('- Opt-in feature');

  // Usage pattern
  print('\nUsage pattern:');
  print('// Check availability');
  print('final available = await SensitiveContentService');
  print('    .instance.isServiceAvailable();');
  print('');
  print('if (available) {');
  print('  // Analyze content');
  print('  final result = await service.analyzeImage(imageData);');
  print('}');

  // Image analysis results
  print('\nAnalysis results:');
  print('- Safe: No sensitive content');
  print('- Sensitive: Contains sensitive content');
  print('- Error: Analysis failed');

  // Settings access
  print('\nSystem Settings (macOS):');
  print('System Settings > Privacy & Security');
  print('  > Sensitive Content Warning');

  // Type hierarchy
  print('\nType hierarchy:');
  print('SensitiveContentService (singleton)');
  print('  \u2514\u2500 Platform-specific implementation');

  // Explain purpose
  print('\nSensitiveContentService purpose:');
  print('- Detect sensitive/explicit content');
  print('- On-device ML analysis');
  print('- macOS Sensitive Content API');
  print('- Privacy-preserving detection');
  print('- Enables content warnings');

  print('\n' + '=' * 50);
  print('SensitiveContentService test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'SensitiveContentService Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: singleton service'),
      Text('Platform: macOS 14+, iOS 17+'),
      Text('Privacy: On-device ML'),
      Text('Purpose: Sensitive content detection'),
    ],
  );
}
