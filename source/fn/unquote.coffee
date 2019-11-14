_ = require 'lodash'

getDepth = require '../fn/getDepth'
setDepth = require '../fn/setDepth'

# function

format = (line) ->

  n = getDepth line
  line = line
  .trim()
  .replace /['"].*?,.*\1/g, (text) -> text.replace /,/g, '__comma__'
  .replace /\[.*?,.*]/g, (text) -> text.replace /,/g, '__comma__'
  .replace /{.*?,.*}/g, (text) -> text.replace /,/g, '__comma__'

  result = []

  for item in line.split ','

    item = item.trim()

    unless item.includes '='
      result.push item
      continue

    if ~item.search /(==|!|<|>)/
      result.push item
      continue

    [key, value...] = item.split '='
    
    value = value
    .join '='
    .trim()

    result.push "#{key}:= #{value}"

  result = result
  .join ', '
  .replace /__comma__/g, ','

  # return
  "#{setDepth n}#{result}"

trans = (input) ->

  unless input = input.trim()[2...(input.length - 2)]
    return ''

  # string
  if ["'", '"'].includes input[0]
    result = input[1...(input.length - 1)]
    .replace /(#{|})/g, '%'
    return "\"#{result}\""

  # number
  unless _.isNaN parseInt input
    return input

  # array, object, function
  if ~input.search /[\[{\(]/
    return input

  # boolean
  if ['true', 'false'].includes input
    return input

  # variable
  "%#{input}%"

# return
module.exports = (line) ->

  if line.includes '='
    line = format line

  unless line.includes '{{'
    return line

  line
  .replace /{{.*?}}/g, (text) -> trans text