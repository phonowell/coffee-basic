import $ from '../../lib/fire-keeper'

import { getDepth } from './fn'

// interface

import { IData, IOption } from '../type'

// function

async function insert_(content: string, option: IOption) {

  // format
  const listContent = content
    .replace(/\r/g, '')
    .replace(/\n{2,}/g, '\n')
    .split('\n')

  const result = [] as string[]

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
    const cont = await $.read_(source)

    if ($.type(cont) !== 'string') {
      throw new Error(`invalid source '${source}'`)
    }

    if (!cont.includes('# include')) {
      result.push(cont)
      continue
    }

    result.push((await insert_(cont, option)).join('\n'))

  }

  return result

}

// export
export default async (data: IData, option: IOption) => {

  data.raw = (await insert_(data.raw, option))
    .join('\n')
    .replace(/\r/g, '')
    .replace(/\n{2,}/g, '\n')

  data.main = data.raw
    .split('\n')

}