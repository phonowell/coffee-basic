import $ from '../../source/fire-keeper'
import _ = require('lodash')

import { getDepth, setDepth } from './fn'

import { $abs, $ceil, $floor, $round } from '../built-in/math'
import { $alert, $info, $tip } from '../built-in/info'
import { $beep, $click, $exit, $move, $open, $reload, $sleep } from '../built-in/simple'
import { $clearInterval, $clearTimeout, $setInterval, $setTimeout } from '../built-in/timer'
import { $findColor, $findImage } from '../built-in/find'
import { $getColor, $getPosition, $getState } from '../built-in/get'
import { $isPressing, $press } from '../built-in/press'
import { $setFixed } from '../built-in/set'
import { $trim, $trimEnd, $trimStart } from '../built-in/trim'

// interface

import { IData } from '../type'

interface IOption {
  argument: string[]
  depth: number
  name: string
  output: string
}

// const

const Rule = {

  '$.beep': $beep,
  '$.clearInterval': $clearInterval,
  '$.clearTimeout': $clearTimeout,
  '$.click': $click,
  '$.exit': $exit,
  '$.findColor': $findColor,
  '$.findImage': $findImage,
  '$.getColor': $getColor,
  '$.getPosition': $getPosition,
  '$.getState': $getState,
  '$.info': $info,
  '$.isPressing': $isPressing,
  '$.move': $move,
  '$.open': $open,
  '$.press': $press,
  '$.reload': $reload,
  '$.setFixed': $setFixed,
  '$.setInterval': $setInterval,
  '$.setTimeout': $setTimeout,
  '$.sleep': $sleep,
  '$.tip': $tip,
  '$.trim': $trim,
  '$.trimEnd': $trimEnd,
  '$.trimStart': $trimStart,
  'Math.abs': $abs,
  'Math.ceil': $ceil,
  'Math.floor': $floor,
  'Math.round': $round,
  'alert': $alert

} as { [key: string]: (option: IOption, data?: IData) => any }

// function

function format(line: string, data: IData) {

  if (!line.includes('(')) {
    return line
  }

  const option = pickOption(line)
  if (!option) {
    return line
  }
  const { argument, depth, name, output } = option

  // not found
  const fn = Rule[name]
  if (!fn) {
    let _result = `${name}(${argument.join(', ')})`
    if (output) {
      _result = `${output} = ${_result}`
    }
    return `${setDepth(depth)}${_result}`
  }

  // return
  const result = fn(option, data) as string | string[]

  if ($.type(result) === 'string') {
    return `${setDepth(depth)}${result as string}`
  }

  if ($.type(result) === 'array') {
    const _result = [] as string[]
    for (const _line of result as string[]) {
      _result.push(`${setDepth(depth)}${_line}`)
    }
    return _result
  }

}

function pickOption(line: string) {

  const depth = getDepth(line)

  let [name, ...arg] = line
    .trim()
    .split('(')
  let output: string

  if (name.includes('=')) {
    const list = name.split('=')
    output = list[0].trim()
    name = list[1].trim()
  }

  if (name.includes(' ')) {
    return
  }

  arg = _.trim(arg.join('('), ' ()')
    .replace(/'[^']+?'/g, (text: string): string => text.replace(/,/g, '__comma__'))
    .replace(/"[^"]+?"/g, (text: string): string => text.replace(/,/g, '__comma__'))
    .split(',')

  for (const i in arg) {
    if (!arg.hasOwnProperty(i)) {
      continue
    }
    const it = arg[i]
    arg[i] = it
      .trim()
      .replace(/__comma__/g, ',')
  }

  // return
  const argument = arg
  return { argument, depth, name, output } as IOption

}

// export
export default (data: IData) => {

  for (const block of [...data.fn, ...data.event]) {

    let result: string[] = []

    for (const line of block.content) {

      const res = format(line, data)

      if (typeof (res) === 'string') {
        result.push(res)
        continue
      }

      result = [...result, ...res]

    }

    block.content = result

  }

}