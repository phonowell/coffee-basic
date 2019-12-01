_ = require 'lodash'

getDepth = require '../fn/getDepth'
setDepth = require '../fn/setDepth'

# function

execute = (content) ->

  result = []
  cache = []

  for line in content

    depth = getDepth line
    if depth <= _.last cache

      m = _.indexOf cache, depth
      (list = cache[m...]).reverse()

      for j in list

        cache.pop()
        result.push "#{setDepth j}}"

    if line.startsWith '$.loop'
      cache.push depth

      _line = line
      .replace /\$\.loop\s+([^,]+,\s+)?->/g, (text) ->
        
        n = text
        .replace /[\s,]/g, ''
        .replace '$.loop', ''
        .replace '->', ''
        .trim()
        
        unless n
          return 'loop {'
        
        unless _.isNaN parseInt n
          return "loop #{n} {"
        
        "loop %#{n}% {"

      .replace /\s{2,}/g, ' '

      result.push _line
      continue

    result.push line

  result # return

# return
module.exports = ->

  unless @raw.includes '$.loop'
    return

  for block in [@function..., @bind...]
    block.content = execute block.content