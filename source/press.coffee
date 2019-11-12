# return
module.exports = (cont) ->

  unless cont.includes '$.press'
    return cont

  result = cont.split '\n'

  for line, i in result

    unless line.includes '$.press'
      continue

    result[i] = line
    .replace /\$\.press /g, 'Send '
    .replace /\$\.press\(.*?\)/g, 'Send $1'
    .replace /'(.*?)'/g, '{$1}'
    .replace /},\s*{/g, '}{'
    .replace /[-:](up|down)/g, ' $1'

  result.join '\n' # return