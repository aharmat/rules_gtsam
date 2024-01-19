"""Macro to load transitive dependencies for gtsam"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def gtsam_repositories():
    # Latest commit as of: June 20, 2023
    maybe(
        http_archive,
        name = "com_github_nelhage_rules_boost",
        sha256 = "8d3b0100de31bfdc8cf3ac2b0ed10a0d87403707fa18cf384a103077655d6cf1",
        strip_prefix = "rules_boost-84d2e305b0bc2dce19af4ddc2a8f76f84af4d3fa",
        urls = ["https://github.com/nelhage/rules_boost/archive/84d2e305b0bc2dce19af4ddc2a8f76f84af4d3fa.tar.gz"],
    )

    maybe(
        http_archive,
        name = "eigen",
        build_file = "@rules_gtsam//third_party:eigen.BUILD",
        sha256 = "8586084f71f9bde545ee7fa6d00288b264a2b7ac3607b974e54d13e7162c1c72",
        strip_prefix = "eigen-3.4.0",
        urls = ["https://gitlab.com/libeigen/eigen/-/archive/3.4.0/eigen-3.4.0.tar.gz"],
    )

    # Latest commit as of: June 20, 2023
    maybe(
        http_archive,
        name = "gtsam",
        build_file = "@rules_gtsam//third_party:gtsam.BUILD",
        sha256 = "b132b65e99bf172eeed7da718aad8be8a23aef9a98cde84de0157942a7e6b3ea",
        strip_prefix = "gtsam-b3635cc6ce8057e04a894870d7ce81e68dd9d707",
        urls = ["https://github.com/borglab/gtsam/archive/b3635cc6ce8057e04a894870d7ce81e68dd9d707.tar.gz"],
    )
