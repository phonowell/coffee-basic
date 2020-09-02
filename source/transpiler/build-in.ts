import $ from 'fire-keeper'
import _ from 'lodash'
import { getDepth, setDepth } from './fn'

import { $abs, $ceil, $floor, $round } from '../built-in/math'
import { $alert, $info, $prompt, $tip } from '../built-in/info'
import { $beep, $click, $exit, $move, $reload, $sleep } from '../built-in/simple'
import { $clearInterval, $clearTimeout, $setInterval, $setTimeout } from '../built-in/timer'
import { $findColor, $findImage } from '../built-in/find'
import { $getColor, $getPosition, $getState } from '../built-in/get'
import { $isPressing, $press } from '../built-in/press'
import { $open, $write } from '../built-in/file'
import { $setFixed } from '../built-in/set'
import { $trim, $trimEnd, $trimStart } from '../built-in/trim'

// interface

import { Block } from '../type'

type Option = {
  argument: string[]
  depth: number
  name: string
  output: string
}

// const

const Rule: {
  [key: string]: (option: Option) => string[] | string
} = {

  '$.beep': $beep,
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
  '$.sleep': $sleep,
  '$.tip': $tip,
  '$.trim': $trim,
  '$.trimEnd': $trimEnd,
  '$.trimStart': $trimStart,
  '$.write': $write,
  'Math.abs': $abs,
  'Math.ceil': $ceil,
  'Math.floor': $floor,
  'Math.round': $round,
  'alert': $alert,
  'clearInterval': $clearInterval,
  'clearTimeout': $clearTimeout,
  'prompt': $prompt,
  'setInterval': $setInterval,
  'setTimeout': $setTimeout

} as const

// function

function format(
  line: string
): string[] | string {

  if (!line.includes('(')) return line

  const option = pickOption(line)
  if (!option) return line
  const { argument, depth, name, output } = option

  // not found
  const fn = Rule[name]
  if (!fn) {
    let _result = `${name}(${argument.join(', ')})`
    if (output)
      _result = `${output} = ${_result}`
    return `${setDepth(depth)}${_result}`
  }

  // return
  const result = fn(option)

  if (typeof result === 'string')
    return `${setDepth(depth)}${result}`

  if (result instanceof Array) {
    const _listResult: string[] = []
    for (const _line of result)
      _listResult.push(`${setDepth(depth)}${_line}`)
    return _listResult
  }

  throw new Error(`invalid type '${$.type(result)}'`)
}

function main(
  listBlock: Block[]
): void {

  for (const block of listBlock) {

    let listResult: string[] = []

    for (const line of block.content) {

      const result = format(line)

      if (typeof (result) === 'string') {
        listResult.push(result)
        continue
      }

      listResult = [...listResult, ...result]
    }

    block.content = listResult
  }
}

function pickOption(
  line: string
): Option | undefined {

  const depth = getDepth(line)

  let [name, ...listArg] = line
    .trim()
    .split('(')
  let output: string = ''

  if (name.includes('=')) {
    const list = name.split('=')
    output = list[0].trim()
    name = list[1].trim()
  }

  if (name.includes(' ')) return

  listArg = _.trim(listArg.join('('), ' ()')
    .replace(/'[^']+?'/g, text => text.replace(/,/g, '__comma__'))
    .replace(/"[^"]+?"/g, text => text.replace(/,/g, '__comma__'))
    .split(',')
    .map(it => it
      .trim()
      .replace(/__comma__/g, ',')
    )

  // return
  const argument = listArg
  return { argument, depth, name, output }
}

// export
export default main