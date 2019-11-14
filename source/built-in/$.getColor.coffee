# return
module.exports = (arg, output) ->

  result = []

  [x, y] = arg
  unless x and y
    x or= '__x__'
    y or= '__y__'
    result.push "MouseGetPos #{x}, #{y}"

  result.push "PixelGetColor #{output}, #{x}, #{y}"

  result # return