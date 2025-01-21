"""Provides a set of variables to the template engine."""

load("//tools:rules_cc.bzl", "MYAPP_AUTHOR", "MYAPP_AUTHOR_EMAIL", "MYAPP_DESCRIPTION", "MYAPP_HOMEPAGE", "MYAPP_LICENSE", "MYAPP_NAME", "MYAPP_SOURCE", "MYAPP_TRACKER", "MYAPP_VERSION")

def _make_var_substitution_impl(ctx):
    vars = dict(ctx.attr.variables)

    # Python
    py_runtime = ctx.toolchains[ctx.attr._python_toolchain].py3_runtime
    major = py_runtime.interpreter_version_info.major
    minor = py_runtime.interpreter_version_info.minor
    implementation = py_runtime.implementation_name
    if implementation == "cpython":
        tag = "cp" + str(major) + str(minor)
        vars["PYTHON_ABI_TAG"] = tag
        vars["PYTHON_TAG"] = tag
    else:
        fail("This rule only supports CPython.")

    # myapp
    vars["MYAPP_NAME"] = MYAPP_NAME
    vars["MYAPP_VERSION"] = MYAPP_VERSION
    vars["MYAPP_AUTHOR"] = MYAPP_AUTHOR
    vars["MYAPP_AUTHOR_EMAIL"] = MYAPP_AUTHOR_EMAIL
    vars["MYAPP_DESCRIPTION"] = MYAPP_DESCRIPTION
    vars["MYAPP_HOMEPAGE"] = MYAPP_HOMEPAGE
    vars["MYAPP_LICENSE"] = MYAPP_LICENSE
    vars["MYAPP_SOURCE"] = MYAPP_SOURCE
    vars["MYAPP_TRACKER"] = MYAPP_TRACKER

    return [platform_common.TemplateVariableInfo(vars)]

make_var_substitution = rule(
    implementation = _make_var_substitution_impl,
    attrs = {
        "variables": attr.string_dict(),
        "_python_toolchain": attr.string(default = "@rules_python//python:toolchain_type"),
    },
    doc = """Provides a set of variables to the template engine.
Variables are passed as a dictionary of strings.
The keys are the variable names, and the values are the variable values.

It also comes with a set of default variables that are always available:
- MYAPP_NAME: The name of the myapp library.
- MYAPP_VERSION: The version of the myapp library.
- MYAPP_AUTHOR: The author of the myapp library.
- MYAPP_AUTHOR_EMAIL: The author email of the myapp library.
- MYAPP_DESCRIPTION: The description of the myapp library.
- MYAPP_HOMEPAGE: The homepage of the myapp library.
- MYAPP_LICENSE: The license of the myapp library.
- PYTHON_ABI_TAG: The Python ABI tag (e.g., cp36, cp311).
- PYTHON_TAG: The Python tag (e.g., cp36, cp311).

Example:
```python
make_var_substitution(
    variables = {
        "MY_VARIABLE": "my_value",
    },
)
```

This will make the variable `MY_VARIABLE` available to the template engine.
""",
    toolchains = [
        "@rules_python//python:toolchain_type",
    ],
)
