/// UserBridge override for `Text` (package:flutter/src/widgets/text.dart).
///
/// CANDIDATE fix for OPEN A.7 / interpreter_unfixable.md §U16: a bridge-built
/// `Text('')` feeds a zero-glyph paragraph into the engine layout, which
/// constructs an `Offset` from a NaN value ("Offset argument contained a NaN
/// value", dart:ui/painting.dart) and — under `IntrinsicHeight` — surfaces as
/// "BoxConstraints forces an infinite height". Native (non-interpreted) Flutter
/// renders `Text('')` cleanly (proven by the control test
/// `tom_d4rt_flutter/test/a7_empty_text_nan_control_test.dart`), so the NaN is a
/// genuine defect in the bridged paragraph path, not in Flutter itself.
///
/// The normalization here replaces a degenerate empty `data` with a zero-width
/// space (`​`) so the paragraph always has at least one glyph to lay out,
/// while staying visually empty (zero advance width). All other named arguments
/// are forwarded byte-for-byte against the generated default-constructor adapter
/// in `widgets_bridges.b.dart`.
///
/// NOTE — this is a CANDIDATE and is INERT until the bridges are regenerated.
/// It MUST be validated against a live render before the script-side workarounds
/// and banner-suppression are removed (see todo_impossible.md #12 and
/// completion_steps.d4rt.md A.7 tail). U19 (per-character non-Latin `TextSpan`
/// NaN) is NOT addressed here — a `Text`-level override cannot reach a
/// `RichText`/`TextSpan` tree; that needs `TextSpan`/`RichText` normalization.
///
/// `textScaleFactor` is forwarded as-is to match the generated bridge adapter,
/// which keeps the same deprecated parameter for API parity.
// ignore_for_file: deprecated_member_use
library;

import 'package:flutter/widgets.dart' as widgets;
import 'package:tom_d4rt_ast/d4rt.dart';

/// Overrides the `Text('')` default constructor to normalize a degenerate
/// empty string into a zero-width space, sidestepping the bridged
/// zero-glyph-paragraph NaN layout (OPEN A.7 / §U16).
@D4rtUserBridge('package:flutter/src/widgets/text.dart', 'Text')
class TextUserBridge extends D4UserBridge {
  /// Sentinel substituted for an empty `data` so the engine always lays out at
  /// least one (zero-advance) glyph. Visually identical to `''`.
  static const String _emptyTextSentinel = '​';

  /// Override the default `Text` constructor. Mirrors the generated
  /// default-constructor adapter exactly, with the sole change that an empty
  /// `data` is normalized to [_emptyTextSentinel].
  static Object? overrideConstructor(
    Object? visitor,
    List<Object?> positional,
    Map<String, Object?> named,
  ) {
    D4.requireMinArgs(positional, 1, 'Text');
    final data = D4.getRequiredArg<String>(positional, 0, 'data', 'Text');
    final key = D4.getOptionalNamedArg<widgets.Key?>(named, 'key');
    final style = D4.getOptionalNamedArg<widgets.TextStyle?>(named, 'style');
    final strutStyle =
        D4.getOptionalNamedArg<widgets.StrutStyle?>(named, 'strutStyle');
    final textAlign =
        D4.getOptionalNamedArg<widgets.TextAlign?>(named, 'textAlign');
    final textDirection =
        D4.getOptionalNamedArg<widgets.TextDirection?>(named, 'textDirection');
    final locale = D4.getOptionalNamedArg<widgets.Locale?>(named, 'locale');
    final softWrap = D4.getOptionalNamedArg<bool?>(named, 'softWrap');
    final overflow =
        D4.getOptionalNamedArg<widgets.TextOverflow?>(named, 'overflow');
    final textScaleFactor =
        D4.getOptionalNamedArg<double?>(named, 'textScaleFactor');
    final textScaler =
        D4.getOptionalNamedArg<widgets.TextScaler?>(named, 'textScaler');
    final maxLines = D4.getOptionalNamedArg<int?>(named, 'maxLines');
    final semanticsLabel =
        D4.getOptionalNamedArg<String?>(named, 'semanticsLabel');
    final semanticsIdentifier =
        D4.getOptionalNamedArg<String?>(named, 'semanticsIdentifier');
    final textWidthBasis =
        D4.getOptionalNamedArg<widgets.TextWidthBasis?>(named, 'textWidthBasis');
    final textHeightBehavior = D4.getOptionalNamedArg<widgets.TextHeightBehavior?>(
        named, 'textHeightBehavior');
    final selectionColor =
        D4.getOptionalNamedArg<widgets.Color?>(named, 'selectionColor');
    return widgets.Text(
      data.isEmpty ? _emptyTextSentinel : data,
      key: key,
      style: style,
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textScaleFactor: textScaleFactor,
      textScaler: textScaler,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      semanticsIdentifier: semanticsIdentifier,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      selectionColor: selectionColor,
    );
  }
}
