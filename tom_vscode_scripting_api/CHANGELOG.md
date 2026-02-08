## 1.0.1

- Changed license from MIT to BSD-3-Clause.

## 1.0.0

- Initial public release.
- Bridge-agnostic Dart abstractions for the VS Code extension API.
- Core API namespaces: `VSCodeWindow`, `VSCodeWorkspace`, `VSCodeCommands`, `VSCodeExtensions`.
- Language model API (`VSCodeLanguageModel`) for accessing models like GitHub Copilot.
- Chat participant API (`VSCodeChat`) for building chat extensions.
- Socket-based bridge client (`VSCodeBridgeClient`) with JSON-RPC 2.0 communication.
- Convenience script globals (`vscode`, `window`, `workspace`, `commands`, `extensions`, `lm`, `chat`).
- Helper utilities (`VsCodeHelper`) for common VS Code scripting tasks.
