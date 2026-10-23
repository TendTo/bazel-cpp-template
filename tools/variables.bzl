MYAPP_NAME = "myapp"
MYAPP_VERSION = "0.0.1"
MYAPP_AUTHOR = "Ernesto Casablanca"
MYAPP_AUTHOR_EMAIL = "casablancaernesto@gmail.com"
MYAPP_DESCRIPTION = "DElta-complete LP solver"
MYAPP_HOMEPAGE = "https://github.com/TendTo/myapp"
MYAPP_SOURCE = "https://github.com/TendTo/myapp"
MYAPP_TRACKER = "https://github.com/TendTo/myapp/issues"
MYAPP_LICENSE = "Apache-2.0"

# Can't parse the list
MYAPP_CLASSIFIERS = [
    "Development Status :: 3 - Alpha",
    "Operating System :: POSIX :: Linux",
    "Operating System :: MacOS",
    "Operating System :: Microsoft :: Windows",
    "Programming Language :: C++",
    "Programming Language :: Python :: 3",
    "Programming Language :: Python :: 3.9",
    "Programming Language :: Python :: 3.10",
    "Programming Language :: Python :: 3.11",
    "Programming Language :: Python :: 3.12",
    "Programming Language :: Python :: 3.13",
    "Programming Language :: Python :: 3.14",
    "Programming Language :: Python :: 3.15",
    "Topic :: Software Development :: Libraries :: Python Modules",
    "Topic :: Scientific/Engineering",
    "Topic :: Scientific/Engineering :: Information Analysis",
    "Typing :: Typed",
]

def _expose_variable_impl(_):
    pass

expose_variable = rule(
    implementation = _expose_variable_impl,
    attrs = {
        "value": attr.string(
            mandatory = True,
            doc = "The value of the variable to expose.",
        ),
    },
)
