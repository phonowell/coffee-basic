_ = require 'lodash'

# return
module.exports = (arg, output) ->

  [x, y] = _.trim output, ' []'
  .replace /\s/g, ''
  .split ','

  "MouseGetPos #{x}, #{y}"