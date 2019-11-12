_ = require 'lodash'

# function

getDepth = (line) -> (line.length - line.trimStart().length) // 2

# return
module.exports = (cont) ->

  result = []
  cache = []

  for line, i in cont.split '\n'

    n = getDepth line

    if n <= _.last cache

      list = [0...(cache.length - _.indexOf cache, n)]
      m = list.length - 1

      for j in list
        cache.pop()
        result.push "#{_.repeat ' ', (m - j) * 2}}"

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