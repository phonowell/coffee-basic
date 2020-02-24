import _ = require('lodash')

import getDepth from '../fn/getDepth'
import setDepth from '../fn/setDepth'

// function

function format(line: string) {

  const depth = getDepth(line)

  line = line.trim()
  if (!line) {
    return
  }

  // remove comment
  if (line.startsWith('#')) {
    return
  }

  line = line
    .replace(/\s+/g, ' ')
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
export default () => {

  let result = []

  for (const line of this.main) {

    const _line = format(line)
    if (!_line) {
      continue
    }
    result.push(_line)

  }

  result.push('')

  return this.main = result
    .join('\n')
    .split('\n')

}