FROM archlinux:latest

LABEL "com.github.actions.name"="clang-format C/C++ Check"
LABEL "com.github.actions.description"="Run clang-format style check for C family programs."
LABEL "com.github.actions.icon"="check-circle"
LABEL "com.github.actions.color"="green"

LABEL "repository"="https://github.com/spoutn1k/github-action-clang-format.git"
LABEL "homepage"="https://github.com/spoutn1k/github-action-clang-format"
LABEL "maintainer"="spoutn1k <jb.skutnik@gmail.com>"

RUN pacman -Sy
RUN pacman -S diffutils clang --noconfirm

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
