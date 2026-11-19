# Test Priority: services

The hand-maintained tiers of the bridged classes, the input of `tool/testplan_report.dart`. Every row names a class the bridges register (the guard `test/testplan_fresh_test.dart` checks it); a bridged class no priority file names is Hardly Relevant. The counts and coverage are measured in the generated `testplan_*.md` files.

## Essential
Core platform service classes.

| Class | Description |
|-------|-------------|
| Clipboard | System clipboard access |
| ClipboardData | Clipboard content |
| SystemChrome | System UI control |
| SystemNavigator | System navigation |
| SystemSound | System sounds |
| HapticFeedback | Vibration feedback |
| AssetBundle | Asset loading |
| MethodChannel | Platform method calls |
| MethodCall | Method invocation |
| TextInputFormatter | Input formatting |
| FilteringTextInputFormatter | Text filtering |
| LengthLimitingTextInputFormatter | Length limits |

## Important
Commonly used service classes.

| Class | Description |
|-------|-------------|
| ServicesBinding | Services binding |
| SystemUiOverlayStyle | Status bar styling |
| BasicMessageChannel | Basic messaging |
| EventChannel | Stream events |
| OptionalMethodChannel | Optional methods |
| StandardMethodCodec | Standard codec |
| StandardMessageCodec | Standard messages |
| JSONMethodCodec | JSON codec |
| JSONMessageCodec | JSON messages |
| BinaryCodec | Binary codec |
| StringCodec | String codec |
| KeyboardInsertedContent | Keyboard content |
| HardwareKeyboard | Keyboard events |
| LogicalKeyboardKey | Logical keys |
| PhysicalKeyboardKey | Physical keys |
| MouseCursor | Mouse cursor |
| SystemMouseCursor | System cursors |
| SystemMouseCursors | Cursor constants |
| TextBoundary | Text boundaries |
| CharacterBoundary | Character bounds |
| LineBoundary | Line bounds |
| ParagraphBoundary | Paragraph bounds |
| DocumentBoundary | Document bounds |
| TextEditingDelta | Editing changes |
| SpellCheckResults | Spell check |

## Secondary
Specialized service classes.

| Class | Description |
|-------|-------------|
| PlatformViewsService | Platform views |
| PlatformViewsRegistry | View registry |
| PlatformViewController | View controller |
| AndroidViewController | Android views |
| UiKitViewController | iOS views |
| AppKitViewController | macOS views |
| SurfaceAndroidViewController | Surface Android |
| TextureAndroidViewController | Texture Android |
| ExpensiveAndroidViewController | Expensive Android |
| HybridAndroidViewController | Hybrid Android |
| DarwinPlatformViewController | Darwin views |
| RestorationManager | State restoration |
| AutofillConfiguration | Autofill config |
| AutofillScope | Autofill scope |
| FontLoader | Font loading |
| AssetManifest | Asset manifest |
| AssetMetadata | Asset metadata |
| PlatformAssetBundle | Platform assets |
| NetworkAssetBundle | Network assets |
| CachingAssetBundle | Cached assets |
| SpellCheckService | Spell checking |
| DefaultSpellCheckService | Default spell check |
| ProcessTextService | Text processing |
| DefaultProcessTextService | Default processing |
| ProcessTextAction | Process action |
| LiveText | Live text |
| UndoManager | Undo system |
| UndoManagerClient | Undo client |
| Scribe | Text scribe |
| PredictiveBackEvent | Predictive back |
| BrowserContextMenu | Browser menu |
| SystemChannels | System channels |
| FlutterVersion | Flutter version |
| SuggestionSpan | Suggestion span |
| TextLayoutMetrics | Text metrics |

## Hardly Relevant
Internal/low-level classes.

| Class | Description |
|-------|-------------|
| BinaryMessenger | Binary messaging |
| MessageCodec | Message codec base |
| MethodCodec | Method codec base |
| MissingPluginException | Plugin error |
| PlatformException | Platform error |
| DeferredComponent | Deferred loading |
| SensitiveContentService | Sensitive content |
| ApplicationSwitcherDescription | App switcher |
| SystemContextMenuClient | Context menu |
| MouseCursorManager | Cursor manager |
| MouseCursorSession | Cursor session |
| MouseTrackerAnnotation | Mouse tracking |
| AndroidMotionEvent | Android motion |
| AndroidPointerCoords | Android coords |
| AndroidPointerProperties | Android properties |
| TextSelection | Text selection |
