/// Stdio capture where `dart:io` is not available (the web): `print` is
/// still captured through the Zone's print handler; there is no `stdout` /
/// `stderr` to redirect, so the Zone is returned unchanged.
///
/// This file is mirrored between `tom_d4rt` (lib/src/) and `tom_d4rt_ast`
/// (lib/src/runtime/); keep the two identical.
library;

import 'dart:async';

/// Returns [zone]: without `dart:io` nothing else writes to stdio.
Zone forkStdioCapture(
  Zone zone, {
  required void Function(String text) out,
  required void Function(String text) err,
  required bool echo,
}) => zone;
