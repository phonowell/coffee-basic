# function

format = (line) ->

  line
  .toLowerCase()
  .replace /['"]/g, ''
  # ---
  .replace /equal/g, '='
  .replace /minus/, '-'
  .replace /num(\d)/g, 'numpad$1'
  .replace /page-?down/g, 'pgdn'
  .replace /page-?up/g, 'pgup'
  .replace /plus/g, '+'
  # --
  .replace /:/g, ' '

# return
module.exports = (arg) ->
  list = (format it for it in arg)
  "Send {#{list.join '}{'}}"