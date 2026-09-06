// SCC48 harness probe — DELIBERATELY raises a Flutter framework advisory.
//
// This script is NOT part of the behavioural corpus. It lives under `_harness/`,
// which `SendTestRunner.findAllScripts` skips, precisely because a script that
// is *supposed* to fail would otherwise read as a corpus regression.
//
// It exists to give `framework_error_isolation_test.dart` a reliable source of
// exactly one framework error, so that test can prove two things a passing
// corpus cannot: that the error is attributed to the script that raised it, and
// that it does not survive into the next script's verdict.
//
// The trigger is `ListTile._debugCheckBackgroundIsHidden`
// (flutter/lib/src/material/list_tile.dart:1147). It walks ancestors from the
// ListTile upward and reports if it meets a ColoredBox/DecoratedBox with a
// non-transparent colour BEFORE it meets a Material. So the ColoredBox below
// must sit between the ListTile and the app's Material — adding a Material
// inside the ColoredBox is exactly what silences it (see the victim probe).
//
// The walk is not run unconditionally. Its call site (list_tile.dart:832) is
// guarded by `onTap != null || onLongPress != null || hasOpaqueBackground`, so
// a decoration-free ListTile inside a coloured box reports NOTHING. The
// explicit `tileColor` below is what opens that gate — without it this probe
// is silent and the whole isolation test goes vacuous. Measured 2026-09-06:
// the first draft omitted it and F-SCC48-1 failed with frameworkErrors=0.
//
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('framework_error_offender: building one advisory-raising ListTile');
  return const Center(
    child: SizedBox(
      width: 300,
      child: ColoredBox(
        // Opaque colour + no intervening Material == advisory.
        color: Color(0xFFFFC107),
        child: ListTile(
          // Opaque tileColor: opens the guard at list_tile.dart:832.
          tileColor: Color(0xFFFFFFFF),
          title: Text('offender'),
        ),
      ),
    ),
  );
}
