#!/bin/sh -eu

################################################################################
# Keep cabal from being affected by local configuration.
export HOME=`mktemp -d`

################################################################################
TOP_DIR=`pwd`
SANDBOX=$TOP_DIR/.cabal-sandbox
CONFIGURE_FLAGS="--enable-optimization --enable-tests"

################################################################################
clean () {
  rm -rf $HOME
}

trap clean EXIT

################################################################################
build() {
  dir=$1;     shift
  do_test=$1; shift

  echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
  echo ">>"
  echo "=> Building $dir"
  echo "<<"
  echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"

  cd $dir
  cabal sandbox init --sandbox=$SANDBOX

  for source in "$@"; do
    echo "==> add-source $source"
    cabal sandbox add-source $source
  done

  cabal install --only-dependencies
  cabal configure $CONFIGURE_FLAGS
  cabal build

  if [ "$do_test" = "YES" ]; then
    cabal test
  fi
}

################################################################################
# Start by creating a cabal sandbox in xmonad-test that will be shared
# with xmonad and xmonad-contrib:
cabal sandbox init

################################################################################
# Now go build and test xmonad, and xmonad-contrib:
build $TOP_DIR/vendor/xmonad YES
build $TOP_DIR/vendor/xmonad-contrib YES $TOP_DIR/vendor/xmonad

################################################################################
# Build xmonad-test to ensure everything compiles and links:
build $TOP_DIR NO \
      $TOP_DIR/vendor/xmonad \
      $TOP_DIR/vendor/xmonad-contrib
