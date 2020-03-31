import _ = require('lodash')

import { getDepth, setDepth } from './fn'

// interface
import { IData } from '../type'

// function

function execute(content: string[]) {

  const result = [] as string[]
  const cache: number[] = []

  for (const line of content) {

    const n = getDepth(line)
    if (n <= _.last(cache)) {

      const m = _.indexOf(cache, n)
      const list = cache.slice(m)
      list.reverse()

      for (const j of list) {
        cache.pop()
        result.push(`${setDepth(j)}}`)
      }

    }

    if (line.includes('for')) {
      cache.push(n)
      result.push(`${line} {`)
      continue
    }

    result.push(line)

  }

  return result

}

// export
export default (data: IData) => {

  if (!data.raw.includes('for')) {
    return
  }

  for (const block of [...data.fn, ...data.event]) {
    block.content = execute(block.content)
  }

}