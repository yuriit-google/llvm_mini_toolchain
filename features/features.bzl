# MIT License
#
# Copyright (c) 2024 Google LLC
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

load(
    "@llvm_mini_toolchain//features:cc_toolchain_import.bzl",
    "CcToolchainImportInfo",
)
load(
    "@rules_cc//cc:action_names.bzl",
    "ACTION_NAMES",
    "ACTION_NAME_GROUPS",
    "ALL_CC_COMPILE_ACTION_NAMES",
    "ALL_CPP_COMPILE_ACTION_NAMES",
    "CC_LINK_EXECUTABLE_ACTION_NAMES",
    "DYNAMIC_LIBRARY_LINK_ACTION_NAMES",
)
load(
    "@rules_cc//cc:cc_toolchain_config_lib.bzl",
    "FeatureInfo",
    "feature",
    "flag_group",
    "flag_set",
    _feature = "feature",
)

def _cc_feature_impl(ctx):
    flag_sets = []
    if ctx.attr.cc_flags:
        flag_sets.append(flag_set(
            actions = ALL_CPP_COMPILE_ACTION_NAMES,
            flag_groups = [flag_group(flags = ctx.attr.cc_flags)],
        ))
    if ctx.attr.c_flags:
        flag_sets.append(flag_set(
            actions = [
                ACTION_NAMES.c_compile,
            ],
            flag_groups = [flag_group(flags = ctx.attr.c_flags)],
        ))
    if ctx.attr.compiler_flags:
        flag_sets.append(flag_set(
            actions = ALL_CC_COMPILE_ACTION_NAMES,
            flag_groups = [flag_group(flags = ctx.attr.compiler_flags)],
        ))
    if ctx.attr.linker_flags:
        flag_sets.append(flag_set(
            actions = ACTION_NAME_GROUPS.all_cc_link_actions,
            flag_groups = [flag_group(flags = ctx.attr.linker_flags)],
        ))
    return [
        feature(
            name = ctx.label.name,
            enabled = ctx.attr.enabled,
            provides = ctx.attr.provides,
            implies = [target.label.name for target in ctx.attr.implies],
            flag_sets = flag_sets,
        ),
    ]

cc_feature = rule(
    _cc_feature_impl,
    attrs = {
        "enabled": attr.bool(
            default = False,
            doc = "This feature should be enabled by default",
        ),
        "provides": attr.string_list(
            default = [],
            doc = "Unique key for which only one provider of a functionality \
can be enabled any given time.",
        ),
        "implies": attr.label_list(
            default = [],
            doc = "Other features that are automatically enabled with this \
feature.",
        ),
        "cc_flags": attr.string_list(
            default = [],
            doc = "The list of flags to apply when compiling c++ files.",
        ),
        "c_flags": attr.string_list(
            default = [],
            doc = "The list of flags to apply when compiling c files.",
        ),
        "compiler_flags": attr.string_list(
            default = [],
            doc = "The list of flags to pass to the compiler regardless of if\
the target is a C or C++ library.",
        ),
        "linker_flags": attr.string_list(
            default = [],
            doc = "The list of flags to apply when linking",
        ),
    },
    provides = [FeatureInfo],
)

def _file_to_library_flag(file):
    lib_prefix = "lib"
    if file.basename.startswith(lib_prefix):
        library_name = file.basename.replace("." + file.extension, "")
        library_flag = "-l" + library_name[len(lib_prefix):]
    else:
        library_flag = file.path

    return library_flag

LIB_EXCLUDE_CRT_OBJS = ["crt1.o", "Scrt1.o", "gcrt1.o", "Mcrt1.o"]

def _filter_for_shared_obj(flags):
    libFlags = []
    for flag in flags:
        needed = True
        for crtObj in LIB_EXCLUDE_CRT_OBJS:
            if crtObj in flag:
                needed = False
                break

        if needed:
            libFlags.append(flag)

    return libFlags

def _import_feature_impl(ctx):
    toolchain_import_info = ctx.attr.toolchain_import[CcToolchainImportInfo]

    include_flags = [
        "-isystem" + inc
        for inc in toolchain_import_info
            .compilation_context.includes.to_list()
    ]

    injected_include_flags = [
        "-include " + hdr.path
        for hdr in toolchain_import_info
            .compilation_context
            .injected_headers
            .to_list()
    ]

    linker_runtime_path_flags = depset([
        "-Wl,-rpath," + path
        for path in toolchain_import_info
            .linking_context.runtime_paths.to_list()
    ]).to_list()

    linker_dir_flags = depset([
        "-L" + file.dirname
        for file in toolchain_import_info
            .linking_context.static_libraries.to_list()
    ] + [
        "-L" + file.dirname
        for file in toolchain_import_info
            .linking_context.dynamic_libraries.to_list()
    ] + [
        "-L" + file.dirname
        for file in toolchain_import_info
            .linking_context.additional_libs.to_list()
    ]).to_list()

    linker_flags = depset([
        _file_to_library_flag(file)
        for file in toolchain_import_info
            .linking_context.static_libraries.to_list()
    ] + [
        _file_to_library_flag(file)
        for file in toolchain_import_info
            .linking_context.dynamic_libraries.to_list()
    ]).to_list()

    flag_sets = []
    if include_flags:
        flag_sets.append(flag_set(
            actions = ALL_CC_COMPILE_ACTION_NAMES,
            flag_groups = [
                flag_group(
                    flags = include_flags,
                ),
            ],
        ))
    if injected_include_flags:
        flag_sets.append(flag_set(
            actions = ALL_CC_COMPILE_ACTION_NAMES,
            flag_groups = [
                flag_group(
                    flags = injected_include_flags,
                ),
            ],
        ))

    if linker_dir_flags or linker_flags or linker_runtime_path_flags:
        flag_sets.append(flag_set(
            actions = CC_LINK_EXECUTABLE_ACTION_NAMES,
            flag_groups = [
                flag_group(
                    flags = linker_dir_flags +
                            linker_flags +
                            linker_runtime_path_flags,
                ),
            ],
        ))

    linker_flags_for_shared_obj = depset(_filter_for_shared_obj([
        _file_to_library_flag(file)
        for file in toolchain_import_info
            .linking_context.static_libraries.to_list()
    ]) + [
        _file_to_library_flag(file)
        for file in toolchain_import_info
            .linking_context.dynamic_libraries.to_list()
    ]).to_list()

    if linker_dir_flags or linker_flags_for_shared_obj:
        flag_sets.append(flag_set(
            actions = [ACTION_NAMES.cpp_link_dynamic_library],
            flag_groups = [
                flag_group(
                    flags = linker_dir_flags +
                            linker_flags_for_shared_obj,
                ),
            ],
        ))

    library_feature = _feature(
        name = ctx.label.name,
        enabled = ctx.attr.enabled,
        flag_sets = flag_sets,
        implies = ctx.attr.implies,
        provides = ctx.attr.provides,
    )
    return [library_feature, ctx.attr.toolchain_import[DefaultInfo]]

cc_toolchain_import_feature = rule(
    _import_feature_impl,
    attrs = {
        "enabled": attr.bool(default = False),
        "provides": attr.string_list(),
        "requires": attr.string_list(),
        "implies": attr.string_list(),
        "toolchain_import": attr.label(providers = [CcToolchainImportInfo]),
    },
    provides = [FeatureInfo, DefaultInfo],
)

def _sysroot_feature(ctx):
    return _feature(
        name = ctx.label.name,
        enabled = ctx.attr.enabled,
        provides = ctx.attr.provides,
        implies = ["sysroot"] + [label.name for label in ctx.attr.implies],
        flag_sets = [
            flag_set(
                actions = CC_LINK_EXECUTABLE_ACTION_NAMES +
                          DYNAMIC_LIBRARY_LINK_ACTION_NAMES +
                          ALL_CC_COMPILE_ACTION_NAMES,
                flag_groups = [
                    flag_group(
                        flags = [
                            "--sysroot",
                            ctx.attr.sysroot.label.workspace_root,
                        ],
                    ),
                    flag_group(
                        flags = [
                            "--target=" + ctx.attr.target,
                        ],
                    ),
                ],
            ),
        ],
    )

cc_toolchain_sysroot_feature = rule(
    _sysroot_feature,
    attrs = {
        "enabled": attr.bool(default = False),
        "provides": attr.string_list(),
        "requires": attr.string_list(),
        "implies": attr.string_list(),
        "sysroot": attr.label(mandatory = True),
        "target": attr.string(mandatory = True),
    },
    provides = [FeatureInfo],
)
