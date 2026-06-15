# Run the D4rt Flutter sample on Windows desktop.
# Re-bundles the example/ scripts into assets first so edits show up.
$ErrorActionPreference = 'Stop'
Set-Location -Path $PSScriptRoot
dart run tool/sync_samples_to_assets.dart
flutter run -d windows @args
