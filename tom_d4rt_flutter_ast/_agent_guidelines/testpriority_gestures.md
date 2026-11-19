# Test Priority: gestures

The hand-maintained tiers of the bridged classes, the input of `tool/testplan_report.dart`. Every row names a class the bridges register (the guard `test/testplan_fresh_test.dart` checks it); a bridged class no priority file names is Hardly Relevant. The counts and coverage are measured in the generated `testplan_*.md` files.

## Essential
Core gesture classes used commonly.

| Class | Description |
|-------|-------------|
| TapDownDetails | Tap down info |
| TapUpDetails | Tap up info |
| DragEndDetails | Drag end info |
| DragUpdateDetails | Drag update info |
| LongPressStartDetails | Long press start |
| LongPressEndDetails | Long press end |
| LongPressMoveUpdateDetails | Long press move |
| ScaleStartDetails | Scale gesture start |
| ScaleUpdateDetails | Scale gesture update |
| ScaleEndDetails | Scale gesture end |

## Important
Commonly used gesture recognizers.

| Class | Description |
|-------|-------------|
| HorizontalDragGestureRecognizer | Horizontal drag |
| VerticalDragGestureRecognizer | Vertical drag |
| PanGestureRecognizer | Pan gesture |
| ScaleGestureRecognizer | Scale/pinch gesture |
| LongPressGestureRecognizer | Long press |
| DoubleTapGestureRecognizer | Double tap |
| ForcePressGestureRecognizer | Force press (3D Touch) |
| ForcePressDetails | Force press info |
| Velocity | Movement velocity |
| GestureBinding | Gesture binding |
| PointerRouter | Event routing |
| HitTestResult | Hit testing result |
| HitTestEntry | Hit test entry |
| HitTestTarget | Hit test target |
| GestureArenaManager | Gesture disambiguation |
| GestureArenaEntry | Arena entry |
| GestureArenaMember | Arena member |
| GestureArenaTeam | Arena team |

## Secondary
Specialized gesture classes.

| Class | Description |
|-------|-------------|
| DragGestureRecognizer | Base drag recognizer |
| MultiDragGestureRecognizer | Multi-pointer drag |
| MultiDragPointerState | Multi-drag state |
| ImmediateMultiDragGestureRecognizer | Immediate multi-drag |
| HorizontalMultiDragGestureRecognizer | Horizontal multi-drag |
| VerticalMultiDragGestureRecognizer | Vertical multi-drag |
| DelayedMultiDragGestureRecognizer | Delayed multi-drag |
| MultiTapGestureRecognizer | Multi-tap |
| TapAndPanGestureRecognizer | Tap and pan |
| TapAndHorizontalDragGestureRecognizer | Tap and horizontal |
| SerialTapGestureRecognizer | Serial taps |
| SerialTapDownDetails | Serial tap down |
| SerialTapUpDetails | Serial tap up |
| SerialTapCancelDetails | Serial tap cancel |
| BaseTapAndDragGestureRecognizer | Base tap+drag |
| TapDragDownDetails | Tap drag down |
| TapDragStartDetails | Tap drag start |
| TapDragUpdateDetails | Tap drag update |
| TapDragEndDetails | Tap drag end |
| TapDragUpDetails | Tap drag up |
| EagerGestureRecognizer | Eager recognizer |
| Drag | Drag callback |
| DeviceGestureSettings | Device settings |
| LongPressDownDetails | Long press down |
| PositionedGestureDetails | Positioned details |

## Hardly Relevant
Internal/low-level classes.

| Class | Description |
|-------|-------------|
| PointerEvent | Base pointer event |
| PointerDownEvent | Pointer down |
| PointerUpEvent | Pointer up |
| PointerCancelEvent | Pointer cancel |
| PointerSignalEvent | Pointer signal |
| PointerPanZoomStartEvent | Pan zoom start |
| PointerEventConverter | Event conversion |
| PointerEventResampler | Event resampling |
| PointerSignalResolver | Signal resolution |
| SamplingClock | Sampling clock |
| LeastSquaresSolver | Math solver |
| PolynomialFit | Polynomial fitting |
| FlutterErrorDetailsForPointerEventDispatcher | Error details |
