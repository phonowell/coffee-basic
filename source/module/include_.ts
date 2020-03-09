import $ = require('fire-keeper')

import { getDepth } from './fn'

// interface

import { IData, IOption } from '../type'

// export
export default async (data: IData, option: IOption) => {

  const listContent = data.raw
    .replace(/\r/g, '')
    .replace(/\n{2,}/g, '\n')
    .split('\n')

  const result: string[] = []

  for (const line of listContent) {

    if (getDepth(line)) {
      result.push(line)
      continue
    }

    if (!line.startsWith('# include')) {
      result.push(line)
      continue
    }

    let source = line
      .replace(/# include/, '')
      .trim()

    source = `${$.getDirname(option.path)}/${source}.coffee`
    result.push(await $.read_(source))

  }

  //

  data.raw = result
    .join('\n')
    .replace(/\r/g, '')
    .replace(/\n{2,}/g, '\n')

  data.main = data.raw
    .split('\n')

}