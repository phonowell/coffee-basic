_ = require 'lodash'

# function

getDepth = require '../fn/getDepth'
setDepth = require '../fn/setDepth'

removeSpace = (line) ->

  n = getDepth line

  line = line
  .trim()
  .replace /\s+/, ' '

  unless line
    return ''
  
  # return
  "#{setDepth n}#{line}"

# return
module.exports = (cont) ->

  result = []

  for line, i in cont.split '\n'

    unless line = removeSpace line
      continue

    # return
    result.push line

  result = result
  .join '\n'
  .replace /'/g, '"'

  result + '\n' # return