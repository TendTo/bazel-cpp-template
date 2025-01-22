/**
 * @file pymyapp.cpp
 * @author Ernesto Casablanca (casablancaernesto@gmail.com)
 * @copyright 2024
 * @licence BSD 3-Clause License
 */
#ifndef MYAPP_PYTHON
#error MYAPP_PYTHON is not defined. Ensure you are building with the option '--config=python'
#endif

#include <pybind11/pybind11.h>

#include "myapp/util/calculator.h"
#include "myapp/version.h"

namespace py = pybind11;

using Calculator = myapp::Calculator;

PYBIND11_MODULE(_pymyapp, m) {
  auto CalculatorClass = py::class_<Calculator>(m, "Calculator");

  CalculatorClass.def(py::init<>())
      .def(py::init<const int>(), py::arg("verbose"))
      .def("add", &Calculator::add<int>)
      .def("subtract", &Calculator::subtract<int>)
      .def("multiply", &Calculator::multiply<int>)
      .def("divide", &Calculator::divide<int>)
      .def_property_readonly("verbose", &Calculator::getVerbose);

  m.doc() = MYAPP_DESCRIPTION;
#ifdef MYAPP_VERSION_STRING
  m.attr("__version__") = MYAPP_VERSION_STRING;
#else
#error "MYAPP_VERSION_STRING is not defined"
#endif
}
