import _ = require('lodash')

import { getDepth, setDepth } from './fn'

// interface
import { iData } from '../type'

// function

function execute(content: string[]) {

  let result: string[] = []
  let cache: number[] = []

  for (let line of content) {

    line = line
      .replace('unless', 'not-if')

    const n = getDepth(line)
    if (n <= _.last(cache)) {

      const m = _.indexOf(cache, n)
      let list = cache.slice(m)
      list.reverse()

      for (const j of list) {
        cache.pop()
        result.push(`${setDepth(j)}}`)
      }

    }

    if (~line.search(/(if |else)/)) {
      cache.push(n)

      const _line = `${line} {`
        .replace(/if\s+(.*?)\s+{/, 'if ($1) {')
        .replace('not-if (', 'if !(')

      result.push(_line)
      continue
    }

    result.push(line)

  }

  return result

}

// export
export default (data: iData) => {

  const isValid = [
    data.raw.includes('if'),
    data.raw.includes('unless')
  ].includes(true)

  if (!isValid) {
    return
  }

  for (const block of [...data.fn, ...data.event]) {
    block.content = execute(block.content)
  }

}