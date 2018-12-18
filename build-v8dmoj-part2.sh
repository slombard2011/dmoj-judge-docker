#!/bin/bash

cd "$(dirname "$0")"
DEPOT_TOOLS="$PWD/depot_tools"
PATH="$DEPOT_TOOLS:$PATH"
V8DMOJ="$PWD/v8dmoj"

(
 echo "Building v8_shell..."
 cd v8
 tools/dev/v8gen.py x64.release
 ninja -C out.gn/x64.release/ v8_shell
)

V8DMOJ_BIN="$PWD/v8dmoj_bin"
mkdir -p "$V8DMOJ_BIN"
cp v8/out.gn/x64.release/v8_shell "$V8DMOJ_BIN/v8dmoj"
cp v8/out.gn/x64.release/*.bin "$V8DMOJ_BIN"
