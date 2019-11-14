_ = require 'lodash'

getDepth = require '../fn/getDepth'

# const

Block = ->
  name: ''
  content: []

# function

format = (string) ->
  string
  .toLowerCase()
  .replace /[\s\+-]/g, ''
  # ---
  .replace /alt/g, '!'
  .replace /control/g, '^'
  .replace /ctrl/g, '^'
  .replace /shift/g, '+'
  .replace /win/g, '#'
  # ---
  .replace /clickmiddle/g, 'mbutton'
  .replace /clickright/g, 'rbutton'
  .replace /click/g, 'lbutton'
  # ---
  .replace /:/g, ' '

getName = (line) ->

  name = line
  .replace /\s/g, ''
  .replace '$.on', ''
  .replace ',->', ''

  name = format _.trim name, " '\""

  name # return

validate = (line) ->

  if n = getDepth line
    return

  line = line
  .trim()

  unless line.startsWith '$.on'
    return

  unless line.endsWith '->'
    return

  true

# return
module.exports = ->

  block = Block()
  result = []

  for line in @main

    if isPending
      
      if n = getDepth line
        block.content.push line.replace '  ', ''
        continue

      isPending = false
      @bind.push block
      block = Block()

    unless validate line
      result.push line
      continue

    isPending = true
    name = getName line
    Object.assign block, {name}

  # return
  @main = result