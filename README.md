
example:

      console.log DIFF.analyze "this is some test. blah blah blah", "this is other text. blah blah blah"

      [ [ 0, "this is " ]
        [ -1, "some" ]
        [ 1, "other" ]
        [ 0, " te" ]
        [ -1, "s" ]
        [ 1, "x" ]
        [ 0, "t. blah blah blah" ] ]

      console.log DIFF.colorize "this is some test. blah blah blah", "this is other text. blah blah blah"
