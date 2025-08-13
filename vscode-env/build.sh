#!/usr/bin/env bash
set -euo pipefail

# ---- add this block ----
if [[ $# -ne 1 ]]; then
  echo "Usage: ./build.sh <path-to-file.c|path-to-file.cpp>" >&2
  exit 2
fi
# ------------------------

FILE="$1"
EXT="${FILE##*.}"
NAME="$(basename "${FILE%.*}")"

CC="/usr/bin/clang"
CXX="/usr/bin/clang++"

mkdir -p build/c build/cpp
rm -f "build/c/${NAME}" "build/cpp/${NAME}"

if [[ "${EXT}" == "c" ]]; then
  "${CC}" -g "${FILE}" -o "build/c/${NAME}"
elif [[ "${EXT}" == "cpp" ]]; then
  "${CXX}" -g "${FILE}" -o "build/cpp/${NAME}"
else
  echo "Unsupported file extension: ${EXT}" >&2
  exit 1
fi
