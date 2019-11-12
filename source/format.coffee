_ = require 'lodash'

# function

getDepth = (line) -> (line.length - line.trimStart().length) // 2

removeSpace = (line) ->

  depth = getDepth line

  line = line
  .trim()
  .replace /\s+/, ' '
  
  # return
  "#{_.repeat ' ', depth * 2}#{line}"

# return
module.exports = (cont) ->

  result = []

  for line, i in (cont + '\n').split '\n'

    line = removeSpace line

    # return
    result.push line

  result = result
  .join '\n'
  .replace /\n{2,}/g, '\n\n'

  result # return