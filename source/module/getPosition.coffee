# function

getDepth = require '../fn/getDepth'
setDepth = require '../fn/setDepth'

# return
module.exports = (cont) ->

  unless cont.includes '$.getPosition'
    return cont

  result = []

  for line in cont.split '\n'

    unless line.includes '$.getPosition'
      result.push line
      continue

    n = getDepth line

    line = line
    .replace /\s/g, ''
    .replace /[\(\)\[\]]/g, ''
    .replace /\$\.getPosition/, ''

    [output] = line.split '='

    # arg
    [x, y] = output.split ','

    # return
    result.push "#{setDepth n}MouseGetPos #{x}, #{y}"

  result.join '\n' # return