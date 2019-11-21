$ = require 'fire-keeper'

# return
module.exports = ->

  path = 'alpha'

  await $.remove_ "./script/#{path}.ahk"
  
  parse_ = $.require './source/index'
  for source in await $.source_ "./script/#{path}.coffee"
    await parse_ source,
      bare: true