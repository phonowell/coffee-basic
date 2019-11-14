# return
module.exports = (input) ->

  unless ["'", '"'].includes input[0]
    return input

  input[1...(input.length - 1)]