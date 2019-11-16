_ = require 'lodash'

# function

execute = (content) ->

  result = []
  cache = []

  for line in content

    n = @getDepth line
    if n <= _.last cache

      m = _.indexOf cache, n
      (list = cache[m...]).reverse()

      for j in list

        cache.pop()
        result.push "#{@setDepth j}}"

    if line.startsWith '$.loop'
      cache.push n

      _line = line
      .replace /\$\.loop\s+([^,],\s+)?->/g, (text) ->
        
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

  unless @raw.includes 'loop'
    return

  for block in [@function..., @bind...]
    block.content = execute.call @, block.content