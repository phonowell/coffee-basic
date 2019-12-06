$ = require 'fire-keeper'

# return
module.exports = ->

  parse_ = $.require './source/index'

  listSource = [
    './script/*.coffee'
    './script/other/*.coffee'
    './script/test/*.coffee'
  ]

  $.watch listSource, (e) -> await parse_ e.path

  $.watch './script/ffxiv/**/*.coffee', (e) ->
    dirname = $.getDirname e.path
    await parse_ "#{dirname}/index.coffee"