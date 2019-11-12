_ = require 'lodash'

# return
module.exports = (cont) ->

  cont
  .replace /\b\d+e\d+\b/g, (text) ->
    
    [pre, sub] = text.split 'e'
    
    # return
    "#{pre}#{_.repeat 0, parseInt sub}"