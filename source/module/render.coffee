unquote = require '../fn/unquote'

# function

renderBind = (list) ->

  result = []

  for block in list

    content = []
    for line in block.content
      unless line.trim()
        continue
      content.push "  #{unquote line}"

    result = [
      result...
      ''
      "#{block.name}::"
      content...
      'return'
    ]

  result # return

renderFunction = (list) ->

  result = []

  for block in list

    content = []
    for line in block.content
      unless line.trim()
        continue
      content.push "  #{unquote line}"

    result = [
      result...
      ''
      "#{block.name}(#{unquote block.argument}) {"
      content...
      '}'
    ]

  result # return

renderGlobal = (list) ->

  result = []

  for line in list
    result.push unquote "global #{line}"

  result # return

# return
module.exports = ->

  result = []

  # head
  result = [@head...]

  # global
  if @global.length
    result = [
      result...
      ''
      '; global'
      ''
      (renderGlobal @global)...
    ]

  # function
  if @function.length
    result = [
      result...
      ''
      '; function'
      ''
      (renderFunction @function)...
    ]

  # main
  if (@main.join '\n').trim()
    result = [
      result...
      ''
      '; default'
      'default()'
    ]

  # bind
  if @bind.length
    result = [
      result...
      ''
      '; bind'
      ''
      (renderBind @bind)...
    ]

  # foot
  result = [
    result...
    ''
    @foot...
  ]

  # return
  (line.trimEnd() for line in result)
  .join '\n'
  .replace /\n{2,}/g, '\n\n'
  .replace /'/g, '"'
  .replace /\s=\s/g, ' := '