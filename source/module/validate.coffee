# const

listForbiden = [
  'then'
  'until'
  'when'
  'while'
]

# function

log = (message, i) ->
  console.log "line #{i + 1}: #{message}"
  message # return

# return
module.exports = ->

  result = true

  for line, i in @raw.split '\n'

    # comment
    if line.includes '###'
      log 'found block comment', i
      result = false
    if line.trim()[0] == '#'
      continue

    # forbiden words
    for word in listForbiden
      unless line.includes word
        continue
      log "found forbiden word '#{word}'", i
      result = false

  result # return