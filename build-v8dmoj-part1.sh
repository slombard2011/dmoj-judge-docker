#!/bin/bash

cd "$(dirname "$0")"

DEPOT_TOOLS="$PWD/depot_tools"
if [[ -d "$DEPOT_TOOLS" ]]; then
	(
	 cd "$DEPOT_TOOLS"
	 echo "Syncing depot_tools..."
	 git pull
	)
else
	echo "Cloning depot_tools..."
	git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git "$DEPOT_TOOLS"
fi

PATH="$DEPOT_TOOLS:$PATH"

echo "Fetching v8..."
fetch v8
gclient sync

V8DMOJ="$PWD/v8dmoj"
if [[ -d "$V8DMOJ" ]]; then
	(
	 echo "Syncing v8dmoj..."
	 cd "$V8DMOJ"
	 git pull
	)
else
	echo "Cloning v8dmoj..."
	git clone https://github.com/cuklev/v8dmoj.git -b v8_5.8 "$V8DMOJ"
	cd "$V8DMOJ"
fi

cp "$V8DMOJ/v8dmoj.cc" v8/samples/
mv v8/samples/v8dmoj.cc v8/samples/shell.cc
