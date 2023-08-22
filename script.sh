#!/usr/bin/env sh

set -eu

git checkout -- *.java

rm -r disk_cache
bazel --nohome_rc --nosystem_rc clean --expunge
bazel --nohome_rc --nosystem_rc shutdown

bazel --nohome_rc --nosystem_rc run //:main --disk_cache=$(pwd)/disk_cache "$@"

time=$(date +%s%3N)

echo "=================================================="
echo "Modify the implementation of a private method in A"
echo "Only rebuilds A                                   "
echo "=================================================="
sed -i -e "s/Hello from A\![0-9]*/Hello from A\!$(date +%s%3N)/g" A.java
bazel --nohome_rc --nosystem_rc run //:main --disk_cache=$(pwd)/disk_cache "$@"

echo "============================================="
echo "Modify the signature of a private method in A"
echo "Only rebuilds A                              "
echo "============================================="
sed -i -e "s/getPrivate/getPrivate$(date +%s%3N)/g" A.java
bazel --nohome_rc --nosystem_rc run //:main --disk_cache=$(pwd)/disk_cache "$@"

echo "=============================================================="
echo "Modify the signature of a public method in A                  "
echo "Only rebuilds A and B with --experimental_java_classpath=bazel"
echo "Otherwise rebuilds A, B, and C                                "
echo "=============================================================="
suffix=$(date +%s%3N)
sed -i -e "s/getPublic/getPublic${suffix}/g" A.java
sed -i -e "s/A\\.getPublic/A\\.getPublic${suffix}/g" B.java
bazel --nohome_rc --nosystem_rc run //:main --disk_cache=$(pwd)/disk_cache "$@"

echo "================================="
echo "Make the direct dep A of B unused"
echo "Only rebuilds B                  "
echo "================================="
sed -i -e "s/A.getPublic[0-9]*()/\"Inlined Hello from A\"/g" B.java
bazel --nohome_rc --nosystem_rc run //:main --disk_cache=$(pwd)/disk_cache "$@"

echo "================================================================="
echo "Modify the signature of a public method in the (now unused) dep A"
echo "Only rebuilds A and B with --experimental_java_classpath=bazel   "
echo "Otherwise rebuilds A, B, and C                                   "
echo "Would ideally only rebuild A since A wasn't used to compile B    "
echo "================================================================="
sed -i -e "s/getPublic[0-9]*/getPublic$(date +%s%3N)/g" A.java
bazel --nohome_rc --nosystem_rc run //:main --disk_cache=$(pwd)/disk_cache "$@"
