_GTSAM_CONFIG_H_TEMPLATE = "@gtsam//:gtsam/config.h.in"
_GTSAM_DLLEXPORT_H_TEMPLATE = "@gtsam//:cmake/dllexport.h.in"

def _cmakedefine_substitutions(*args):
    substitutions = {}
    for (cmakedefine_str, enabled) in args:
        full_cmakedefine_str = "#cmakedefine {}".format(cmakedefine_str)
        if enabled:
            substitutions[full_cmakedefine_str] = "#define {}".format(cmakedefine_str)
        else:
            substitutions[full_cmakedefine_str] = "/* #undef {} */".format(
                cmakedefine_str.split(" ")[0],
            )
    return substitutions

def _gen_gtsam_config_impl(ctx):
    version_numeric = 10000 * ctx.attr.version_major + 100 * ctx.attr.version_minor + ctx.attr.version_patch
    version_pretty_str = "{}.{}.{}".format(
        ctx.attr.version_major,
        ctx.attr.version_minor,
        ctx.attr.version_patch,
    )
    substitutions = {
        "@GTSAM_VERSION_MAJOR@": "{}".format(ctx.attr.version_major),
        "@GTSAM_VERSION_MINOR@": "{}".format(ctx.attr.version_minor),
        "@GTSAM_VERSION_PATCH@": "{}".format(ctx.attr.version_patch),
        "@GTSAM_VERSION_NUMERIC@": "{}".format(version_numeric),
        "@GTSAM_VERSION_STRING@": version_pretty_str,
    }
    substitutions.update(
        _cmakedefine_substitutions(
            ("GTSAM_USE_QUATERNIONS", False),
            ("GTSAM_POSE3_EXPMAP", True),
            ("GTSAM_ROT3_EXPMAP", True),
            ("GTSAM_USE_TBB", False),  # TODO(aharmat): Figure out best way to use TBB
            ("TBB_GREATER_EQUAL_2020", False),
            ("GTSAM_USE_SYSTEM_EIGEN", False),
            ("GTSAM_USE_EIGEN_MKL_OPENMP", False),  # Put this first so substituations doesn't mess up with next line
            ("GTSAM_USE_EIGEN_MKL", False),
            ("EIGEN_USE_MKL_ALL", False),
            # Undefine these because they have no use in a bazel-compiled GTSAM
            ("GTSAM_EIGEN_VERSION_WORLD @GTSAM_EIGEN_VERSION_WORLD@", False),
            ("GTSAM_EIGEN_VERSION_MAJOR @GTSAM_EIGEN_VERSION_MAJOR@", False),
            ("GTSAM_EIGEN_VERSION_MINOR @GTSAM_EIGEN_VERSION_MINOR@", False),
            ("GTSAM_ALLOCATOR_BOOSTPOOL", True),
            ("GTSAM_ALLOCATOR_TBB", False),
            ("GTSAM_ALLOCATOR_STL", False),
            ("GTSAM_THROW_CHEIRALITY_EXCEPTION", True),
            ("GTSAM_ALLOW_DEPRECATED_SINCE_V41", True),
            ("GTSAM_SUPPORT_NESTED_DISSECTION", False),
            ("GTSAM_TANGENT_PREINTEGRATION", True),
            ("GTSAM_USE_SYSTEM_METIS", False),
            ("GTSAM_SLOW_BUT_CORRECT_BETWEENFACTOR", False),
        ),
    )
    ctx.actions.expand_template(
        template = ctx.file._template,
        substitutions = substitutions,
        output = ctx.outputs.gtsam_config_hdr,
    )

def _gen_gtsam_dllexport_impl(ctx):
    out = ctx.actions.declare_file(ctx.attr.library_name + "/dllexport.h")
    substitutions = {
        "@library_name@": ctx.attr.library_name.upper(),
    }
    substitutions.update(
        _cmakedefine_substitutions(
            ("BUILD_SHARED_LIBS", True),
        ),
    )
    ctx.actions.expand_template(
        template = ctx.file._template,
        substitutions = substitutions,
        output = out,
    )

    return [DefaultInfo(files = depset([out]))]

gen_gtsam_config = rule(
    implementation = _gen_gtsam_config_impl,
    attrs = {
        "version_major": attr.int(default = 4),
        "version_minor": attr.int(default = 1),
        "version_patch": attr.int(default = 1),
        "_template": attr.label(
            default = Label(_GTSAM_CONFIG_H_TEMPLATE),
            allow_single_file = True,
        ),
    },
    outputs = {"gtsam_config_hdr": "config.h"},
)

gen_gtsam_dllexport = rule(
    implementation = _gen_gtsam_dllexport_impl,
    attrs = {
        "library_name": attr.string(default = "gtsam"),
        "_template": attr.label(
            default = Label(_GTSAM_DLLEXPORT_H_TEMPLATE),
            allow_single_file = True,
        ),
    },
)

def gtsam_config(**kwargs):
    gen_gtsam_config(
        name = "__gtsam_gen_gtsam_config",
        **kwargs
    )
    native.cc_library(
        name = "gtsam_config",
        hdrs = [":__gtsam_gen_gtsam_config"],
        include_prefix = "gtsam",
        visibility = ["//visibility:public"],
    )

def gtsam_dllexport(**kwargs):
    library_name = kwargs.get("library_name", "gtsam")

    gen_gtsam_dllexport(
        name = "__gtsam_gen_" + library_name + "_dllexport",
        **kwargs
    )

    native.cc_library(
        name = library_name + "_dllexport",
        hdrs = [":__gtsam_gen_" + library_name + "_dllexport"],
        # The next two lines are a bit silly, but without it #include <gtsam/dllexport.h> and
        # #include <gtsam_unstable/dllexport.h> can't be used, because bazel is expecting the
        # quote includes instead of angle brackets. With the next two lines, gtsam and gtsam_unstable
        # are added to the system path, so the angle bracket includes work.
        strip_include_prefix = library_name,
        include_prefix = library_name,
        visibility = ["//visibility:public"],
    )
