# const

dicSimple =
  beep: 'SoundBeep'
  block: 'BlockInput'
  click: 'Click'
  exit: 'ExitApp'
  move: 'MouseMove'
  open: 'Run'
  play: 'SoundPlay'
  sleep: 'Sleep'
  trim: 'Trim'
  trimEnd: 'RTrim'
  trimStart: 'LTrim'

dicBoolean = ['BlockInput']

# function

replace = (cont) ->

  for key, value of dicSimple

    unless cont.includes key
      continue

    regA = new RegExp "\\$\\.#{key} ", 'g'
    regB = new RegExp "\\$\\.#{key}\\((.*?)\\)", 'g'

    cont = cont
    .replace regA, "#{value} "
    .replace regB, "#{value} $1"

  for key in dicBoolean

    unless cont.includes key
      continue

    regA = new RegExp "#{key}\\s+?true", 'g'
    regB = new RegExp "#{key}\\s+?false", 'g'

    cont = cont
    .replace regA, "#{key} on"
    .replace regB, "#{key} off"

  cont # return

# return
module.exports = (cont) ->

  replace cont