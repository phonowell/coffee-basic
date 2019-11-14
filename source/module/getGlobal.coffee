# function

getDepth = require '../fn/getDepth'

format = (line) ->

  [key, value...] = line.split '='
  
  # key
  key = key.trim()
  if ~key.search /[\s\$\.]/
    return

  # value
  value = value
  .join '='
  .trim()

  {key, value} # return

validate = (line) ->

  if n = getDepth line
    return

  unless line.includes '='
    return

  if line.includes '->'
    return

  true

# return
module.exports = ->

  result = []

  for line in @main

    unless validate line
      result.push line
      continue

    unless data = format line
      result.push line
      continue

    @global.push data

  # return
  @main = result