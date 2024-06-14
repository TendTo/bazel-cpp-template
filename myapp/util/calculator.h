/**
 * @file calculator.h
 * @author Ernesto Casablanca (casablancaernesto@gmail.com)
 * @copyright 2024
 * @licence Apache-2.0 license
 * @brief Calculator class.
 *
 * This header includes the Calculator class.
 * Consider this as an placeholder for a proper useful library.
 */
#pragma once

#include <spdlog/spdlog.h>

namespace myapp {

/**
 * @brief Simple calculator class.
 *
 * This class provides basic arithmetic operations.
 */
class Calculator {
 private:
  int verbose_;  ///< Verbosity level.

 public:
  /**
   * @brief Constructor.
   * @param verbose Verbosity level.
   */
  explicit Calculator(int verbose = 0);
  /**
   * @brief Get the verbosity level.
   * @return Verbosity level.
   */
  int getVerbose();
  /**
   * @brief Add two numbers.
   * @tparam T Type of the numbers.
   * @param a First number.
   * @param b Second number.
   * @return Sum of the numbers.
   */
  template <typename T>
  T add(T a, T b);
  /**
   * @brief Subtract two numbers.
   * @tparam T Type of the numbers.
   * @param a First number.
   * @param b Second number.
   * @return Subtraction of the numbers.
   */
  template <typename T>
  T subtract(T a, T b);
  /**
   * @brief Multiply two numbers.
   * @tparam T Type of the numbers.
   * @param a First number.
   * @param b Second number.
   * @return Multiplication of the numbers.
   */
  template <typename T>
  T multiply(T a, T b);
  /**
   * @brief Divide two numbers.
   *
   * If the second number is zero, it returns 0.
   * @tparam T Type of the numbers.
   * @param a First number.
   * @param b Second number.
   * @return Division of the numbers.
   */
  template <typename T>
  T divide(T a, T b);
};

template <typename T>
inline T Calculator::add(T a, T b) {
  spdlog::debug("Adding {} and {}", a, b);
  return a + b;
}

template <typename T>
inline T Calculator::subtract(T a, T b) {
  spdlog::debug("Subtracting {} and {}", a, b);
  return a - b;
}

template <typename T>
inline T Calculator::multiply(T a, T b) {
  spdlog::debug("Multiplying {} and {}", a, b);
  return a * b;
}

template <typename T>
inline T Calculator::divide(T a, T b) {
  if (b == 0) {
    spdlog::error("Division by zero. Returning 0.");
    return 0;
  }
  spdlog::debug("Dividing {} and {}", a, b);
  return a / b;
}

}  // namespace myapp
