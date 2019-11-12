# const

listForbiden = [
  'then'
  'unless'
  'until'
  'when'
  'while'
]

# function

log = (message, i, result) ->
  console.log "line #{i + 1}: #{message}"
  result = false
  message # return

# return
module.exports = (cont) ->

  result = true

  for line, i in cont.split '\n'

    # comment
    if line.includes '###'
      log 'found block comment', i, result
    if line.trim()[0] == '#'
      continue

    # forbiden words
    for word in listForbiden
      unless line.includes word
        continue
      log "found forbiden word '#{word}'", i, result

    # inline
    if ~line.search /->\s*\S/
      log 'inline funciton', i, result

  result # return