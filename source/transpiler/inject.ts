import $ from 'fire-keeper'
import _ from 'lodash'
import { encodeFnName, regFn } from './fn'

// interface

import { Block } from '../type'

type Yaml = [
  string[], string[]
]

// const

const Rule = [
  '$.beep',
  '$.click',
  '$.exit',
  // '$.findColor': $findColor,
  // '$.findImage': $findImage,
  // '$.getColor': $getColor,
  // '$.getPosition': $getPosition,
  // '$.getState': $getState,
  // '$.info': $info,
  // '$.isPressing': $isPressing,
  '$.move',
  '$.now',
  // '$.open': $open,
  // '$.press': $press,
  '$.reload',
  // '$.setFixed': $setFixed,
  // '$.sleep': $sleep,
  // '$.tip': $tip,
  '$.trim',
  '$.trimEnd',
  '$.trimStart',
  // '$.write': $write,
  // 'Math.abs': $abs,
  // 'Math.ceil': $ceil,
  // 'Math.floor': $floor,
  // 'Math.round': $round,
  // 'alert': $alert,
  // 'clearInterval': $clearInterval,
  // 'clearTimeout': $clearTimeout,
  // 'prompt': $prompt,
  // 'setInterval': $setInterval,
  // 'setTimeout': $setTimeout
] as const

// function

async function main_(
  listVar: string[],
  listFn: Block[],
  listBlock: Block[]
): Promise<void> {

  const setResult: Set<typeof Rule[number]> = new Set()

  listBlock.forEach(block =>
    block.content.forEach(line => {
      for (const key of Rule) {
        if (!line.includes(key)) continue
        setResult.add(key as typeof Rule[number])
      }
    })
  )

  if (!setResult.size) return

  // variable
  listVar.unshift('$ = {}')

  // function
  
  const listResult: string[] = []

  for (const name of setResult) {
    const filename = name.replace('$.', '')
    const data: Yaml = await $.read_(`./source/builtIn/${filename}.yaml`) as Yaml
    regFn(listFn, name, data[0], data[1])
    const _name = encodeFnName(name)
    listResult.push(`${name} = Func('${_name}')`)
  }

  let block = _.find(listFn, {
    name: encodeFnName('$default')
  })
  if (!block) {
    regFn(listFn, '$default', [], [])
    block = _.find(listFn, {
      name: encodeFnName('$default')
    }) as Block
  }

  block.content = [
    ...listResult,
    ...block.content
  ]
}

// export
export default main_