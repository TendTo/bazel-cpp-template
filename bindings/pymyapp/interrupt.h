/**
 * @file interrupt.h
 * @author Ernesto Casablanca (casablancaernesto@gmail.com)
 * @copyright 2024
 * @licence BSD 3-Clause License
 * Interrupt handler used by pymyapp to handle any signal coming from the Python interpreter.
 */
#pragma once

namespace myapp {

/**
 * Check if the python interpreter has any flags that should interrupt the C++ execution.
 * Ctrl-C, along with other signals,
 * is received by the Python interpreter which holds it until the GIL is released.
 * To interrupt potentially long-running from inside your function,
 * we use the PyErr_CheckSignals() function, that will tell if a signal has been sent by the Python side.
 * If a signal is detected, a @verbatim py::error_already_set @endverbatim exception will be thrown.
 */
void py_check_signals();

}  // namespace myapp
