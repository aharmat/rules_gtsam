# Description:
#   Georgia Tech Smoothing and Mapping Library

licenses(["notice"])  # BSD 3-Clause

exports_files(["gtsam/config.h.in"])

exports_files(["cmake/dllexport.h.in"])

GTSAM_TEST_FILES = [
    "gtsam/base/tests/**",
    "gtsam/basis/tests/**",
    "gtsam/discrete/tests/**",
    "gtsam/geometry/tests/**",
    "gtsam/inference/tests/**",
    "gtsam/linear/tests/**",
    "gtsam/navigation/tests/**",
    "gtsam/nonlinear/tests/**",
    "gtsam/sam/tests/**",
    "gtsam/sfm/tests/**",
    "gtsam/slam/tests/**",
    "gtsam/symbolic/tests/**",
]

cc_library(
    name = "gtsam",
    srcs = glob(
        [
            "gtsam/3rdparty/CCOLAMD/Source/ccolamd.c",
            "gtsam/3rdparty/SuiteSparse_config/SuiteSparse_config.c",
            # Nothing uses this, and it has a transitive dependency on CppUnitLite, so let's ignore it
            # "gtsam/precompiled_header.cpp",
            "gtsam/base/**/*.cpp",
            "gtsam/basis/**/*.cpp",
            "gtsam/discrete/**/*.cpp",
            "gtsam/geometry/**/*.cpp",
            "gtsam/inference/**/*.cpp",
            "gtsam/linear/**/*.cpp",
            "gtsam/navigation/**/*.cpp",
            "gtsam/nonlinear/**/*.cpp",
            "gtsam/sam/**/*.cpp",
            "gtsam/sfm/**/*.cpp",
            "gtsam/slam/**/*.cpp",
            "gtsam/symbolic/**/*.cpp",
        ],
        exclude = ["gtsam/slam/serialization.cpp"] + GTSAM_TEST_FILES,
    ),
    hdrs = glob(
        [
            "gtsam/3rdparty/CCOLAMD/Include/ccolamd.h",
            "gtsam/3rdparty/SuiteSparse_config/SuiteSparse_config.h",
            "gtsam/3rdparty/Spectra/**/*.h",
            "gtsam/global_includes.h",
            # Nothing uses this, and it has a transitive dependency on CppUnitLite, so let's ignore it
            # "gtsam/precompiled_header.h",
            "gtsam/base/**/*.h",
            "gtsam/basis/*.h",
            "gtsam/discrete/*.h",
            "gtsam/geometry/*.h",
            "gtsam/inference/**/*.h",
            "gtsam/linear/**/*.h",
            "gtsam/navigation/*.h",
            "gtsam/nonlinear/**/*.h",
            "gtsam/sam/**/*.h",
            "gtsam/sfm/**/*.h",
            "gtsam/slam/**/*.h",
            "gtsam/symbolic/**/*.h",
        ],
        exclude = [
            "gtsam/slam/serialization.h",
            "gtsam/base/chartTesting.h",
            "gtsam/base/testLie.h",
        ] + GTSAM_TEST_FILES,
    ),
    includes = [
        ".",  # allows angle bracket includes used throughout GTSAM
        "gtsam/3rdparty/CCOLAMD/Include",
        "gtsam/3rdparty/Spectra",
        "gtsam/3rdparty/SuiteSparse_config",
    ],
    visibility = ["//visibility:public"],
    deps = [
        "@//:gtsam_config",
        "@//:gtsam_dllexport",
        "@boost//:assign",
        "@boost//:algorithm",
        "@boost//:bimap",
        "@boost//:concept",
	"@boost//:date_time",
        "@boost//:filesystem",
        "@boost//:format",
	"@boost//:graph",
        "@boost//:math",
        "@boost//:pool",
        "@boost//:serialization",
        "@boost//:shared_ptr",
        "@boost//:tokenizer",
        "@boost//:tuple",
        "@boost//:type_traits",
        "@boost//:utility",
        "@eigen",
    ],
)

GTSAM_UNSTABLE_TEST_FILES = [
    "gtsam_unstable/base/tests/**",
    "gtsam_unstable/discrete/tests/**",
    "gtsam_unstable/dynamics/tests/**",
    "gtsam_unstable/geometry/tests/**",
    "gtsam_unstable/linear/tests/**",
    "gtsam_unstable/nonlinear/tests/**",
    "gtsam_unstable/slam/tests/**",
]

cc_library(
    name = "gtsam_unstable",
    srcs = glob(
        [
            "gtsam_unstable/base/**/*.cpp",
            "gtsam_unstable/discrete/**/*.cpp",
            "gtsam_unstable/dynamics/**/*.cpp",
            "gtsam_unstable/geometry/**/*.cpp",
            "gtsam_unstable/linear/**/*.cpp",
            "gtsam_unstable/nonlinear/**/*.cpp",
            "gtsam_unstable/slam/**/*.cpp",
        ],
        exclude = [
            "gtsam_unstable/slam/serialization.cpp",
            "gtsam_unstable/discrete/examples/**/*.cpp"
        ] + GTSAM_UNSTABLE_TEST_FILES,
    ),
    hdrs = glob(
        [
            "gtsam_unstable/base/**/*.h",
            "gtsam_unstable/discrete/*.h",
            "gtsam_unstable/dynamics/*.h",
            "gtsam_unstable/geometry/*.h",
            "gtsam_unstable/linear/**/*.h",
            "gtsam_unstable/nonlinear/**/*.h",
            "gtsam_unstable/slam/**/*.h",
        ],
        exclude = ["gtsam_unstable/slam/serialization.h"] + GTSAM_UNSTABLE_TEST_FILES,
    ),
    includes = [
        ".",  # allows angle bracket includes used throughout GTSAM
    ],
    visibility = ["//visibility:public"],
    deps = [
        ":gtsam",
        "@//:gtsam_config",
        "@//:gtsam_unstable_dllexport",
        "@boost//:assign",
	"@boost//:algorithm",
        "@boost//:bind",
        "@boost//:fusion",
        "@boost//:lambda",
        "@boost//:optional",
        "@boost//:phoenix",
        "@boost//:range",
        "@boost//:serialization",
        "@boost//:shared_ptr",
        "@boost//:spirit",
        "@boost//:tokenizer",
    ],
)
