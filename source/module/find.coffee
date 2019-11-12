_ = require 'lodash'

# function

getDepth = require '../fn/getDepth'
setDepth = require '../fn/setDepth'

transColor = (string) ->

  if string.includes '0x'
    return string

  string = _.trim string, '"#'

  if string.length == 3
    string = [
      _.repeat string[0], 2
      _.repeat string[1], 2
      _.repeat string[2], 2
    ].join ''

  "0x#{string.toUpperCase()}" # return

# return
module.exports = (cont) ->

  unless cont.includes '$.find'
    return cont

  result = []

  for line in cont.split '\n'

    unless line.includes '$.find'
      result.push line
      continue

    n = getDepth line

    line = line
    .replace /\s/g, ''
    .replace /[\[\]\(\)]/g, ''
    .replace /\$\.find/, ''

    [output, arg] = line.split '='

    # output
    [oX, oY] = output.split ','

    # arg
    [target, x1, y1, x2, y2] = arg.split ','

    [method, target] = if target.includes '#'
      ['PixelSearch', "#{transColor target}, 0, Fast RGB"]
    else ['ImageSearch', "*25 #{target}"]

    # return
    result.push "#{setDepth n}#{method} #{oX}, #{oY},
    #{x1}, #{y1}, #{x2}, #{y2},
    #{target}"

  result.join '\n' # return