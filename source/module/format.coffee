_ = require 'lodash'

getDepth = require '../fn/getDepth'
setDepth = require '../fn/setDepth'

# function

execute = (content) ->
  
  result = []

  for line in content

    n = getDepth line

    _line = line
    .trim()

    # ' -> "
    .replace /'/g, '"'

    # 1e3 -> 1000
    .replace /\b\d+e\d+\b/g, (text) ->
      [pre, sub] = text.split 'e'
      "#{pre}#{_.repeat 0, parseInt sub}"

    unless _line
      continue

    result.push "#{setDepth n}#{_line}"

  result.push ''
  result # return

# return
module.exports = ->

  for block in [@function..., @bind...]
    block.content = execute block.content