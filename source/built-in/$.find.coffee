_ = require 'lodash'

unquote = require '../fn/unquote'

# function

transColor = (string) ->

  if string.includes '0x'
    return string

  string = _.trim string, " '\"#"

  if string.length == 3
    string = [
      _.repeat string[0], 2
      _.repeat string[1], 2
      _.repeat string[2], 2
    ].join ''

  "0x#{string.toUpperCase()}" # return

# return
module.exports = ({argument, output}) ->

  # output
  [oX, oY] = _.trim output, ' []'
  .replace /\s/g, ''
  .split ','

  # arg
  [target, x1, y1, x2, y2] = argument
  x1 or= 0
  y1 or= 0
  x2 or= 'A_ScreenWidth'
  y2 or= 'A_ScreenHeight'

  [method, target] = if ~target.search /#\w/
    ['PixelSearch', "#{transColor target}, 0, Fast RGB"]
  else ['ImageSearch', "% A_ScriptDir . \"\\\" . #{target}"]

  # return
  "#{method} #{oX}, #{oY},
  #{x1}, #{y1}, #{x2}, #{y2},
  #{target}"