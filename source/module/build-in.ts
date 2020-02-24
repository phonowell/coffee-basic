import _ = require('lodash')

import formatKey from '../fn/formatKey'
import getDepth from '../fn/getDepth'
import setDepth from '../fn/setDepth'
import trim from '../fn/trim'

import findColor from '../built-in/$.findColor'
import findImage from '../built-in/$.findImage'
import getColor from '../built-in/$.getColor'
import getPosition from '../built-in/$.getPosition'
import isPressing from '../built-in/$.isPressing'
import press from '../built-in/$.press'

// const

const Rule = {
  '$.beep': 'SoundBeep',
  '$.exit': 'ExitApp',
  '$.info': 'TrayTip %',
  '$.reload': 'Reload',
  '$.sleep': 'Sleep %',
  '$.trim': 'Trim',
  '$.trimEnd': 'RTrim',
  '$.trimStart': 'LTrim',
  'alert': 'MsgBox %',

  // ---

  '$.findColor': findColor,
  '$.findImage': findImage,
  '$.getColor': getColor,
  '$.getPosition': getPosition,
  '$.isPressing': isPressing,
  '$.press': press,

  // ---

  '$.clearInterval': ({ argument }: { argument: string[] }): string => {
    return `SetTimer ${wrap.call(this, argument[0])}, Off`
  },

  '$.clearTimeout': ({ argument }: { argument: string[] }): string => {
    return `SetTimer ${wrap.call(this, argument[0])}, Off`
  },

  '$.click': ({ argument }: { argument: string[] }): string => {
    if (!argument[0]) {
      return 'Click'
    } else {
      return `Click % ${argument[0].replace(/:/g, ' ')}`
    }
  },

  '$.getState': ({ argument, output }: { argument: string[], output: string }): string => {
    return `GetKeyState ${output}, ${formatKey(argument[0])}`
  },

  '$.move': ({ argument }: { argument: string[] }): string => {
    return `MouseMove ${argument[0] || 0}, ${argument[1] || 0}, ${argument[2] || 0}`
  },

  '$.open': ({ argument }: { argument: string[] }): string => {
    return `Run ${trim(argument[0])}`
  },

  '$.setInterval': ({ argument }: { argument: string[] }): string => {
    return `SetTimer ${wrap.call(this, argument[0])}, % ${argument[1] || 0}`
  },

  '$.setTimeout': ({ argument }: { argument: string[] }): string => {
    return `SetTimer ${wrap.call(this, argument[0])}, % 0 - ${argument[1] || 0}`
  },

  '$.tip': ({ argument }: { argument: string[] }): string => {
    if (!argument[0]) {
      return 'ToolTip'
    } else {
      return `ToolTip % ${argument.join(', ')}`
    }
  },

  'Math.abs': ({ argument, output }: { argument: string[], output: string }): string => {
    return `${output} = Abs(${argument[0]})`
  },
  'Math.ceil': ({ argument, output }: { argument: string[], output: string }): string => {
    return `${output} = Ceil(${argument[0]})`
  },
  'Math.floor': ({ argument, output }: { argument: string[], output: string }): string => {
    return `${output} = Floor(${argument[0]})`
  },
  'Math.round': ({ argument, output }: { argument: string[], output: string }): string => {
    return `${output} = Round(${argument[0]})`
  }

}

// function

function format(line: string): string | string[] {

  if (!line.includes('(')) {
    return line
  }

  const data = getData(line)
  if (!data) {
    return line
  }
  const { argument, depth, name, output } = data

  // not found
  const transformer = Rule[name]
  if (!transformer) {
    let result = `${name}(${argument.join(', ')})`
    if (output) {
      result = `${output} = ${result}`
    }
    return `${setDepth(depth)}${result}`
  }

  // string
  if (typeof (transformer) === 'string') {
    return formatString(_.assign({ transformer }, data))
  }

  // function
  const res = transformer.call(this, data)
  if (typeof (res) === 'string') {
    return `${setDepth(depth)}${res}`
  }

  // return
  const result = []
  for (const line of result) {
    result.push(`${setDepth(depth)}${line}`)
  }
  return result

}

function formatString(
  data: { argument: string[], depth: number, output: string, transformer: string }
) {

  const { argument, depth, output, transformer } = data

  if (argument.length === 1 && argument[0] === '') {
    return `${setDepth(depth)}${transformer}`
  }

  let result = `"#{${argument.join('}, #{')}}"`
  result = `${transformer} ${result}`
  if (output) {
    result = `${output} = ${result}`
  }

  return `${setDepth(depth)}${result}`

}

function getData(line: string) {

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

function wrap(name: string) {
  if (~_.findIndex(this.function, { name })) {
    return name
  }
  return `%${name}%`
}

// export
export default () => {

  for (const block of [...this.function, ...this.bind]) {

    let result = []

    for (const line of block.content) {

      const res = format.call(this, line)

      if (typeof (res) === 'string') {
        result.push(res)
        continue
      }

      result = [...result, ...res]

    }

    block.content = result

  }

}