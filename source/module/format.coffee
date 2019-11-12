_ = require 'lodash'

# function

getDepth = require '../fn/getDepth'

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
  .replace /'/g, '"'

  result # return