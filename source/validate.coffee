# function
log = (message, i) ->
  console.log "line #{i + 1}: #{message}"
  message # return

# return
module.exports = (cont) ->

  for line, i in cont.split '\n'

    if line.includes '###'
      log 'found block comment'
      return false

    if ~line.search /\S\s+#./
      log 'found inline comment'
      return false

    if line.includes 'then'
      log 'found if-then'
      return false

    if ~line.search /->\s*\S/
      log 'inline funciton'
      return false

  true # return