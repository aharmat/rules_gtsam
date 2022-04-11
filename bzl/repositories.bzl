load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def gtsam_repositories():
    maybe(
        http_archive,
        name = "com_github_nelhage_rules_boost",
        sha256 = "b64e6f7e96c5b0d7ebcb74c5ee29ab879b8ef8c37581ed0be5ff6c23168da985",
        strip_prefix = "rules_boost-ed844db5990d21b75dc3553c057069f324b3916b",
        urls = ["https://github.com/nelhage/rules_boost/archive/ed844db5990d21b75dc3553c057069f324b3916b.tar.gz"],
    )

    maybe(
        http_archive,
        name = "eigen",
        build_file = "@rules_gtsam//third_party:eigen.BUILD",
        sha256 = "8586084f71f9bde545ee7fa6d00288b264a2b7ac3607b974e54d13e7162c1c72",
        strip_prefix = "eigen-3.4.0",
        urls = ["https://gitlab.com/libeigen/eigen/-/archive/3.4.0/eigen-3.4.0.tar.gz"],
    )

    maybe(
        http_archive,
        name = "gtsam",
        build_file = "@rules_gtsam//third_party:gtsam.BUILD",
        sha256 = "c7b5e6cdad52b141c272778f47baf628975457be3e26ed96a7bc2ae685a00af0",
        strip_prefix = "gtsam-4.1.1",
        urls = ["https://github.com/borglab/gtsam/archive/4.1.1.tar.gz"],
    )
