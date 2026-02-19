#!/bin/zsh
# Compile dcli binary to ~/.tom/bin/{platform}/
#
# Usage: ./compile.sh
#
# This script:
# 1. Runs dart pub get
# 2. Runs build_runner to regenerate bridges
# 3. Compiles the dcli binary

set -e

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

# Detect platform
case "$(uname -s)" in
    Darwin)
        case "$(uname -m)" in
            arm64) PLATFORM="darwin-arm64" ;;
            x86_64) PLATFORM="darwin-x64" ;;
            *) echo "Unsupported Mac architecture: $(uname -m)"; exit 1 ;;
        esac
        ;;
    Linux)
        case "$(uname -m)" in
            aarch64|arm64) PLATFORM="linux-arm64" ;;
            x86_64) PLATFORM="linux-x64" ;;
            *) echo "Unsupported Linux architecture: $(uname -m)"; exit 1 ;;
        esac
        ;;
    MINGW*|MSYS*|CYGWIN*)
        PLATFORM="win32-x64"
        ;;
    *)
        echo "Unsupported OS: $(uname -s)"
        exit 1
        ;;
esac

# Target directory
TARGET_DIR="$HOME/.tom/bin/$PLATFORM"
OUTPUT="$TARGET_DIR/dcli"

# Ensure target directory exists
mkdir -p "$TARGET_DIR"

echo "=== DCLI Binary Compiler ==="
echo "Platform: $PLATFORM"
echo "Target: $OUTPUT"
echo ""

# Get dependencies
echo "📦 Getting dependencies..."
dart pub get
echo ""

# Delete bridges_trigger.g.dart to force bridge regeneration
echo "🗑️  Removing trigger file to force bridge regeneration..."
rm -f lib/src/d4rt_library_bridges/bridges_trigger.g.dart
echo ""

# Run build_runner to regenerate bridges
echo "🔧 Running build_runner..."
dart run build_runner build --delete-conflicting-outputs
echo ""

# Compile
echo "📦 Compiling dclie..."
if dart compile exe bin/dclie.dart -o "$OUTPUT"; then
    echo "✅ Successfully compiled: $OUTPUT"
else
    echo "❌ Compilation failed"
    exit 1
fi
echo ""

# Check PATH
if [[ ":$PATH:" != *":$TARGET_DIR:"* ]]; then
    echo "⚠️  Warning: $TARGET_DIR is not in your PATH"
    echo ""
    echo "Add this to your ~/.zshrc or ~/.bashrc:"
    echo ""
    echo "  export PATH=\"\$HOME/.tom/bin/$PLATFORM:\$PATH\""
    echo ""
fi

# Show version
echo "Testing binary..."
"$OUTPUT" --version
