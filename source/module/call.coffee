# function

format = (line) ->

  # remove await
  line = line
  .replace /await\s+/g, ''

  # validate
  unless validate line
    return line

  # return
  line
  .replace /[^\s=\()\{},\+\-\*\/]+\s+[^=]+/g, (text) ->

    [key, value...] = text.split ' '
    value = (value.join ' ').trim()

    if ~value.search /[+\-*/]\s/
      return text

    "#{key}(#{value})"

validate = (string) ->

  list = [
    'else {'
    'if ('
    'loop '
    'return'
  ]

  result = true
  for key in list when string.includes key
    result = false
    break

  result # return

# return
module.exports = ->

  for line, i in @global
    @global[i] = format line

  for block in [@function..., @bind...]
    block.content = (format line for line in block.content)