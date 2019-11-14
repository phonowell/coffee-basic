# return
module.exports = ->

  unless @raw.includes '#'
    return

  result = []

  for line in @main

    unless line.includes '#'
      result.push line
      continue

    if line.trim()[0] == '#'
      continue

    result.push line

  @main = result # return