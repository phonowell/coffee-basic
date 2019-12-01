$ = require 'fire-keeper'
getDepth = require '../fn/getDepth'

# return
module.exports = ->

  list = @raw
  .replace /\r/g, ''
  .replace /\n{2,}/g, '\n'
  .split '\n'

  result = []

  for line in list

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
  
  @raw = result
  .join '\n'
  .replace /\r/g, ''
  .replace /\n{2,}/g, '\n'

  @main = @raw
  .split '\n'