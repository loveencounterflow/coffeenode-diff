
############################################################################################################
diff_match_patch          = require 'googlediff'
TRM                       = require 'coffeenode-trm'


#-----------------------------------------------------------------------------------------------------------
new_diff = ( text1, text2 ) ->
  dmp = new diff_match_patch()
  d   = dmp.diff_main text1, text2
  R   =
    dmp: dmp
    d:   d
  return R

#-----------------------------------------------------------------------------------------------------------
cleanup = ( me )  ->
  { d
    dmp } = me
  dmp.Diff_EditCost = 10
  dmp.diff_cleanupSemantic    d
  dmp.diff_cleanupEfficiency  d
  return me

#-----------------------------------------------------------------------------------------------------------
$.analyze = ( text1, text2 ) ->
  { d
    dmp } = cleanup new_diff text1, text2
  return d

#-----------------------------------------------------------------------------------------------------------
$.colorize = ( text1, text2 ) ->
  R = []
  for part in @analyze text1, text2
    [ action
      text    ] = part
    R.push ( get_color action ) text
  return R.join ''

#-----------------------------------------------------------------------------------------------------------
get_color = ( action ) ->
  return TRM.red    if action == -1
  return TRM.white  if action ==  0
  return TRM.green  if action == +1






