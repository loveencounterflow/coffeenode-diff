
############################################################################################################
diff_match_patch          = require 'googlediff'
TRM                       = require 'coffeenode-trm'
#...........................................................................................................
red                       = TRM.red.bind   TRM
white                     = TRM.white.bind TRM
green                     = TRM.green.bind TRM


#-----------------------------------------------------------------------------------------------------------
@_new_diff = ( text1, text2 ) ->
  dmp = new diff_match_patch()
  d   = dmp.diff_main text1, text2
  R   =
    dmp: dmp
    d:   d
  return R

#-----------------------------------------------------------------------------------------------------------
@_cleanup = ( me )  ->
  { d
    dmp } = me
  dmp.Diff_EditCost = 10
  dmp.diff_cleanupSemantic    d
  dmp.diff_cleanupEfficiency  d
  return me

#-----------------------------------------------------------------------------------------------------------
@analyze = ( text1, text2 ) ->
  { d
    dmp } = @_cleanup @_new_diff text1, text2
  return d

#-----------------------------------------------------------------------------------------------------------
@colorize = ( text1, text2 ) ->
  R = []
  for part in @analyze text1, text2
    [ action
      text    ] = part
    R.push ( @_get_color action ) text
  return R.join ''

#-----------------------------------------------------------------------------------------------------------
@_get_color = ( action ) ->
  return red    if action == -1
  return white  if action ==  0
  return green  if action == +1






