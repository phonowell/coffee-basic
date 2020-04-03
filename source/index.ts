import $ from '../lib/fire-keeper'
import iconv = require('iconv-lite')

import read_ from './read_'
import transpile_ from './transpile_'
import write_ from './write_'

// interface

import { IOption } from './type'

// function

async function execute_(source: string, option: IOption) {

  const content = await read_(source)
  Object.assign(option, { path: source })

  let result: string = await transpile_(content, option)
  result = iconv.encode(result, 'utf8', {
    addBOM: true
  }).toString()

  await write_(source, result)

  return result

}

// export
module.exports = async (
  source: string | string[], option: IOption = {}
) => {

  const listSource = await $.source_(source)
  if(!listSource.length){
    $.info(`found no script(s) from '${source}'`)
    return
  }

  for (const src of listSource) {
    await execute_(src, option)
  }

}