_ = require 'lodash'

# function

transColor = (string) ->

  if string.includes '0x'
    return string

  string = _.trim string, '"#'

  if string.length == 3
    string = [
      _.repeat string[0], 2
      _.repeat string[1], 2
      _.repeat string[2], 2
    ].join ''

  "0x#{string.toUpperCase()}" # return

# return
module.exports = (arg, output) ->

  # output
  [oX, oY] = _.trim output, ' []'
  .replace /\s/g, ''
  .split ','

  # arg
  [target, x1, y1, x2, y2] = arg
  x1 or= 0
  y1 or= 0
  x2 or= 'A_ScreenWidth'
  y2 or= 'A_ScreenHeight'

  [method, target] = if target.includes '#'
    ['PixelSearch', "#{transColor target}, 0, Fast RGB"]
  else ['ImageSearch', "*25 #{target}"]

  # return
  "#{method} #{oX}, #{oY},
  #{x1}, #{y1}, #{x2}, #{y2},
  #{target}"