// Reproduces A.8 — private SDK view types are unreachable.
//
// `ByteData.view(...)` returns a runtime `_ByteDataView`, a private SDK type
// with no bridge mapping. Member access on it (`lengthInBytes`) is undefined
// because the private type cannot be named or registered.
//
// ignore_for_file: avoid_print

import 'dart:typed_data';

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  final byteData = ByteData.view(Uint8List(8).buffer);
  final length = byteData.lengthInBytes;
  return Center(child: Text('$length'));
}
