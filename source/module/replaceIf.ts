import * as _ from 'lodash'

import { getDepth, setDepth } from './fn'

// interface
import { IData } from '../type'

// function

const execute = (content: string[]) => {

  const result = [] as string[]
  const cache: number[] = []

  for (let line of content) {

    line = line
      .replace('unless', 'not-if')

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

    if (line.search(/(if |else)/) !== -1) {
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
export default (data: IData) => {

  const isValid = [
    data.raw.includes('if'),
    data.raw.includes('unless')
  ].includes(true)

  if (!isValid) return

  [...data.fn, ...data.event].forEach(block =>
    block.content = execute(block.content)
  )
}