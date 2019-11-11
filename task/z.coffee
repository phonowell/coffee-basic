$ = require 'fire-keeper'

# return
module.exports = ->

  await $.remove_ './test/*.ahk'
  
  parse_ = $.require './source/index'
  for source in await $.source_ './test/*.coffee'
    await parse_ source