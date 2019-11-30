_ = require 'lodash'

getDepth = require '../fn/getDepth'
setDepth = require '../fn/setDepth'

# function

execute = (content) ->

  result = []
  cache = []

  for line in content

    line = line
    .replace 'unless', 'not-if'

    n = getDepth line
    if n <= _.last cache

      m = _.indexOf cache, n
      (list = cache[m...]).reverse()

      for j in list

        cache.pop()
        result.push "#{setDepth j}}"

    if ~line.search /(if |else)/
      cache.push n

      _line = "#{line} {"
      .replace /if\s+(.*?)\s+{/, 'if ($1) {'
      .replace 'not-if (', 'if !('

      result.push _line
      continue

    result.push line

  result # return

# return
module.exports = ->

  isValid = [
    @raw.includes 'if '
    @raw.includes 'unless '
  ].includes true

  unless isValid
    return

  for block in [@function..., @bind...]
    block.content = execute block.content