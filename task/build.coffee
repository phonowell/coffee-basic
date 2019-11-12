$ = require 'fire-keeper'

# return
module.exports = ->

  await $.remove_ './script/**/*.ahk'
  
  parse_ = $.require './source/index'
  for source in await $.source_ './script/**/*.coffee'
    await parse_ source