_ = require 'lodash'

# function

getDepth = require '../fn/getDepth'

# return
module.exports = (cont) ->

  result = []
  cache = []

  for line, i in cont.split '\n'

    n = getDepth line
    if n <= _.last cache

      m = _.indexOf cache, n
      (list = cache[m...]).reverse()

      for j in list

        cache.pop()
        result.push "#{_.repeat ' ', j * 2}}"

    if line.includes 'for'
      cache.push n
      result.push "#{line} {"
      continue

    result.push line

  result = result
  .join '\n'

  result # return