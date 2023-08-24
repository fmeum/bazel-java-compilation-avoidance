#!/usr/bin/env sh

set -eu

git reset --hard

rm -rf disk_cache
"${BAZEL:-bazel}" --nohome_rc --nosystem_rc clean --expunge
"${BAZEL:-bazel}" --nohome_rc --nosystem_rc shutdown

"${BAZEL:-bazel}" --nohome_rc --nosystem_rc run //:main --disk_cache=$(pwd)/disk_cache "$@"

time=$(date +%s%3N)

echo "=================================================="
echo "Modify the implementation of a private method in A"
echo "to use another dependency                         "
echo "                                                  "
echo "expected: Rebuild only A                          "
echo "=================================================="
git apply patches/internal-deps-change.patch
"${BAZEL:-bazel}" --nohome_rc --nosystem_rc run //:main --disk_cache=$(pwd)/disk_cache --verbose_explanations --explain=patches/internal-deps-change.explain.log "$@"
