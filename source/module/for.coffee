_ = require 'lodash'

# function

getDepth = require '../fn/getDepth'
setDepth = require '../fn/setDepth'

isValid = (string) ->

  listBoolean = [
    string.includes 'for'
    string.includes 'loop'
  ]

  listBoolean.includes true # return

# return
module.exports = (cont) ->

  unless isValid cont
    return cont

  result = []
  cache = []

  for line, i in cont.split '\n'

    n = getDepth line
    if n <= _.last cache

      m = _.indexOf cache, n
      (list = cache[m...]).reverse()

      for j in list

        cache.pop()
        result.push "#{setDepth j}}"

    if isValid line
      cache.push n
      result.push "#{line} {"
      continue

    result.push line

  result = result
  .join '\n'

  result # return