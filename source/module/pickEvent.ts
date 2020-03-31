import _ = require('lodash')

import { getDepth, newBlock } from './fn'

// interface
import { IData } from '../type'

// function

function format(text: string) {
  return text
    .toLowerCase()
    .replace(/[\s-]/g, '')
    .replace(/\+/g, '&')
    // ---
    .replace(/alt&?/g, '!')
    .replace(/control&?/g, '^')
    .replace(/ctrl&?/g, '^')
    .replace(/shift&?/g, '+')
    .replace(/win&?/g, '#')
    // ---
    .replace(/(clickmiddle|middleclick)/g, 'mbutton')
    .replace(/(clickright|rightclick)/g, 'rbutton')
    .replace(/click/g, 'lbutton')
    // ---
    .replace(/&/g, ' & ')
    .replace(/:/g, ' ')
}

function getName(line: string) {

  const name = line
    .replace(/\s/g, '')
    .replace('$.on', '')
    .replace(',->', '')

  return format(_.trim(name, " '\""))

}

function validate(line: string) {

  if (getDepth(line)) {
    return
  }

  line = line
    .trim()

  if (!line.startsWith('$.on')) {
    return
  }

  if (!line.endsWith('->')) {
    return
  }

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
      data.event.push(block)
      block = newBlock()

    }

    if (!validate(line)) {
      result.push(line)
      continue
    }

    isPending = true
    const name = getName(line)
    Object.assign(block, { name })

  }

  //

  data.main = result

}