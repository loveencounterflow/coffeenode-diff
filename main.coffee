#!/usr/bin/env node

############################################################################################################
diff_match_patch          = require 'googlediff'
TRM                       = require 'coffeenode-trm'
#...........................................................................................................
red                       = TRM.RED.bind    TRM
white                     = TRM.white.bind  TRM
green                     = TRM.GREEN.bind  TRM


#-----------------------------------------------------------------------------------------------------------
@_new_diff = ( text_1, text_2 ) ->
  dmp = new diff_match_patch()
  d   = dmp.diff_main text_1, text_2
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
@analyze = ( text_1, text_2 ) ->
  { d
    dmp } = @_cleanup @_new_diff text_1, text_2
  return d

#-----------------------------------------------------------------------------------------------------------
@colorize = ( text_1, text_2 ) ->
  R = []
  for part in @analyze text_1, text_2
    [ action
      text    ] = part
    R.push ( @_get_color action ) text
  return R.join ''

#-----------------------------------------------------------------------------------------------------------
@_get_color = ( action ) ->
  return red    if action == -1
  return white  if action ==  0
  return green  if action == +1

#-----------------------------------------------------------------------------------------------------------
@_main = ( options ) ->
  njs_fs  = require 'fs'
  log     = console.log
  console.log options
  njs_fs.readFile options[ '<file_1>' ], encoding: 'utf-8', ( error, text_1 ) =>
    throw error if error?
    njs_fs.readFile options[ '<file_2>' ], encoding: 'utf-8', ( error, text_2 ) =>
      throw error if error?
      white = TRM.grey.bind TRM
      console.log @colorize text_1, text_2

############################################################################################################
unless module.parent?
  docopt = ( require 'docopt' ).docopt
  usage = """
  Usage: diff <file_1> <file_2>

  Options:
    -h, --help
    -v, --version
  """
  options = docopt usage, version: ( require './package.json' )[ 'version' ]
  @_main options




