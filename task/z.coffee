$ = require 'fire-keeper'

# return
module.exports = ->

  await $.remove_ './script/alpha.ahk'
  
  parse_ = $.require './source/index'
  for source in await $.source_ './script/alpha.coffee'
    await parse_ source