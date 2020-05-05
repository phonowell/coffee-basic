import * as _ from 'lodash'

import { encodeFnName, getDepth, newBlock } from './fn'

// interface
import { IData } from '../type'

// function

const getName = (line: string) => {

  const [name, ...arg] = line
    .trim()
    .replace(/->/, '')
    .split('=')

  return [
    name.trim(),
    _.trim(arg.join('='), ' ()')
  ]
}

const validate = (line: string) => {

  if (getDepth(line)) return

  line = line
    .trim()

  if (line.startsWith('$.')) return
  if (!line.endsWith('->')) return

  return true
}

// export
export default (data: IData) => {

  let block = newBlock()
  const result = [] as string[]
  let isPending: boolean

  for (const line of data.main) {

    if (isPending) {

      if (getDepth(line)) {
        block.content.push(line.replace('  ', ''))
        continue
      }

      isPending = false
      block.content.push('')
      data.fn.push(block)
      block = newBlock()
    }

    if (!validate(line)) {
      result.push(line)
      continue
    }

    isPending = true
    const [name, argument] = getName(line)

    let _name: string
    if (name.includes('.')) {
      _name = encodeFnName(name)
      result.push(`${name} = Func('${_name}')`)
    } else {
      _name = name
    }

    Object.assign(block, { name: _name, argument })
  }

  //

  data.main = result
}