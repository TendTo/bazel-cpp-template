/**
 * @file interrupt.cpp
 * @author Ernesto Casablanca (casablancaernesto@gmail.com)
 * @copyright 2024
 * @licence BSD 3-Clause License
 */
#include <Python.h>
#include <nanobind/nanobind.h>

namespace nb = nanobind;
using namespace nb::literals;

namespace myapp {

void py_check_signals() {
  if (PyErr_CheckSignals() == -1) {
    throw std::runtime_error("Python signal received");
    // throw nb::error_already_set();
  }
}

}  // namespace myapp
