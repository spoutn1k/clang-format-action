#!/usr/bin/env bash

###############################################################################
#                                entrypoint.sh                                #
###############################################################################
# Checks all C files (.c and .h) in the GitHub workspace for conforming to
# clang-format. If any C files are incorrectly formatted, the script lists them
# and exits with 1.
# Define your own formatting rules in a .clang-format file at your repository
# root. Otherwise, the LLVM style guide is used as a default.


###############################################################################
#                             format_diff function                            #
###############################################################################
# Accepts a filepath argument. The filepath passed to this function must point
# to a .c or .h file. The file is formatted with clang-format and that output is
# compared to the original file.

format_diff(){
    local filepath="$1"
    local_format="$(clang-format --style=file --fallback-style=LLVM "${filepath}")"
    diff -q <(cat "${filepath}") <(echo "${local_format}") > /dev/null
    diff_result="$?"
    if [[ "${diff_result}" -ne 0 ]]; then
# All files improperly formatted will be printed to the output.
	echo "${filepath} is not formatted correctly." >&2
	exit_code=1
	return "${diff_result}"
    fi
    return 0
}

cd "$GITHUB_WORKSPACE" || exit 1

# initialize exit code
exit_code=0

# find all C family files
c_files=$(find . \( -name "*.[hc]" -o -name "*.cpp" -o -name "*.hpp" \) )
blacklist=$(cat .format-ignore 2>/dev/null)

# check formatting in each C file not present in the blacklist
for file in $c_files; do
    if [[ ! " ${blacklist[@]} " =~ " ${file} " ]]; then
        format_diff "${file}"
    fi
done

exit "$exit_code"
