_ = require 'lodash'

# function

getDepth = require '../fn/getDepth'

getKey = (text) ->
  text
  .toLowerCase()
  .replace /[\s\+-]/g, ''
  # ---
  .replace /alt/g, '!'
  .replace /control/g, '^'
  .replace /ctrl/g, '^'
  .replace /shift/g, '+'
  .replace /win/g, '#'
  # ---
  .replace /clickright/g, 'rbutton'
  .replace /click/g, 'lbutton'
  # ---
  .replace /:/g, ' '

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
        result.push "#{_.repeat ' ', j * 2}return"

    if line.includes '$.on'
      cache.push n
      line = line
      .replace /\$\.on\s+".*",\s+->/g, (text) ->
        # $.on 'key', ->
        (getKey (text.split '"')[1]) + '::'
      result.push line
      continue

    result.push line

  result = result
  .join '\n'

  result # return