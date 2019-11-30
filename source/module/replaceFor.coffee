_ = require 'lodash'

getDepth = require '../fn/getDepth'
setDepth = require '../fn/setDepth'

# function

execute = (content) ->

  result = []
  cache = []

  for line in content

    n = getDepth line
    if n <= _.last cache

      m = _.indexOf cache, n
      (list = cache[m...]).reverse()

      for j in list

        cache.pop()
        result.push "#{setDepth j}}"

    if line.includes 'for'
      cache.push n
      result.push "#{line} {"
      continue

    result.push line

  result # return

# return
module.exports = ->

  unless @raw.includes 'for'
    return

  for block in [@function..., @bind...]
    block.content = execute block.content