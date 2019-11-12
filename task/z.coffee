$ = require 'fire-keeper'

# return
module.exports = ->

  await $.remove_ './script/beta.ahk'
  
  parse_ = $.require './source/index'
  for source in await $.source_ './script/beta.coffee'
    await parse_ source