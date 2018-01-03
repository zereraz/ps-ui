module View where

import Prelude
import Text.Smolder.HTML (body, button, div, h1, html)
import Text.Smolder.HTML.Attributes (lang)
import Text.Smolder.Markup (Markup, on, text, (!), (#!))


doc = div do
          h1 $ text "new view"
          button $ text "replace me"
