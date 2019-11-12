$ = require 'fire-keeper'

# return
module.exports = ->

  parse_ = $.require './source/index'

  $.watch './script/**/*.coffee', (e) -> await parse_ e.path