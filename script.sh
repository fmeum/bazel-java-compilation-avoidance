#!/usr/bin/env sh

set -eu

git reset --hard

rm -rf disk_cache
"${BAZEL:-bazel}" --nohome_rc --nosystem_rc clean --expunge
"${BAZEL:-bazel}" --nohome_rc --nosystem_rc shutdown

"${BAZEL:-bazel}" --nohome_rc --nosystem_rc run //:main --disk_cache=$(pwd)/disk_cache "$@"

time=$(date +%s%3N)

run_bazel_with_patch()
{
  PATCH_FILE=$1
  shift;
  git apply "patches/$PATCH_FILE.patch"
  "${BAZEL:-bazel}" --nohome_rc --nosystem_rc run //:main --disk_cache=$(pwd)/disk_cache --verbose_explanations --explain=patches/$PATCH_FILE.explain.log "$@"
  git reset --hard
}


echo "=================================================="
echo "patch: $1  "
echo "=================================================="
run_bazel_with_patch $@


