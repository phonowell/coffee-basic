_ = require 'lodash'

# function

getDepth = require '../fn/getDepth'
setDepth = require '../fn/setDepth'

# return
module.exports = (cont) ->

  unless cont.includes 'if'
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

    if ~line.search /(if|else)/
      cache.push n
      result.push "#{line} {"
      continue

    result.push line

  result = result
  .join '\n'
  .replace /if\s*(.*?)\s*{/g, 'if ($1) {'
  .replace /}\s*else/g, '} else'

  result # return