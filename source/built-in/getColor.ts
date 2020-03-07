// interface
import { iArgumentBuiltIn } from '../type'

// export
export default ({ argument, output }: iArgumentBuiltIn) => {

  let result: string[] = []

  let [x, y] = argument
  if (!(x && y)) {
    x = x || '__x__'
    y = y || '__y__'
    result.push(`MouseGetPos ${x}, ${y}`)
  }

  result.push(`PixelGetColor ${output}, ${x}, ${y}, RGB`)

  return result

}