import _ = require('lodash')

import { formatKey } from '../module/fn'

// interface
import { iArgumentBuiltIn } from '../type'

// export
export function $getColor({ argument, output }: iArgumentBuiltIn) {

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

export function $getPosition({ output }: iArgumentBuiltIn) {

  const [x, y] = _.trim(output, ' []')
    .replace(/\s/g, '')
    .split(',')

  return `MouseGetPos ${x}, ${y}`

}

export function $getState({ argument, output }: iArgumentBuiltIn) {
  return `GetKeyState ${output}, ${formatKey(argument[0])}`
}