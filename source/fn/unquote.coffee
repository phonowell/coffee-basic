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
      result.push it.replace /(?:#{|})/g, '%'
      continue

    # number
    unless _.isNaN parseInt it
      result.push it
      continue

    # variable
    result.push "%#{it}%"

  result.join ', ' # return