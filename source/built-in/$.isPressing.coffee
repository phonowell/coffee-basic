formatKey = require '../fn/formatKey'

# return
module.exports = ({argument, output}) ->
  
  key = argument[0]
  .replace /['"]/g, ''

  # return
  [
    "GetKeyState __value__, #{formatKey key}"
    "#{output} = __value__ == \"D\""
  ]