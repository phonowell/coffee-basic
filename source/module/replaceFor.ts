import * as _ from 'lodash'

import { getDepth, setDepth } from './fn'

// interface
import { IData } from '../type'

// function

function execute(content: string[]) {

  const result = [] as string[]
  const cache = [] as number[]

  for (const line of content) {

    const depth = getDepth(line)
    if (depth <= _.last(cache)) {

      const n = _.indexOf(cache, depth)
      const list = cache.slice(n)
      list.reverse()

      for (const j of list) {
        cache.pop()
        result.push(`${setDepth(j)}}`)
      }

    }

    if (line.includes('for')) {

      let _line = line
        .replace(' of ', ' in ')

      if(!_line.includes(',')){
        _line = _line
        .replace('for', 'for __i__,')
      }

      cache.push(depth)
      result.push(`${_line} {`)
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