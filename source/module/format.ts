import $ = require('fire-keeper')
import _ = require('lodash')

import { getDepth, setDepth } from './fn'

// interface
import { iData } from '../type'

// function

function formatBlock(list: string[]) {

  return list

    .join('__break__')

    // []
    .replace(/\[[^\[]*?\]/g, (text) => {
      return text
        .replace(/\s*__break__\s*/g, '__comma__')
        .replace(/\[__comma__/g, '[')
        .replace(/__comma__\]/g, ']')
        .replace(/__comma__/g, ', ')
    })

    .split('__break__')

}

function formatLine(line: string) {

  const depth = getDepth(line)

  // remove blank line
  line = line.trim()
  if (!line) {
    return
  }

  // remove comment
  if (line.startsWith('#')) {
    return
  }

  line = line

    // join space(s)
    .replace(/\s+/g, ' ')

    // ' -> "
    .replace(/'/g, '"')

    // 1e3 -> 1000
    .replace(/\b\d+e\d+\b/g, (text) => {
      const [pre, sub] = text.split('e')
      return `${pre}${_.repeat('0', parseInt(sub))}`
    })

    // break inline
    .replace(/-> (.*)/, `->\n${setDepth(depth + 1)}$1\n`)

  return `${setDepth(depth)}${line}`

}

// export
export default (data: iData) => {

  let result: string[] = []

  for (const line of formatBlock(data.main)) {

    const _line = formatLine(line)
    if (!_line) {
      continue
    }
    result.push(_line)

  }

  result.push('')
  data.main = result
    .join('\n')
    .split('\n')

}