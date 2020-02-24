$ = require 'fire-keeper'

# export
module.exports = ->

  await $.remove_ './script/**/*.ahk'
  
  parse_ = $.require './source/index'

  listSource = [
    './script/*.coffee'
    './script/ffxiv/**/index.coffee'
    './script/other/*.coffee'
    './script/test/*.coffee'
  ]
  for source in await $.source_ listSource
    await parse_ source