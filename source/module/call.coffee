getDepth = require '../fn/getDepth'
setDepth = require '../fn/setDepth'

# function

format = (line) ->

  # remove await
  line = line
  .replace /await\s+/g, ''

  # validate
  unless validate line
    return line

  depth = getDepth line
  line = line.trim()

  # if/unless/else if
  if line.startsWith 'if ('
    isIf = true
    line = line
    .replace 'if (', ''
    .replace ') {', ''
  else if line.startsWith 'if !('
    isUnless = true
    line = line
    .replace 'if !(', ''
    .replace ') {', ''
  else if line.startsWith 'else if ('
    isElseIf = true
    line = line
    .replace 'else if (', ''
    .replace ') {', ''

  result = line
  .replace /[^\s=\()\{},\+\-\*\/]+\s+[^=]+/g, (text) ->

    if ~text.search /[=<>]/
      return text

    [key, value...] = text.split ' '
    value = (value.join ' ').trim()

    isInvalid = [
      key == 'if'
      # ---
      value == '!'
      value.startsWith 'and '
      value.startsWith 'or '
      value.startsWith '+ '
      value.startsWith '- '
      value.startsWith '* '
      value.startsWith '/ '
      value.startsWith '> '
      value.startsWith '< '
      value.startsWith '!= '
      value.startsWith '== '
    ].includes true
    if isInvalid
      return text

    "#{key}(#{value})"

  if isIf
    result = "if (#{result}) {"
  else if isUnless
    result = "if !(#{result}) {"
  else if isElseIf
    result = "else if (#{result}) {"

  "#{setDepth depth}#{result}" # return

validate = (string) ->

  list = [
    'else {'
    'loop '
    'return'
  ]

  result = true
  for key in list when string.includes key
    result = false
    break

  result # return

# export
module.exports = ->

  for line, i in @global
    @global[i] = format line

  for block in [@function..., @bind...]
    block.content = (format line for line in block.content)