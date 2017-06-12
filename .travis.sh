#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# This is separate from .travis.yml so we terminate as soon as
# anything errors.
# See https://github.com/travis-ci/travis-ci/issues/1066
set -e
set -x

export PATH=$PATH:~/.cargo/bin

cd "$DIR"
echo 'Configuring Emacs for building'
./autogen.sh
# These configure flags are only required on OS X.
# TODO: remove them.
./configure --without-makeinfo --with-xpm=no --with-gif=no --with-gnutls=no

echo 'Building Emacs'
make -j 3

echo 'Running C and Rust tests'
make check
