# function

getDepth = require '../fn/getDepth'
setDepth = require '../fn/setDepth'

# return
module.exports = (cont) ->

  unless cont.includes '$.getColor'
    return cont

  result = []

  for line in cont.split '\n'

    unless line.includes '$.getColor'
      result.push line
      continue

    n = getDepth line

    line = line
    .replace /\s/g, ''
    .replace /[\(\)]/g, ''
    .replace /\$\.getColor/, ''

    [output, arg] = line.split '='

    # arg
    [x, y] = arg.split ','
    x or= 0
    y or= 0

    # return
    result.push "#{setDepth n}PixelGetColor #{output}, #{x}, #{y}"

  result.join '\n' # return