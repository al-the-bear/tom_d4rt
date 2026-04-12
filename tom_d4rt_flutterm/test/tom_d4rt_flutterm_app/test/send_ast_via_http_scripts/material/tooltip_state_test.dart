// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== TooltipState Deep Demo (Harness-Safe) ===');

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: Center(
          child: Tooltip(
            message: 'Preview tooltip',
            child: const Icon(Icons.info_outline),
          ),
        ),
      ),
    ),
  );
}
