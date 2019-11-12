# return
module.exports = (cont) ->

  unless cont.includes '#'
    return cont

  result = []

  for line in cont.split '\n'

    unless line.includes '#'
      result.push line
      continue

    if line.trim()[0] == '#'
      continue

    result.push line

  result.join '\n' # return