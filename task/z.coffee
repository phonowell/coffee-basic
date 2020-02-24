$ = require 'fire-keeper'

# export
module.exports = ->

  path = 'ffxiv/rdm/index'

  await $.remove_ "./script/#{path}.ahk"
  
  parse_ = $.require './source/index'
  for source in await $.source_ "./script/#{path}.coffee"
    await parse_ source,
      bare: true