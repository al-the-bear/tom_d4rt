# Test Priority: foundation

The hand-maintained tiers of the bridged classes, the input of `tool/testplan_report.dart`. Every row names a class the bridges register (the guard `test/testplan_fresh_test.dart` checks it); a bridged class no priority file names is Hardly Relevant. The counts and coverage are measured in the generated `testplan_*.md` files.

## Essential
Core classes used in virtually every Flutter application.

| Class | Description |
|-------|-------------|
| Key | Widget identity - fundamental to Flutter |
| LocalKey | Local widget identity |
| ValueKey | Value-based key |
| UniqueKey | Unique widget key |
| ChangeNotifier | State change notification |
| ValueNotifier | Single value notification |
| Listenable | Base listenable interface |
| ValueListenable | Value listenable interface |

## Important
Commonly used classes for intermediate Flutter development.

| Class | Description |
|-------|-------------|
| FlutterError | Error handling |
| FlutterErrorDetails | Error details |
| ErrorDescription | Error description |
| ErrorHint | Error hints |
| ErrorSummary | Error summary |
| DiagnosticsNode | Debug diagnostics |
| DiagnosticPropertiesBuilder | Building diagnostics |
| BindingBase | Binding base class |
| LicenseEntry | License information |
| LicenseEntryWithLineBreaks | License with formatting |
| LicenseRegistry | License registry |
| LicenseParagraph | License paragraph |

## Secondary
Specialized classes for advanced use cases.

| Class | Description |
|-------|-------------|
| ObserverList | Observer pattern |
| HashedObserverList | Hashed observer list |
| StackFrame | Stack frame info |
| StackFilter | Stack filtering |
| RepetitiveStackFrameFilter | Repetitive frame filter |
| PartialStackFrame | Partial frame info |
| ReadBuffer | Binary reading |
| WriteBuffer | Binary writing |
| SynchronousFuture | Sync future wrapper |
| FlutterTimeline | Timeline events |
| TimedBlock | Timed code block |
| AggregatedTimedBlock | Aggregated timing |
| AggregatedTimings | Timing aggregation |
| PersistentHashMap | Immutable hash map |
| Unicode | Unicode utilities |
| BitField | Bit manipulation |

## Hardly Relevant
Internal/low-level classes rarely used directly.

| Class | Description |
|-------|-------------|
| Category | Internal category |
| DiagnosticsStackTrace | Stack diagnostics |
| DocumentationIcon | Doc icon annotation |
| ErrorSpacer | Error formatting |
| FlutterMemoryAllocations | Memory tracking |
| ObjectCreated | Object lifecycle |
| ObjectDisposed | Object lifecycle |
| ObjectEvent | Object events |
| Summary | Summary annotation |
