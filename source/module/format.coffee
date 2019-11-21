_ = require 'lodash'

getDepth = require '../fn/getDepth'
setDepth = require '../fn/setDepth'

# function

format = (line) ->

  depth = getDepth line

  unless line = line.trim()
    return

  # remove comment
  if line.startsWith '#'
    return

  line = line
  .replace /\s+/g, ' '
  .replace /'/g, '"'
  
  # 1e3 -> 1000
  .replace /\b\d+e\d+\b/g, (text) ->
    [pre, sub] = text.split 'e'
    "#{pre}#{_.repeat 0, parseInt sub}"

  # break inline
  .replace /-> (.*)/, "->\n#{setDepth depth + 1}$1\n"

  # return
  "#{setDepth depth}#{line}"

# return
module.exports = ->

  result = []

  for line in @main
    unless _line = format line
      continue
    result.push _line

  result.push ''
  
  # return
  @main = result
  .join '\n'
  .split '\n'