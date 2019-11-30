_ = require 'lodash'

formatKey = require '../fn/formatKey'

# const

Rule =
  '$.beep': 'SoundBeep'
  '$.block': 'BlockInput'
  '$.exit': 'ExitApp'
  '$.info': 'TrayTip %'
  '$.pause': 'Pause'
  '$.play': 'SoundPlay'
  '$.trim': 'Trim'
  '$.trimEnd': 'RTrim'
  '$.trimStart': 'LTrim'
  'alert': 'MsgBox %'
  '$.sleep': 'Sleep %'

  # ---
  
  '$.findColor': require '../built-in/$.findColor'
  '$.findImage': require '../built-in/$.findImage'
  '$.getColor': require '../built-in/$.getColor'
  '$.getPosition': require '../built-in/$.getPosition'
  '$.isPressing': require '../built-in/$.isPressing'
  '$.press': require '../built-in/$.press'

  # ---

  '$.clearInterval': ({argument}) ->
    "SetTimer #{wrap.call @, argument[0]}, Off"
  
  '$.clearTimeout': ({argument}) ->
    "SetTimer #{wrap.call @, argument[0]}, Off"
  
  '$.click': ({argument}) ->
    unless argument[0]
      'Click'
    else "Click % #{argument[0].replace /:/g, ' '}"

  '$.getState': ({argument, output}) ->
    "GetKeyState #{output}, #{formatKey argument[0]}"

  '$.move': ({argument}) ->
    "MouseMove #{argument[0] or 0}, #{argument[1] or 0}, #{argument[2] or 0}"
  
  '$.open': ({argument}) ->
    "Run #{@trim argument[0]}"
  
  '$.setInterval': ({argument}) ->
    "SetTimer #{wrap.call @, argument[0]}, #{argument[1] or 0}"
  
  '$.setTimeout': ({argument}) ->
    "SetTimer #{wrap.call @, argument[0]}, % 0 - #{argument[1] or 0}"
  
  '$.tip': ({argument}) ->
    unless argument[0]
      'ToolTip'
    else "ToolTip % #{argument[0]}"

  'Math.abs': ({argument, output}) -> "#{output} = Abs(#{argument[0]})"
  'Math.ceil': ({argument, output}) -> "#{output} = Ceil(#{argument[0]})"
  'Math.round': ({argument, output}) -> "#{output} = Round(#{argument[0]})"

# function

format = (line) ->

  unless line.includes '('
    return line

  unless data = getData.call @, line
    return line
  {argument, depth, name, output} = data

  # not found
  unless transformer = Rule[name]
    result = "#{name}(#{argument.join ', '})"
    if output
      result = "#{output} = #{result}"
    return "#{@setDepth depth}#{result}"

  # string
  if (typeof transformer) == 'string'
    return formatString.call @, _.assign {transformer}, data

  # function
  result = transformer.call @, data
  if (typeof result) == 'string'
    return "#{@setDepth depth}#{result}"
  ("#{@setDepth depth}#{line}" for line in result)

formatString = (data) ->

  {argument, depth, output, transformer} = data

  if argument.length == 1 and argument[0] == ''
    return "#{@setDepth depth}#{transformer}"
  
  result = '"#{' + (argument.join '}, #{') + '}"'
  result = "#{transformer} #{result}"
  if output
    result = "#{output} = #{result}"
  
  return "#{@setDepth depth}#{result}"

getData = (line) ->
  
  depth = @getDepth line

  [name, arg...] = line
  .trim()
  .split '('

  if name.includes '='
    [output, name] = (it.trim() for it in name.split '=')

  if name.includes ' '
    return

  arg = _.trim (arg.join '('), ' ()'
  .replace /'[^']+?'/g, (text) -> text.replace /,/g, '__comma__'
  .replace /"[^"]+?"/g, (text) -> text.replace /,/g, '__comma__'
  .split ','

  for it, i in arg
    arg[i] = it
    .trim()
    .replace /__comma__/g, ','

  # return
  argument = arg
  {argument, depth, name, output}

wrap = (name) ->

  if ~_.findIndex @function, {name}
    return name

  "%#{name}%"

# return
module.exports = ->

  for block in [@function..., @bind...]

    result = []

    for line in block.content
      res = format.call @, line

      if (typeof res) == 'string'
        result.push res
        continue

      result = [result..., res...]

    block.content = result