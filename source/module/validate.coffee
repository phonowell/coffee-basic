# const

listForbidden = [
  'then'
  'until'
  'when'
  'while'
]

# function

log = (message, i) ->
  console.log "line #{i + 1}: #{message}"
  message # return

# export
module.exports = ->

  result = true

  for line, i in @raw.split '\n'

    # comment
    if line.includes '###'
      log 'found block comment', i
      result = false
    if line.trim()[0] == '#'
      continue

    # forbidden words
    for word in listForbidden
      unless line.includes word
        continue
      log "found forbidden word '#{word}'", i
      result = false

  result # return