# function

getDepth = require '../fn/getDepth'
setDepth = require '../fn/setDepth'

transClear = (line) ->

  isValid = [
    line.includes 'clearInterval'
    line.includes 'clearTimeout'
  ].includes true

  unless isValid
    return

  _line = line
  .replace /(?:clearInterval|clearTimeout)/g, ''
  .replace /\s/g, ''

  [label] = _line.split ','

  # return
  "SetTimer #{label}, Off"

transInterval = (line) ->

  unless line.includes 'setInterval'
    return

  _line = line
  .replace 'setInterval', ''
  .replace /\s/g, ''

  [label, delay] = _line.split ','

  # return
  "SetTimer #{label}, #{delay}"

transTimeout = (line) ->

  unless line.includes 'setTimeout'
    return

  _line = line
  .replace 'setTimeout', ''
  .replace /\s/g, ''

  [label, delay] = _line.split ','

  # return
  "SetTimer #{label}, -#{delay}"

validate = (string) ->

  # return
  [
    string.includes 'clearInterval'
    string.includes 'clearTimeout'
    string.includes 'setInterval'
    string.includes 'setTimeout'
  ].includes true

# return
module.exports = (cont) ->

  unless validate cont
    return cont

  result = []

  for line in cont.split '\n'

    unless validate line
      result.push line
      continue

    n = getDepth line

    _result = null
    
    for fn in [
      transClear
      transInterval
      transTimeout
    ]
      if _result = fn line
        break
    
    if _result
      result.push "#{setDepth n}#{_result}"
      continue

  result.join '\n' # return