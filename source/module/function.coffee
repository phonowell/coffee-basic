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

      # add return
      _i = result.length - 1
      unless result[_i].trim()[0] == '$'
        result[_i] = result[_i]
        .replace /(\S)/, 'return $1'

      m = _.indexOf cache, n
      (list = cache[m...]).reverse()

      for j in list

        cache.pop()
        result.push "#{_.repeat ' ', j * 2}}"

    if line.includes '->'
      cache.push n
      result.push line.replace /(\S+)\s*=\s*\(?(.*?)\)?\s*->/g
      , '$1($2) {'
      continue

    result.push line

  result = result
  .join '\n'
  .replace /(?:return ){1,}/g, 'return '

  result # return