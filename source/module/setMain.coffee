# export
module.exports = ->

  unless (@main.join '\n').trim()
    return

  @function.push
    name: 'default'
    argument: []
    content: @main