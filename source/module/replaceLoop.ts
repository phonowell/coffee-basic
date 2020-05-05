import * as _ from 'lodash'

import { getDepth, setDepth } from './fn'

// interface
import { IData } from '../type'

// function

const execute = (content: string[]) => {

  const result = [] as string[]
  const cache: number[] = []

  for (const line of content) {

    const depth = getDepth(line)
    if (depth <= _.last(cache)) {

      const m = _.indexOf(cache, depth)
      const list = cache.slice(m)
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

          if (!n) return 'loop {'
          if (!_.isNaN(parseInt(n, 10))) return `loop ${n} {`
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
export default (data: IData) => {

  if (!data.raw.includes('$.loop')) return

  for (const block of [...data.fn, ...data.event]) {
    block.content = execute(block.content)
  }
}