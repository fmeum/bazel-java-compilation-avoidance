#!/usr/bin/env sh

set -eu

git checkout -- *.java

rm -rf disk_cache
"${BAZEL:-bazel}" --nohome_rc --nosystem_rc clean --expunge
"${BAZEL:-bazel}" --nohome_rc --nosystem_rc shutdown

"${BAZEL:-bazel}" --nohome_rc --nosystem_rc run //:main --disk_cache=$(pwd)/disk_cache "$@"

time=$(date +%s%3N)

echo "=================================================="
echo "Modify the implementation of a private method in A"
echo "Only rebuilds A                                   "
echo "=================================================="
sed -i -e "s/Hello from A\![0-9]*/Hello from A\!$(date +%s%3N)/g" lib/A.java
#"${BAZEL:-bazel}" --nohome_rc --nosystem_rc run //:main --disk_cache=$(pwd)/disk_cache --verbose_explanations --explain=explain-Apriv1.txt "$@"
