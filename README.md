# clang-format-action
GitHub Action for clang-format

This action checks all C-family files (.c, .h, .cpp, .hpp) in the GitHub workspace are formatted correctly using `clang-format`.

The action returns:

* SUCCESS: zero exit-code if project C files are formatted correctly
* FAILURE: nonzero exit-code if project C files are not formatted correctly

Define your own formatting rules in a `.clang-format` file at your repository root. Otherwise, the LLVM style guide is used as a default. Skip checking any file by placing its path in the repo in a `.format-ignore` file.

# Usage

To use this action, create a `.github/workflows/clang-format-check.yml` in your repository containing:

```
name: clang-format Check
on: [push]
jobs:
  formatting-check:
    name: Formatting Check
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - name: Run clang-format style check for C-family programs.
      uses: spoutn1k/clang-format-action@master
```
