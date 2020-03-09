import $ = require('fire-keeper')
import _ = require('lodash')

import { getDepth, setDepth } from './fn'

import { $setFixed } from '../built-in/set'
import { $info, $tip } from '../built-in/info'
import { $abs, $ceil, $floor, $round } from '../built-in/math'
import { $alert, $beep, $click, $exit, $move, $open, $reload, $sleep } from '../built-in/simple'
import { $clearInterval, $clearTimeout, $setInterval, $setTimeout } from '../built-in/timer'
import { $findColor, $findImage } from '../built-in/find'
import { $getColor, $getPosition, $getState } from '../built-in/get'
import { $trim, $trimEnd, $trimStart } from '../built-in/trim'
import { $isPressing, $press } from '../built-in/press'

// interface
import { iData } from '../type'

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

}

// function

function format(line: string, data: iData) {

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
    let result = `${name}(${argument.join(', ')})`
    if (output) {
      result = `${output} = ${result}`
    }
    return `${setDepth(depth)}${result}`
  }

  // return
  const result = fn(option, data) as string | string[]

  if ($.type(result) === 'string') {
    return `${setDepth(depth)}${result as string}`
  }

  if ($.type(result) === 'array') {
    let _result: string[] = []
    for (const line of result as string[]) {
      _result.push(`${setDepth(depth)}${line}`)
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
    let list = name.split('=')
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
    const it = arg[i]
    arg[i] = it
      .trim()
      .replace(/__comma__/g, ',')
  }

  // return
  const argument = arg
  return { argument, depth, name, output }

}

// export
export default (data: iData) => {

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