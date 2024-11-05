load(
    "@rules_cc//cc:cc_toolchain_config_lib.bzl",
    "FeatureInfo",
    "action_config",
    "env_entry",
    "env_set",
    "feature",
    "tool",
    "tool_path",
)
load(
    "@rules_cc//cc:action_names.bzl",
    "ACTION_NAMES",
    "ACTION_NAME_GROUPS",
)

ALL_ACTIONS = [
    ACTION_NAMES.c_compile,
    ACTION_NAMES.cpp_compile,
    ACTION_NAMES.linkstamp_compile,
    ACTION_NAMES.cc_flags_make_variable,
    ACTION_NAMES.cpp_module_codegen,
    ACTION_NAMES.cpp_header_parsing,
    ACTION_NAMES.cpp_module_compile,
    ACTION_NAMES.assemble,
    ACTION_NAMES.preprocess_assemble,
    ACTION_NAMES.lto_indexing,
    ACTION_NAMES.lto_backend,
    ACTION_NAMES.lto_index_for_executable,
    ACTION_NAMES.lto_index_for_dynamic_library,
    ACTION_NAMES.lto_index_for_nodeps_dynamic_library,
    ACTION_NAMES.cpp_link_executable,
    ACTION_NAMES.cpp_link_dynamic_library,
    ACTION_NAMES.cpp_link_nodeps_dynamic_library,
    ACTION_NAMES.cpp_link_static_library,
    ACTION_NAMES.clif_match,
]

def _label_to_tool_path_feature(tool_mapping = {}):
    """Creates a feature with an env variable pointing to the label.

    Creates an always enabled feature that sets an environment variable in the
    format '<name:capitalised>_TOOL_PATH'. This can then be used by the
    execution wrapper, which has to remain relative to the toolchain
    instantiation.

    Args:
        tool_mapping (Dict[str,File]): A mapping between the tool name and the
            executable file for that tool.
    """
    return feature(
        name = "__tool_paths_as_environment_vars",
        enabled = True,
        env_sets = [env_set(
            actions = ALL_ACTIONS,
            env_entries = [
                env_entry(name.upper() + "_TOOL_PATH", file.path)
                for name, file in tool_mapping.items()
                if file
            ],
        )],
    )

def _cc_toolchain_config_impl(ctx):
    action_configs = [action_config(
        action_name = action,
        enabled = True,
        tools = [
            tool(ctx.attr._tool_paths["ld"]),
        ],
        implies = [
        ],
    ) for action in ACTION_NAME_GROUPS.all_cc_link_actions]

    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        toolchain_identifier = "k8-toolchain",
        host_system_name = "x86_64",
        target_system_name = "x86_64",
        target_cpu = "x86_64",
        target_libc = "unknown",
        compiler = "clang",
        abi_version = "unknown",
        abi_libc_version = "unknown",
        tool_paths = [
            tool_path(name = name, path = path)
            for name, path in ctx.attr._tool_paths.items()
        ],
        features = [
            label[FeatureInfo]
            for label in ctx.attr.compiler_features
        ] + [_label_to_tool_path_feature({
            "gcc": ctx.file.c_compiler,
            "cpp": ctx.file.cc_compiler,
            "ld": ctx.file.linker,
        })],
    )

cc_toolchain_config = rule(
    implementation = _cc_toolchain_config_impl,
    attrs = {
        "_tool_paths": attr.string_dict(
            default = {
                "gcc": "wrappers/posix/gcc",
                "cpp": "wrappers/posix/cpp",
                "ld": "wrappers/posix/ld",
                "ar": "wrappers/posix/idle",
                "gcov": "wrappers/posix/idle",
                "llvm-cov": "wrappers/posix/idle",
                "nm": "wrappers/posix/idle",
                "objdump": "wrappers/posix/idle",
                "strip": "wrappers/posix/idle",
            },
        ),
        "compiler_features": attr.label_list(
            providers = [FeatureInfo],
            doc = "A list of features that are used by the toolchain.",
            mandatory = True,
        ),
        "c_compiler": attr.label(
            doc = "The c compiler e.g. clang/gcc. Maps to tool path 'gcc'.",
            allow_single_file = True,
            mandatory = True,
        ),
        "cc_compiler": attr.label(
            doc = "The c++ compiler e.g. clang/gcc. Maps to tool path 'cpp'.",
            allow_single_file = True,
            mandatory = True,
        ),
        "linker": attr.label(
            doc = "The linker e.g. ld/lld. Maps to tool path 'ld'.",
            allow_single_file = True,
            mandatory = True,
        ),
    },
    provides = [CcToolchainConfigInfo],
)
