import $ = require('fire-keeper')

// interface
import { IData } from '../type'

// const

const listForbidden = [
  'then',
  'until',
  'when',
  'while'
]

// function

function log(message: string, i: number) {
  $.i(`line ${i + 1}: ${message}`)
  return message
}

// export
export default (data: IData) => {

  let result = true

  const listRaw = data.raw.split('\n')
  for (const _i in listRaw) {
    if (!listRaw.hasOwnProperty(_i)) {
      continue
    }

    const i = parseInt(_i, 10)
    const line = listRaw[i]

    // block comment
    if (line.includes('###')) {
      log('found block comment', i)
      result = false
    }

    // skip comment
    if (line.trim().startsWith('#')) {
      continue
    }

    // forbidden words
    for (const word of listForbidden) {
      if (!line.includes(word)) {
        continue
      }
      log(`found forbidden word '${word}'`, i)
      result = false
    }

  }

  return result

}