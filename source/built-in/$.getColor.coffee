# return
module.exports = ({argument, output}) ->

  result = []

  [x, y] = argument
  unless x and y
    x or= '__x__'
    y or= '__y__'
    result.push "MouseGetPos #{x}, #{y}"

  result.push "PixelGetColor #{output}, #{x}, #{y}, RGB"

  result # return