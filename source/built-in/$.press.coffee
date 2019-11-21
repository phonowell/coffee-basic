# function

format = (line) ->

  line
  .toLowerCase()
  .replace /['"]/g, ''
  # ---
  .replace /equal/g, '='
  .replace /minus/g, '-'
  .replace /num-/g, 'numpad'
  .replace /numpad-/g, 'numpad'
  .replace /page-?down/g, 'pgdn'
  .replace /page-?up/g, 'pgup'
  .replace /plus/g, '+'
  # --
  .replace /:/g, ' '

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
        listResult.push format "#{key}:down"
        continue

      listResult.push format key

    listPre.reverse()
    for key in listPre
      listResult.push format "#{key}:up"

  # return
  "Send {#{listResult.join '}{'}}"