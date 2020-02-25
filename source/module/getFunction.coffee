_ = require 'lodash'

getDepth = require '../fn/getDepth'

# const

Block = ->
  name: ''
  argument: []
  content: []

# function

getName = (line) ->

  [name, arg...] = line
  .trim()
  .replace /->/, ''
  .split '='

  name = name.trim()

  arg = _.trim (arg.join '='), ' ()'

  # return
  [name, arg]

validate = (line) ->

  if getDepth line
    return

  line = line
  .trim()

  if line.startsWith '$.'
    return

  unless line.endsWith '->'
    return

  true

# export
module.exports = ->

  block = Block()
  result = []

  for line in @main

    if isPending
      
      if getDepth line
        block.content.push line.replace '  ', ''
        continue

      isPending = false
      block.content.push ''
      @function.push block
      block = Block()

    unless validate line
      result.push line
      continue

    isPending = true
    [name, argument] = getName line
    Object.assign block, {name, argument}

  # return
  @main = result