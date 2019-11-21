# return
module.exports = ({argument, output}) ->
  
  key = argument[0]
  .replace /['"]/g, ''

  # return
  [
    "GetKeyState __value__, #{key}"
    "#{output} = __value__ == \"D\""
  ]