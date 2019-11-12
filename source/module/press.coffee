# function

rename = (line) ->

  line
  .toLowerCase()
  .replace /-/g, ''
  # ---
  .replace /num(\d)/g, 'numpad$1'
  .replace /pagedown/g, 'pgdn'
  .replace /pageup/g, 'pgup'
  # --
  .replace /:/g, ' '

# return
module.exports = (cont) ->

  unless cont.includes '$.press'
    return cont

  result = cont.split '\n'

  for line, i in result

    unless line.includes '$.press'
      continue

    result[i] = rename line
    .replace /\$\.press /g, 'Send '
    .replace /\$\.press\(.*?\)/g, 'Send $1'
    .replace /"(.*?)"/g, '{$1}'
    .replace /},\s*{/g, '}{'

  result.join '\n' # return