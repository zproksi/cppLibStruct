# cppLib Purpose

I would like to have static CPP libraries under next demands:

 * The code must be compilable with C++ 20 standard (gcc, clang, msvc compiler)
 * It must be easy to include code
 * cmake is the main way of integration
 * Code must be tested with unit tests
 * Library API must be documented
 * Library must contain "How to" examples of the library code usage
 * This repository contains a script to generate the base code for such a library
   * windows [**winscript**](scripts/spplibgen.cmd)
   * linux [**linscript**](scripts/spplibgen.sh)

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
| Unit Tests          | [Unit Tests Documentation](doc/unit_tests.md) |
| How To              | [How To Documentation](doc/how_to.md) |
| Integration Tests   | [Integration Tests Documentation](doc/integration_tests.md) |
| Comments            | [Comments Guidelines](doc/comments.md) |

---

# Code Rules

1. Use consistent indentation and spacing across all files.  
2. Avoid using global variables; prefer encapsulation when possible.  
3. Ensure proper error handling and logging mechanisms.

---

# Naming Conventions

- **Outer Namespace:** Use PascalCase for namespaces representing larger modules or systems (e.g., `DataProcessing`).
- **Inner Namespace:** Use camelCase for inner namespaces that are smaller subdivisions (e.g., `coreUtilities`).
- **Class and Methods:** Classes use PascalCase (e.g., `UserManager`), while methods use camelCase (e.g., `createUser`).
- **Functions:** Functions follow camelCase and should convey their purpose (e.g., `getUserInfo`).

---

# Compliance

| Image                              | Description                     |
|------------------------------------|---------------------------------|
| ![Compliance Check 1](img/image1.png) | Proper usage of coding standards. |
| ![Compliance Check 2](img/image2.png) | Unit tests covering required functionality. |
| ![Compliance Check 3](img/image3.png) | Verified alignment with licensing requirements. |

---

# List of Libraries by Licensing

| License Type           | Documentation Link                     |
|------------------------|----------------------------------------|
| MIT License            | [MIT License Documentation](lic/mit.md) |
| GNU GPL License        | [GNU GPL License Documentation](lic/gpl.md) |
| Apache License 2.0     | [Apache License Documentation](lic/apache.md) |