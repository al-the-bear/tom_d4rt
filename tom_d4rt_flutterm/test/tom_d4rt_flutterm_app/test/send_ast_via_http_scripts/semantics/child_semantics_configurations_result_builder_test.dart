// D4rt test script: Tests ChildSemanticsConfigurationsResultBuilder from semantics
import 'dart:ui';
import 'package:flutter/semantics.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ChildSemanticsConfigurationsResultBuilder comprehensive test executing');
  final results = <String>[];

  // ========== ChildSemanticsConfigurationsResultBuilder Tests ==========
  print('Testing ChildSemanticsConfigurationsResultBuilder...');

  // Test 1: Create ChildSemanticsConfigurationsResultBuilder
  final builder = ChildSemanticsConfigurationsResultBuilder();
  assert(builder != null, 'Should create builder');
  results.add('Builder created');
  print('Builder created: ${builder.runtimeType}');

  // Test 2: Create SemanticsConfiguration to add
  final config1 = SemanticsConfiguration();
  config1.label = 'Button 1';
  config1.isSemanticBoundary = true;
  assert(config1.label == 'Button 1', 'Config label should match');
  results.add('SemanticsConfiguration 1 created');
  print('Config 1 label: ${config1.label}');

  // Test 3: Create second configuration
  final config2 = SemanticsConfiguration();
  config2.label = 'Button 2';
  config2.isSemanticBoundary = true;
  results.add('SemanticsConfiguration 2 created');
  print('Config 2 label: ${config2.label}');

  // Test 4: Create third configuration
  final config3 = SemanticsConfiguration();
  config3.label = 'Text Content';
  config3.isSemanticBoundary = false;
  results.add('SemanticsConfiguration 3 created');
  print('Config 3 label: ${config3.label}');

  // Test 5: markAsMergeUp for merged semantics
  builder.markAsMergeUp(config1);
  results.add('Config 1 marked as mergeUp');
  print('markAsMergeUp called for config 1');

  // Test 6: markAsSiblingMergeGroup for sibling semantics
  builder.markAsSiblingMergeGroup(config2);
  results.add('Config 2 marked as siblingMergeGroup');
  print('markAsSiblingMergeGroup called for config 2');

  // Test 7: Add another to merge up
  builder.markAsMergeUp(config3);
  results.add('Config 3 marked as mergeUp');
  print('markAsMergeUp called for config 3');

  // Test 8: Build the result
  final result = builder.build();
  assert(result != null, 'Build should return result');
  results.add('Result built');
  print('Result built: ${result.runtimeType}');

  // Test 9: Verify result is ChildSemanticsConfigurationsResult
  assert(result is ChildSemanticsConfigurationsResult, 'Should be ChildSemanticsConfigurationsResult');
  results.add('Result type verified');
  print('Is ChildSemanticsConfigurationsResult: ${result is ChildSemanticsConfigurationsResult}');

  // Test 10: Check siblingMergeGroups
  final siblingGroups = result.siblingMergeGroups;
  assert(siblingGroups != null, 'Sibling groups should not be null');
  results.add('Sibling groups retrieved');
  print('Sibling groups count: ${siblingGroups.length}');

  // Test 11: Check mergeUp configurations
  final mergeUpConfigs = result.mergeUp;
  assert(mergeUpConfigs != null, 'MergeUp should not be null');
  results.add('MergeUp configs retrieved');
  print('MergeUp configs count: ${mergeUpConfigs.length}');

  // Test 12: Verify mergeUp contains expected configs
  assert(mergeUpConfigs.length == 2, 'Should have 2 mergeUp configs');
  results.add('MergeUp count: 2');
  print('MergeUp verified: ${mergeUpConfigs.length} configs');

  // Test 13: Verify siblingMergeGroups contains expected
  assert(siblingGroups.length == 1, 'Should have 1 sibling group');
  results.add('Sibling groups count: 1');
  print('Sibling groups verified: ${siblingGroups.length} group(s)');

  // Test 14: Builder pattern - fresh builder
  final builder2 = ChildSemanticsConfigurationsResultBuilder();
  results.add('Second builder created');
  print('Fresh builder created');

  // Test 15: Build empty result
  final emptyResult = builder2.build();
  assert(emptyResult.mergeUp.isEmpty, 'Empty builder mergeUp should be empty');
  assert(emptyResult.siblingMergeGroups.isEmpty, 'Empty builder sibling groups should be empty');
  results.add('Empty result: mergeUp=0, siblings=0');
  print('Empty result: mergeUp=${emptyResult.mergeUp.length}, siblings=${emptyResult.siblingMergeGroups.length}');

  // Test 16: Configuration with actions for builder
  final actionConfig = SemanticsConfiguration();
  actionConfig.label = 'Clickable';
  actionConfig.onTap = () { print('Tapped'); };
  actionConfig.isSemanticBoundary = true;
  results.add('Action config created');
  print('Action config with onTap created');

  // Test 17: Builder with action config
  final builder3 = ChildSemanticsConfigurationsResultBuilder();
  builder3.markAsSiblingMergeGroup(actionConfig);
  final actionResult = builder3.build();
  assert(actionResult.siblingMergeGroups.length == 1, 'Should have action config');
  results.add('Action config added to builder');
  print('Action config in result');

  // Test 18: Semantics boundary config
  final boundaryConfig = SemanticsConfiguration();
  boundaryConfig.isSemanticBoundary = true;
  boundaryConfig.textDirection = TextDirection.ltr;
  boundaryConfig.label = 'Boundary Node';
  results.add('Boundary config: isSemanticBoundary=true');
  print('Boundary config created');

  // Test 19: Complex tree simulation
  final rootConfig = SemanticsConfiguration();
  rootConfig.label = 'Root';
  rootConfig.explicitChildNodes = true;
  results.add('Complex tree: root with explicit children');
  print('Root config with explicitChildNodes');

  // Test 20: Summary
  print('ChildSemanticsConfigurationsResultBuilder test completed with ${results.length} tests');
  results.add('All tests passed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ChildSemanticsConfigurationsResultBuilder Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      Text('Builder pattern for semantics configurations'),
      Text('Methods: markAsMergeUp, markAsSiblingMergeGroup'),
      Text('Result: mergeUp, siblingMergeGroups'),
      Text('Tests passed: ${results.length}'),
    ],
  );
}
