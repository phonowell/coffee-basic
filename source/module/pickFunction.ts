import _ = require('lodash')

import getDepth from '../fn/getDepth'
import newBlock from '../fn/newBlock'

// interface
import { iData } from '../type'

// function

function getName(line: string) {

  const [name, ...arg] = line
    .trim()
    .replace(/->/, '')
    .split('=')

  return [
    name.trim(),
    _.trim(arg.join('='), ' ()')
  ]

}

function validate(line: string) {

  if (getDepth(line)) {
    return
  }

  line = line
    .trim()

  if (line.startsWith('$.')) {
    return
  }

  if (!line.endsWith('->')) {
    return
  }

  return true

}

// export
export default (data: iData) => {

  let block = newBlock()
  let result: string[] = []
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
    Object.assign(block, { name, argument })

  }

  //

  data.main = result

}