load(
    "@rules_cc//cc:action_names.bzl",
    "ACTION_NAMES",
    "ACTION_NAME_GROUPS",
)
load(
    "@rules_cc//cc:cc_toolchain_config_lib.bzl",
    "FeatureInfo",
    "action_config",
    "artifact_name_pattern",
    "env_entry",
    "env_set",
    "feature",
    "tool",
    "tool_path",
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

def _create_artifact_name_patterns(ctx):
    artifact_name_patterns = []
    if ctx.attr.dynamic_library_extension:
        artifact_name_pattern(
            category_name = "dynamic_library",
            prefix = "lib",
            extension = ctx.attr.dynamic_library_extension,
        )

        artifact_name_patterns = [
            artifact_name_pattern(
                category_name = "dynamic_library",
                prefix = "lib",
                extension = ctx.attr.dynamic_library_extension,
            ),
        ]

    return artifact_name_patterns

def _cc_toolchain_config_impl(ctx):
    action_configs = [action_config(
        action_name = action,
        enabled = True,
        tools = [
            tool(ctx.attr.tool_paths["ld"]),
        ],
        implies = [
        ],
    ) for action in ACTION_NAME_GROUPS.all_cc_link_actions]

    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        host_system_name = "local",
        target_system_name = ctx.attr.target_system_name,
        target_cpu = ctx.attr.target_cpu,
        target_libc = ctx.attr.target_libc,
        artifact_name_patterns = _create_artifact_name_patterns(ctx),
        toolchain_identifier = "aarch64_linux_clang_id",
        compiler = "clang",
        abi_version = "unknown",
        abi_libc_version = "unknown",
        tool_paths = [
            tool_path(name = name, path = path)
            for name, path in ctx.attr.tool_paths.items()
        ],
        features = [
            label[FeatureInfo]
            for label in ctx.attr.compiler_features
        ] + [_label_to_tool_path_feature({
            "gcc": ctx.file.c_compiler,
            "cpp": ctx.file.cc_compiler,
            "ld": ctx.file.linker,
            "ar": ctx.file.archiver,
            "in": ctx.file.install_name,
        })],
    )

cc_toolchain_config = rule(
    implementation = _cc_toolchain_config_impl,
    attrs = {
        "target_system_name": attr.string(
            doc = "Target system name.",
            mandatory = True,
        ),
        "target_cpu": attr.string(
            doc = "Target CPU name.",
            mandatory = True,
        ),
        "target_libc": attr.string(
            doc = "Target libc.",
            mandatory = False,
            default = "unknown",
        ),
        "dynamic_library_extension": attr.string(
            doc = "Dynamic library extension.",
            mandatory = False,
            default = "",
        ),
        "tool_paths": attr.string_dict(
            default = {
                "gcc": "wrappers/linux/gcc",
                "cpp": "wrappers/linux/cpp",
                "ld": "wrappers/linux/ld",
                "ar": "wrappers/linux/ar",
                "gcov": "wrappers/linux/idle",
                "llvm-cov": "wrappers/linux/idle",
                "nm": "wrappers/linux/idle",
                "objdump": "wrappers/linux/idle",
                "strip": "wrappers/linux/idle",
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
        "archiver": attr.label(
            doc = "The archiver e.g. ar/llvm-ar. Maps to tool path 'ar'.",
            allow_single_file = True,
            mandatory = True,
        ),
        "install_name": attr.label(
            doc = "The install name tool for macOS e.g. install_name_tool/llvm-install-name-tool. Maps to tool path 'nmt'.",
            allow_single_file = True,
            mandatory = False,
        ),
    },
    provides = [CcToolchainConfigInfo],
)
