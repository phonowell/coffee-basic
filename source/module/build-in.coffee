_ = require 'lodash'

# const

Rule =
  '$.beep': 'SoundBeep'
  '$.block': 'BlockInput'
  '$.exit': 'ExitApp'
  '$.info': 'TrayTip %'
  '$.move': 'MouseMove'
  '$.pause': 'Pause'
  '$.play': 'SoundPlay'
  '$.trim': 'Trim'
  '$.trimEnd': 'RTrim'
  '$.trimStart': 'LTrim'
  'Math.abs': 'Abs'
  'Math.ceil': 'Ceil'
  'Math.round': 'Round'
  'alert': 'MsgBox %'
  '$.sleep': 'Sleep %'

  # ---
  
  '$.find': require '../built-in/$.find'
  '$.getColor': require '../built-in/$.getColor'
  '$.getPosition': require '../built-in/$.getPosition'
  '$.press': require '../built-in/$.press'

  # ---

  '$.clearInterval': (arg) ->
    "SetTimer #{wrap.call @, arg[0]}, Off"
  
  '$.clearTimeout': (arg) ->
    "SetTimer #{wrap.call @, arg[0]}, Off"
  
  '$.click': (arg) ->
    unless arg[0]
      'Click'
    else "Click % #{arg[0].replace /:/g, ' '}"
  
  '$.open': (arg) ->
    "Run #{@trim arg[0]}"
  
  '$.setInterval': (arg) ->
    "SetTimer #{wrap.call @, arg[0]}, #{arg[1] or 0}"
  
  '$.setTimeout': (arg) ->
    "SetTimer #{wrap.call @, arg[0]}, % 0 - #{arg[1] or 0}"
  
  '$.tip': (arg) ->
    unless arg[0]
      'ToolTip'
    else "ToolTip % #{arg[0]}"

# function

format = (line) ->

  unless line.includes '('
    return line

  unless data = getName line
    return line
  [name, argument, output] = data
  n = @getDepth line

  # not found
  unless transformer = Rule[name]
    result = "#{name}(#{argument.join ', '})"
    if output
      result = "#{output} = #{result}"
    return "#{@setDepth n}#{result}"

  # string
  if (typeof transformer) == 'string'
    
    if argument.length == 1 and argument[0] == ''
      return "#{@setDepth n}#{transformer}"
    
    result = '"#{' + (argument.join '}, #{') + '}"'
    result = "#{transformer} #{result}"
    if output
      result = "#{output} = #{result}"
    
    return "#{@setDepth n}#{result}"

  # function
  result = transformer.call @, argument, output
  if (typeof result) == 'string'
    return result
  ("#{@setDepth n}#{line}" for line in result)

getName = (line) ->
  
  [name, arg...] = line.trim().split '('

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
  [name, arg, output]

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