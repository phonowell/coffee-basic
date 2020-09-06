import _ from 'lodash'

// interface

import { ArgumentBuiltIn } from '../type'

// function

function format(
  text: string
): string {

  if (text.includes('0x')) return text

  text = _.trim(text, " '\"#")

  if (text.length === 3)
    text = [
      _.repeat(text[0], 2),
      _.repeat(text[1], 2),
      _.repeat(text[2], 2)
    ].join('')

  return `0x${text.toUpperCase()}`
}

export function $findColor(
  { argument, output }: ArgumentBuiltIn
): string {

  // output

  if (!output) throw new Error('found no output')

  const [oX, oY] = _.trim(output, ' []')
    .replace(/\s/g, '')
    .split(',')

  // argument
  let [target, x1, y1, x2, y2, variation] = argument
  x1 = x1 || '0'
  y1 = y1 || '0'
  x2 = x2 || 'A_ScreenWidth'
  y2 = y2 || 'A_ScreenHeight'
  variation = variation || '0'

  if (target.startsWith('"#'))
    target = format(target)

  return [
    `PixelSearch ${oX}, ${oY},`,
    `${x1}, ${y1}, ${x2}, ${y2},`,
    `${target}, ${variation}, Fast RGB`
  ].join(' ')

}

export function $findImage(
  { argument, output }: ArgumentBuiltIn
): string {

  // output

  if (!output) throw new Error('found no output')

  const [oX, oY] = _.trim(output, ' []')
    .replace(/\s/g, '')
    .split(',')

  // argument
  let [target, x1, y1, x2, y2] = argument
  x1 = x1 || '0'
  y1 = y1 || '0'
  x2 = x2 || 'A_ScreenWidth'
  y2 = y2 || 'A_ScreenHeight'

  target = target
    .replace(/\//g, '\\')

  return [
    `ImageSearch ${oX}, ${oY},`,
    `${x1}, ${y1}, ${x2}, ${y2},`,
    `% A_ScriptDir . \"\\\" . ${target}`
  ].join(' ')
}