_ = require 'lodash'

# function

unquote = require '../fn/unquote'

# return
module.exports = (cont) ->

  unless cont.includes '{{'
    return cont

  cont
  .replace /\{\{.*?}}/g, (text) ->
    unquote _.trim text, '{}'