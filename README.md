# cppLib Purpose

I would like to have static CPP libraries under next demands:

 * Library must contain "How to" examples of the library code usage
 * Code must be tested with unit tests
 * The code must be compilable with C++ 20 standard (gcc, clang, msvc compiler)
 * It must be easy to include code and cmake is the main way of integration
 * Library API must be documented
---
 * This repository contains a script to generate the base code for such a library
   * windows [**winscript**](scripts/cpplibgen.cmd)
   * linux [**linscript**](scripts/cpplibgen.sh)

---

# Table of Contents

1. [Purpose](#cpplib-purpose)
2. [Demands to Library](#demands-to-library)
3. [Code Rules](#code-rules)
4. [Naming Conventions](#naming-conventions)
5. [Compliance](#compliance)
6. [List of Libraries by Licensing](#list-of-libraries-by-licensing)

---

# Demands to Library

| Requirement         | Documentation Link                     |
|---------------------|----------------------------------------|
| How To              | [How To Documentation](doc/how_to.md) |
| Unit Tests          | [Unit Tests Documentation](doc/unit_tests.md) |
| Integration Tests   | [Integration Tests Documentation](doc/integration_tests.md) |
| API Documentation   | [Comments Guidelines](doc/comments.md) |

---

# Code Rules

1. Use consistent indentation and spacing across all files;
2. Avoid using global variables; prefer encapsulation when possible;
3. Ensure proper error handling and logging mechanisms and document possible cases properly;

---

# Naming Conventions

- There are **two namespaces** supposed
  - **Outer Namespace:** As a strong recommendation: Use either your github name, or organization name (e.g., `zproksi` is the outer namespace for this repo autor). namespace should be always in lower case;
  - **Inner Namespace:** Use purpose of the class(es) functions for the inner name namespaces (e.g., `zproksi::profiler` for the class(es) which can be used for time measurement and code speed profiling);
- **Classes, functions, static variables, constants, defines:** No strict rules, however as a common recommendation: use unified style for all names from your outer namespace. For example PascalCase for classes and camelCase for methods;
---

# Compliance

*This section is under construction and should not be taken into account for now*

| Image                              | Description                     |
|------------------------------------|---------------------------------|
| ![Compliance Check 1](img/image1.png) | Proper usage of coding standards. |
| ![Compliance Check 2](img/image2.png) | Unit tests covering required functionality. |
| ![Compliance Check 3](img/image3.png) | Verified alignment with licensing requirements. |

---

# List of Libraries by Licensing

*This section is under construction and should not be taken into account for now*

| License Type           | Documentation Link                     |
|------------------------|----------------------------------------|
| MIT License            | [MIT License Documentation](lic/mit.md) |
| GNU GPL License        | [GNU GPL License Documentation](lic/gpl.md) |
| Apache License 2.0     | [Apache License Documentation](lic/apache.md) |