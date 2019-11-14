# function

execute = (content) ->

  result = []

  for line in content

    unless validate line
      result.push line
      continue

    _result = line
    .replace /([^\s=\()\{},\+\-\*\/]+)\s+([^=]+)/g, (text) ->
      [key, value...] = text.split ' '
      value = (value.join ' ').trim()

      if ~value.search /[+\-*/]\s/
        return text

      "#{key}(#{value})"

    # add
    result.push _result

  result # return

validate = (string) ->

  list = [
    'return'
    '{'
    '}'
  ]

  result = true
  for key in list when string.includes key
    result = false
    break

  result # return

# return
module.exports = ->

  for block in [@function..., @bind...]
    block.content = execute block.content