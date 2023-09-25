load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
http_archive(
    name = "bazel_jdt_java_toolchain",
    urls = [
        "https://github.com/salesforce/bazel-jdt-java-toolchain/releases/download/0.1.9/rules_jdt-0.1.9.tar.gz",
    ],
    sha256 = "e36506597dc57192115ad2a554c4c11734052cafb6364f630d314231e15d5f69",
)
load("@bazel_jdt_java_toolchain//jdt:repositories.bzl", "rules_jdt_dependencies", "rules_jdt_toolchains")
rules_jdt_dependencies()
rules_jdt_toolchains()
