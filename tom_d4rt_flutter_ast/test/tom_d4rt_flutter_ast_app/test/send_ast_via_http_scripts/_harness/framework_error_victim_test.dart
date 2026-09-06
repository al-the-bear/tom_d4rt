// SCC48 harness probe — the CLEAN counterpart to the offender.
//
// Structurally the same recipe as `framework_error_offender_test.dart`: a
// ListTile with an opaque `tileColor` inside an opaque ColoredBox. The single
// difference is the `Material(type: MaterialType.transparency)` between them,
// which is the documented fix for the advisory and is layout-neutral — so this
// script renders the same pixels while raising nothing.
//
// Keep the `tileColor` in sync with the offender. It is what opens the guard at
// list_tile.dart:832; dropping it here would make the victim clean for the
// wrong reason (check never ran) rather than the right one (Material found
// first), and F-SCC48-3 would then pass without proving anything.
//
// Keeping the two probes near-identical is the point. If the victim ever
// reports a framework error, the cause is the harness attributing someone
// else's error to it, not a difference in what the two scripts draw.
//
// Not part of the behavioural corpus — see the offender probe's header for why
// `_harness/` is skipped by `SendTestRunner.findAllScripts`.
//
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('framework_error_victim: building a clean ListTile');
  return const Center(
    child: SizedBox(
      width: 300,
      child: ColoredBox(
        color: Color(0xFFFFC107),
        child: Material(
          type: MaterialType.transparency,
          child: ListTile(title: Text('victim')),
        ),
      ),
    ),
  );
}
