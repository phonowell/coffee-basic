# return
module.exports = (cont) ->

  unless cont.includes '$.getColor'
    return cont

  result = []

  for line in cont.split '\n'

    unless line.includes '$.getColor'
      result.push line
      continue

    line = line
    .replace /\s/g, ''
    .replace /[\(\)]/g, ''
    .replace /\$\.getColor/, ''

    [output, arg] = line.split '='

    # arg
    [x, y] = arg.split ','

    # return
    result.push "PixelGetColor #{output}, #{x}, #{y}"

  result.join '\n' # return