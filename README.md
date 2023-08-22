Run `./script.sh` to test Bazel's Java compilation avoidance on a number of test cases with `--experimental_java_classpath=bazel`.

Check the `INFO: 3 processes: 1 internal, 1 linux-sandbox, 1 worker.` line to determine how many targets were rebuilt: Every rebuilt Java target results in one `worker` and one `*-sandbox` action, `disk-cache` indicates actions for which the local action key changed but which still got a cache hit due to `--experimental_java_classpath=bazel`.

Passing in additional arguments such as `--experimental_java_classpath=javabuilder` is supported.
