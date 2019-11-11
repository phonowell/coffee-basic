$ = require 'fire-keeper'

# function

class Parser

  ###
  execute_(path)
  read_(path)
  write_(path, cont)
  ###

  execute_: (path) ->

    source = await @read_ path
    cont = @transpile source
    await @write_ path, cont

    cont # return

  read_: require './read_'
  transpile: require './transpile'
  write_: require './write_'

# return
module.exports = (source) ->
  parser = new Parser()
  await parser.execute_ source