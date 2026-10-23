/**
 * @file pymyapp.cpp
 * @author Ernesto Casablanca (casablancaernesto@gmail.com)
 * @copyright 2024
 * @licence BSD 3-Clause License
 */
#ifndef MYAPP_PYTHON
#error MYAPP_PYTHON is not defined. Ensure you are building with the option '--config=py'
#endif

#include <nanobind/nanobind.h>

#include "myapp/util/calculator.h"
#include "myapp/version.h"

namespace nb = nanobind;
using namespace nb::literals;

using Calculator = myapp::Calculator;

NB_MODULE(_pymyapp, m) {
  auto CalculatorClass = nb::class_<Calculator>(m, "Calculator");

  CalculatorClass.def(nb::init<>())
      .def(nb::init<const int>(), "verbose"_a = 0)
      .def("add", &Calculator::add<int>)
      .def("subtract", &Calculator::subtract<int>)
      .def("multiply", &Calculator::multiply<int>)
      .def("divide", &Calculator::divide<int>)
      .def_prop_ro("verbose", &Calculator::getVerbose);

  m.doc() = MYAPP_DESCRIPTION;
#ifdef MYAPP_VERSION_STRING
  m.attr("__version__") = MYAPP_VERSION_STRING;
#else
#error "MYAPP_VERSION_STRING is not defined"
#endif
}
