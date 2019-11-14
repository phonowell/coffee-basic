_ = require 'lodash'

# const

Rule =
  '$.beep': 'SoundBeep'
  '$.block': 'BlockInput'
  '$.clearInterval': (arg) -> "SetTimer #{arg[0]}, Off"
  '$.clearTimeout': (arg) -> "SetTimer #{arg[0]}, Off"
  '$.click': 'Click'
  '$.exit': 'ExitApp'
  '$.find': require '../built-in/$.find'
  '$.getColor': require '../built-in/$.getColor'
  '$.getPosition': require '../built-in/$.getPosition'
  '$.info': 'TrayTip'
  '$.move': 'MouseMove'
  '$.open': (arg) -> "Run #{@trim arg[0]}"
  '$.pause': 'Pause'
  '$.play': 'SoundPlay'
  '$.press': require '../built-in/$.press'
  '$.setInterval': (arg) -> "SetTimer #{arg[0]}, {{#{arg[1]}}}"
  '$.setTimeout': (arg) -> "SetTimer #{arg[0]}, -{{#{arg[1]}}}"
  '$.sleep': 'Sleep'
  '$.tip': (arg) -> "ToolTip #{@trim arg[0]}"
  '$.trim': 'Trim'
  '$.trimEnd': 'RTrim'
  '$.trimStart': 'LTrim'
  'Math.abs': 'Abs'
  'Math.ceil': 'Ceil'
  'Math.round': 'Round'
  'alert': 'MsgBox'

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
      _res = "#{transformer} {{#{argument.join '}}, {{'}}}"
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
  .split ','
  arg = (it.trim() for it in arg)

  # return
  [name, arg, output]

# return
module.exports = ->

  for block in [@function..., @bind...]
    block.content = execute.call @, block.content