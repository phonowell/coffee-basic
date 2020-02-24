_ = require 'lodash'

# return
module.exports = ({argument, output}) ->

  # output
  [oX, oY] = _.trim output, ' []'
  .replace /\s/g, ''
  .split ','

  # argument
  [target, x1, y1, x2, y2] = argument
  x1 or= 0
  y1 or= 0
  x2 or= 'A_ScreenWidth'
  y2 or= 'A_ScreenHeight'

  target = target
  .replace /\//g, '\\'

  # return
  "ImageSearch #{oX}, #{oY},
  #{x1}, #{y1}, #{x2}, #{y2},
  % A_ScriptDir . \"\\\" . #{target}"