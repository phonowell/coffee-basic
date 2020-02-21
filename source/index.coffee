iconv = require 'iconv-lite'

# function

class Parser

  read_: require './read_'
  transpile_: require './transpile_'
  write_: require './write_'

  # ---

  execute_: (path, option) ->

    source = await @read_ path
    Object.assign option, {path}
    cont = await @transpile_ source, option
    await @write_ path, iconv.encode cont, 'utf8',
      addBOM: true

    cont # return

# return
module.exports = (source, option = {}) ->
  parser = new Parser()
  await parser.execute_ source, option