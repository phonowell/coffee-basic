_ = require 'lodash'

# function

format = (string) ->

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

# export
module.exports = ({argument, output}) ->

  # output
  [oX, oY] = _.trim output, ' []'
  .replace /\s/g, ''
  .split ','

  # argument
  [target, x1, y1, x2, y2, variation] = argument
  x1 or= 0
  y1 or= 0
  x2 or= 'A_ScreenWidth'
  y2 or= 'A_ScreenHeight'
  variation or= 0

  if target.startsWith '"#'
    target = format target

  # return
  "PixelSearch #{oX}, #{oY},
  #{x1}, #{y1}, #{x2}, #{y2},
  #{target}, #{variation}, Fast RGB"