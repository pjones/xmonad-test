{-

This file is part of the package xmonad-test. It is subject to the
license terms in the LICENSE file found in the top-level directory of
this distribution and at http://github.com/pjones/xmonad-test/LICENSE.
No part of the xmonad-test package, including this file, may be
copied, modified, propagated, or distributed except according to the
terms contained in the LICENSE file.

-}

--------------------------------------------------------------------------------
import XMonad

--------------------------------------------------------------------------------
main :: IO ()
main = xmonad $ def
    { borderWidth        = 2
    , terminal           = "urxvt"
    , normalBorderColor  = "#cccccc"
    , focusedBorderColor = "#cd8b00"
    }
