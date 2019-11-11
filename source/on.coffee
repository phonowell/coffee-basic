_ = require 'lodash'

# function

getDepth = (line) -> (line.length - line.trimStart().length) // 2

getKey = (text) ->
  text
  .toLowerCase()
  .replace /[\s\+]/g, ''
  .replace /win/g, '#'
  .replace /alt/g, '!'
  .replace /shift/g, '+'

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
        result.push "#{_.repeat ' ', (m - j) * 2}return"

    if line.includes '$.on'
      cache.push n
      line = line
      .replace /\$\.on\s+'.*',\s+->/g, (text) ->
        # $.on 'key', ->
        (getKey (text.split "'")[1]) + '::'
      result.push line
      continue

    result.push line

  result = result
  .join '\n'

  result # return