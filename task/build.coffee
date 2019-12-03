$ = require 'fire-keeper'

# return
module.exports = ->

  await $.remove_ './script/**/*.ahk'
  
  parse_ = $.require './source/index'

  listSource = [
    './script/**/index.coffee'
    './script/test/*.coffee'
  ]
  for source in await $.source_ listSource
    await parse_ source