import _ = require('lodash')

import getDepth from '../fn/getDepth'
import setDepth from '../fn/setDepth'

// interface
import { iData } from '../type'

// function

function execute(content: string[]) {

  let result: string[] = []
  let cache: number[] = []

  for (const line of content) {

    const depth = getDepth(line)
    if (depth <= _.last(cache)) {

      const m = _.indexOf(cache, depth)
      let list = cache.slice(m)
      list.reverse()

      for (const j of list) {
        cache.pop()
        result.push(`${setDepth(j)}}`)
      }

    }

    if (line.startsWith('$.loop')) {
      cache.push(depth)

      const _line = line
        .replace(/\$\.loop\s+([^,]+,\s+)?->/g, (text) => {

          const n = text
            .replace(/[\s,]/g, '')
            .replace('$.loop', '')
            .replace('->', '')
            .trim()

          if (!n) {
            return 'loop {'
          }

          if (!_.isNaN(parseInt(n))) {
            return `loop ${n} {`
          }

          return `loop %${n}% {`

        })
        .replace(/\s{2,}/g, ' ')

      result.push(_line)
      continue

    }

    result.push(line)

  }

  return result

}

// export
export default (data: iData) => {

  if (!data.raw.includes('$.loop')) {
    return
  }

  for (const block of [...data.fn, ...data.event]) {
    block.content = execute(block.content)
  }

}