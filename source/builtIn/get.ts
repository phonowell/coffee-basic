import _ from 'lodash'
import { formatKey } from '../transpiler/fn'

// interface

import { ArgumentBuiltIn } from '../type'

// function

export function $getColor(
  { argument, output }: ArgumentBuiltIn
): string[] {

  if (!output) throw new Error('found no output')

  const result: string[] = []

  let [x, y] = argument
  if (!(x && y)) {
    x = x || '__x__'
    y = y || '__y__'
    result.push(`MouseGetPos ${x}, ${y}`)
  }

  result.push(`PixelGetColor ${output}, ${x}, ${y}, RGB`)

  return result
}

export function $getPosition(
  { output }: ArgumentBuiltIn
): string {

  if (!output) throw new Error('found no output')

  const [x, y] = _.trim(output, ' []')
    .replace(/\s/g, '')
    .split(',')

  return `MouseGetPos ${x}, ${y}`
}

export function $getState(
  { argument, output }: ArgumentBuiltIn
): string {
  return `GetKeyState ${output}, ${formatKey(argument[0])}`
}