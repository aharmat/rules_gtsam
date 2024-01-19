# rules_gtsam

Rules for building [GTSAM](https://github.com/borglab/gtsam) with bazel. Heavily inspired by [rules_pcl](https://github.com/kgreenek/rules_pcl).


## How to use

In your WORKSPACE file:

```
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "rules_gtsam",
    url = "https://github.com/aharmat/rules_gtsam/archive/gtsam4.3.0pre-v0.tar.gz",
    sha256 = "[TODO SHA for release]",  # TODO(kgk): Update this as a follow-up commit after merging and tagging.
    strip_prefix = "gtsam4.3.0pre-v0",
)

load("@rules_gtsam//bzl:repositories.bzl", "gtsam_repositories")
gtsam_repositories()

# NOTE: This must be loaded after the call to gtsam_repositories().
load("@rules_gtsam//bzl:init_deps.bzl", "gtsam_init_deps")
gtsam_init_deps()
```

In your top-level BUILD.bazel file:

```
load("@rules_gtsam//bzl:gtsam.bzl", "gtsam_config")
load("@rules_gtsam//bzl:gtsam.bzl", "gtsam_dllexport")

gtsam_config()
gtsam_dllexport(library_name="gtsam")
gtsam_dllexport(library_name="gtsam_unstable")
```

C++17 is required. Add the following line to your .bazelrc file:

```
build --cxxopt='-std=c++17'
```

To define a target that depends on GTSAM:

```
cc_binary(
    name = "example",
    srcs = ["main.cc"],
    deps = ["@gtsam"],
)

cc_binary(
    name = "example2",
    srcs = ["main2.cc"],
    deps = ["@gtsam//:gtsam_unstable"],
)
```

Current limitations:
* `TBB` is not supported, so Boost pool is the default allocator
* `Metis` is not supported, so `GTSAM_SUPPORT_NESTED_DISSECTION` is `False`
* `GeographicLib` is not supported, so anything that depends on it will fail to compile
* Tests are not built
* All files that depend on `CppUnitLite` are excluded

IMPORTANT:

The version of gtsam used is the latest on the development branch as of June 20, 2023. This version is a Pre-4.3 release which has some major breaking changes since 4.1. In particular, boost::shared_ptr was replaced with std::shared_ptr throughout the codebase and stdc++17 is required to compile.

If you need gtsam version 4.1.1, use the following rules_gtsam release: `gtsam4.1.1-v0`.
