# function

execute = (content) ->

  result = []

  for line in content

    unless line.startsWith '$.loop'
      result.push line
      continue

    _line = line
    .replace /\$\.loop\s+([^,]*)(?:,\s+)?->/g, 'loop $1'

    result.push _line

  result # return

# return
module.exports = ->

  unless @raw.includes 'loop'
    return

  for block in [@function..., @bind...]
    block.content = execute block.content