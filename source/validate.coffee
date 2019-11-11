# return
module.exports = (cont) ->

  for line, i in cont.split '\n'

    if line.includes '###'
      console.log "line #{i + 1}: found block comment"
      return false

    if ~line.search /\S\s*#./
      console.log "line #{i + 1}: found inline comment"
      return false

    if ~line.search /->\s*\S/
      console.log "line #{i + 1}: found inline function"
      return false

  true # return