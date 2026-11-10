# Test Priority: scheduler

The hand-maintained tiers of the bridged classes, the input of `tool/testplan_report.dart`. Every row names a class the bridges register (the guard `test/testplan_fresh_test.dart` checks it); a bridged class no priority file names is Hardly Relevant. The counts and coverage are measured in the generated `testplan_*.md` files.

## Essential
Core classes used in Flutter applications.

| Class | Description |
|-------|-------------|
| TickerProvider | Frame tick provider |
| Ticker | Frame callback ticker |

## Important
Commonly used classes.

| Class | Description |
|-------|-------------|
| SchedulerBinding | Scheduler binding |
| TickerFuture | Ticker completion future |
| TickerCanceled | Ticker cancellation |

## Secondary
Specialized classes.

| Class | Description |
|-------|-------------|
| Priority | Scheduling priority |
| PerformanceModeRequestHandle | Performance mode |

## Hardly Relevant
Internal classes.

| Class | Description |
|-------|-------------|
