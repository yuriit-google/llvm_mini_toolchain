
def _llvm18_archive(repository_context):
    url = repository_context.attr.url
    checksum = repository_context.attr.sha256

llvm18_archive = repository_rule(
    implementation = _llvm18_archive,
    attrs = {
        "url": attr.string(mandatory=True),
        "sha256": attr.string(mandatory=True),

    }
)
