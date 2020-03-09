import _ = require('lodash')

// interface
import { IBlock, IData } from '../type'

// export

export function formatKey(input: string) {

  return input
    .toLowerCase()
    .replace(/['"]/g, '')
    .replace(/\-/g, '')
    // ---
    .replace(/equal/g, '=')
    .replace(/minus/g, '-')
    .replace(/num/g, 'numpad')
    .replace(/padpad/g, 'pad')
    .replace(/pagedown/g, 'pgdn')
    .replace(/pageup/g, 'pgup')
    .replace(/plus/g, '+')
    // --
    .replace(/:/g, ' ')

}

export function getDepth(line: string) {
  return Math.floor((line.length - line.trimStart().length) / 2)
}

export function newBlock() {
  return {
    name: '',
    argument: '',
    content: []
  } as IBlock
}

export function setDepth(n: number) {
  return _.repeat(' ', n * 2)
}

export function trim(input: string) {

  if (!["'", '"'].includes(input[0])) {
    return input
  }

  return input.slice(1, (input.length - 1))

}

export function unquote(line: string) {

  if (!line.includes('#{')) {
    return line
  }

  return line
    .replace(/#{/g, '" . ')
    .replace(/}/g, ' . "')
    .replace(/\.\s*""\s*\./g, '.')
    .replace(/"\s*\.\s*\.\s*"/g, '')

}

export function wrapName(name: string, data: IData) {

  if (_.findIndex(data.fn, { name }) !== -1) {
    return name
  }
  return `%${name}%`

}