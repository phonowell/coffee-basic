$ = require 'fire-keeper'

# return
module.exports = (path) ->

  extname = '.coffee'
  unless path.includes extname
    path += extname

  await $.read_ path