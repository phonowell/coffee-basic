# const

mapRename =
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
  '$.play': 'SoundPlay'
  '$.sleep': 'Sleep'
  '$.tip': 'ToolTip'
  '$.trim': 'Trim'
  '$.trimEnd': 'RTrim'
  '$.trimStart': 'LTrim'

# function

replace = (cont) ->

  for key, value of mapRename

    unless cont.includes key
      continue

    _key = key
    .replace /([\$\.])/g, '\\$1'

    regA = new RegExp "#{_key}\\s+?(.*?)\n", 'g'
    regB = new RegExp "#{_key}\\((.*?)\\)", 'g'

    cont = cont
    .replace regA, "#{value} {{$1}}\n"
    .replace regB, "#{value} {{$1}}"

    # {{{{}}}}
    if cont.includes '{{{'
      cont = cont
      .replace /([\{}]){3,}/g, '$1$1'

    # $.$.
    if cont.includes '$.$.'
      cont = cont
      .replace /(?:\$\.){1,}/g, '$.'

  cont # return

# return
module.exports = (cont) ->

  replace cont