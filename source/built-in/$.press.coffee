# function

format = (line) ->

  line
  .toLowerCase()
  .replace /[-'"]/g, ''
  # ---
  .replace /num(\d)/g, 'numpad$1'
  .replace /pagedown/g, 'pgdn'
  .replace /pageup/g, 'pgup'
  # --
  .replace /:/g, ' '

# return
module.exports = (arg) ->
  list = (format it for it in arg)
  "Send {#{list.join '}{'}}"