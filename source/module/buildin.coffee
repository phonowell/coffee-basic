# const

mapFunction =
  'Math.abs': 'Abs'
  'Math.ceil': 'Ceil'
  'Math.round': 'Round'
  # ---

mapOrder =
  '$.send': '$.press'
  'alert': '$.alert'
  # ---
  '$.alert': 'MsgBox'
  '$.beep': 'SoundBeep'
  '$.block': 'BlockInput'
  '$.click': 'Click'
  '$.exit': 'ExitApp'
  '$.info': 'TrayTip'
  '$.move': 'MouseMove'
  '$.open': 'Run'
  '$.pause': 'Pause'
  '$.play': 'SoundPlay'
  '$.sleep': 'Sleep'
  '$.tip': 'ToolTip'
  '$.trim': 'Trim'
  '$.trimEnd': 'RTrim'
  '$.trimStart': 'LTrim'

# function

format = (cont) ->

  # {{{{}}}}
  if cont.includes '{{{'
    cont = cont
    .replace /([\{}]){3,}/g, '$1$1'

  # $.$.
  if cont.includes '$.$.'
    cont = cont
    .replace /(?:\$\.){1,}/g, '$.'

  cont # return

makeReg = (key) ->
  
  _key = key
  .replace /([\$\.])/g, '\\$1'
  
  # return
  [
    new RegExp "#{_key}\\s+?(.*?)\n", 'g'
    new RegExp "#{_key}\\((.*?)\\)", 'g'
  ]

replaceFunction = (cont) ->

  for key, value of mapFunction

    unless cont.includes key
      continue

    reg = makeReg key

    cont = cont
    .replace reg[0], "#{value}({{$1}})\n"
    .replace reg[1], "#{value}({{$1}})"

    cont = format cont

  cont # return

replaceOrder = (cont) ->

  for key, value of mapOrder

    unless cont.includes key
      continue

    reg = makeReg key

    cont = cont
    .replace reg[0], "#{value} {{$1}}\n"
    .replace reg[1], "#{value} {{$1}}"

    cont = format cont

  cont # return

# return
module.exports = (cont) ->

  cont = replaceFunction cont
  cont = replaceOrder cont

  cont # return