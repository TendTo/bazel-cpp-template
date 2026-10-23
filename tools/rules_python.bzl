"""Macro with some preconfigurations for testing with pytest."""

load("@rules_python//python:defs.bzl", "py_binary", "py_test")

def pytest_test(name, srcs, deps = [], args = [], **kwargs):
    """Call pytest from a py_test rule, taking care of the common arguments and dependencies.

    Args:
        name: The name of the rule.
        srcs: The source files to test.
        deps: The dependencies of the rule.
        args: The arguments to pass to pytest.
        **kwargs: Additional arguments to pass to py_test.
    """
    py_test(
        name = name,
        srcs = ["//tools:pytest_main.py"] + srcs,
        main = "//tools:pytest_main.py",
        args = ["--capture=no"] + args + ["$(location :%s)" % x for x in srcs],
        python_version = "PY3",
        srcs_version = "PY3",
        deps = deps + ["@pypi//pytest"],
        **kwargs
    )

def pymyapp_py_test(name, srcs = None, deps = [], args = [], data = [], size = "small", tags = [], **kwargs):
    """Call pytest from a py_test rule, taking care of the common arguments and dependencies.

    By default, sets size="small" because that indicates a unit test.
    If a list of srcs is not provided, it will be inferred from the name, by capitalizing each _-separated word and appending .py.
    For example, pymyapp_py_test(name = "test_foo_bar") will look for TestFooBar.py.

    Args:
        name: The name of the rule.
        srcs: The source files to test.
        deps: The dependencies of the rule.
        args: The arguments to pass to pytest.
        data: The data dependencies of the rule.
        size: The size of the test.
        tags: The tags to apply to the test. Ease of use for filtering tests.
        **kwargs: Additional arguments to pass to py_test.
    """
    if srcs == None:
        srcs = ["".join([word.capitalize() for word in name.split("_")]) + ".py"]
    pytest_test(
        name = name,
        srcs = srcs,
        args = args,
        deps = deps + ["//bindings/pymyapp:pymyapp_lib"],
        data = data,
        size = size,
        tags = tags + ["pymyapp"],
        **kwargs
    )

def myapp_py_stubgen(
        name,
        module,
        imports = [],
        marker_file = None,
        include_private_members = False,
        exclude_docstrings = False,
        exclude_values = False,
        quiet = False):
    """Creates a stub file containing Python type annotations for a nanobind extension.

    Args:
        name: str
            Name of this stub generation target, unused.
        module: Label
            Label of the extension module for which the stub file should be
            generated.
        imports: list
            List of modules to import for stub generation.
        marker_file: str or None
            An empty typing marker file to add to the project, most often named
            "py.typed". Must be given relative to your Python project root.
        include_private_members: bool
            Whether to include private module members, i.e. those starting and/or
            ending with an underscore ("_").
        exclude_docstrings: bool
            Whether to exclude all docstrings of all module members from the generated
            stub file.
        exclude_values: bool
            Whether to replace all constants with a Python ellipsis placeholder.
        quiet: bool
            Whether to suppress output of the stubgen script.
    """
    python_module = Label(module).name
    stub_file = "%s.pyi" % python_module

    args = [
        "--output-file=$(location %s)" % stub_file,
        "--module=%s" % python_module,
        "--marker-file=$(location %s)" % marker_file if marker_file else "",
        "--include-private" if include_private_members else "",
        "--exclude-docstrings" if exclude_docstrings else "",
        "--exclude-values" if exclude_values else "",
        "--quiet" if quiet else "",
    ]

    args = [arg for arg in args if arg]  # Remove empty strings

    py_binary(
        name = "_%s_stubgen_bin" % name,
        srcs = ["@nanobind//:stubgen"],
        imports = imports,
        main = "stubgen.py",
        python_version = "PY3",
        data = [module, "@pypi//typing_extensions"],
    )

    native.genrule(
        name = name,
        srcs = [module],
        outs = [stub_file] + ([marker_file] if marker_file else []),
        cmd = "$(location :_%s_stubgen_bin) %s" % (name, " ".join(args)),
        tools = [":_%s_stubgen_bin" % name],
    )
