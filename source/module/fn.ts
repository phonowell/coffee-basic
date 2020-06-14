import $ from '../../lib/fire-keeper'
import * as _ from 'lodash'

// interface
import { IBlock, IData } from '../type'

// function

export function encodeFnName(name: string) {
  name = name
    .replace(/\]/g, '')
    .replace(/\[/g, '.')
    .replace(/\./g, '_dot_')

  return `__${name}__`
}

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
    // ---
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

export function regFn(data: IData, name: string, argument: string | string[], content: string[]) {

  name = `__${name}__`
  if ($.type(argument) === 'array') {
    argument = (argument as string[]).join(', ')
  }
  content.push('')

  if (_.findIndex(data.fn, { name }) !== -1) return name

  data.fn.push({ name, argument: argument as string, content })

  return name
}

export function setDepth(n: number) {
  return _.repeat(' ', n * 2)
}

export function trim(input: string) {
  if (!["'", '"'].includes(input[0])) return input
  return input.slice(1, (input.length - 1))
}

export function unquote(line: string) {

  if (!line.includes('#{')) return line

  return line
    .replace(/#{/g, '" . ')
    .replace(/}/g, ' . "')
    .replace(/\.\s*""\s*\./g, '.')
    .replace(/"\s*\.\s*\.\s*"/g, '')
}