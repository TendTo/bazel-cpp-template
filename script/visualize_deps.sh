#!/bin/bash
bazel query --noimplicit_deps --notool_deps 'deps(//myapp) except kind("source file", deps(//myapp)) -@platforms//...:* -@boost//...:* -@zlib//:copy_public_headers  -//tools:* -@bazel_tools//tools/cpp:*' --output graph > graph.in && dot -Tpng < graph.in > graph.png && rm graph.in

bazel cquery "@bazel_tools//tools/cc:compiler" --output starlark --starlark:expr 'providers(target)'



bazel query --noimplicit_deps --notool_deps 'deps(//myapp) -//tools:*' --output graph