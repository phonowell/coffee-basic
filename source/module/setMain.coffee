# return
module.exports = ->

  unless (@main.join '\n').trim()
    return

  @function.push
    name: '__fn_main__'
    argument: []
    content: @main