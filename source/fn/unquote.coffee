_ = require 'lodash'

# return
module.exports = (input) ->

  unless input
    return ''

  result = []

  for item in input.split ','

    item = item.trim()
    it = _.trim item, '\'"'

    # string
    if it != item
      
      it = it
      .replace /(?:#{|})/g, '%'

      if it.includes ' '
        it = "\"#{it}\""

      result.push it
      continue

    # number
    unless _.isNaN parseInt it
      result.push it
      continue

    # variable
    result.push "%#{it}%"

  result.join ', ' # return