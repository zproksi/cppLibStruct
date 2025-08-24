#!/bin/bash

set -e

# where to create a project - folder
# must be created during run
CPPLG_WHERE=""

# outer namespace for the project
CPPLG_OUTER_NAMESPACE=""

# inner namespace for the project
CPPLG_INNER_NAMESPACE=""

# main include header for the library - can contain .h
# .h will be added if there is no .h in the end
CPPLG_H_FILENAME=""

# main cpp file for the project will be generated from the name of CPPLG_H_FILENAME
CPPLG_CPP_FILENAME=""

# to set tabulation size
CPPLG_TABULATION_SIZE=4
CPPLG_TABULATION="    "

# to monitor errors
CPPLG_ERROR=0

CPPLG_SCRIPT_PATH=""

divisor() {
    echo -e "\033[35m----------------------------------\033[0m"
}

manual()
{
    local SCRIPT_NAME=$(basename "$0")
    divisor
    echo "  To build new library draft use"
    echo "Execute:"
    echo "\"./${SCRIPT_NAME}\"  [-w folder_name] [-o outer_namespace] [-i inner_namespace] [-n filename] <-t 2|3|5>"
    echo ""
    echo "-w   <folder_name>"
    echo "          Specifies the target folder where the library code will be generated"
    echo "            The folder must not exist — it will be created automatically"
    echo "-o   <outer_namespace>"
    echo "          Defines the outer namespace for the library"
    echo "-i   <inner_namespace>"
    echo "          Defines the inner namespace (nested inside the outer namespace)"
    echo "-n   <filename>"
    echo "          Specifies the main header file name (used for library inclusion)"
    echo "            * If missing, .h will be appended automatically"
    echo "            * The corresponding source (<filename>.cpp) and test (test_<filename>.cpp) filenames"
    echo "               will be derived from this header name"
    echo "-t   2|3|5"
    echo "          Specifies the indentation size in whitespaces"
    echo "            * if -t option is skipped - 4 whitespaces is default value"
    echo "            * script accepts only 2, 3 and 5 values"
    divisor
}

define_tabulations() {
    case "${CPPLG_TABULATION_SIZE}" in
        2)
            CPPLG_TABULATION="  "
            ;;
        3)
            CPPLG_TABULATION="   "
            ;;
        5)
            CPPLG_TABULATION="     "
            ;;
        *)
            CPPLG_TABULATION="    "
            ;;
    esac
}

parse_arguments() {
    local args=("$@")  # Store all arguments in an array

    # Loop through all arguments
    for (( kk=0; kk<${#args[@]}; ++kk )); do
        case "${args[kk]}" in
            "-w")
                # Check if next argument exists and isn't another option
                if (( kk+1 < ${#args[@]} )) && [[ ${args[kk+1]} != -* ]]; then
                    CPPLG_WHERE="${args[kk+1]}"
                    ((++kk))  # Skip next argument since we've processed it
                else
                    manual
                    return 1
                fi
                ;;
            "-o")
                # Check if next argument exists and isn't another option
                if (( kk+1 < ${#args[@]} )) && [[ ${args[kk+1]} != -* ]]; then
                    CPPLG_OUTER_NAMESPACE="${args[kk+1]}"
                    ((++kk))  # Skip next argument since we've processed it
                else
                    manual
                    return 1
                fi
                ;;
            "-i")
                # Check if next argument exists and isn't another option
                if (( kk+1 < ${#args[@]} )) && [[ ${args[kk+1]} != -* ]]; then
                    CPPLG_INNER_NAMESPACE="${args[kk+1]}"
                    ((++kk))  # Skip next argument since we've processed it
                else
                    manual
                    return 1
                fi
                ;;
            "-n")
                # Check if next argument exists and isn't another option
                if (( kk+1 < ${#args[@]} )) && [[ ${args[kk+1]} != -* ]]; then
                    CPPLG_H_FILENAME="${args[kk+1]}"
                    ((++kk))  # Skip next argument since we've processed it
                else
                    manual
                    return 1
                fi
                ;;
            "-t")
                # Check if next argument exists and isn't another option
                if (( kk+1 < ${#args[@]} )) && [[ ${args[kk+1]} != -* ]]; then
                    CPPLG_TABULATION_SIZE="${args[kk+1]}"
                    ((++kk))  # Skip next argument since we've processed it
                    define_tabulations
                else
                    manual
                    return 1
                fi
                ;;
            "-h")
                manual
                return 1
                ;;
            *)
                echo "Error: Unknown option ${args[kk]}" >&2
                manual
                return 1
                ;;
        esac
    done
    return 0
}

# Function to check for whitespace or dots in the first argument
has_whitespace_or_dot() {
    local input="$1"

    # Check if input contains whitespace or a dot
    if [[ "$input" =~ [[:space:]] || "$input" == *"."* ]]; then
        CPPLG_ERROR=1  # Contains whitespace or dot
    else
        CPPLG_ERROR=0  # Does NOT contain whitespace or dot
    fi
}

# get this script path to find the prj folder
get_script_path() {
    local CWDLocal=$(pwd)
    # Handle symbolic links
    if [ -L "$0" ]; then
        CPPLG_SCRIPT_PATH="$( dirname "$( readlink -f "$0" )" )"
    else
        CPPLG_SCRIPT_PATH="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )"
    fi
    cd ${CWDLocal}
}
# Function to replace strings in all files recursively
replace_strings() {
    local folder="$1"
    local search="$2"
    local replace="$3"

    find "${folder}" -type f -print0 | while IFS= read -r -d '' file; do
        sed -i "s|${search}|${replace}|g" "${file}"
    done

}

# Function to replace strings in all files recursively
set_tabulations() {
    local folder="$1"
    local replace="$2"

    find "${folder}" -type f -print0 | while IFS= read -r -d '' file; do
        sed -i -E "s/^( {4})+/$(echo -n "${replace}" | sed 's/[\/&]/\\&/g')/g" "${file}"
    done

}

# get path of the script
get_script_path

# script logic entry point
parse_arguments "$@"

# Remove .h suffix if present
if [[ "${CPPLG_H_FILENAME}" == *.h ]]; then
    CPPLG_H_FILENAME="${CPPLG_H_FILENAME%.h}"
fi

# Check if any required variable is empty and exit if true
if [[ -z "${CPPLG_WHERE}" || -z "${CPPLG_OUTER_NAMESPACE}" ||
      -z "${CPPLG_INNER_NAMESPACE}" || -z "${CPPLG_H_FILENAME}" ]]; then
    # Print which specific variables are empty
    [[ -z "${CPPLG_WHERE}" ]] && echo "'-w' missed - there is no folder name to create" >&2
    [[ -z "${CPPLG_OUTER_NAMESPACE}" ]] && echo "'-o' missed - there is no outer namespace name" >&2
    [[ -z "${CPPLG_INNER_NAMESPACE}" ]] && echo "'-i' missed - there is no inner namespace name" >&2
    [[ -z "${CPPLG_H_FILENAME}" ]] && echo "'-n' missed - there is no name for files to generate" >&2

    manual
    exit 1
fi

# a little verification
has_whitespace_or_dot "${CPPLG_INNER_NAMESPACE}"
if [ "${CPPLG_ERROR}" -eq 1 ]; then
    echo "namespace '${CPPLG_INNER_NAMESPACE}' cannot contain whitespace or dot character"
    exit 1
fi

# a little verification
has_whitespace_or_dot "${CPPLG_OUTER_NAMESPACE}"
if [ "${CPPLG_ERROR}" -eq 1 ]; then
    echo "namespace '${CPPLG_OUTER_NAMESPACE}' cannot contain whitespace or dot character"
    exit 1
fi

# Announce extracted values
divisor
echo "Received parameters: '${CPPLG_WHERE}' '${CPPLG_OUTER_NAMESPACE}' '${CPPLG_INNER_NAMESPACE}' '${CPPLG_H_FILENAME}'"
divisor

# Check if target folder already exists
if [ -d "${CPPLG_WHERE}" ]; then
    echo "Error: Folder '${CPPLG_WHERE}' already exists" >&2
    exit 1
fi

# create project folder
mkdir -p "${CPPLG_WHERE}" || {
    echo "Error: Failed to create directory '${CPPLG_WHERE}'" >&2
    exit 1
}

# copy sources
cp -r ${CPPLG_SCRIPT_PATH}/../prj/. "${CPPLG_WHERE}/"

# rename files
mv "${CPPLG_WHERE}/dummyname.cpp" "${CPPLG_WHERE}/${CPPLG_H_FILENAME}.cpp"
mv "${CPPLG_WHERE}/dummyname.h" "${CPPLG_WHERE}/${CPPLG_H_FILENAME}.h"
mv "${CPPLG_WHERE}/tests/unit/test_dummyname.cpp" "${CPPLG_WHERE}/tests/unit/test_${CPPLG_H_FILENAME}.cpp"

replace_strings "${CPPLG_WHERE}/" outer  ${CPPLG_OUTER_NAMESPACE}
replace_strings "${CPPLG_WHERE}/" inner  ${CPPLG_INNER_NAMESPACE}
replace_strings "${CPPLG_WHERE}/" dummyname  ${CPPLG_H_FILENAME}

set_tabulations "${CPPLG_WHERE}/" "${CPPLG_TABULATION}"

#list of files in the root folder:
# CMakeLists.txt
# README.md
# samples.md
# ${CPPLG_H_FILENAME}.cpp
# ${CPPLG_H_FILENAME}.h

#list of files in the .github/workflows folder:
# cmake-multi-platform.yml

#list of files in the tests/unit folder:
# CMakeLists.txt
# rebuild.cmd
# rebuild.sh
# test_${CPPLG_H_FILENAME}.cpp

