/// UserBridge override for dart:ui StrutStyle.
///
/// The dart:ui StrutStyle is an opaque engine object with no getters.
/// painting.StrutStyle wraps it with full getter support (fontSize, height,
/// fontWeight, etc.). When a D4rt script creates StrutStyle (whether from
/// dart:ui or painting import), we always create the painting version so
/// that property access works. The RC-3 type coercion
/// (painting.StrutStyle → dart:ui.StrutStyle) handles conversion when
/// dart:ui APIs like ParagraphStyle need the engine-level type.
library;

import 'dart:ui' as ui;

import 'package:flutter/painting.dart' as painting;
import 'package:tom_d4rt_exec/tom_d4rt.dart';

/// Overrides the dart:ui StrutStyle default constructor to create
/// painting.StrutStyle instead, providing full getter support for D4rt scripts.
@D4rtUserBridge('dart:ui', 'StrutStyle')
class StrutStyleUserBridge extends D4UserBridge {
  /// Override the default constructor to create painting.StrutStyle.
  ///
  /// painting.StrutStyle has full getter support (fontSize, height, leading,
  /// fontWeight, fontStyle, forceStrutHeight, fontFamily, fontFamilyFallback).
  /// The dart:ui version is an opaque engine object with no getters.
  static Object? overrideConstructor(
    Object? visitor,
    List<Object?> positional,
    Map<String, Object?> named,
  ) {
    return painting.StrutStyle(
      fontFamily:
          D4.extractBridgedArgOrNull<String>(named['fontFamily'], 'fontFamily'),
      fontFamilyFallback: D4.coerceListOrNull<String>(
        named['fontFamilyFallback'],
        'fontFamilyFallback',
      ),
      fontSize:
          D4.extractBridgedArgOrNull<double>(named['fontSize'], 'fontSize'),
      height: D4.extractBridgedArgOrNull<double>(named['height'], 'height'),
      leadingDistribution:
          D4.extractBridgedArgOrNull<ui.TextLeadingDistribution>(
        named['leadingDistribution'],
        'leadingDistribution',
      ),
      leading:
          D4.extractBridgedArgOrNull<double>(named['leading'], 'leading'),
      fontWeight: D4.extractBridgedArgOrNull<ui.FontWeight>(
        named['fontWeight'],
        'fontWeight',
      ),
      fontStyle: D4.extractBridgedArgOrNull<ui.FontStyle>(
        named['fontStyle'],
        'fontStyle',
      ),
      forceStrutHeight: D4.extractBridgedArgOrNull<bool>(
        named['forceStrutHeight'],
        'forceStrutHeight',
      ),
    );
  }
}
