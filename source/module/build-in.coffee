_ = require 'lodash'

# const

Rule =
  '$.beep': 'SoundBeep'
  '$.block': 'BlockInput'
  '$.exit': 'ExitApp'
  '$.info': 'TrayTip'
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

execute = (content) ->

  result = []

  for line in content

    unless line.includes '('
      result.push line
      continue

    unless data = getName line
      result.push line
      continue

    n = @getDepth line

    [name, argument, output] = data

    unless transformer = Rule[name]
      _res = "#{name}(#{argument.join ', '})"
      if output
        _res = "#{output} = #{_res}"
      result.push "#{@setDepth n}#{_res}"
      continue

    if (typeof transformer) == 'string'
      _res = '#{' + (argument.join '}, #{') + '}'
      _res = "#{transformer} #{_res}"
      if output
        _res = "#{output} = #{_res}"
      result.push "#{@setDepth n}#{_res}"
      continue

    _res = transformer.call @, argument, output
    if (typeof _res) == 'string'
      _res = [_res]

    for it in _res
      result.push "#{@setDepth n}#{it}"

  result # return

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
    block.content = execute.call @, block.content