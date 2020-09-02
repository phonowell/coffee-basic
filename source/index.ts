import $ from 'fire-keeper'
import iconv from 'iconv-lite'

import { read_, write_ } from './file'
import transpile_ from './transpiler'

// interface

import { Option } from './type'

// function

async function compile_(
  source: string,
  option: Option
): Promise<void> {

  const content = await read_(source)
  Object.assign(option, {
    path: source
  })

  let result = await transpile_(content, option)
  result = iconv.encode(result, 'utf8', {
    addBOM: true
  }).toString()

  await write_(source, result)
}

async function main_(
  source: string[] | string,
  option: Partial<Option> = {}
): Promise<void> {

  const listSource = await $.source_(source)
  if (!listSource.length) {
    $.info(`found no script(s) from '${source}'`)
    return
  }

  Object.assign({
    bare: false,
    path: ''
  }, option)
  for (const source of listSource)
    await compile_(source, option as Option)
}

// export
export default main_