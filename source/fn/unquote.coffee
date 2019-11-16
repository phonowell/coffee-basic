# return
module.exports = (line) ->

  unless line.includes '#{'
    return line

  line
  .replace /#{/g, '" . '
  .replace /}/g, ' . "'
  .replace /\.\s*""\s*\./g, '.'
  .replace /"\s*\.\s*\.\s*"/g, ''