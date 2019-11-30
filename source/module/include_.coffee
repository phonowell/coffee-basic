$ = require 'fire-keeper'
getDepth = require '../fn/getDepth'

# return
module.exports = ->

  unless @raw.includes '# include'
    return

  result = []

  for line in @main

    if getDepth line
      result.push line
      continue

    unless line.startsWith '# include'
      result.push line
      continue

    path = line
    .replace /# include/, ''
    .trim()

    path = "#{$.getDirname @option.path}/#{path}.coffee"
    result.push await $.read_ path

  # return
  @main = result
  .join '\n'
  .replace /\r/g, ''
  .replace /\n{2,}/g, '\n'
  .split '\n'