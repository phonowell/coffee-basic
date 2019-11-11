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

      # add return
      _i = result.length - 1
      result[_i] = result[_i]
      .replace /(\S)/, 'return $1'

      for j in list
        cache.pop()
        result.push "#{_.repeat ' ', (m - j) * 2}}"

    if line.includes '->'
      cache.push n
      result.push line.replace /(\S+)\s*=\s*\(?(.*?)\)?\s*->/g
      , '$1($2){'
      continue

    result.push line

  result = result
  .join '\n'
  .replace /(?:return ){1,}/g, 'return '

  result # return