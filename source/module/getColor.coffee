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
    .replace /\$\.getColor/, ''
    .replace /\s/g, ''
    .replace /[\(\)]/g, ''

    [output, arg] = line.split '='

    # arg
    [x, y] = arg.split ','
    unless x and y
      x or= '__x__'
      y or= '__y__'
      result.push "#{setDepth n}[#{x}, #{y}] = $.getPosition()"

    # return
    result.push "#{setDepth n}PixelGetColor #{output}, #{x}, #{y}"

  result.join '\n' # return