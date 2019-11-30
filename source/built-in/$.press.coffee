formatKey = require '../fn/formatKey'

# function

# return
module.exports = ({argument}) ->

  listResult = []
  for arg in argument

    list = arg
    .replace /\s/g, ''
    .split '+'

    max = list.length - 1
    listPre = []
    
    for key, i in list

      if i < max
        listPre.push key
        listResult.push formatKey "#{key}:down"
        continue

      listResult.push formatKey key

    listPre.reverse()
    for key in listPre
      listResult.push formatKey "#{key}:up"

  # return
  "Send {#{listResult.join '}{'}}"