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

    if ~line.search /(if |else)/
      cache.push n

      _line = "#{line} {"
      .replace /if\s+(.*?)\s+{/, 'if ($1) {'

      result.push _line
      continue

    result.push line

  result # return

# return
module.exports = ->

  unless @raw.includes 'if '
    return

  for block in [@function..., @bind...]
    block.content = execute.call @, block.content