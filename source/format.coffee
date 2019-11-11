_ = require 'lodash'

# function

getDepth = (line) -> (line.length - line.trimStart().length) // 2

# return
module.exports = (cont) ->

  result = []

  for line, i in (cont + '\n').split '\n'

    # remove space at the end
    line = line
    .trimEnd()

    # set depth
    
    depth = getDepth line
    
    line = line
    .trimStart()
    .replace /\s+/, ' '
    
    line = "#{_.repeat ' ', depth * 2}#{line}"

    result.push line

  result = result
  .join '\n'
  .replace /\n{2,}/g, '\n\n'

  result # return