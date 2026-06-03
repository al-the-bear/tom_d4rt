// Stopwatch with lap history — entry #2 from doc/example_app_plan.md.
//
// Digital stopwatch counting at 10 ms resolution, Start / Stop / Reset
// buttons, plus a Lap button that appends to a scrolling history list.
// The current elapsed time pulses gently via an `AnimationController`
// while the stopwatch is running.
import 'package:flutter/material.dart';

import 'app.dart';

Widget build(BuildContext context) {
  return const StopwatchApp();
}
