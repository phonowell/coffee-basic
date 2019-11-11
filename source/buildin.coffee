# const

dicSimple =
  beep: 'SoundBeep'
  block: 'BlockInput'
  exit: 'ExitApp'
  open: 'Run'
  sleep: 'Sleep'

dicBoolean = ['BlockInput']

# function

replace = (cont) ->

  for key, value of dicSimple

    regA = new RegExp "\\$\\.#{key} ", 'g'
    regB = new RegExp "\\$\\.#{key}\\((.*?)\\)", 'g'

    cont = cont
    .replace regA, "#{value} "
    .replace regB, "#{value} $1"

  for key in dicBoolean

    regA = new RegExp "#{key}\\s+?true", 'g'
    regB = new RegExp "#{key}\\s+?false", 'g'

    cont = cont
    .replace regA, "#{key} on"
    .replace regB, "#{key} off"

  cont # return

# return
module.exports = (cont) ->

  replace cont