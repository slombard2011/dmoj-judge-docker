#!/bin/bash

#V8DMOJ="$PWD/v8dmoj"
#echo "Cloning v8dmoj..."
#git clone https://github.com/cuklev/v8dmoj.git -b v8_5.8 "$V8DMOJ"
#cd "$V8DMOJ"

#cp "$V8DMOJ/v8dmoj.cc" /buildv8/v8/samples/
#mv /buildv8/v8/samples/v8dmoj.cc /buildv8/v8/samples/shell.cc
echo "Building v8_shell..."
cd /buildv8/v8
python /buildv8/v8/tools/dev/v8gen.py x64.release
ninja -C out.gn/x64.release/ v8_shell

V8DMOJ_BIN="$PWD/v8dmoj_bin"
mkdir -p "$V8DMOJ_BIN"
cp v8/out.gn/x64.release/v8_shell "$V8DMOJ_BIN/v8dmoj"
cp v8/out.gn/x64.release/*.bin "$V8DMOJ_BIN"
