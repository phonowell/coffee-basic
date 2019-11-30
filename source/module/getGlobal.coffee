getDepth = require '../fn/getDepth'

# function

validate = (line) ->

  if getDepth line
    return

  unless line.includes '='
    return

  if line.includes '->'
    return

  [key, value...] = line.split '='
  key = key.trim()
  value = (value.join '=').trim()

  if key.includes ' '
    return

  true

# return
module.exports = ->

  result = []

  for line in @main

    unless validate line
      result.push line
      continue

    @global.push line

  # return
  @main = result