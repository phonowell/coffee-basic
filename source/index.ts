import $ = require('fire-keeper')
import iconv = require('iconv-lite')

import read_ from './read_'
import transpile_ from './transpile_'
import write_ from './write_'

// interface

import { iOption } from './type'

// function

async function execute_(source: string, option: iOption) {

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
  source: string | string[], option: iOption = {}
) => {

  for (const src of await $.source_(source)) {
    await execute_(src, option)
  }

}