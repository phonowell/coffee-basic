_ = require 'lodash'

# return
module.exports = ({output}) ->

  [x, y] = _.trim output, ' []'
  .replace /\s/g, ''
  .split ','

  "MouseGetPos #{x}, #{y}"